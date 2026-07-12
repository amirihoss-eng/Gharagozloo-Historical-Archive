# Gharagozloo Archive v2.0 Patch

This patch contains two sequential migrations:

1. `0009_expand_schema_v2_0.sql` — adds institutional, military, role, and estate tables.
2. `0010_complete_chapter2_structured_data.sql` — loads the structured Chapter 2 extraction.

## Apply with the one-command installer

From the archive folder containing `archive.sqlite`, run:

```powershell
py tools\apply_patch.py "C:\full\path\to\Gharagozloo_Archive_v2_0_Chapter2_Patch.zip"
```

The installer applies both migrations in order, validates the database, and regenerates all CSV exports.

## Suggested commit

```text
Upgrade archive to v2.0 and complete structured Chapter 2 mining
```

Do not copy the outer patch folder into the repository.
