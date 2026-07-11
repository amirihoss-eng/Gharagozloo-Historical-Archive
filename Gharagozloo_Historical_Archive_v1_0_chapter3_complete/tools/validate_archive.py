#!/usr/bin/env python3
"""Validate SQLite integrity and archive-level references."""
from pathlib import Path
import sqlite3, json, sys
from datetime import datetime, timezone

ROOT = Path(__file__).resolve().parents[1]
DB = ROOT / "archive.sqlite"

def main() -> int:
    conn = sqlite3.connect(DB)
    conn.row_factory = sqlite3.Row
    conn.execute("PRAGMA foreign_keys = ON")
    errors, warnings = [], []

    integrity = conn.execute("PRAGMA integrity_check").fetchone()[0]
    if integrity != "ok":
        errors.append(f"SQLite integrity_check: {integrity}")

    for row in conn.execute("PRAGMA foreign_key_check"):
        errors.append(f"Foreign-key violation: {tuple(row)}")

    mappings = {
        "person": ("persons", "person_id"),
        "event": ("events", "event_id"),
        "place": ("places", "place_id"),
        "title": ("titles", "title_id"),
        "source": ("sources", "source_id"),
    }
    for subject_type, (table, column) in mappings.items():
        rows = conn.execute(
            f"""SELECT claim_id, subject_id FROM claims
                WHERE subject_type=?
                AND subject_id NOT IN (SELECT {column} FROM {table})""",
            (subject_type,),
        ).fetchall()
        for row in rows:
            errors.append(
                f"Orphan claim {row['claim_id']}: {subject_type} {row['subject_id']} does not exist"
            )

    unknown = conn.execute(
        "SELECT DISTINCT subject_type FROM claims WHERE subject_type NOT IN ('person','event','place','title','source')"
    ).fetchall()
    for row in unknown:
        warnings.append(f"Unrecognized claim subject_type: {row[0]}")

    uncited = conn.execute(
        """SELECT claim_id FROM claims
           WHERE status='active'
           AND claim_id NOT IN (SELECT claim_id FROM claim_citations)"""
    ).fetchall()
    for row in uncited:
        warnings.append(f"Active claim without citation: {row[0]}")

    duplicate_names = conn.execute(
        """SELECT person_id, language, name_text, COUNT(*) n
           FROM person_names
           GROUP BY person_id, language, name_text
           HAVING COUNT(*) > 1"""
    ).fetchall()
    for row in duplicate_names:
        warnings.append(
            f"Duplicate person name: {row['person_id']} / {row['language']} / {row['name_text']}"
        )

    tables = [r[0] for r in conn.execute(
        "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%' ORDER BY name"
    )]
    counts = {t: conn.execute(f'SELECT COUNT(*) FROM "{t}"').fetchone()[0] for t in tables}

    report = {
        "validated_at": datetime.now(timezone.utc).isoformat(),
        "database": DB.name,
        "integrity": integrity,
        "errors": errors,
        "warnings": warnings,
        "row_counts": counts,
        "status": "PASS" if not errors else "FAIL",
    }
    report_path = ROOT / "validation_report.json"
    report_path.write_text(json.dumps(report, indent=2, ensure_ascii=False), encoding="utf-8")

    print(f"Validation: {report['status']}")
    print(f"Errors: {len(errors)} | Warnings: {len(warnings)}")
    print(f"Report: {report_path.name}")
    for item in errors:
        print("ERROR:", item)
    for item in warnings:
        print("WARNING:", item)
    return 0 if not errors else 1

if __name__ == "__main__":
    raise SystemExit(main())
