#!/usr/bin/env python3
"""Export every user table in archive.sqlite to exports/*.csv."""
from pathlib import Path
import sqlite3, csv

ROOT = Path(__file__).resolve().parents[1]
DB = ROOT / "archive.sqlite"
EXPORTS = ROOT / "exports"

def main() -> int:
    EXPORTS.mkdir(exist_ok=True)
    conn = sqlite3.connect(DB)
    tables = [r[0] for r in conn.execute(
        "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%' ORDER BY name"
    )]
    for table in tables:
        cur = conn.execute(f'SELECT * FROM "{table}"')
        path = EXPORTS / f"{table}.csv"
        with path.open("w", newline="", encoding="utf-8-sig") as f:
            writer = csv.writer(f)
            writer.writerow([d[0] for d in cur.description])
            writer.writerows(cur.fetchall())
        print(f"Exported {table} -> {path.relative_to(ROOT)}")
    conn.close()
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
