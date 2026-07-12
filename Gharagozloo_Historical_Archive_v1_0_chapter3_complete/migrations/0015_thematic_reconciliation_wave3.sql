-- Archive v2.4 — Thematic Reconciliation Wave 3
-- Adds explicit reconciliation structures for titles, offices, estates, artifacts,
-- and source conflicts. No source data is deleted.

INSERT OR REPLACE INTO reconciliation_waves(
    wave_id,title,source_scope,status,completed_at,notes
) VALUES(
    'RW003',
    'Thematic Reconciliation Wave 3 — titles, offices, estates, and artifacts',
    'S0001',
    'complete',
    '2026-07-12T06:45:00Z',
    'Introduces title equivalence, title succession, thematic review status, and artifact/estate cautions.'
);

CREATE TABLE IF NOT EXISTS title_equivalence (
    title_equivalence_id TEXT PRIMARY KEY,
    title_id_a TEXT NOT NULL REFERENCES titles(title_id),
    title_id_b TEXT NOT NULL REFERENCES titles(title_id),
    equivalence_type TEXT NOT NULL CHECK(equivalence_type IN ('duplicate','variant','possible_variant','not_equivalent')),
    notes TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS title_successions (
    title_succession_id TEXT PRIMARY KEY,
    title_id TEXT NOT NULL REFERENCES titles(title_id),
    predecessor_person_id TEXT REFERENCES persons(person_id),
    successor_person_id TEXT REFERENCES persons(person_id),
    date_text TEXT,
    notes TEXT,
    verification_status TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS thematic_reconciliation_status (
    theme_code TEXT PRIMARY KEY,
    theme_name TEXT NOT NULL,
    wave_id TEXT NOT NULL REFERENCES reconciliation_waves(wave_id),
    status TEXT NOT NULL,
    reviewed_records INTEGER NOT NULL DEFAULT 0,
    unresolved_records INTEGER NOT NULL DEFAULT 0,
    notes TEXT
);

CREATE TABLE IF NOT EXISTS evidence_conflicts (
    conflict_id TEXT PRIMARY KEY,
    entity_type TEXT NOT NULL,
    entity_id TEXT NOT NULL,
    conflict_topic TEXT NOT NULL,
    statement_a TEXT NOT NULL,
    statement_b TEXT NOT NULL,
    resolution_status TEXT NOT NULL CHECK(resolution_status IN ('unresolved','partially_resolved','resolved')),
    notes TEXT
);

-- Duplicate title IDs from earlier migrations are retained but explicitly reconciled.
INSERT OR REPLACE INTO title_equivalence(
    title_equivalence_id,title_id_a,title_id_b,equivalence_type,notes
) VALUES
('TE001','T0003','T0018','duplicate','Both records represent Sardar Akram / سردار اکرم.'),
('TE002','T0005','T0019','duplicate','Both records represent Ejlal al-Mamalek / اجلال‌الممالک.'),
('TE003','T0015','T0023','variant',
 'Ehtesham al-Saltaneh and Ehtesham al-Dowleh are distinct title forms used for the same person P0024 in S0001; do not globally equate them for all people.');

-- Title successions supported by the narrative.
INSERT OR REPLACE INTO title_successions(
    title_succession_id,title_id,predecessor_person_id,successor_person_id,date_text,notes,verification_status
) VALUES
('TS001','T0014','P0022','P0023',NULL,
 'Hesam al-Molk passed within the Shervin line from Mohammad-Hossein Khan to Zeyn al-Abedin Khan.',
 'confirmed'),
('TS002','T0016','P0014','P0040','1305 AH',
 'Abolqasem Khan inherited the Naser al-Molk title after the death of his grandfather Mahmoud Khan.',
 'confirmed');

-- Artifact reconciliation: retain cautious linkage where the caption and narrative naming differ.
UPDATE artifacts SET
    confidence='confirmed',
    notes=COALESCE(notes,'') || ' Wave 3: caption securely identifies the subject as father of Amir Afkham, but exact alignment with canonical P0022 should remain under review.'
WHERE artifact_id='A0003';

UPDATE artifacts SET
    confidence='confirmed',
    notes=COALESCE(notes,'') || ' Wave 3: linked to canonical P0023; caption numbering is documentary wording, not a replacement canonical name.'
WHERE artifact_id='A0004';

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0003','P0022','probable_subject',
 'Caption identifies Hossein Khan Hesam al-Molk I, father of Amir Afkham; probable linkage to canonical P0022, but naming variance is retained.'),
('A0005','P0036','spouse_context',
 'Caption identifies P0024 as son-in-law of Mozaffar al-Din Shah; marriage relationship is recorded separately.');

-- Estate associations: branch/house-level only unless individual ownership is explicit.
INSERT OR IGNORE INTO estate_associations(
    estate_association_id,estate_id,person_id,organization_id,association_type,date_text,notes,verification_status
) VALUES
('EA0008','EST0001','P0004',NULL,'family_house_center',NULL,
 'Latgah is a principal center of the Amir Nezam family; personal parcel-level ownership not reconstructed.',
 'confirmed'),
('EA0009','EST0002','P0004',NULL,'family_house_center',NULL,
 'Kabudarahang is a major landed center of the Amir Nezam family; exact inherited/acquired division remains unresolved.',
 'confirmed'),
('EA0010','EST0003','P0023',NULL,'principal_estate_zone',NULL,
 'Shervin is a principal center of the Amir Afkham/Hesam al-Molk house.',
 'confirmed'),
('EA0011','EST0007','P0040',NULL,'family_house_center',NULL,
 'Bahar is the center associated with the Naser al-Molk family line.',
 'confirmed');

-- Explicit conflict records.
INSERT OR REPLACE INTO evidence_conflicts(
    conflict_id,entity_type,entity_id,conflict_topic,statement_a,statement_b,resolution_status,notes
) VALUES
('CF001','person','P0040','children',
 'Chapter 2 regimental passage calls Mehdi Khan a son of Naser al-Molk.',
 'Chapter 4 states that Naser al-Molk had sons Hossein-Ali and Mohsen and one daughter.',
 'unresolved',
 'Do not merge Mehdi Khan into the confirmed child list without further evidence.'),
('CF002','person','P0024','title form',
 'Marriage-period narrative uses Ehtesham al-Saltaneh.',
 'Later narrative and documentary caption use Ehtesham al-Dowleh.',
 'partially_resolved',
 'Both forms remain attached to P0024; chronology of formal title change remains open.'),
('CF003','artifact','A0003','portrait identity',
 'Caption identifies Hossein Khan Hesam al-Molk I, father of Amir Afkham.',
 'Canonical narrative person is Mohammad-Hossein Khan Hesam al-Molk P0022.',
 'unresolved',
 'Probable identity, but exact name form must be verified from a better scan or another source.');

INSERT OR REPLACE INTO thematic_reconciliation_status(
    theme_code,theme_name,wave_id,status,reviewed_records,unresolved_records,notes
) VALUES
('titles','Title normalization and succession','RW003','complete_for_s0001',25,3,
 'Duplicate title IDs documented; person-specific variants preserved.'),
('offices','Civil and military office chronology','RW003','complete_for_current_major_figures',29,6,
 'Major figures reviewed; exact dates remain open for several offices.'),
('estates','Estate and landed-house associations','RW003','complete_at_house_level',11,7,
 'Only explicit individual or family-house associations are recorded; parcel-level ownership is not inferred.'),
('artifacts','Portrait and documentary artifact linkage','RW003','complete_for_cataloged_artifacts',15,5,
 'Portrait links reviewed; difficult documents remain untranscribed and genealogy diagrams remain corroborative only.'),
('identity','Namesake and duplicate identity control','RW003','complete_for_known_collisions',8,3,
 'Canonical redirects and identity exclusions now coexist.');

-- New research questions from thematic reconciliation.
INSERT OR IGNORE INTO research_questions(question_id,question,status,priority,notes) VALUES
('Q0016','Is the portrait captioned Hossein Khan Hesam al-Molk I on page 201 the same person as canonical P0022?','open','high','Artifact A0003 / conflict CF003.'),
('Q0017','When did Gholamreza Khan formally change or receive the title Ehtesham al-Dowleh after Ehtesham al-Saltaneh?','open','high','P0024 / conflict CF002.'),
('Q0018','Can the Shervin, Lalejin, Latgah, and Kabudarahang holdings be reconstructed parcel by parcel from deeds or probate records?','open','high','Estate reconciliation remains house-level in S0001.'),
('Q0019','Can exact governorship dates be established for Amir Afkham across Kermanshah, Kerman, Baluchestan, and Borujerd?','open','high','P0023 office chronology.');

INSERT OR REPLACE INTO metadata(key,value) VALUES('archive_version','2.4.0');
INSERT OR REPLACE INTO metadata(key,value) VALUES('thematic_reconciliation_wave_3','complete');
INSERT OR REPLACE INTO metadata(key,value) VALUES(
    'wave3_data_preservation_note',
    'Migrations 0014 and 0015 are additive; no records from the uploaded post-0013 Git master were deleted.'
);
