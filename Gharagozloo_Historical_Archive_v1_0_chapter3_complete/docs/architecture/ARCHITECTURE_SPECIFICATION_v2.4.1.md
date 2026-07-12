# Gharagozloo Historical Archive — Architecture Specification

**Archive release documented:** v2.4.1  
**Canonical database:** `archive.sqlite`  
**Specification generated:** 2026-07-12  
**Application tables:** 40  
**Declared foreign keys:** 52  
**Latest applied migration:** 0016  
**Validation status:** PASS — 0 errors, 0 warnings

## 1. Purpose and scope

The Gharagozloo Historical Archive is a source-critical historical knowledge system designed to preserve, reconcile, and publish structured evidence about the Gharagozloo family, related branches, institutions, estates, military formations, political activity, and documentary artifacts.

The archive is not a conventional family-tree file and not merely a transcription database. Its architecture supports:

- canonical identities and alternate names;
- genealogical, marital, political, institutional, and military relationships;
- events, offices, titles, estates, organizations, and places;
- atomic historical claims linked to precise citations;
- explicit assessment of evidence quality and interpretive status;
- non-destructive identity reconciliation;
- preservation of conflicts, uncertainty, and rejected hypotheses;
- reproducible database evolution through migrations;
- validation, export, dossier generation, and future public presentation.

The current release represents the structured mining of Source S0001 across Chapters 1–4 and the documentary back matter, followed by three reconciliation waves.

## 2. Architectural principles

### 2.1 The database is the canonical source of truth

`archive.sqlite` is the authoritative machine-readable archive. CSV exports, dossier files, reports, and visualizations are derived representations.

No derived file should silently override the database.

### 2.2 Historical assertions are evidence-bearing claims

Facts are not treated as self-authenticating prose. Important assertions belong in `claims` and should be supported through `claim_citations`. Interpretive status is further described through `claim_evidence_profiles`.

This separates:

1. what the archive asserts;
2. where the assertion comes from;
3. what kind of evidence it is;
4. how confidently the archive currently interprets it.

### 2.3 Canonical entities are separated from names and labels

A person, organization, title, estate, place, or military unit has one canonical record. Alternate spellings, scripts, transliterations, aliases, and historical forms are stored separately where supported.

This prevents variant names from becoming duplicate identities.

### 2.4 Reconciliation is non-destructive

Duplicate or superseded person IDs are preserved through `person_identity_redirects`. Explicit non-matches are preserved through `identity_exclusions`.

The archive therefore records not only the final identity decision, but also the history of how that decision was reached.

### 2.5 Uncertainty is preserved

Conflicting evidence is stored in `evidence_conflicts`; open questions are tracked in `research_questions`; evidence profiles distinguish fact, synthesis, opinion, inference, unresolved interpretation, and rejected hypothesis.

The architecture avoids converting uncertainty into false certainty.

### 2.6 Schema change is migration-driven

All structural and major data changes are applied through ordered SQL migrations recorded in `schema_migrations`.

The live archive currently includes migrations `0001` through `0016`.

## 3. System context

```text
Historical sources and user-supplied family knowledge
                      |
                      v
              Research extraction
                      |
                      v
          Imports / migration SQL patches
                      |
                      v
               archive.sqlite
          /            |             \
         v             v              v
   validation      CSV exports      dossiers/docs
         |             |              |
         +-------------+--------------+
                       |
                       v
          future website / explorer / API
```

The repository includes four operational layers:

1. **Research inputs** — source scans, structured imports, extracted tables, and interpretive notes.
2. **Canonical storage** — the SQLite archive.
3. **Quality control** — migrations, validators, reconciliation records, and audit trails.
4. **Publication outputs** — CSV exports, dossiers, diagrams, reports, and future interactive interfaces.

## 4. Repository architecture

```text
archive.sqlite                Canonical archive database
migrations/                   Ordered, reproducible schema and data changes
tools/                        Migration, validation, export, and patch utilities
imports/                      Structured source-mining and reconciliation inputs
exports/                      Table-level CSV snapshots derived from the database
dossiers/
  foundational/               Initial dossier set for 25 selected people
  reconciled/                 Silver-level reconciled dossiers
docs/
  schema/                     Existing schema evolution notes
  reconciliation/             Completion records for Waves 1–3
backups/                      Pre-migration SQLite safety copies
validation_report.json        Latest machine-readable validation outcome
manifest.json                 Release metadata; currently stale and due for update
README.md                     Entry documentation; currently stale and due for update
```

### 4.1 Important documentation discrepancy

