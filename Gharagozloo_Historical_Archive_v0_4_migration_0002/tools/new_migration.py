#!/usr/bin/env python3
"""Create the next numbered migration file."""
from pathlib import Path
import re, sys

ROOT = Path(__file__).resolve().parents[1]
MIGRATIONS = ROOT / "migrations"

def main() -> int:
    description = "_".join(sys.argv[1:]).strip().lower()
    description = re.sub(r"[^a-z0-9_]+", "_", description).strip("_")
    if not description:
        print("Usage: python tools/new_migration.py short description")
        return 2
    ids = []
    for path in MIGRATIONS.glob("[0-9][0-9][0-9][0-9]_*.sql"):
        ids.append(int(path.name[:4]))
    next_id = max(ids, default=0) + 1
    path = MIGRATIONS / f"{next_id:04d}_{description}.sql"
    path.write_text(
        f"-- Migration {next_id:04d}: {description.replace('_', ' ')}\n"
        "-- Do not add BEGIN, COMMIT, or ROLLBACK.\n"
        "-- Use explicit column lists in every INSERT.\n\n",
        encoding="utf-8",
    )
    print(path.relative_to(ROOT))
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
