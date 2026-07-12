# Gharagozloo Historical Archive — Data Dictionary

**Archive version:** v2.4.1  
**Database audited:** `archive.sqlite`  
**Dictionary generated:** 2026-07-12  
**Scope:** 40 application tables in the live SQLite archive

## Purpose

This document defines the meaning, structure, constraints, and relationships of the Gharagozloo Historical Archive database. It was generated from the live SQLite schema, then supplemented with plain-language descriptions of each table and field.

> **Authority note:** column types, nullability, primary keys, defaults, foreign keys, indexes, and row counts are taken directly from the database. Plain-language purpose statements are documentary interpretations of the implemented schema.

## Conventions

- Permanent identifiers are stored as `TEXT` values such as `P...`, `S...`, or other archive-defined IDs.
- `NOT NULL` means the value is required by SQLite.
- Composite primary keys identify junction-table records without introducing a synthetic ID.
- Foreign-key delete behavior is reported exactly as implemented.
- Polymorphic pairs such as `entity_type + entity_id` and `subject_type + subject_id` are validated by application logic rather than conventional SQLite foreign keys.

## Schema inventory

| System | Tables |
|---|---|
| Core entities | `persons`, `places`, `events`, `organizations`, `roles`, `titles`, `estates`, `military_units`, `sources`, `artifacts` |
| Names, relationships, and participation | `person_names`, `organization_names`, `relationships`, `event_persons`, `person_titles`, `person_role_assignments`, `organization_memberships`, `estate_associations`, `military_commands`, `artifact_persons`, `title_equivalence`, `title_successions` |
| Evidence and provenance | `bibliography_entries`, `citations`, `claims`, `claim_citations`, `claim_evidence_profiles`, `entity_citations`, `evidence_types`, `evidence_conflicts` |
| Dossiers, identity, and reconciliation | `person_dossiers`, `person_reconciliation`, `person_identity_redirects`, `identity_exclusions`, `reconciliation_waves`, `thematic_reconciliation_status` |
| Research and archive operations | `research_questions`, `schema_migrations`, `metadata`, `change_log` |

## Table summary

| Table | Purpose | Rows |
|---|---|---:|
| `artifact_persons` | Junction table linking artifacts to depicted, mentioned, or otherwise associated people. | 19 |
| `artifacts` | Catalog of visual or documentary artifacts, including images, charts, family trees, and scanned items. | 15 |
| `bibliography_entries` | Raw and normalized bibliography entries extracted from a source. | 129 |
| `change_log` | Operational audit trail recording entity-level changes made to the archive. | 32 |
| `citations` | Precise source references, typically at page or passage level. | 86 |
| `claim_citations` | Many-to-many links between historical claims and the citations supporting or discussing them. | 173 |
| `claim_evidence_profiles` | Structured assessment of the evidence quality, status, and interpretation for a claim. | 35 |
| `claims` | Atomic historical assertions about people, places, events, organizations, estates, or other entities. | 151 |
| `entity_citations` | Direct citation links to archive entities when a citation supports the entity as a whole. | 49 |
| `estate_associations` | Associations between estates and people or organizations, including ownership, control, residence, or administration. | 11 |
| `estates` | Named estates, villages, landed properties, or territorial holdings. | 7 |
| `event_persons` | Junction table connecting people to events with a defined participation role. | 113 |
| `events` | Historical events, appointments, campaigns, political episodes, and other dated or date-bounded occurrences. | 74 |
| `evidence_conflicts` | Recorded contradictions, ambiguities, or unresolved disagreements in the evidence. | 3 |
| `evidence_types` | Controlled vocabulary describing classes of evidence used to evaluate claims. | 10 |
| `identity_exclusions` | Explicit declarations that two identity candidates must not be merged. | 6 |
| `metadata` | Project-level key-value metadata for the archive. | 30 |
| `military_commands` | Records of a person's command or service relationship to a military unit. | 14 |
| `military_units` | Military formations, regiments, corps, detachments, or other organized forces. | 7 |
| `organization_memberships` | Membership or affiliation records connecting people to organizations. | 9 |
| `organization_names` | Alternate, historical, Persian, transliterated, or normalized names for organizations. | 13 |
| `organizations` | Political, military, tribal, administrative, family, or institutional organizations. | 21 |
| `person_dossiers` | Curated dossier records for selected people, including sequence and dossier status. | 25 |
| `person_identity_redirects` | Canonical redirects from deprecated or duplicate person identifiers to the surviving person record. | 2 |
| `person_names` | Alternate names, spellings, scripts, transliterations, and name forms for people. | 93 |
| `person_reconciliation` | Per-person reconciliation status, review level, and resolution notes. | 16 |
| `person_role_assignments` | Assignments of people to formal roles, often within an organization and bounded by dates. | 7 |
| `person_titles` | Titles and honorifics held or associated with a person. | 38 |
| `persons` | Canonical registry of historical and modern persons represented in the archive. | 75 |
| `places` | Canonical registry of geographic places. | 45 |
| `reconciliation_waves` | Metadata describing each formal identity or thematic reconciliation wave. | 3 |
| `relationships` | Person-to-person relationships such as parentage, siblinghood, marriage, or other kinship/social links. | 46 |
| `research_questions` | Open, resolved, or deferred historical research questions tracked by the archive. | 19 |
| `roles` | Controlled vocabulary of offices, functions, occupations, and institutional roles. | 12 |
| `schema_migrations` | Record of migration scripts applied to the live SQLite database. | 16 |
| `sources` | Catalog of books, documents, images, oral testimony, and other evidentiary sources. | 131 |
| `thematic_reconciliation_status` | Status tracking for thematic reconciliation domains such as titles, estates, offices, and identity. | 5 |
| `title_equivalence` | Relationships among equivalent, variant, broader, narrower, or potentially conflated titles. | 3 |
| `title_successions` | Documented succession or transfer relationships between title holders. | 2 |
| `titles` | Controlled registry of titles, ranks, honorifics, and styled offices. | 25 |

# Core entities

## `persons`

Canonical registry of historical and modern persons represented in the archive.

**Current rows:** 75

### Columns

