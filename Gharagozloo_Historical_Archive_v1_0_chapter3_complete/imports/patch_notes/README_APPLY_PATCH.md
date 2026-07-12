# Gharagozloo Archive v2.1 — Chapter 1 Patch

This patch contains:

- `0011_add_evidence_classification.sql`
- `0012_complete_chapter1_historical_origins.sql`
- schema documentation;
- Chapter 1 audit/import summaries.

Apply from the archive root with:

```powershell
py tools\apply_patch.py "C:\full\path\to\Gharagozloo_Archive_v2_1_Chapter1_Patch.zip"
```

The installer applies migrations in numerical order, validates the archive, and
regenerates exports.

Suggested commit:

```text
Archive v2.1: evidence classification and complete Chapter 1 mining
```
