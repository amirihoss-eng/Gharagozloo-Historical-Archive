# Gharagozloo Historical Archive — v0.4 / Migration 0002

## Canonical archive

`archive.sqlite` is the single source of truth. Git preserves every prior version.

## Reliable migration pipeline

From the repository folder:

```text
python tools/validate_archive.py
python tools/new_migration.py chapter 3 next batch
python tools/apply_migration.py migrations/0003_chapter_3_next_batch.sql
python tools/validate_archive.py
python tools/export_csv.py
```

`apply_migration.py` automatically:

1. creates a timestamped database backup;
2. refuses already-applied or altered migrations;
3. applies the SQL in one transaction;
4. records the migration checksum;
5. runs SQLite integrity and foreign-key checks;
6. restores the backup if validation fails.

## Rules for future SQL migrations

- Do not put `BEGIN`, `COMMIT`, or `ROLLBACK` in migration files.
- Always name files `NNNN_description.sql`.
- Always use explicit column names in `INSERT` statements.
- Never edit a migration after it has been applied.
- Correct mistakes with a new migration.
- Do not edit exported CSV files as archive data.

## Migration 0001 validation

Migration 0001 is present and its Chapter 3 data is in `archive.sqlite`.
The current database passes `PRAGMA integrity_check` and `PRAGMA foreign_key_check`.

## Repository workflow

Mine pages → write migration → apply → validate → export → Git commit → push.