| Column | Type | Required | Key / default | Meaning |
|---|---|---:|---|---|
| `person_id` | `TEXT` | No | PK position 1 | Permanent person identifier. |
| `preferred_name_en` | `TEXT` | Yes | — | Preferred name en. |
| `preferred_name_fa` | `TEXT` | No | — | Preferred name fa. |
| `sex` | `TEXT` | No | default `'U'` | Sex. |
| `birth_date_text` | `TEXT` | No | — | Birth date text. |
| `death_date_text` | `TEXT` | No | — | Death date text. |
| `branch` | `TEXT` | No | — | Branch. |
| `summary` | `TEXT` | No | — | Summary. |
| `verification_status` | `TEXT` | Yes | default `'provisional'` | Verification status. |
| `created_at` | `TEXT` | Yes | — | Record creation timestamp. |
| `updated_at` | `TEXT` | Yes | — | Record modification timestamp. |

## `places`

Canonical registry of geographic places.

**Current rows:** 45

### Columns

| Column | Type | Required | Key / default | Meaning |
|---|---|---:|---|---|
| `place_id` | `TEXT` | No | PK position 1 | Permanent place identifier. |
| `preferred_name_en` | `TEXT` | Yes | — | Preferred name en. |
| `preferred_name_fa` | `TEXT` | No | — | Preferred name fa. |
| `place_type` | `TEXT` | No | — | Place type. |
| `parent_place_id` | `TEXT` | No | `places.place_id`; update `NO ACTION`; delete `NO ACTION` | Parent place id. |
| `notes` | `TEXT` | No | — | Free-text editorial or research notes. |

### Declared foreign keys

| From | References | On update | On delete |
|---|---|---|---|
| `parent_place_id` | `places.place_id` | `NO ACTION` | `NO ACTION` |

## `events`

Historical events, appointments, campaigns, political episodes, and other dated or date-bounded occurrences.

**Current rows:** 74

### Columns

| Column | Type | Required | Key / default | Meaning |
|---|---|---:|---|---|
| `event_id` | `TEXT` | No | PK position 1 | Permanent event identifier. |
| `event_type` | `TEXT` | Yes | — | Event type. |
| `title` | `TEXT` | Yes | — | Title. |
| `date_text` | `TEXT` | No | — | Date text. |
| `place_id` | `TEXT` | No | `places.place_id`; update `NO ACTION`; delete `NO ACTION` | Permanent place identifier. |
| `description` | `TEXT` | No | — | Description. |
| `verification_status` | `TEXT` | Yes | default `'provisional'` | Verification status. |

### Declared foreign keys

| From | References | On update | On delete |
|---|---|---|---|
| `place_id` | `places.place_id` | `NO ACTION` | `NO ACTION` |

## `organizations`

Political, military, tribal, administrative, family, or institutional organizations.

**Current rows:** 21

### Columns

| Column | Type | Required | Key / default | Meaning |
|---|---|---:|---|---|
| `organization_id` | `TEXT` | No | PK position 1 | Permanent organization identifier. |
| `preferred_name_en` | `TEXT` | Yes | — | Preferred name en. |
| `preferred_name_fa` | `TEXT` | No | — | Preferred name fa. |
| `organization_type` | `TEXT` | Yes | — | Organization type. |
| `parent_organization_id` | `TEXT` | No | `organizations.organization_id`; update `NO ACTION`; delete `NO ACTION` | Parent organization id. |
| `date_text` | `TEXT` | No | — | Date text. |
| `description` | `TEXT` | No | — | Description. |
| `verification_status` | `TEXT` | Yes | default `'provisional'` | Verification status. |

### Declared foreign keys

| From | References | On update | On delete |
|---|---|---|---|
| `parent_organization_id` | `organizations.organization_id` | `NO ACTION` | `NO ACTION` |

### Explicit indexes

| Index | Columns | Unique | Partial |
|---|---|---:|---:|
| `idx_org_parent` | `parent_organization_id` | No | No |

## `roles`

Controlled vocabulary of offices, functions, occupations, and institutional roles.

**Current rows:** 12

### Columns

| Column | Type | Required | Key / default | Meaning |
|---|---|---:|---|---|
| `role_id` | `TEXT` | No | PK position 1 | Permanent role identifier. |
| `preferred_name_en` | `TEXT` | Yes | — | Preferred name en. |
| `preferred_name_fa` | `TEXT` | No | — | Preferred name fa. |
| `role_category` | `TEXT` | Yes | — | Role category. |
| `description` | `TEXT` | No | — | Description. |

## `titles`

Controlled registry of titles, ranks, honorifics, and styled offices.

**Current rows:** 25

### Columns

| Column | Type | Required | Key / default | Meaning |
|---|---|---:|---|---|
| `title_id` | `TEXT` | No | PK position 1 | Permanent title identifier. |
| `title_en` | `TEXT` | Yes | — | Title en. |
| `title_fa` | `TEXT` | No | — | Title fa. |
| `meaning_notes` | `TEXT` | No | — | Meaning notes. |

## `estates`

Named estates, villages, landed properties, or territorial holdings.

**Current rows:** 7

### Columns

| Column | Type | Required | Key / default | Meaning |
|---|---|---:|---|---|
| `estate_id` | `TEXT` | No | PK position 1 | Permanent estate identifier. |
| `preferred_name_en` | `TEXT` | Yes | — | Preferred name en. |
| `preferred_name_fa` | `TEXT` | No | — | Preferred name fa. |
| `place_id` | `TEXT` | No | `places.place_id`; update `NO ACTION`; delete `NO ACTION` | Permanent place identifier. |
| `estate_type` | `TEXT` | Yes | default `'landed_estate'` | Estate type. |
| `description` | `TEXT` | No | — | Description. |
| `verification_status` | `TEXT` | Yes | default `'provisional'` | Verification status. |

### Declared foreign keys

| From | References | On update | On delete |
|---|---|---|---|
| `place_id` | `places.place_id` | `NO ACTION` | `NO ACTION` |

## `military_units`

Military formations, regiments, corps, detachments, or other organized forces.

**Current rows:** 7

### Columns

