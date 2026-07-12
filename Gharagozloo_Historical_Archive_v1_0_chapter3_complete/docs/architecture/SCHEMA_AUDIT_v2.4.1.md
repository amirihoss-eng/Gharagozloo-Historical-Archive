# Gharagozloo Historical Archive — Schema Audit v2.4.1

**Audit basis:** live `archive.sqlite` from repository ZIP uploaded 2026-07-12  
**Database integrity:** PASS  
**Foreign-key violations:** 0  
**Application tables:** 40  
**Declared foreign-key relationships:** 52

## Executive assessment

The schema is structurally sound, internally consistent, and already suitable for a serious source-based historical archive. It is substantially more advanced than a genealogy database: it separates historical entities, evidence, citations, identity reconciliation, titles, offices, estates, military structures, artifacts, and research management.

The principal weakness is not corruption or poor normalization. It is uneven scholarly coverage across subsystems. Claims are well cited, but direct entity-level citation coverage, evidence-profile coverage, and full-person reconciliation remain incomplete.

## Strengths

1. **Clear entity separation** — persons, places, events, organizations, roles, titles, estates, military units, sources, claims, citations, and artifacts are modeled independently.
2. **Strong junction-table design** — event participation, titles, offices, memberships, commands, estate associations, artifact depictions, and citation links are normalized rather than embedded as free text.
3. **Evidence-aware scholarship** — claims are distinct from citations; evidence type, assertion scope, author position, confidence, conflicts, and unresolved questions are preserved.
4. **Identity reconciliation subsystem** — aliases, exclusions, redirects, reconciliation waves, and thematic reconciliation prevent silent conflation of historical people.
5. **Migration discipline** — 16 recorded migrations with filename and SHA-256 provenance.
6. **Validation discipline** — integrity check passes and no foreign-key violations exist.
7. **Controlled vocabularies where most valuable** — claim confidence, evidence scope, source position, role category, organization type, reconciliation level, and conflict status use checks.

## Current coverage snapshot

| Area | Current state |
|---|---:|
| Persons | 75 |
| Confirmed persons | 70 |
| Merged duplicate person records | 2 |
| Events | 74, all confirmed |
| Claims | 151 |
| Claims with citations | 151 / 151 |
| Claim-citation links | 173 |
| Claims with evidence profiles | 35 / 151 |
| Relationships | 46 |
| Person dossiers | 25 |
| Reconciled people | 16, all silver and complete for S0001 |
| Sources | 131 |
| Citations | 86 |
| Research questions | 19 |

## Findings requiring improvement

### 1. Evidence profiling is incomplete
Only 35 of 151 claims have entries in `claim_evidence_profiles`. The schema supports nuanced source criticism, but most claims have not yet been classified by evidence type, assertion scope, and source position.

**Recommendation:** make evidence-profile completion the next scholarly quality pass, prioritizing probable, possible, and disputed claims first.

### 2. Entity-level citation coverage is sparse
All claims are cited, which is excellent. However, many direct entity records do not yet have `entity_citations`:

- 67 of 75 persons have no direct person-level citation.
- 62 of 74 events have no direct event-level citation.
- 46 of 46 relationships have no direct relationship-level citation.

This is not necessarily missing evidence because claims may carry the citations, but it limits easy provenance display for future dossiers and the website.

**Recommendation:** define a clear policy: either claims are the sole evidentiary layer, or high-value entities also receive direct citations. Avoid duplicating citations without a documented display purpose.

### 3. Reconciliation coverage is partial
Only 16 of 75 people are represented in `person_reconciliation`, although all 16 are marked `silver` and `complete_for_source`.

**Recommendation:** preserve the distinction between the 25 foundational dossiers and the 16 fully reconciled silver dossiers. Do not describe all 25 as Gold Records. Promote records only when the criteria are explicitly met.

### 4. Preferred-name coverage is uneven
18 persons lack rows in `person_names`. Their preferred names remain in `persons`, so the database is functional, but alias and transliteration coverage is incomplete.

**Recommendation:** require at least one `person_names` row for every active canonical person, ideally with English/transliterated and Persian forms where available.

### 5. Several status fields remain unconstrained
Fields such as `verification_status`, `support_type`, `source_type`, `artifact_type`, `transcription_status`, `research_questions.status`, and `priority` are free text.

**Recommendation:** do not immediately hard-code all values with CHECK constraints. First export current distinct values, define controlled vocabularies in documentation, then add constraints through a later migration if stable.

### 6. Date model is intentionally textual but not machine-ready
The schema uses `date_text`, `start_date_text`, and `end_date_text`, which is appropriate for uncertain historical dates. However, chronological querying will remain limited.

**Recommendation:** retain original text, but later add optional normalized fields such as earliest/latest year, calendar system, and date precision. This should be additive, not a replacement.

### 7. Polymorphic references depend on validation
`claims`, `entity_citations`, `evidence_conflicts`, and `change_log` use entity type plus entity ID instead of direct foreign keys.

**Recommendation:** keep the design, but expand `validate_archive.py` so every polymorphic reference is checked against its declared target table and allowed entity-type vocabulary.

### 8. Indexing is adequate for current size, not yet optimized for growth
Primary keys and many major person-side foreign keys are indexed. Some frequently queried columns are not explicitly indexed, including citation source, event place, estate place, organization membership organization, person title title, and several status/type columns.

**Recommendation:** no urgent migration is required at 40 tables and modest row counts. Add indexes only when query patterns or the website justify them; avoid premature indexing.

### 9. README is stale
The top-level README still labels the archive `v1.0` and says Chapter 3 is complete while Chapter 4 begins afterward. The live repository is at v2.4.1 with all chapters mined and three reconciliation waves completed.

**Recommendation:** treat README correction as urgent documentation work in the next release.

## Architectural judgment

**Schema integrity:** A  
**Normalization:** A  
**Evidence model:** A-  
**Identity reconciliation:** A-  
**Coverage consistency:** B+  
**Documentation alignment:** B  
**Readiness for second-source ingestion:** A-

## Recommended next actions

1. Update `README.md` and create `docs/project/PROJECT_STATE.md` for v2.4.1.
2. Document the exact dossier levels: foundational, reconciled silver, Gold, and future Platinum.
3. Complete evidence profiles for all non-confirmed claims, then remaining confirmed claims.
4. Decide and document the entity-citation policy before bulk-adding citations.
5. Add validator checks for all polymorphic references and controlled-vocabulary drift.
6. Build a data dictionary from the current live schema.
7. Defer schema expansion until this documentation and quality pass is complete.

## Conclusion

No structural repair is required before continuing. The database is healthy and intelligently designed. The next release should emphasize documentation alignment, evidence classification coverage, and explicit quality-level definitions rather than adding more tables.
