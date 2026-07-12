-- Archive v2.3 — Master Reconciliation Wave 2
-- Reconciles the first documented Ashiqloo generation and the Rostam/Shervin line.
-- This migration is additive and preserves all records from migrations 0001-0013.

INSERT OR REPLACE INTO reconciliation_waves(
    wave_id,title,source_scope,status,completed_at,notes
) VALUES(
    'RW002',
    'Master Reconciliation Wave 2 — Ashiqloo first generation and Shervin line',
    'S0001',
    'complete',
    '2026-07-12T06:30:00Z',
    'Nine dossiers reconciled. Duplicate person records created in earlier migrations are retained but redirected to canonical IDs.'
);

CREATE TABLE IF NOT EXISTS person_identity_redirects (
    deprecated_person_id TEXT PRIMARY KEY REFERENCES persons(person_id) ON DELETE CASCADE,
    canonical_person_id TEXT NOT NULL REFERENCES persons(person_id),
    resolution_type TEXT NOT NULL CHECK(resolution_type IN ('duplicate','probable_duplicate','split_required')),
    rationale TEXT NOT NULL,
    resolved_in_wave TEXT REFERENCES reconciliation_waves(wave_id)
);

-- Canonicalize duplicate records without deleting historical IDs.
INSERT OR REPLACE INTO person_identity_redirects(
    deprecated_person_id,canonical_person_id,resolution_type,rationale,resolved_in_wave
) VALUES
('P0074','P0018','duplicate',
 'P0018 already contained the campaign and regimental record for Rostam/Rustam Khan; P0074 was created later for the same eldest son of P0011.',
 'RW002'),
('P0075','P0020','duplicate',
 'P0020 already contained Ali-Naqi Khan military data; P0075 was later created for the same named son of P0011.',
 'RW002');

UPDATE persons SET
    verification_status='merged_duplicate',
    summary='Deprecated duplicate record. Use canonical person P0018.',
    updated_at='2026-07-12T06:30:00Z'
WHERE person_id='P0074';

UPDATE persons SET
    verification_status='merged_duplicate',
    summary='Deprecated duplicate record. Use canonical person P0020.',
    updated_at='2026-07-12T06:30:00Z'
WHERE person_id='P0075';