The live database and Git history identify the archive as v2.4.1 with migration 0016 applied. However, the repository's current `README.md` and `manifest.json` still describe v1.0 / migration 0005 and Chapter 3-only status.

This is a documentation-alignment defect, not a database defect. It should be corrected in the next release.

## 5. Logical data architecture

The schema is organized into five interdependent subsystems.

### 5.1 Historical entity subsystem

Primary tables:

- `persons`
- `places`
- `events`
- `organizations`
- `roles`
- `titles`
- `estates`
- `military_units`
- `sources`
- `artifacts`

These tables define independent entities that can be cited, linked, and reused.

The archive currently contains:

| Entity | Rows |
|---|---:|
| Persons | 75 |
| Places | 45 |
| Events | 74 |
| Organizations | 21 |
| Roles | 12 |
| Titles | 25 |
| Estates | 7 |
| Military units | 7 |
| Sources | 131 |
| Artifacts | 15 |

### 5.2 Relationship and participation subsystem

Primary tables:

- `person_names`
- `organization_names`
- `relationships`
- `event_persons`
- `person_titles`
- `person_role_assignments`
- `organization_memberships`
- `estate_associations`
- `military_commands`
- `artifact_persons`
- `title_equivalence`
- `title_successions`

This subsystem answers questions such as:

- Who was related to whom?
- Which person participated in an event?
- Who held a title or office?
- Which family or organization controlled an estate?
- Who commanded a military unit?
- Which artifact depicts a particular person?
- Which titles were equivalent, variant, or sequential?

The design uses junction tables rather than embedding lists inside entity rows. This supports many-to-many relationships and preserves dates, roles, and notes for each association.

### 5.3 Evidence and provenance subsystem

Primary tables:

- `bibliography_entries`
- `citations`
- `claims`
- `claim_citations`
- `claim_evidence_profiles`
- `entity_citations`
- `evidence_types`
- `evidence_conflicts`

The intended evidence chain is:

```text
source
  |
  v
citation
  |
  v
claim_citations
  |
  v
claim
  |
  v
claim_evidence_profiles
```

`entity_citations` supports direct entity-level citation when evidence applies broadly to a person, event, title, or other entity.

`evidence_conflicts` preserves contradictions and unresolved discrepancies.

At v2.4.1:

- claims: **151**
- citations: **86**
- claim–citation links: **173**
- evidence profiles: **35**
- evidence conflicts: **3**

All current claims have at least one citation, but only a subset has a detailed evidence profile. Expanding evidence-profile coverage is therefore an enrichment priority.

### 5.4 Identity and reconciliation subsystem

Primary tables:

- `person_reconciliation`
- `person_identity_redirects`
- `identity_exclusions`
- `reconciliation_waves`
- `thematic_reconciliation_status`
- `person_dossiers`

This subsystem records:

- which people have been reviewed;
- the quality level reached;
- duplicate IDs redirected to canonical identities;
- candidate identities explicitly kept separate;
- the scope and completion of each reconciliation wave;
- dossier availability and ordering.

The current archive contains:

- reconciliation waves: **3**
- person reconciliation records: **16**
- identity redirects: **2**
- identity exclusions: **6**
- foundational dossier registrations: **25**

The reconciled dossiers are currently described as **Silver — complete for Source S0001**, not complete biographies across all possible sources.

### 5.5 Research and operations subsystem

Primary tables:

- `research_questions`
- `schema_migrations`
- `metadata`
- `change_log`

This subsystem governs the archive as a living research project.

`research_questions` keeps unresolved work queryable. `schema_migrations` provides reproducibility. `change_log` records archive evolution. `metadata` stores release and project-wide settings.

## 6. Key entity relationships

### 6.1 Person-centered historical graph

```text
persons
  ├── person_names
  ├── relationships ──> persons
  ├── event_persons ──> events
  ├── person_titles ──> titles
  ├── person_role_assignments ──> roles / organizations / places
  ├── organization_memberships ──> organizations
  ├── estate_associations ──> estates
  ├── military_commands ──> military_units
  ├── artifact_persons ──> artifacts
  ├── person_reconciliation
  └── person_dossiers
```

`persons` is the main biographical hub, but it is not the only center of the model. Events, organizations, estates, titles, places, and sources remain independent entities so they can support their own histories and future pages.

### 6.2 Event model

`events` stores the event itself. `event_persons` records participants and their roles.

This allows one event to involve many people and one person to participate in many events.

### 6.3 Office and role model

