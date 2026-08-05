-- 0047_add_gallery_and_primary_portraits.sql
-- Archive v2.9.4 — Gallery architecture and migration of existing Explorer portraits.
-- No genealogy changes.

PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS artifact_gallery_metadata (
    artifact_id TEXT PRIMARY KEY REFERENCES artifacts(artifact_id) ON DELETE CASCADE,
    verification_class TEXT NOT NULL DEFAULT 'source_captioned'
        CHECK (verification_class IN ('family_verified','source_captioned','unresolved')),
    display_status TEXT NOT NULL DEFAULT 'visible'
        CHECK (display_status IN ('visible','hidden','hold')),
    selection_notes TEXT
);

CREATE TABLE IF NOT EXISTS person_primary_portraits (
    person_id TEXT PRIMARY KEY REFERENCES persons(person_id) ON DELETE CASCADE,
    artifact_id TEXT NOT NULL REFERENCES artifacts(artifact_id) ON DELETE RESTRICT,
    selection_basis TEXT NOT NULL,
    selected_by TEXT,
    notes TEXT,
    UNIQUE(person_id, artifact_id)
);

INSERT OR IGNORE INTO sources(
    source_id, short_title, full_title, author, publication_year, source_type, file_name, notes
) VALUES (
    'S0203',
    'Existing Explorer portrait collection',
    'Existing portrait files preserved from explorer/static/people before Gallery migration',
    NULL,
    NULL,
    'archive image collection',
    'explorer/static/people',
    'Technical migration source for portrait files that already existed in the Explorer before the artifact-driven Gallery was introduced. Identity is inherited from the prior P-ID filename convention; provenance of the original image should be enriched when known.'
);

INSERT OR IGNORE INTO artifacts(
    artifact_id, source_id, printed_page, artifact_type, title, caption_fa,
    description, transcription_status, confidence, file_reference, notes
) VALUES
('A0210','S0203',NULL,'portrait','Existing Explorer portrait — Gholamhossein Khan Amiri Gharagozloo',NULL,
 'Portrait previously displayed by the Explorer from static/people/P0008.jpg. Preserved as an artifact so future portraits can coexist in a person gallery.',
 'not_applicable','confirmed','A0210.jpg','Migrated from legacy Explorer portrait path; original source provenance should be enriched when known.'),
('A0211','S0203',NULL,'portrait','Existing Explorer portrait — Alireza Khan Baha al-Molk Gharagozloo',NULL,
 'Portrait previously displayed by the Explorer from static/people/P0037.jpg. Preserved as an artifact so future portraits can coexist in a person gallery.',
 'not_applicable','confirmed','A0211.jpg','Migrated from legacy Explorer portrait path; original source provenance should be enriched when known.'),
('A0212','S0203',NULL,'portrait','Existing Explorer portrait — Mirza Abu al-Qasem Khan Naser al-Molk Gharagozloo',NULL,
 'Portrait previously displayed by the Explorer from static/people/P0040.jpg. Preserved as an artifact so future portraits can coexist in a person gallery.',
 'not_applicable','confirmed','A0212.jpg','Migrated from legacy Explorer portrait path; original source provenance should be enriched when known.');

INSERT OR IGNORE INTO artifact_persons(artifact_id, person_id, role, notes) VALUES
('A0210','P0008','subject','Identity inherited from legacy P0008.jpg Explorer portrait filename.'),
('A0211','P0037','subject','Identity inherited from legacy P0037.jpg Explorer portrait filename.'),
('A0212','P0040','subject','Identity inherited from legacy P0040.jpg Explorer portrait filename.');

INSERT OR IGNORE INTO artifact_gallery_metadata(artifact_id,verification_class,display_status,selection_notes) VALUES
('A0210','source_captioned','visible','Legacy portrait retained as current primary until a better verified portrait is deliberately selected.'),
('A0211','source_captioned','visible','Legacy portrait retained as current primary until a better verified portrait is deliberately selected.'),
('A0212','source_captioned','visible','Legacy portrait retained as current primary until a better verified portrait is deliberately selected.');

INSERT OR REPLACE INTO person_primary_portraits(person_id,artifact_id,selection_basis,selected_by,notes) VALUES
('P0008','A0210','Legacy Explorer portrait preserved during gallery migration','archive migration 0047','May later be replaced by a stronger family-verified portrait without deleting this artifact.'),
('P0037','A0211','Legacy Explorer portrait preserved during gallery migration','archive migration 0047','May later be replaced by a stronger verified/source-captioned portrait without deleting this artifact.'),
('P0040','A0212','Legacy Explorer portrait preserved during gallery migration','archive migration 0047','May later be replaced by a stronger verified/source-captioned portrait without deleting this artifact.');