| Column | Type | Required | Key / default | Meaning |
|---|---|---:|---|---|
| `military_unit_id` | `TEXT` | No | PK position 1 | Permanent military-unit identifier. |
| `organization_id` | `TEXT` | Yes | `organizations.organization_id`; update `NO ACTION`; delete `CASCADE` | Permanent organization identifier. |
| `unit_kind` | `TEXT` | Yes | — | Unit kind. |
| `service_arm` | `TEXT` | No | — | Service arm. |
| `affiliated_branch_id` | `TEXT` | No | `organizations.organization_id`; update `NO ACTION`; delete `NO ACTION` | Affiliated branch id. |
| `headquarters_place_id` | `TEXT` | No | `places.place_id`; update `NO ACTION`; delete `NO ACTION` | Headquarters place id. |
| `notes` | `TEXT` | No | — | Free-text editorial or research notes. |

### Declared foreign keys

| From | References | On update | On delete |
|---|---|---|---|
| `headquarters_place_id` | `places.place_id` | `NO ACTION` | `NO ACTION` |
| `affiliated_branch_id` | `organizations.organization_id` | `NO ACTION` | `NO ACTION` |
| `organization_id` | `organizations.organization_id` | `NO ACTION` | `CASCADE` |

## `sources`

Catalog of books, documents, images, oral testimony, and other evidentiary sources.

**Current rows:** 131

### Columns

| Column | Type | Required | Key / default | Meaning |
|---|---|---:|---|---|
| `source_id` | `TEXT` | No | PK position 1 | Permanent source identifier. |
| `short_title` | `TEXT` | Yes | — | Short title. |
| `full_title` | `TEXT` | No | — | Full title. |
| `author` | `TEXT` | No | — | Author. |
| `publication_year` | `TEXT` | No | — | Publication year. |
| `source_type` | `TEXT` | Yes | — | Source type. |
| `file_name` | `TEXT` | No | — | File name. |
| `notes` | `TEXT` | No | — | Free-text editorial or research notes. |

## `artifacts`

Catalog of visual or documentary artifacts, including images, charts, family trees, and scanned items.

**Current rows:** 15

### Columns

| Column | Type | Required | Key / default | Meaning |
|---|---|---:|---|---|
| `artifact_id` | `TEXT` | No | PK position 1 | Permanent artifact identifier. |
| `source_id` | `TEXT` | Yes | `sources.source_id`; update `NO ACTION`; delete `NO ACTION` | Permanent source identifier. |
| `printed_page` | `TEXT` | No | — | Page number as printed in the source. |
| `artifact_type` | `TEXT` | Yes | — | Artifact type. |
| `title` | `TEXT` | Yes | — | Title. |
| `caption_fa` | `TEXT` | No | — | Caption fa. |
| `description` | `TEXT` | No | — | Description. |
| `transcription_status` | `TEXT` | Yes | — | Transcription status. |
| `confidence` | `TEXT` | Yes | — | Archive confidence assessment. |
| `file_reference` | `TEXT` | No | — | File reference. |
| `notes` | `TEXT` | No | — | Free-text editorial or research notes. |

### Declared foreign keys

| From | References | On update | On delete |
|---|---|---|---|
| `source_id` | `sources.source_id` | `NO ACTION` | `NO ACTION` |


# Names, relationships, and participation

## `person_names`

Alternate names, spellings, scripts, transliterations, and name forms for people.

**Current rows:** 93

### Columns

| Column | Type | Required | Key / default | Meaning |
|---|---|---:|---|---|
| `person_name_id` | `INTEGER` | No | PK position 1 | Person name id. |
| `person_id` | `TEXT` | Yes | `persons.person_id`; update `NO ACTION`; delete `CASCADE` | Permanent person identifier. |
| `name_text` | `TEXT` | Yes | — | Name text. |
| `language` | `TEXT` | No | — | Language. |
| `name_type` | `TEXT` | No | — | Name type. |
| `is_preferred` | `INTEGER` | Yes | default `0` | Is preferred. |

### Declared foreign keys

| From | References | On update | On delete |
|---|---|---|---|
| `person_id` | `persons.person_id` | `NO ACTION` | `CASCADE` |

## `organization_names`

Alternate, historical, Persian, transliterated, or normalized names for organizations.

**Current rows:** 13

### Columns

| Column | Type | Required | Key / default | Meaning |
|---|---|---:|---|---|
| `organization_name_id` | `INTEGER` | No | PK position 1 | Organization name id. |
| `organization_id` | `TEXT` | Yes | `organizations.organization_id`; update `NO ACTION`; delete `CASCADE` | Permanent organization identifier. |
| `name_text` | `TEXT` | Yes | — | Name text. |
| `language` | `TEXT` | No | — | Language. |
| `name_type` | `TEXT` | Yes | default `'alias'` | Name type. |
| `is_preferred` | `INTEGER` | Yes | default `0` | Is preferred. |

### Declared foreign keys

| From | References | On update | On delete |
|---|---|---|---|
| `organization_id` | `organizations.organization_id` | `NO ACTION` | `CASCADE` |

## `relationships`

Person-to-person relationships such as parentage, siblinghood, marriage, or other kinship/social links.

**Current rows:** 46

### Columns

| Column | Type | Required | Key / default | Meaning |
|---|---|---:|---|---|
| `relationship_id` | `TEXT` | No | PK position 1 | Relationship id. |
| `person1_id` | `TEXT` | Yes | `persons.person_id`; update `NO ACTION`; delete `NO ACTION` | Person1 id. |
| `relationship_type` | `TEXT` | Yes | — | Relationship type. |
| `person2_id` | `TEXT` | Yes | `persons.person_id`; update `NO ACTION`; delete `NO ACTION` | Person2 id. |
| `notes` | `TEXT` | No | — | Free-text editorial or research notes. |
| `verification_status` | `TEXT` | Yes | default `'provisional'` | Verification status. |

### Declared foreign keys

| From | References | On update | On delete |
|---|---|---|---|
| `person2_id` | `persons.person_id` | `NO ACTION` | `NO ACTION` |
| `person1_id` | `persons.person_id` | `NO ACTION` | `NO ACTION` |

### Explicit indexes

| Index | Columns | Unique | Partial |
|---|---|---:|---:|
| `idx_relationships_person2` | `person2_id` | No | No |
| `idx_relationships_person1` | `person1_id` | No | No |

## `event_persons`