Formal service is represented through `person_role_assignments`, rather than storing one office directly on the person.

A role assignment can connect:

- one person;
- one normalized role;
- optionally one organization;
- optionally one place;
- a date range;
- supporting notes and citations.

Titles are kept distinct from roles because a Qajar title, honorific, military rank, office, and administrative function are not always semantically identical.

### 6.4 Estate model

`estates` defines the property or landed center. `estate_associations` connects it to a person or organization with an association type.

This supports future estate histories without forcing ownership, administration, residence, inheritance, or family affiliation into one undifferentiated relationship.

### 6.5 Artifact model

`artifacts` defines a scanned image, portrait, diagram, genealogy chart, document, or other object. `artifact_persons` links people to it and can preserve uncertain identification.

This is particularly important for family-tree diagrams and portraits where the visual source may be corroborative but not conclusive.

## 7. Polymorphic references

Several tables use a flexible entity reference expressed as a type field plus an identifier field:

- `claims.subject_type + claims.subject_id`
- `entity_citations.entity_type + entity_citations.entity_id`
- `evidence_conflicts.entity_type + evidence_conflicts.entity_id`
- `change_log.entity_type + change_log.entity_id`

This enables one table to refer to several entity classes.

### Benefits

- avoids separate claim tables for people, events, estates, titles, and organizations;
- keeps evidence logic uniform;
- supports future entity types without large schema duplication.

### Risks

SQLite cannot enforce these references with ordinary foreign keys. Correctness therefore depends on:

- controlled allowed values for the type field;
- validator checks that the target entity exists;
- migration discipline;
- test coverage when new entity types are introduced.

The existing validator should remain the enforcement layer for polymorphic integrity.

## 8. Evidence classification architecture

Schema v2.1 introduced explicit evidence classification because Source S0001 contains:

- direct narrative statements;
- captions and diagrams;
- authorial synthesis;
- scholarly opinion;
- unresolved inference;
- internally conflicting claims;
- theories the author discusses but rejects.

The archive therefore distinguishes the existence of a claim from the archive's assessment of that claim.

This is essential for Chapter 1, where early tribal-origin narratives and discontinuous historical names must not be converted into a fabricated continuous pedigree.

## 9. Dossier architecture

The repository contains two dossier layers.

### 9.1 Foundational dossiers

Twenty-five initial files provide a person-oriented research surface for selected figures. They should be understood as foundational records, not automatically as Gold-standard biographies.

### 9.2 Reconciled dossiers

Sixteen reconciled dossiers represent people reviewed through the master reconciliation process. The Wave documentation defines their status as:

> Silver — complete for Source S0001

This means all currently identifiable S0001 evidence has been reconciled, identity conflicts reviewed, and remaining gaps registered. It does not mean no additional historical evidence exists elsewhere.

### 9.3 Gold-record implication

Gold should be treated as a future, explicit quality designation with documented criteria. A Gold record would normally require broader source coverage, resolved core identity and chronology, citation completeness, conflict handling, and human review.

Naser al-Molk served as the first high-detail model dossier, but the database currently does not assign Gold status to any record.

## 10. Migration and release architecture

### 10.1 Migration workflow

```text
research extraction
      |
      v
numbered SQL migration
      |
      v
automatic backup
      |
      v
apply_migration.py
      |
      v
archive.sqlite
      |
      v
validate_archive.py
      |
      v
validation_report.json
```

The migration sequence records the project's evolution from Chapter 3 extraction through schema expansion, Chapters 1–2 completion, evidence classification, and three reconciliation waves.

### 10.2 Backup policy

Pre-migration backups are stored in `backups/` with migration and timestamp information.

This provides recovery capability and supports auditability.

### 10.3 Release rule

A coherent release should include:

- updated `archive.sqlite`;
- all new migrations;
- passing validation report;
- updated manifest and README;
- regenerated exports where required;
- updated project-state and release notes;
- architecture documentation when schema behavior changes.

## 11. Validation architecture

The current validation report records:

- SQLite integrity: `ok`
- foreign-key and archive-rule errors: none
- warnings: none
- status: `PASS`

Validation should cover two distinct classes:

### 11.1 Database-native integrity

- SQLite integrity check;
- declared foreign keys;
- uniqueness and required fields;
- migration consistency.

### 11.2 Archive-semantic integrity

- valid polymorphic references;
- claim citation coverage;
- canonical redirect correctness;
- no redirect loops;
- reconciliation consistency;
- evidence-profile vocabulary;
- dossier references;
- controlled-value validation;
- impossible or contradictory date structures where detectable.

