# Apply Archive v2.2 — Reconciliation Wave 1

From the archive root, run:

```powershell
py tools\apply_patch.py "C:\full\path\to\Gharagozloo_Archive_v2_2_Reconciliation_Wave1_Patch.zip"
```

The installer will copy the migration and dossier files, apply Migration 0013,
validate the database, and regenerate exports.

Suggested commit:

```text
Archive v2.2: complete Master Reconciliation Wave 1
```
