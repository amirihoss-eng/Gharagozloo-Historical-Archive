# Development Journal

## 2026-08-09 — Public Baseline and Local Curator Mode

### Stable public baseline

- Render service: `gharagozloo-historical-archive`
- Public URL: https://gharagozloo-historical-archive.onrender.com
- Deployment branch: `research/hajilou-figure4-reconstruction`
- Original public baseline: `7b2ec88`
- Render root directory: `Gharagozloo_Historical_Archive_v1_0_chapter3_complete`
- Start command: `python explorer/app.py`
- Health path: `/health`
- Auto-deploy: on commit
- Public behavior verified after deployment.

### Phase 1 — Photo Curator

Commit: `657fef3` — `Add local photo curator mode with audit history`

Completed:

- Added `edit_revisions` and `manual_edit_entities` through migration 0053.
- Manual operations record `Manual Edit` provenance and before/after state.
- Added local-only photo upload for JPEG, PNG, and WebP.
- Added links between new or existing photos and existing people.
- Added caption, description, source, and notes editing.
- Added primary portrait selection.
- Only manually created artifacts and photo-person links can be removed.
- Manual removals can be restored from the revision history.
- Research/migration artifacts and links remain protected.
- Curator navigation and mutation endpoints return unavailable in Render/public mode.
- Corrected person gallery cards so linked names display instead of “No canonical person linked.”
- Artifact IDs are never reused after removal.

Archive changes made through Curator Mode:

- A0253 was created for Ali Amiri Gharagozloo and later removed; its file is retained for restoration.
- A0254 is the active photograph for Ali Amiri Gharagozloo (`P0178`).
- A0254 is his primary portrait.
- The landing-page dedication now displays A0254.

### Phase 2 — People and Relationship Curator

Commit: `c4cae4b` — `Add audited people and relationship curator`

Completed:

- Added local-only creation of people/nodes with permanent non-reused P-IDs.
- Added audited editing of core person identity fields.
- Added creation of parent, father, spouse, sibling, and relative links with permanent R-IDs.
- Only manually created people and relationships can be removed or restored.
- Research/migration people and relationships remain protected.
- A manually created person cannot be removed until their relationships and photo links are removed.
- Replaced unreliable browser prompt editing with an inline person edit form.
- Verified new people and relationships appear in People, person records, and the Family Graph.

Archive changes made through Curator Mode:

- Created Soudabeh Keykavousi as `P0180`.
- Created spouse relationship `R0162` between `P0180` and Dr. Alireza Amiri Gharagozloo (`P0009`).
- Soudabeh’s death date and branch are intentionally blank.
- Both records have active Manual Edit ownership and audit history.

### Validation and deployment status

- SQLite integrity: PASS.
- Foreign-key validation: PASS.
- Archive validator: 0 errors, 0 warnings.
- Photo create/edit/link/primary/remove/revert lifecycle: PASS.
- Person create/edit/remove/revert lifecycle: PASS.
- Relationship create/remove/revert lifecycle: PASS.
- Public-mode mutation protection: PASS.
- Commits `657fef3` and `c4cae4b` pushed successfully.
- Render deployment of `c4cae4b` visually verified by the archive owner.
- Public site remains read-only; Curator Mode is local only.

### Resume point

Begin the next session from commit `c4cae4b` plus this journal entry. Suggested next work:

1. Decide whether Phase 3 should cover aliases/Persian names, richer relationship editing, or event/biography editing.
2. Review whether living-person privacy rules are needed before adding more contemporary relatives.
3. Keep every new editing surface behind the existing local-only capability gate.
4. Continue using `Manual Edit` provenance and removal protection rather than directly deleting research/migration records.