## 12. Export and publication architecture

The `exports/` directory contains table-level CSV snapshots.

CSV is useful for:

- review;
- diffing;
- analysis;
- interoperability;
- spreadsheet inspection;
- website preprocessing.

CSV is not the canonical editing surface. Changes should flow into SQLite through migrations, not by manually modifying exports.

Future publication layers may include:

- person dossier pages;
- family-tree and graph explorer;
- event timeline;
- estate atlas;
- title and office succession views;
- source and citation viewer;
- artifact gallery;
- research-question dashboard.

The present schema can support these layers without major redesign.

## 13. Security, privacy, and stewardship

The archive contains both historical and modern family information. Publication architecture should distinguish:

- public historical data;
- living-person information;
- private family testimony;
- uncertain or sensitive assertions;
- internal editorial notes.

A future website should use a publication policy or visibility field rather than exposing every database record automatically.

The canonical repository should continue to use version control and backup discipline. Sensitive source material should not be published merely because it exists in the research database.

## 14. Current strengths

1. **Strong provenance model** — claims and citations are structurally separated.
2. **Non-destructive reconciliation** — duplicate identities remain auditable.
3. **Scholarly uncertainty model** — conflicts and interpretation are preserved.
4. **Extensible entity design** — supports people, organizations, events, estates, titles, places, artifacts, and military units.
5. **Reproducible evolution** — 16 migrations and automated backups.
6. **Validated current state** — PASS with zero errors and warnings.
7. **Publication readiness at the data-model level** — major explorer use cases are already representable.

## 15. Current limitations and architectural debt

### 15.1 Stale release documentation

`README.md` and `manifest.json` do not reflect v2.4.1. This is the most visible continuity problem.

### 15.2 Partial evidence-profile coverage

All claims are cited, but only 35 of 151 claims have explicit evidence profiles.

### 15.3 Sparse direct entity citation

Entity-level citation coverage is less complete than claim-level coverage. This may complicate simple person and event pages unless publication queries aggregate claim citations.

### 15.4 Polymorphic references depend on validators

This is an acceptable design choice, but it creates a permanent validator obligation.

### 15.5 Quality-level vocabulary requires formalization

Foundational, reconciled, Silver, and Gold need one documented quality rubric so dossier labels remain consistent.

### 15.6 Repository naming reflects an earlier phase

The directory name `Gharagozloo_Historical_Archive_v1_0_chapter3_complete` no longer describes the actual release. Renaming may be considered in a controlled future release, but should not be done casually if scripts or Git history depend on it.

## 16. Recommended next-release actions

For the proposed architecture-documentation release:

1. add this specification under `docs/architecture/`;
2. add the Entity Relationship Map, Schema Audit, and Data Dictionary;
3. create `docs/project/PROJECT_STATE.md`;
4. update `README.md` to reflect v2.4.1 or the new release number;
5. update `manifest.json` with the correct database version and last migration;
6. add release notes and a concise architecture index;
7. rerun validation;
8. package and commit as one coherent release.

No major schema rewrite is recommended before these documentation and continuity corrections are complete.

## 17. Architectural decision summary

| Decision | Current approach | Rationale |
|---|---|---|
| Canonical store | SQLite | Portable, queryable, transactional, versionable through migrations |
| Identity model | Canonical record plus alternate names and redirects | Prevents duplicate identities and preserves audit history |
| Historical facts | Atomic claims | Separates assertion from evidence and interpretation |
| Evidence | Source → citation → claim links | Precise provenance |
| Uncertainty | Evidence profiles, conflicts, research questions | Avoids false certainty |
| Relationships | Junction tables | Supports many-to-many historical structures |
| Entity-general evidence | Polymorphic references | Uniform evidence model across entity classes |
| Evolution | Numbered migrations with backups | Reproducibility and recovery |
| Quality control | Automated validator | Enforces database and archive-semantic integrity |
| Publication | Derived views and exports | Keeps research database canonical |

## 18. Related documentation

This specification should be maintained together with:

- `ENTITY_RELATIONSHIP_MAP_v2.4.1.svg`
- `SCHEMA_AUDIT_v2.4.1.md`
- `DATA_DICTIONARY_v2.4.1.md`
- future `PROJECT_STATE.md`
- future `ROADMAP.md`
- reconciliation completion documents
- schema evolution documents

---

**Specification status:** Complete for the v2.4.1 repository audit.  
**Next review trigger:** Any migration that changes tables, foreign keys, polymorphic targets, validation rules, or dossier quality levels.