Junction table connecting people to events with a defined participation role.

**Current rows:** 113

### Columns

| Column | Type | Required | Key / default | Meaning |
|---|---|---:|---|---|
| `event_id` | `TEXT` | Yes | PK position 1; `events.event_id`; update `NO ACTION`; delete `CASCADE` | Permanent event identifier. |
| `person_id` | `TEXT` | Yes | PK position 2; `persons.person_id`; update `NO ACTION`; delete `CASCADE` | Permanent person identifier. |
| `role` | `TEXT` | No | PK position 3 | Role. |

### Declared foreign keys

| From | References | On update | On delete |
|---|---|---|---|
| `person_id` | `persons.person_id` | `NO ACTION` | `CASCADE` |
| `event_id` | `events.event_id` | `NO ACTION` | `CASCADE` |

### Explicit indexes

| Index | Columns | Unique | Partial |
|---|---|---:|---:|
| `idx_event_persons_person` | `person_id` | No | No |

## `person_titles`

Titles and honorifics held or associated with a person.

**Current rows:** 38

### Columns

| Column | Type | Required | Key / default | Meaning |
|---|---|---:|---|---|
| `person_title_id` | `INTEGER` | No | PK position 1 | Person title id. |
| `person_id` | `TEXT` | Yes | `persons.person_id`; update `NO ACTION`; delete `CASCADE` | Permanent person identifier. |
| `title_id` | `TEXT` | Yes | `titles.title_id`; update `NO ACTION`; delete `NO ACTION` | Permanent title identifier. |
| `date_text` | `TEXT` | No | — | Date text. |
| `notes` | `TEXT` | No | — | Free-text editorial or research notes. |

### Declared foreign keys

| From | References | On update | On delete |
|---|---|---|---|
| `title_id` | `titles.title_id` | `NO ACTION` | `NO ACTION` |
| `person_id` | `persons.person_id` | `NO ACTION` | `CASCADE` |

## `person_role_assignments`

Assignments of people to formal roles, often within an organization and bounded by dates.

**Current rows:** 7

### Columns

| Column | Type | Required | Key / default | Meaning |
|---|---|---:|---|---|
| `assignment_id` | `TEXT` | No | PK position 1 | Assignment id. |
| `person_id` | `TEXT` | Yes | `persons.person_id`; update `NO ACTION`; delete `NO ACTION` | Permanent person identifier. |
| `role_id` | `TEXT` | Yes | `roles.role_id`; update `NO ACTION`; delete `NO ACTION` | Permanent role identifier. |
| `organization_id` | `TEXT` | No | `organizations.organization_id`; update `NO ACTION`; delete `NO ACTION` | Permanent organization identifier. |
| `place_id` | `TEXT` | No | `places.place_id`; update `NO ACTION`; delete `NO ACTION` | Permanent place identifier. |
| `date_text` | `TEXT` | No | — | Date text. |
| `start_date_text` | `TEXT` | No | — | Source-preserving or approximate start-date expression. |
| `end_date_text` | `TEXT` | No | — | Source-preserving or approximate end-date expression. |
| `appointing_authority_text` | `TEXT` | No | — | Appointing authority text. |
| `notes` | `TEXT` | No | — | Free-text editorial or research notes. |
| `verification_status` | `TEXT` | Yes | default `'provisional'` | Verification status. |

### Declared foreign keys

| From | References | On update | On delete |
|---|---|---|---|
| `place_id` | `places.place_id` | `NO ACTION` | `NO ACTION` |
| `organization_id` | `organizations.organization_id` | `NO ACTION` | `NO ACTION` |
| `role_id` | `roles.role_id` | `NO ACTION` | `NO ACTION` |
| `person_id` | `persons.person_id` | `NO ACTION` | `NO ACTION` |

### Explicit indexes

| Index | Columns | Unique | Partial |
|---|---|---:|---:|
| `idx_role_assignments_person` | `person_id` | No | No |

## `organization_memberships`

Membership or affiliation records connecting people to organizations.

**Current rows:** 9

### Columns

| Column | Type | Required | Key / default | Meaning |
|---|---|---:|---|---|
| `membership_id` | `TEXT` | No | PK position 1 | Membership id. |
| `person_id` | `TEXT` | Yes | `persons.person_id`; update `NO ACTION`; delete `NO ACTION` | Permanent person identifier. |
| `organization_id` | `TEXT` | Yes | `organizations.organization_id`; update `NO ACTION`; delete `NO ACTION` | Permanent organization identifier. |
| `membership_role` | `TEXT` | No | — | Membership role. |
| `date_text` | `TEXT` | No | — | Date text. |
| `notes` | `TEXT` | No | — | Free-text editorial or research notes. |
| `verification_status` | `TEXT` | Yes | default `'provisional'` | Verification status. |

### Declared foreign keys

| From | References | On update | On delete |
|---|---|---|---|
| `organization_id` | `organizations.organization_id` | `NO ACTION` | `NO ACTION` |
| `person_id` | `persons.person_id` | `NO ACTION` | `NO ACTION` |

### Explicit indexes

| Index | Columns | Unique | Partial |
|---|---|---:|---:|
| `idx_memberships_person` | `person_id` | No | No |

## `estate_associations`

Associations between estates and people or organizations, including ownership, control, residence, or administration.

**Current rows:** 11

### Columns

| Column | Type | Required | Key / default | Meaning |
|---|---|---:|---|---|
| `estate_association_id` | `TEXT` | No | PK position 1 | Estate association id. |
| `estate_id` | `TEXT` | Yes | `estates.estate_id`; update `NO ACTION`; delete `NO ACTION` | Permanent estate identifier. |
| `person_id` | `TEXT` | No | `persons.person_id`; update `NO ACTION`; delete `NO ACTION` | Permanent person identifier. |
| `organization_id` | `TEXT` | No | `organizations.organization_id`; update `NO ACTION`; delete `NO ACTION` | Permanent organization identifier. |
| `association_type` | `TEXT` | Yes | — | Association type. |
| `date_text` | `TEXT` | No | — | Date text. |
| `notes` | `TEXT` | No | — | Free-text editorial or research notes. |
| `verification_status` | `TEXT` | Yes | default `'provisional'` | Verification status. |

### Declared foreign keys