-- Move the parent links to canonical records and retire duplicate edges.
INSERT OR IGNORE INTO relationships(
    relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES
('R0044','P0011','parent_of','P0018',
 'Narrative text explicitly names Rostam Khan as the eldest son of the early Mohammad-Hossein Khan.',
 'confirmed'),
('R0045','P0011','parent_of','P0020',
 'Narrative text explicitly names Ali-Naqi Khan among the five sons of the early Mohammad-Hossein Khan.',
 'confirmed'),
('R0046','P0022','parent_of','P0023',
 'Chapter 2 family-line summary identifies Zeyn al-Abedin Khan as son and successor of Mohammad-Hossein Khan Hesam al-Molk.',
 'confirmed');

UPDATE relationships SET
    verification_status='superseded',
    notes=COALESCE(notes,'') || ' Superseded by canonical relationship R0044.'
WHERE relationship_id='R0041';

UPDATE relationships SET
    verification_status='superseded',
    notes=COALESCE(notes,'') || ' Superseded by canonical relationship R0045.'
WHERE relationship_id='R0043';

-- Update canonical summaries.
UPDATE persons SET
    preferred_name_en='Rostam Khan Gharagozloo',
    summary='Eldest son of the early Mohammad-Hossein Khan; contested successor to Ashiqloo leadership, deputy administrator of Gharagozloo districts, Sartip, commander in eastern and southern campaigns, and father of Ali Khan Nosrat al-Molk.',
    branch='Ashiqloo',
    verification_status='confirmed',
    updated_at='2026-07-12T06:30:00Z'
WHERE person_id='P0018';

UPDATE persons SET
    summary='Son of the early Mohammad-Hossein Khan; titled Sarem al-Saltaneh and Sardar Batmanqilich. Commander of Malayer and Tuyserkan regiments, participant in the Bandar Abbas and southern campaigns, and father of Negar Khanom.',
    updated_at='2026-07-12T06:30:00Z'
WHERE person_id='P0028';

UPDATE persons SET
    summary='Son of the early Mohammad-Hossein Khan and father of Mahmoud Khan Naser al-Molk. Also a senior commander wounded in the Herat campaign and an ancestor of the Naser al-Molk house of Bahar.',
    updated_at='2026-07-12T06:30:00Z'
WHERE person_id='P0013';

UPDATE persons SET
    summary='One of the five sons of the early Mohammad-Hossein Khan. Named as colonel of the Sixth Gharagozloo Regiment; exact dates and descendants remain unresolved.',
    updated_at='2026-07-12T06:30:00Z'
WHERE person_id='P0062';

UPDATE persons SET
    preferred_name_en='Ali-Naqi Khan Gharagozloo',
    branch='Ashiqloo',
    death_date_text=COALESCE(death_date_text,'1281 AH'),
    summary='One of the five sons of the early Mohammad-Hossein Khan. Sartip and commander associated with the Dargazin infantry regiment and Kerman/Laristan operations.',
    updated_at='2026-07-12T06:30:00Z'
WHERE person_id='P0020';

UPDATE persons SET
    summary='Son of Rostam Khan; Nosrat al-Molk and senior officer. Married Zobeydeh Khanom, daughter of Fath-Ali Shah, escorted Gobineau, received promotion to Mirpanj, and transmitted hereditary command to the Hesam al-Molk line.',
    updated_at='2026-07-12T06:30:00Z'
WHERE person_id='P0019';

UPDATE persons SET
    preferred_name_en='Mohammad-Hossein Khan Hesam al-Molk Gharagozloo',
    summary='Son of Ali Khan Nosrat al-Molk and father of Zeyn al-Abedin Khan Amir Afkham. Holder of Hesam al-Molk and a link in the hereditary command of the Sixth and Mansur regimental establishments.',
    updated_at='2026-07-12T06:30:00Z'
WHERE person_id='P0022';

UPDATE persons SET
    preferred_name_en='Zeyn al-Abedin Khan Amir Afkham Hesam al-Molk Gharagozloo',
    birth_date_text=COALESCE(birth_date_text,'1275 AH'),
    death_date_text=COALESCE(death_date_text,'1346 AH'),
    summary='Head of the Shervin/Amir Afkham house; son of Mohammad-Hossein Khan Hesam al-Molk; major landowner, military patron, governor of Kerman and Baluchestan and of Borujerd, father of Gholamreza and Gholam-Ali, and royalist opponent of the Constitutional movement.',
    updated_at='2026-07-12T06:30:00Z'
WHERE person_id='P0023';

UPDATE persons SET
    preferred_name_en='Gholamreza Khan Ehtesham al-Dowleh Gharagozloo',
    summary='Son of Zeyn al-Abedin Khan Amir Afkham and husband of Qamar al-Saltaneh, daughter of Mozaffar al-Din Shah. The book uses both Ehtesham al-Saltaneh and Ehtesham al-Dowleh for him.',
    updated_at='2026-07-12T06:30:00Z'
WHERE person_id='P0024';

-- Canonical names and title variants.
INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0018','Rustam Khan Gharagozloo','en','transliteration-variant',0),
('P0020','Ali Naqi Khan Gharagozloo','en','transliteration-variant',0),
('P0022','Mohammad Hossein Khan Hosam al-Molk','en','transliteration-variant',0),
('P0023','Zeyn al-Abedin Khan Hesam al-Molk','en','title-form',0),
('P0023','Amir Afkham','en','title-form',0),
('P0024','Gholamreza Khan Ehtesham al-Saltaneh','en','earlier-title-form',0);

-- Additional confirmed title assignments.
INSERT OR IGNORE INTO person_titles(person_id,title_id,date_text,notes) VALUES
('P0018','T0009','1273 AH','Rank of Sartip in the Anglo-Persian southern campaign.'),
('P0020','T0009','1248 AH','Named as Sartip in the Kerman operations.'),
('P0019','T0012','1273 AH','Promoted to third-grade Mirpanj after the Gobineau escort mission.'),
('P0023','T0014',NULL,'Inherited/used Hesam al-Molk in the Shervin line.'),
('P0024','T0023',NULL,'Later/canonical title form in documentary caption.');

-- Reconciled claims.
INSERT OR IGNORE INTO claims(
    claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES
('C0140','person','P0018','succession',
 'Rostam Khan was the eldest son and contested successor of the early Mohammad-Hossein Khan.',
 'confirmed','active','Text-derived.'),
('C0141','person','P0018','military_career',
 'Rostam Khan served in the Mahmudabad/Herat, Kerman, Bandar Abbas, and Anglo-Persian southern campaigns and commanded Mokhberan regiments.',
 'confirmed','active','Archive synthesis from S0001 narrative.'),
('C0142','person','P0028','military_career',
 'Abdollah Khan Sarem al-Saltaneh commanded Malayer and Tuyserkan regiments and participated in southern campaigns.',
 'confirmed','active','Text-derived.'),
('C0143','person','P0013','dual_significance',
 'Nabi Khan is both a senior Herat commander and the genealogical bridge to the Naser al-Molk house.',
 'confirmed','active','Archive synthesis.'),
('C0144','person','P0062','limited_biography',
 'Fazlollah Khan is securely identified as a son of Mohammad-Hossein Khan and colonel of the Sixth Regiment, but S0001 gives little additional biography.',
 'confirmed','active','Whole-book negative finding.'),
('C0145','person','P0020','military_rank',
 'Ali-Naqi Khan held the rank of Sartip and is associated with Dargazin/Kerman-Laristan operations.',
 'confirmed','active','Text-derived.'),
('C0146','person','P0019','royal_marriage_and_diplomacy',
 'Ali Khan Nosrat al-Molk married Zobeydeh Khanom, daughter of Fath-Ali Shah, and carried out the Gobineau escort mission.',
 'confirmed','active','Text-derived.'),
('C0147','person','P0022','hereditary_command',
 'Mohammad-Hossein Khan Hesam al-Molk transmitted the Shervin military-house succession from Ali Khan to Zeyn al-Abedin Khan.',
 'confirmed','active','Family and regimental synthesis.'),
('C0148','person','P0023','life_dates',
 'Zeyn al-Abedin Khan Amir Afkham was born in 1275 AH and died in 1346 AH.',
 'confirmed','active','Chapter 2 family summary.'),
('C0149','person','P0023','political_and_estate_profile',
 'Amir Afkham was a major landowner, military patron, provincial governor, and royalist opponent of the Constitutional movement.',
 'probable','active','Mix of narrative facts and author synthesis.'),
('C0150','person','P0024','title_variation',
 'S0001 uses both Ehtesham al-Saltaneh and Ehtesham al-Dowleh for Gholamreza Khan.',
 'confirmed','active','Title variation preserved, not flattened.'),
('C0151','person','P0024','royal_marriage',
 'Gholamreza Khan married Qamar al-Saltaneh, daughter of Mozaffar al-Din Shah, in 1309 AH.',
 'confirmed','active','Narrative and caption evidence.');

INSERT OR IGNORE INTO claim_evidence_profiles(
    claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES
('C0140','NARRATIVE_FACT','author_statement','supports','Explicit succession statements.'),
('C0141','ARCHIVE_SYNTHESIS','archive_synthesis','supports','Multiple campaign passages combined.'),
('C0142','ARCHIVE_SYNTHESIS','archive_synthesis','supports','Regimental and campaign passages combined.'),
('C0143','ARCHIVE_SYNTHESIS','archive_synthesis','supports','Military and genealogical evidence combined.'),
('C0144','ARCHIVE_SYNTHESIS','archive_synthesis','supports','Whole-book negative finding.'),
('C0145','ARCHIVE_SYNTHESIS','archive_synthesis','supports','Rank and campaign evidence combined.'),
('C0146','ARCHIVE_SYNTHESIS','archive_synthesis','supports','Marriage and diplomatic mission evidence combined.'),
('C0147','ARCHIVE_SYNTHESIS','archive_synthesis','supports','Hereditary succession reconstruction.'),
('C0148','NARRATIVE_FACT','author_statement','supports','Explicit dates.'),
('C0149','AUTHOR_SYNTHESIS','author_statement','presents','Political orientation partly interpretive.'),
('C0150','ARCHIVE_SYNTHESIS','archive_synthesis','supports','Variant title forms preserved.'),
('C0151','NARRATIVE_FACT','author_statement','supports','Explicit marriage event.');

-- Mark all Wave 2 dossiers as Silver / complete for S0001.
INSERT OR REPLACE INTO person_reconciliation(
    person_id,wave_id,dossier_level,reconciliation_status,
    identity_collision_reviewed,relationships_reviewed,timeline_reviewed,citations_reviewed,
    unresolved_summary,updated_at
) VALUES
('P0018','RW002','silver','complete_for_source',1,1,1,1,
 'Exact dates, spouse, additional children, estates, and details of contested succession remain open.',
 '2026-07-12T06:30:00Z'),
('P0028','RW002','silver','complete_for_source',1,1,1,1,
 'Exact birth, wife, additional children, and full career chronology remain open.',
 '2026-07-12T06:30:00Z'),
('P0013','RW002','silver','complete_for_source',1,1,1,1,
 'Exact birth, wife, children beyond Mahmoud/Amanollah claims, and estate history remain open.',
 '2026-07-12T06:30:00Z'),
('P0062','RW002','silver','complete_for_source',1,1,1,1,
 'Dates, descendants, estates, and full military career remain open.',
 '2026-07-12T06:30:00Z'),
('P0020','RW002','silver','complete_for_source',1,1,1,1,
 'Dates, descendants, estates, and precise command chronology remain open.',
 '2026-07-12T06:30:00Z'),
('P0019','RW002','silver','complete_for_source',1,1,1,1,
 'Dates, complete child list, exact command periods, and royal marriage documentation remain open.',
 '2026-07-12T06:30:00Z'),
('P0022','RW002','silver','complete_for_source',1,1,1,1,
 'Dates, title-grant context, estates, and exact regimental commands remain open.',
 '2026-07-12T06:30:00Z'),
('P0023','RW002','silver','complete_for_source',1,1,1,1,
 'Exact governorship sequence, complete estate inventory, title grants, and full child list remain open.',
 '2026-07-12T06:30:00Z'),
('P0024','RW002','silver','complete_for_source',1,1,1,1,
 'Exact dates, title transition, offices, children, and inherited estate division remain open.',
 '2026-07-12T06:30:00Z');

INSERT OR REPLACE INTO metadata(key,value) VALUES('archive_version','2.3.0');
INSERT OR REPLACE INTO metadata(key,value) VALUES('master_reconciliation_wave_2','complete');
