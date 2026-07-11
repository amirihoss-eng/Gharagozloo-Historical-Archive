#!/usr/bin/env python3
"""Apply one SQL migration safely to the archive database.

Usage:
    python tools/apply_migration.py migrations/0003_description.sql
"""
from pathlib import Path
import sqlite3, hashlib, shutil, sys, re
from datetime import datetime, timezone

ROOT = Path(__file__).resolve().parents[1]
DB = ROOT / "archive.sqlite"
BACKUPS = ROOT / "backups"

def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()

def main() -> int:
    if len(sys.argv) != 2:
        print("Usage: python tools/apply_migration.py migrations/NNNN_description.sql")
        return 2

    migration = Path(sys.argv[1]).resolve()
    if not migration.exists():
        print(f"Migration not found: {migration}")
        return 2
    if migration.parent != (ROOT / "migrations").resolve():
        print("Migration must be inside the repository migrations folder.")
        return 2

    match = re.match(r"^(\d{4})_.+\.sql$", migration.name)
    if not match:
        print("Migration filename must look like 0003_description.sql")
        return 2
    migration_id = match.group(1)

    sql = migration.read_text(encoding="utf-8")
    if re.search(r"(?im)^\s*(BEGIN|COMMIT|ROLLBACK)\b", sql):
        print("Migration must not contain BEGIN, COMMIT, or ROLLBACK; the tool manages the transaction.")
        return 2

    digest = sha256(migration)
    BACKUPS.mkdir(exist_ok=True)
    stamp = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ")
    backup = BACKUPS / f"archive_before_{migration_id}_{stamp}.sqlite"
    shutil.copy2(DB, backup)

    conn = sqlite3.connect(DB)
    try:
        conn.execute("PRAGMA foreign_keys = ON")
        conn.execute("""CREATE TABLE IF NOT EXISTS schema_migrations (
            migration_id TEXT PRIMARY KEY,
            filename TEXT NOT NULL UNIQUE,
            sha256 TEXT NOT NULL,
            applied_at TEXT NOT NULL,
            description TEXT
        )""")
        row = conn.execute(
            "SELECT filename, sha256 FROM schema_migrations WHERE migration_id=?",
            (migration_id,)
        ).fetchone()
        if row:
            if row[1] != digest:
                raise RuntimeError(
                    f"Migration {migration_id} is already recorded with a different checksum."
                )
            print(f"Migration {migration_id} already applied. No changes made.")
            backup.unlink(missing_ok=True)
            return 0

        applied_at = datetime.now(timezone.utc).isoformat()
        escaped_filename = migration.name.replace("'", "''")
        escaped_digest = digest.replace("'", "''")
        escaped_time = applied_at.replace("'", "''")
        script = (
            "PRAGMA foreign_keys = ON;\n"
            "BEGIN IMMEDIATE;\n"
            + sql
            + f"\nINSERT INTO schema_migrations"
              f"(migration_id,filename,sha256,applied_at,description) VALUES "
              f"('{migration_id}','{escaped_filename}','{escaped_digest}',"
              f"'{escaped_time}','Applied by tools/apply_migration.py');\n"
            + f"INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary) VALUES "
              f"('{escaped_time}','migration','{migration_id}','apply',"
              f"'Applied {escaped_filename}');\n"
            + f"INSERT OR REPLACE INTO metadata(key,value) VALUES('last_migration','{migration_id}');\n"
            + f"INSERT OR REPLACE INTO metadata(key,value) VALUES('updated_at','{escaped_time}');\n"
            + "COMMIT;\n"
        )
        conn.executescript(script)

        integrity = conn.execute("PRAGMA integrity_check").fetchone()[0]
        fk_errors = conn.execute("PRAGMA foreign_key_check").fetchall()
        if integrity != "ok" or fk_errors:
            raise RuntimeError(f"Post-migration validation failed: integrity={integrity}, FK={fk_errors}")

        print(f"Applied migration {migration_id}: {migration.name}")
        print(f"Backup created: {backup.relative_to(ROOT)}")
        return 0
    except Exception as exc:
        conn.close()
        shutil.copy2(backup, DB)
        print(f"Migration failed and database was restored from backup: {exc}")
        return 1
    finally:
        try:
            conn.close()
        except Exception:
            pass

if __name__ == "__main__":
    raise SystemExit(main())