| From | References | On update | On delete |
|---|---|---|---|
| `organization_id` | `organizations.organization_id` | `NO ACTION` | `NO ACTION` |
| `person_id` | `persons.person_id` | `NO ACTION` | `NO ACTION` |
| `estate_id` | `estates.estate_id` | `NO ACTION` | `NO ACTION` |

### Explicit indexes

| Index | Columns | Unique | Partial |
|---|---|---:|---:|
| `idx_estate_assoc_org` | `organization_id` | No | No |
| `idx_estate_assoc_person` | `person_id` | No | No |

## `military_commands`

Records of a person's command or service relationship to a military unit.

**Current rows:** 14

### Columns

| Column | Type | Required | Key / default | Meaning |
|---|---|---:|---|---|
| `command_id` | `TEXT` | No | PK position 1 | Command id. |
| `person_id` | `TEXT` | Yes | `persons.person_id`; update `NO ACTION`; delete `NO ACTION` | Permanent person identifier. |
| `military_unit_id` | `TEXT` | Yes | `military_units.military_unit_id`; update `NO ACTION`; delete `NO ACTION` | Permanent military-unit identifier. |
| `command_role_id` | `TEXT` | No | `roles.role_id`; update `NO ACTION`; delete `NO ACTION` | Command role id. |
| `date_text` | `TEXT` | No | — | Date text. |
| `start_date_text` | `TEXT` | No | — | Source-preserving or approximate start-date expression. |
| `end_date_text` | `TEXT` | No | — | Source-preserving or approximate end-date expression. |
| `predecessor_person_id` | `TEXT` | No | `persons.person_id`; update `NO ACTION`; delete `NO ACTION` | Predecessor person id. |
| `successor_person_id` | `TEXT` | No | `persons.person_id`; update `NO ACTION`; delete `NO ACTION` | Successor person id. |
| `notes` | `TEXT` | No | — | Free-text editorial or research notes. |
| `verification_status` | `TEXT` | Yes | default `'provisional'` | Verification status. |

### Declared foreign keys

| From | References | On update | On delete |
|---|---|---|---|
| `successor_person_id` | `persons.person_id` | `NO ACTION` | `NO ACTION` |
| `predecessor_person_id` | `persons.person_id` | `NO ACTION` | `NO ACTION` |
| `command_role_id` | `roles.role_id` | `NO ACTION` | `NO ACTION` |
| `military_unit_id` | `military_units.military_unit_id` | `NO ACTION` | `NO ACTION` |
| `person_id` | `persons.person_id` | `NO ACTION` | `NO ACTION` |

### Explicit indexes

| Index | Columns | Unique | Partial |
|---|---|---:|---:|
| `idx_commands_unit` | `military_unit_id` | No | No |
| `idx_commands_person` | `person_id` | No | No |

## `artifact_persons`

Junction table linking artifacts to depicted, mentioned, or otherwise associated people.

**Current rows:** 19

### Columns

| Column | Type | Required | Key / default | Meaning |
|---|---|---:|---|---|
| `artifact_id` | `TEXT` | Yes | PK position 1; `artifacts.artifact_id`; update `NO ACTION`; delete `CASCADE` | Permanent artifact identifier. |
| `person_id` | `TEXT` | Yes | PK position 2; `persons.person_id`; update `NO ACTION`; delete `CASCADE` | Permanent person identifier. |
| `role` | `TEXT` | Yes | PK position 3 | Role. |
| `notes` | `TEXT` | No | — | Free-text editorial or research notes. |

### Declared foreign keys

| From | References | On update | On delete |
|---|---|---|---|
| `person_id` | `persons.person_id` | `NO ACTION` | `CASCADE` |
| `artifact_id` | `artifacts.artifact_id` | `NO ACTION` | `CASCADE` |

## `title_equivalence`

Relationships among equivalent, variant, broader, narrower, or potentially conflated titles.

**Current rows:** 3

### Columns

| Column | Type | Required | Key / default | Meaning |
|---|---|---:|---|---|
| `title_equivalence_id` | `TEXT` | No | PK position 1 | Title equivalence id. |
| `title_id_a` | `TEXT` | Yes | `titles.title_id`; update `NO ACTION`; delete `NO ACTION` | Title id a. |
| `title_id_b` | `TEXT` | Yes | `titles.title_id`; update `NO ACTION`; delete `NO ACTION` | Title id b. |
| `equivalence_type` | `TEXT` | Yes | — | Equivalence type. |
| `notes` | `TEXT` | Yes | — | Free-text editorial or research notes. |

### Declared foreign keys

| From | References | On update | On delete |
|---|---|---|---|
| `title_id_b` | `titles.title_id` | `NO ACTION` | `NO ACTION` |
| `title_id_a` | `titles.title_id` | `NO ACTION` | `NO ACTION` |

## `title_successions`

Documented succession or transfer relationships between title holders.

**Current rows:** 2

### Columns

| Column | Type | Required | Key / default | Meaning |
|---|---|---:|---|---|
| `title_succession_id` | `TEXT` | No | PK position 1 | Title succession id. |
| `title_id` | `TEXT` | Yes | `titles.title_id`; update `NO ACTION`; delete `NO ACTION` | Permanent title identifier. |
| `predecessor_person_id` | `TEXT` | No | `persons.person_id`; update `NO ACTION`; delete `NO ACTION` | Predecessor person id. |
| `successor_person_id` | `TEXT` | No | `persons.person_id`; update `NO ACTION`; delete `NO ACTION` | Successor person id. |
| `date_text` | `TEXT` | No | — | Date text. |
| `notes` | `TEXT` | No | — | Free-text editorial or research notes. |
| `verification_status` | `TEXT` | Yes | — | Verification status. |

### Declared foreign keys

| From | References | On update | On delete |
|---|---|---|---|
| `successor_person_id` | `persons.person_id` | `NO ACTION` | `NO ACTION` |
| `predecessor_person_id` | `persons.person_id` | `NO ACTION` | `NO ACTION` |
| `title_id` | `titles.title_id` | `NO ACTION` | `NO ACTION` |


# Evidence and provenance

## `bibliography_entries`

Raw and normalized bibliography entries extracted from a source.

**Current rows:** 129

