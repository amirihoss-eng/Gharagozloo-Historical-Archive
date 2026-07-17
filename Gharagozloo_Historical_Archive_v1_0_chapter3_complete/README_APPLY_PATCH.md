GHARAGOZLOO HISTORICAL ARCHIVE v2.5.0 — LIVING FAMILY PATCH

INSTALL WITH YOUR EXISTING PATCH WORKFLOW

1. Close Explorer.
2. Extract this ZIP.
3. Copy the contents into the root of your repository.
   - This adds migrations\0017_add_living_family_branch.sql
   - This adds docs\releases\RELEASE_NOTES_v2.5.0.md
4. Open PowerShell in the repository's tools folder.
5. Run:

   py .\apply_migration.py ..\migrations\0017_add_living_family_branch.sql
   py .\validate_archive.py
   py .\export_csv.py

6. Launch Explorer again.
7. Expand the Amiri branch under Dr. Alireza / Hossein.

EXPECTED RESULT

- 7 new people
- 12 new relationships
- 7 new evidence-backed claims
- source S0002 and citation X0087
- archive version 2.5.0

This patch does not overwrite archive.sqlite directly. The migration tool creates a backup before changing the database.
