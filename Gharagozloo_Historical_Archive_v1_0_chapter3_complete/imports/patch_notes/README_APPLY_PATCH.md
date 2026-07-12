# Apply Archive v2.4 — Reconciliation Waves 2 and 3

This patch was built from the latest uploaded SQLite master containing Migration 0013.

From the archive root, run:

```powershell
py tools\apply_patch.py "C:\full\path\to\Gharagozloo_Archive_v2_4_Reconciliation_Waves2_3_Patch.zip"
```

If the installer says the SQL files are already identical but no new migration was applied,
run manually from the archive root:

```powershell
py tools\apply_migration.py migrations\0014_master_reconciliation_wave2.sql
py tools\apply_migration.py migrations\0015_thematic_reconciliation_wave3.sql
py tools\validate_archive.py
py tools\export_csv.py
```

Suggested commit:

```text
Archive v2.4: complete reconciliation Waves 2 and 3
```