### Columns

| Column | Type | Required | Key / default | Meaning |
|---|---|---:|---|---|
| `bibliography_id` | `TEXT` | No | PK position 1 | Bibliography id. |
| `source_id` | `TEXT` | Yes | `sources.source_id`; update `NO ACTION`; delete `NO ACTION` | Permanent source identifier. |
| `category` | `TEXT` | Yes | — | Category. |
| `raw_entry_fa` | `TEXT` | Yes | — | Raw entry fa. |
| `normalization_status` | `TEXT` | Yes | default `'raw'` | Normalization status. |
| `notes` | `TEXT` | No | — | Free-text editorial or research notes. |

### Declared foreign keys

| From | References | On update | On delete |
|---|---|---|---|
| `source_id` | `sources.source_id` | `NO ACTION` | `NO ACTION` |

## `citations`

Precise source references, typically at page or passage level.

**Current rows:** 86

### Columns

| Column | Type | Required | Key / default | Meaning |
|---|---|---:|---|---|
| `citation_id` | `TEXT` | No | PK position 1 | Permanent citation identifier. |
| `source_id` | `TEXT` | Yes | `sources.source_id`; update `NO ACTION`; delete `NO ACTION` | Permanent source identifier. |
| `page_printed` | `TEXT` | No | — | Page printed. |
| `page_file` | `TEXT` | No | — | Page file. |
| `locator_text` | `TEXT` | No | — | Locator text. |
| `quoted_text` | `TEXT` | No | — | Quoted text. |
| `notes` | `TEXT` | No | — | Free-text editorial or research notes. |

### Declared foreign keys

| From | References | On update | On delete |
|---|---|---|---|
| `source_id` | `sources.source_id` | `NO ACTION` | `NO ACTION` |

## `claims`

Atomic historical assertions about people, places, events, organizations, estates, or other entities.

**Current rows:** 151

### Columns

| Column | Type | Required | Key / default | Meaning |
|---|---|---:|---|---|
| `claim_id` | `TEXT` | No | PK position 1 | Permanent claim identifier. |
| `subject_type` | `TEXT` | Yes | — | Entity class targeted by a polymorphic reference. |
| `subject_id` | `TEXT` | Yes | — | Identifier of the polymorphically referenced subject. |
| `predicate` | `TEXT` | Yes | — | Predicate. |
| `object_text` | `TEXT` | Yes | — | Object text. |
| `confidence` | `TEXT` | Yes | — | Archive confidence assessment. |
| `status` | `TEXT` | Yes | default `'active'` | Workflow or scholarly status. |
| `notes` | `TEXT` | No | — | Free-text editorial or research notes. |

### Explicit indexes

| Index | Columns | Unique | Partial |
|---|---|---:|---:|
| `idx_claims_subject` | `subject_type`, `subject_id` | No | No |

## `claim_citations`

Many-to-many links between historical claims and the citations supporting or discussing them.

**Current rows:** 173

### Columns

| Column | Type | Required | Key / default | Meaning |
|---|---|---:|---|---|
| `claim_id` | `TEXT` | Yes | PK position 1; `claims.claim_id`; update `NO ACTION`; delete `CASCADE` | Permanent claim identifier. |
| `citation_id` | `TEXT` | Yes | PK position 2; `citations.citation_id`; update `NO ACTION`; delete `CASCADE` | Permanent citation identifier. |
| `support_type` | `TEXT` | Yes | default `'supports'` | Support type. |

### Declared foreign keys

| From | References | On update | On delete |
|---|---|---|---|
| `citation_id` | `citations.citation_id` | `NO ACTION` | `CASCADE` |
| `claim_id` | `claims.claim_id` | `NO ACTION` | `CASCADE` |

### Explicit indexes

| Index | Columns | Unique | Partial |
|---|---|---:|---:|
| `idx_claim_citations_citation` | `citation_id` | No | No |

## `claim_evidence_profiles`

Structured assessment of the evidence quality, status, and interpretation for a claim.

**Current rows:** 35

### Columns

| Column | Type | Required | Key / default | Meaning |
|---|---|---:|---|---|
| `claim_id` | `TEXT` | No | PK position 1; `claims.claim_id`; update `NO ACTION`; delete `CASCADE` | Permanent claim identifier. |
| `evidence_type_code` | `TEXT` | Yes | `evidence_types.evidence_type_code`; update `NO ACTION`; delete `NO ACTION` | Evidence type code. |
| `assertion_scope` | `TEXT` | Yes | default `'author_statement'` | Assertion scope. |
| `source_position` | `TEXT` | Yes | default `'neutral'` | Source position. |
| `assessment_notes` | `TEXT` | No | — | Assessment notes. |

### Declared foreign keys

| From | References | On update | On delete |
|---|---|---|---|
| `evidence_type_code` | `evidence_types.evidence_type_code` | `NO ACTION` | `NO ACTION` |
| `claim_id` | `claims.claim_id` | `NO ACTION` | `CASCADE` |

### Explicit indexes

| Index | Columns | Unique | Partial |
|---|---|---:|---:|
| `idx_claim_evidence_type` | `evidence_type_code` | No | No |

## `entity_citations`

Direct citation links to archive entities when a citation supports the entity as a whole.

**Current rows:** 49

### Columns

| Column | Type | Required | Key / default | Meaning |
|---|---|---:|---|---|
| `entity_citation_id` | `TEXT` | No | PK position 1 | Entity citation id. |
| `entity_type` | `TEXT` | Yes | — | Entity class targeted by a polymorphic reference. |
| `entity_id` | `TEXT` | Yes | — | Identifier of the polymorphically referenced entity. |
| `citation_id` | `TEXT` | Yes | `citations.citation_id`; update `NO ACTION`; delete `CASCADE` | Permanent citation identifier. |
| `support_type` | `TEXT` | Yes | default `'supports'` | Support type. |
| `notes` | `TEXT` | No | — | Free-text editorial or research notes. |

### Declared foreign keys

| From | References | On update | On delete |
|---|---|---|---|
| `citation_id` | `citations.citation_id` | `NO ACTION` | `CASCADE` |

### Explicit indexes

| Index | Columns | Unique | Partial |
|---|---|---:|---:|
| `idx_entity_citations_entity` | `entity_type`, `entity_id` | No | No |

