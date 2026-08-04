from pathlib import Path
import sqlite3, sys

def find_db():
    here = Path.cwd()
    candidates = []
    for base in [here, here.parent, here.parent.parent]:
        candidates += list(base.glob("archive.sqlite"))
        candidates += list(base.glob("**/archive.sqlite"))
    # Prefer a database outside backups.
    uniq = []
    seen = set()
    for p in candidates:
        rp = p.resolve()
        if rp in seen or "backups" in {x.lower() for x in p.parts}:
            continue
        seen.add(rp)
        uniq.append(p)
    if not uniq:
        raise SystemExit("Could not find archive.sqlite under current/parent directories.")
    # Prefer likely data/database locations, then shortest path.
    uniq.sort(key=lambda p: (
        0 if any(x.lower() in ("data","database","db") for x in p.parts) else 1,
        len(p.parts)
    ))
    return uniq[0]

def split_sql(text):
    statements = []
    buf = ""
    for line in text.splitlines(True):
        buf += line
        if sqlite3.complete_statement(buf):
            s = buf.strip()
            if s:
                statements.append(s)
            buf = ""
    if buf.strip():
        statements.append(buf.strip())
    return statements

mig = Path(sys.argv[1]) if len(sys.argv) > 1 else Path("../migrations/0045_add_aqeli_gharagozloo_pahlavi_enrichment.sql")
if not mig.exists():
    raise SystemExit(f"Migration not found: {mig}")

db = find_db()
print(f"Database: {db}")
print(f"Migration: {mig}")
print()

con = sqlite3.connect(db)
con.row_factory = sqlite3.Row
con.execute("PRAGMA foreign_keys=ON")

# Print FK definitions for every table touched by 0045.
tables = ["metadata","sources","events","citations","claims","claim_citations",
          "entity_citations","research_questions","change_log"]
print("=== FOREIGN KEYS ON TABLES TOUCHED BY 0045 ===")
for t in tables:
    try:
        rows = con.execute(f"PRAGMA foreign_key_list({t})").fetchall()
    except Exception as e:
        print(t, "ERROR:", e)
        continue
    if rows:
        print(f"\n[{t}]")
        for r in rows:
            print(dict(r))
print()

# Useful existence checks.
print("=== EXISTENCE CHECKS ===")
for table, col, value in [
    ("persons","person_id","P0004"),
    ("sources","source_id","S0202"),
    ("events","event_id","E0400"),
]:
    try:
        n = con.execute(f"SELECT COUNT(*) FROM {table} WHERE {col}=?", (value,)).fetchone()[0]
        print(f"{table}.{col}={value}: {n}")
    except Exception as e:
        print(f"{table}: {e}")
print()

sql = mig.read_text(encoding="utf-8")
stmts = split_sql(sql)

print("=== DRY-RUN STATEMENT TEST ===")
con.execute("SAVEPOINT diagnose_0045")
try:
    for i, stmt in enumerate(stmts, 1):
        # Skip comments-only chunks.
        stripped = "\n".join(
            ln for ln in stmt.splitlines()
            if not ln.lstrip().startswith("--")
        ).strip()
        if not stripped:
            continue
        try:
            con.execute(stmt)
            print(f"OK   statement {i}")
        except Exception as e:
            print(f"\nFAIL statement {i}: {e}")
            print("----- SQL -----")
            print(stmt[:4000])
            print("---------------")
            # Show current FK violations if SQLite can identify them.
            try:
                violations = con.execute("PRAGMA foreign_key_check").fetchall()
                if violations:
                    print("Foreign-key check rows:")
                    for v in violations[:20]:
                        print(tuple(v))
            except Exception:
                pass
            raise
finally:
    con.execute("ROLLBACK TO diagnose_0045")
    con.execute("RELEASE diagnose_0045")
    con.close()

print("\nAll statements passed the dry run. No database changes were retained.")
