-- Migration 0037
-- Abdollah Khan Amir Nezam Explorer / dossier enrichment
-- Baseline: v2.8.3 / migration 0036
--
-- Purpose:
--   Make mature evidence already stored in migrations 0035–0036 visible in the
--   Explorer's person-level presentation for P0004.
--
-- Important:
--   * No canonical genealogy relationships are changed.
--   * No new speculative identities are created.
--   * This migration updates the curated person summary and dossier registration;
--     the underlying detailed claims/events/citations remain the evidentiary basis.
--   * Transaction control is intentionally omitted because apply_migration.py owns it.

UPDATE metadata SET value='2.8.4' WHERE key='database_version';
INSERT OR REPLACE INTO metadata(key,value) VALUES('last_migration','0037');
INSERT OR REPLACE INTO metadata(key,value) VALUES('updated_at','2026-08-04T00:40:00Z');
INSERT OR REPLACE INTO metadata(key,value) VALUES(
    'historical_enrichment_checkpoint',
    'Abdollah Khan Amir Nezam Explorer dossier enrichment'
);

-- Curated Explorer summary.  The Explorer reads persons.summary for the hero/overview prose.
UPDATE persons
SET summary = 'Haji Abdollah Khan Gharagozloo (Sa''ed al-Saltaneh, later Sardar Akram and Amir Nezam) was a senior Qajar military commander, provincial administrator, landholder, and author in the Amir Nezam branch of the Hajilou Gharagozloo family. Son of Mostafa Qoli Khan E''temad al-Saltaneh, he served on the Sarakhs frontier in 1294–1296 AH and later commanded the Fadavi Regiment during a major Khuzestan/Lorestan assignment in roughly 1305–1308 AH. His surviving reports record firsthand observations on frontier defense, military logistics, roads, water and irrigation, agriculture, trade, settlement, and provincial politics. He was the father of Hossein Qoli Khan, Mohtaj Ali Khan, and Mansur Ali Khan and remained a major figure in the later Amir Nezam family.',
    updated_at = '2026-08-04T00:40:00Z'
WHERE person_id = 'P0004';

-- Re-point the existing curated dossier registration, if present, to the enriched dossier.
-- UPDATE is intentionally used rather than INSERT to avoid creating duplicate dossier records.
UPDATE person_dossiers
SET file_path = 'docs/dossiers/P0004_ABDOLLAH_KHAN_AMIR_NEZAM.md',
    status = 'multi_source_historical_enrichment_v2.8.4',
    evidence_policy = 'Curated narrative must be derived from cited archive claims/events; source viewpoints and unresolved conflicts remain explicitly attributed.',
    generated_from_migration = '0037',
    updated_at = '2026-08-04T00:40:00Z'
WHERE person_id = 'P0004';

-- Keep an explicit record that this is a publication/presentation enrichment, not topology work.
INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES(
    '2026-08-04T00:40:00Z',
    'person',
    'P0004',
    'update',
    'Expanded Abdollah Khan Amir Nezam curated Explorer summary from evidence already checkpointed in migrations 0035–0036.'
);

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES(
    '2026-08-04T00:40:00Z',
    'dossier',
    'P0004',
    'update',
    'Registered enriched multi-source Abdollah Khan dossier for Explorer/publication use; canonical genealogy unchanged.'
);

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES(
    '2026-08-04T00:40:00Z',
    'database',
    'archive',
    'release',
    'Prepared v2.8.4 Abdollah Khan Explorer dossier enrichment checkpoint.'
);