## `evidence_types`

Controlled vocabulary describing classes of evidence used to evaluate claims.

**Current rows:** 10

### Columns

| Column | Type | Required | Key / default | Meaning |
|---|---|---:|---|---|
| `evidence_type_code` | `TEXT` | No | PK position 1 | Evidence type code. |
| `preferred_name_en` | `TEXT` | Yes | — | Preferred name en. |
| `preferred_name_fa` | `TEXT` | No | — | Preferred name fa. |
| `description` | `TEXT` | Yes | — | Description. |

## `evidence_conflicts`

Recorded contradictions, ambiguities, or unresolved disagreements in the evidence.

**Current rows:** 3

### Columns

| Column | Type | Required | Key / default | Meaning |
|---|---|---:|---|---|
| `conflict_id` | `TEXT` | No | PK position 1 | Conflict id. |
| `entity_type` | `TEXT` | Yes | — | Entity class targeted by a polymorphic reference. |
| `entity_id` | `TEXT` | Yes | — | Identifier of the polymorphically referenced entity. |
| `conflict_topic` | `TEXT` | Yes | — | Conflict topic. |
| `statement_a` | `TEXT` | Yes | — | Statement a. |
| `statement_b` | `TEXT` | Yes | — | Statement b. |
| `resolution_status` | `TEXT` | Yes | — | Resolution status. |
| `notes` | `TEXT` | No | — | Free-text editorial or research notes. |


# Dossiers, identity, and reconciliation

## `person_dossiers`

Curated dossier records for selected people, including sequence and dossier status.

**Current rows:** 25

### Columns

| Column | Type | Required | Key / default | Meaning |
|---|---|---:|---|---|
| `dossier_id` | `TEXT` | No | PK position 1 | Dossier id. |
| `person_id` | `TEXT` | Yes | `persons.person_id`; update `NO ACTION`; delete `NO ACTION` | Permanent person identifier. |
| `sequence_no` | `INTEGER` | Yes | — | Explicit display or processing order. |
| `file_path` | `TEXT` | Yes | — | File path. |
| `status` | `TEXT` | Yes | default `'foundational_v0.1'` | Workflow or scholarly status. |
| `evidence_policy` | `TEXT` | Yes | — | Evidence policy. |
| `generated_from_migration` | `TEXT` | Yes | — | Generated from migration. |
| `created_at` | `TEXT` | Yes | — | Record creation timestamp. |
| `updated_at` | `TEXT` | Yes | — | Record modification timestamp. |

### Declared foreign keys

| From | References | On update | On delete |
|---|---|---|---|
| `person_id` | `persons.person_id` | `NO ACTION` | `NO ACTION` |

### Explicit indexes

| Index | Columns | Unique | Partial |
|---|---|---:|---:|
| `idx_person_dossiers_sequence` | `sequence_no` | No | No |

## `person_reconciliation`

Per-person reconciliation status, review level, and resolution notes.

**Current rows:** 16

### Columns

| Column | Type | Required | Key / default | Meaning |
|---|---|---:|---|---|
| `person_id` | `TEXT` | No | PK position 1; `persons.person_id`; update `NO ACTION`; delete `CASCADE` | Permanent person identifier. |
| `wave_id` | `TEXT` | Yes | `reconciliation_waves.wave_id`; update `NO ACTION`; delete `NO ACTION` | Wave id. |
| `dossier_level` | `TEXT` | Yes | — | Dossier level. |
| `reconciliation_status` | `TEXT` | Yes | — | Reconciliation status. |
| `identity_collision_reviewed` | `INTEGER` | Yes | default `0` | Identity collision reviewed. |
| `relationships_reviewed` | `INTEGER` | Yes | default `0` | Relationships reviewed. |
| `timeline_reviewed` | `INTEGER` | Yes | default `0` | Timeline reviewed. |
| `citations_reviewed` | `INTEGER` | Yes | default `0` | Citations reviewed. |
| `unresolved_summary` | `TEXT` | No | — | Unresolved summary. |
| `updated_at` | `TEXT` | Yes | — | Record modification timestamp. |

### Declared foreign keys

| From | References | On update | On delete |
|---|---|---|---|
| `wave_id` | `reconciliation_waves.wave_id` | `NO ACTION` | `NO ACTION` |
| `person_id` | `persons.person_id` | `NO ACTION` | `CASCADE` |

## `person_identity_redirects`

Canonical redirects from deprecated or duplicate person identifiers to the surviving person record.

**Current rows:** 2

### Columns

| Column | Type | Required | Key / default | Meaning |
|---|---|---:|---|---|
| `deprecated_person_id` | `TEXT` | No | PK position 1; `persons.person_id`; update `NO ACTION`; delete `CASCADE` | Deprecated person id. |
| `canonical_person_id` | `TEXT` | Yes | `persons.person_id`; update `NO ACTION`; delete `NO ACTION` | Canonical person id. |
| `resolution_type` | `TEXT` | Yes | — | Resolution type. |
| `rationale` | `TEXT` | Yes | — | Rationale. |
| `resolved_in_wave` | `TEXT` | No | `reconciliation_waves.wave_id`; update `NO ACTION`; delete `NO ACTION` | Resolved in wave. |

### Declared foreign keys

| From | References | On update | On delete |
|---|---|---|---|
| `resolved_in_wave` | `reconciliation_waves.wave_id` | `NO ACTION` | `NO ACTION` |
| `canonical_person_id` | `persons.person_id` | `NO ACTION` | `NO ACTION` |
| `deprecated_person_id` | `persons.person_id` | `NO ACTION` | `CASCADE` |

## `identity_exclusions`

Explicit declarations that two identity candidates must not be merged.

**Current rows:** 6

### Columns

| Column | Type | Required | Key / default | Meaning |
|---|---|---:|---|---|
| `exclusion_id` | `TEXT` | No | PK position 1 | Exclusion id. |
| `person_id` | `TEXT` | Yes | `persons.person_id`; update `NO ACTION`; delete `CASCADE` | Permanent person identifier. |
| `excluded_identity_text` | `TEXT` | Yes | — | Excluded identity text. |
| `reason` | `TEXT` | Yes | — | Reason. |
| `evidence_basis` | `TEXT` | Yes | — | Evidence basis. |

### Declared foreign keys

| From | References | On update | On delete |
|---|---|---|---|
| `person_id` | `persons.person_id` | `NO ACTION` | `CASCADE` |

## `reconciliation_waves`

Metadata describing each formal identity or thematic reconciliation wave.

**Current rows:** 3

### Columns

| Column | Type | Required | Key / default | Meaning |
|---|---|---:|---|---|
| `wave_id` | `TEXT` | No | PK position 1 | Wave id. |
| `title` | `TEXT` | Yes | — | Title. |
| `source_scope` | `TEXT` | Yes | — | Source scope. |
| `status` | `TEXT` | Yes | — | Workflow or scholarly status. |
| `completed_at` | `TEXT` | No | — | Completed at. |
| `notes` | `TEXT` | No | — | Free-text editorial or research notes. |

## `thematic_reconciliation_status`

Status tracking for thematic reconciliation domains such as titles, estates, offices, and identity.

**Current rows:** 5

### Columns

| Column | Type | Required | Key / default | Meaning |
|---|---|---:|---|---|
| `theme_code` | `TEXT` | No | PK position 1 | Theme code. |
| `theme_name` | `TEXT` | Yes | — | Theme name. |
| `wave_id` | `TEXT` | Yes | `reconciliation_waves.wave_id`; update `NO ACTION`; delete `NO ACTION` | Wave id. |
| `status` | `TEXT` | Yes | — | Workflow or scholarly status. |
| `reviewed_records` | `INTEGER` | Yes | default `0` | Reviewed records. |
| `unresolved_records` | `INTEGER` | Yes | default `0` | Unresolved records. |
| `notes` | `TEXT` | No | — | Free-text editorial or research notes. |

### Declared foreign keys

| From | References | On update | On delete |
|---|---|---|---|
| `wave_id` | `reconciliation_waves.wave_id` | `NO ACTION` | `NO ACTION` |


# Research and archive operations

## `research_questions`

Open, resolved, or deferred historical research questions tracked by the archive.

**Current rows:** 19

### Columns

| Column | Type | Required | Key / default | Meaning |
|---|---|---:|---|---|
| `question_id` | `TEXT` | No | PK position 1 | Question id. |
| `question` | `TEXT` | Yes | — | Question. |
| `status` | `TEXT` | Yes | default `'open'` | Workflow or scholarly status. |
| `priority` | `TEXT` | Yes | default `'medium'` | Priority. |
| `notes` | `TEXT` | No | — | Free-text editorial or research notes. |

## `schema_migrations`

Record of migration scripts applied to the live SQLite database.

**Current rows:** 16

### Columns

| Column | Type | Required | Key / default | Meaning |
|---|---|---:|---|---|
| `migration_id` | `TEXT` | No | PK position 1 | Migration id. |
| `filename` | `TEXT` | Yes | — | Filename. |
| `sha256` | `TEXT` | Yes | — | Sha256. |
| `applied_at` | `TEXT` | Yes | — | Applied at. |
| `description` | `TEXT` | No | — | Description. |

## `metadata`

Project-level key-value metadata for the archive.

**Current rows:** 30

### Columns

| Column | Type | Required | Key / default | Meaning |
|---|---|---:|---|---|
| `key` | `TEXT` | No | PK position 1 | Key. |
| `value` | `TEXT` | Yes | — | Value. |

## `change_log`

Operational audit trail recording entity-level changes made to the archive.

**Current rows:** 32

### Columns

| Column | Type | Required | Key / default | Meaning |
|---|---|---:|---|---|
| `change_id` | `INTEGER` | No | PK position 1 | Change id. |
| `changed_at` | `TEXT` | Yes | — | Changed at. |
| `entity_type` | `TEXT` | Yes | — | Entity class targeted by a polymorphic reference. |
| `entity_id` | `TEXT` | Yes | — | Identifier of the polymorphically referenced entity. |
| `action` | `TEXT` | Yes | — | Action. |
| `summary` | `TEXT` | Yes | — | Summary. |

# Polymorphic references

The following references deliberately cannot be represented as ordinary SQLite foreign keys because the target table depends on a type field:

| Table | Type field | Identifier field | Intended use |
|---|---|---|---|
| `claims` | `subject_type` | `subject_id` | Attaches an atomic claim to a person, event, place, organization, estate, title, or other supported entity. |
| `entity_citations` | `entity_type` | `entity_id` | Links a citation directly to any supported archive entity. |
| `evidence_conflicts` | `entity_type` | `entity_id` | Records conflicts associated with any supported archive entity. |
| `change_log` | `entity_type` | `entity_id` | Records operational changes against multiple entity classes. |

These references require validator coverage to confirm that the stated target exists and that the type value is allowed.

# Relationship patterns

- **Canonical entity + alternate names:** `persons → person_names` and `organizations → organization_names`.
- **Person participation:** `persons ↔ events`, `persons ↔ organizations`, `persons ↔ roles`, `persons ↔ titles`, `persons ↔ estates`, and `persons ↔ military_units` are represented through junction or assignment tables.
- **Evidence chain:** `sources → citations → claim_citations → claims`; optional evidence assessments extend through `claim_evidence_profiles` and `evidence_types`.
- **Identity governance:** `reconciliation_waves`, `person_reconciliation`, `person_identity_redirects`, and `identity_exclusions` preserve the history and outcome of identity decisions.
- **Artifact attribution:** `sources → artifacts → artifact_persons` preserves the source and person associations for images, figures, charts, and documentary objects.

# Maintenance rules

1. Add new schema changes through numbered migrations rather than direct manual edits.
2. Preserve permanent identifiers after publication; use redirect records when canonical identities change.
3. Add historical assertions as claims with citations rather than embedding unsupported prose in entity records.
4. Record unresolved contradictions in `evidence_conflicts` instead of silently choosing one version.
5. Run the archive validator after every migration and before every release.
6. Update this dictionary whenever a migration adds, removes, renames, or changes a field, table, constraint, or controlled vocabulary.

# Appendix — Database-wide totals

- Application tables: **40**
- Declared foreign keys: **52**
- Explicit non-automatic indexes: **15**
