-- Archive v2.2 — Master Reconciliation, Wave 1
-- Scope: seven central persons reconciled against Source S0001 plus explicitly
-- classified family testimony where the book is silent.
--
-- Text-first policy:
--   * narrative statements and explicit captions are primary;
--   * author inference remains qualified;
--   * user-supplied relationships remain separately labeled;
--   * low-quality genealogy diagrams do not independently establish parentage.

CREATE TABLE IF NOT EXISTS reconciliation_waves (
    wave_id TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    source_scope TEXT NOT NULL,
    status TEXT NOT NULL,
    completed_at TEXT,
    notes TEXT
);

CREATE TABLE IF NOT EXISTS person_reconciliation (
    person_id TEXT PRIMARY KEY REFERENCES persons(person_id) ON DELETE CASCADE,
    wave_id TEXT NOT NULL REFERENCES reconciliation_waves(wave_id),
    dossier_level TEXT NOT NULL CHECK(dossier_level IN ('bronze','silver','gold','platinum')),
    reconciliation_status TEXT NOT NULL CHECK(reconciliation_status IN ('complete_for_source','partial','blocked')),
    identity_collision_reviewed INTEGER NOT NULL DEFAULT 0,
    relationships_reviewed INTEGER NOT NULL DEFAULT 0,
    timeline_reviewed INTEGER NOT NULL DEFAULT 0,
    citations_reviewed INTEGER NOT NULL DEFAULT 0,
    unresolved_summary TEXT,
    updated_at TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS identity_exclusions (
    exclusion_id TEXT PRIMARY KEY,
    person_id TEXT NOT NULL REFERENCES persons(person_id) ON DELETE CASCADE,
    excluded_identity_text TEXT NOT NULL,
    reason TEXT NOT NULL,
    evidence_basis TEXT NOT NULL
);

INSERT OR REPLACE INTO reconciliation_waves(
    wave_id,title,source_scope,status,completed_at,notes
) VALUES(
    'RW001',
    'Master Reconciliation Wave 1 — Founders, Amiri line, and Naser al-Molk',
    'S0001 plus explicitly labeled family testimony',
    'complete',
    '2026-07-11T23:59:00Z',
    'Seven central dossiers reconciled. Diagram-only genealogy remains supporting evidence only.'
);

-- Correct and enrich canonical person summaries.
UPDATE persons SET
    summary='Early Ashiqloo chief and major Zand/early-Qajar commander. The narrative explicitly names five sons: Rostam, Abdollah Sarem al-Saltaneh, Nabi, Fazlollah, and Ali-Naqi. Shahbaz Khan is treated as his probable father or predecessor, not a proven parent.',
    verification_status='confirmed',
    updated_at='2026-07-11T23:59:00Z'
WHERE person_id='P0011';

UPDATE persons SET
    summary='Hajilu commander known as E''temad al-Saltaneh. He commanded the Fadavi military establishment, served in the southern war against Britain, held command in Astarabad and Khorasan, and was father of Abdollah Khan Sa''ed al-Saltaneh.',
    updated_at='2026-07-11T23:59:00Z'
WHERE person_id='P0003';

UPDATE persons SET
    summary='Leading figure of the Amir Nezam family of Latgah. Son of Mostafa-Qoli Khan E''temad al-Saltaneh; father of Hossein-Qoli, Mohtaj-Ali, and Mansur-Ali. Governor of Khuzestan and major landholder associated with Latgah and Kabudarahang.',
    updated_at='2026-07-11T23:59:00Z'
WHERE person_id='P0004';

UPDATE persons SET
    summary='Son of Abdollah Khan Sardar Akram and member of the Amir Nezam family. Confirmed titles: Ejlal al-Mamalek and Amir Arfa''. The book gives little independent career detail beyond lineage, titles, and family-house context.',
    updated_at='2026-07-11T23:59:00Z'
WHERE person_id='P0005';

UPDATE persons SET
    summary='Probable son of Mohtaj-Ali Khan and brother of Gholamhossein Khan according to family testimony and the difficult genealogy diagram. S0001 provides no substantial independent narrative biography.',
    verification_status='provisional',
    updated_at='2026-07-11T23:59:00Z'
WHERE person_id='P0007';

UPDATE persons SET
    summary='Paternal grandfather of the archive owner. Son of Mohtaj-Ali Khan and brother of Gholam-Ali according to family testimony; the small genealogy diagram is only supporting evidence. S0001 does not provide a securely identified narrative biography.',
    verification_status='provisional',
    updated_at='2026-07-11T23:59:00Z'
WHERE person_id='P0008';

UPDATE persons SET
    preferred_name_en='Mirza Abu al-Qasem Khan Naser al-Molk Gharagozloo',
    preferred_name_fa='میرزا ابوالقاسم خان ناصرالملک قراگوزلو',
    summary='Ashiqloo statesman, son of Ahmad Khan Sartip and grandson of Mahmoud Khan Naser al-Molk. Educated at Oxford, court translator, diplomat, finance minister, prime minister, and later regent during Ahmad Shah''s minority.',
    verification_status='confirmed',
    updated_at='2026-07-11T23:59:00Z'
WHERE person_id='P0040';

-- Canonical aliases.
INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0011','Mohammad-Hossein Khan Gharagozloo (early Ashiqloo chief)','en','disambiguated',0),
('P0003','Mostafa-Qoli Khan E''temad al-Saltaneh','en','title-form',0),
('P0004','Abdollah Khan Sardar Akram','en','title-form',0),
('P0004','Abdollah Khan Haji Amir Nezam','en','title-form',0),
('P0005','Mohtaj-Ali Khan Amir Arfa''','en','title-form',0),
('P0007','Gholam-Ali Khan Gharagozloo','en','variant',0),
('P0008','Gholamhossein Khan Amiri','en','short-form',0),
('P0040','Mirza Abu al-Qasem Khan Naser al-Molk','en','title-form',0),
('P0040','Nasir al-Mulk','en','transliteration-variant',0),
('P0040','ناصرالملک','fa','title-form',0);

-- Two missing sons named explicitly in Chapter 2.
INSERT OR IGNORE INTO persons(
    person_id,preferred_name_en,preferred_name_fa,sex,birth_date_text,death_date_text,
    branch,summary,verification_status,created_at,updated_at
) VALUES
('P0074','Rostam Khan Gharagozloo','رستم خان قراگوزلو','M',NULL,NULL,'Ashiqloo',
 'Eldest son of Mohammad-Hossein Khan in the narrative; increasingly assumed command of Gharagozloo forces late in his father''s life.',
 'confirmed','2026-07-11T23:59:00Z','2026-07-11T23:59:00Z'),
('P0075','Ali-Naqi Khan Gharagozloo','علینقی خان قراگوزلو','M',NULL,'1281 AH','Ashiqloo',
 'One of the five sons explicitly named for the early Mohammad-Hossein Khan; later military commander.',
 'confirmed','2026-07-11T23:59:00Z','2026-07-11T23:59:00Z');

INSERT OR IGNORE INTO relationships(
    relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES
('R0041','P0011','parent_of','P0074','Narrative text explicitly names Rostam Khan among Mohammad-Hossein Khan''s five sons.','confirmed'),
('R0042','P0011','parent_of','P0062','Narrative text explicitly names Fazlollah Khan among Mohammad-Hossein Khan''s five sons.','confirmed'),
('R0043','P0011','parent_of','P0075','Narrative text explicitly names Ali-Naqi Khan among Mohammad-Hossein Khan''s five sons.','confirmed');

-- Preserve the unsupported direct-link issue.
UPDATE relationships SET
    notes='User-supplied ancestral chain places Haji Mohammad Khan after Mohammad-Hossein Khan, but S0001 does not establish this direct parent-child link.',
    verification_status='unverified'
WHERE relationship_id='R0011';

UPDATE relationships SET
    notes='Family testimony identifies Mohtaj-Ali as father of Gholam-Ali; the small page-213 genealogy is supporting evidence only.',
    verification_status='provisional'
WHERE relationship_id='R0006';

UPDATE relationships SET
    notes='Family testimony identifies Mohtaj-Ali as father of Gholamhossein; the small page-213 genealogy is supporting evidence only.',
    verification_status='provisional'
WHERE relationship_id='R0007';

UPDATE relationships SET
    notes='Family testimony consistently identifies Gholam-Ali and Gholamhossein as brothers; independent textual corroboration remains pending.',
    verification_status='provisional'
WHERE relationship_id='R0008';

-- Naser al-Molk: resolve the Mehdi Khan conflict by downgrading the existing link.
UPDATE relationships SET
    notes='Chapter 2 calls a Mehdi Khan the son of Naser al-Molk in a regimental passage, but Chapter 4 separately states that Naser al-Molk had two sons, Hossein-Ali and Mohsen, and one daughter. Identity remains unresolved.',
    verification_status='provisional'
WHERE relationship_id='R0039';

-- Reconciliation-specific citations.
INSERT OR IGNORE INTO citations(
    citation_id,source_id,page_printed,page_file,locator_text,quoted_text,notes
) VALUES
('X0076','S0001','59-61',NULL,'Chapter 2 branch and family-line summary',NULL,'Text-first lineage and landed-family classification.'),
('X0077','S0001','67-84',NULL,'Chapter 2 military organization and regimental succession',NULL,'Military ranks, commands, regiments, and succession.'),
('X0078','S0001','96-166',NULL,'Chapter 3 political and military narrative',NULL,'Career events for the reconciled Qajar-era figures.'),
('X0079','S0001','167-186',NULL,'Chapter 4: Mirza Abu al-Qasem Khan Naser al-Molk',NULL,'Primary dossier narrative for Naser al-Molk.'),
('X0080','S0001','213',NULL,'Hajilu genealogy diagram',NULL,'Supporting visual evidence only; small type and low scan quality.'),
('X0081','U0001',NULL,NULL,'Family testimony supplied by archive owner',NULL,'Used only where clearly labeled as user-supplied evidence.');

-- Wave 1 claims.
INSERT OR IGNORE INTO claims(
    claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES
('C0127','person','P0011','five_named_sons',
 'The narrative explicitly names Rostam, Abdollah Sarem al-Saltaneh, Nabi, Fazlollah, and Ali-Naqi as sons of Mohammad-Hossein Khan.',
 'confirmed','active','Text-derived; stronger than diagram-only genealogy.'),
('C0128','person','P0011','probable_parentage',
 'Shahbaz Khan is presented as the probable father or predecessor of Mohammad-Hossein Khan, but the author marks the connection as inference.',
 'probable','active','Do not convert to a confirmed parent-child edge without further evidence.'),
('C0129','person','P0003','military_career',
 'Mostafa-Qoli Khan commanded the Fadavi establishment, served in the southern war, held Astarabad command, and became head of the Khorasan military establishment.',
 'confirmed','active','Composite narrative synthesis from Chapters 2 and 3.'),
('C0130','person','P0003','title_origin',
 'The title E''temad al-Saltaneh was granted after his recall from successful Astarabad service.',
 'confirmed','active','Narrative statement.'),
('C0131','person','P0004','family_and_office',
 'Abdollah Khan was son of Mostafa-Qoli Khan, father of Hossein-Qoli, Mohtaj-Ali, and Mansur-Ali, and served as governor of Khuzestan.',
 'confirmed','active','Text-derived lineage and appointment.'),
('C0132','person','P0004','landholding_scale',
 'The author states that Abdollah Khan controlled approximately 120 villages or landed properties late in life.',
 'probable','active','Author narrative; exact estate list remains incomplete.'),
('C0133','person','P0005','limited_book_biography',
 'S0001 securely establishes Mohtaj-Ali''s lineage and titles but supplies little independent political or military biography.',
 'confirmed','active','Negative finding from whole-book reconciliation.'),
('C0134','person','P0007','limited_book_biography',
 'S0001 contains no substantial independent narrative biography for Gholam-Ali Khan.',
 'confirmed','active','Relationship evidence remains family-supplied and diagram-supported.'),
('C0135','person','P0008','identity_separation',
 'Index references to Gholamhossein Gharagozloo on pages 19 and 64 concern the author of Hegmataneh ta Hamadan and should not be assigned to Gholamhossein Khan Amiri.',
 'confirmed','active','Identity collision resolved.'),
('C0136','person','P0040','canonical_lineage',
 'Naser al-Molk was son of Ahmad Khan Sartip and grandson of Mahmoud Khan Naser al-Molk.',
 'confirmed','active','Narrative-text lineage.'),
('C0137','person','P0040','career_summary',
 'Naser al-Molk studied at Oxford, served as court translator and diplomat, became finance minister and prime minister, and later served as regent.',
 'confirmed','active','Chapter 4 synthesis.'),
('C0138','person','P0040','political_interpretation',
 'The author interprets Naser al-Molk as a conservative landed aristocrat who considered constitutional change premature.',
 'probable','active','Authorial interpretation, not a neutral self-description.'),
('C0139','person','P0040','child_identity_conflict',
 'The Chapter 2 identification of Mehdi Khan as Naser al-Molk''s son conflicts with Chapter 4''s statement that his children were Hossein-Ali, Mohsen, and one daughter.',
 'disputed','active','Preserved as an unresolved identity conflict.');

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0127','X0076','supports'),
('C0128','X0076','supports'),
('C0129','X0077','supports'),
('C0129','X0078','supports'),
('C0130','X0078','supports'),
('C0131','X0076','supports'),
('C0131','X0078','supports'),
('C0132','X0078','supports'),
('C0133','X0076','supports'),
('C0134','X0080','context'),
('C0135','X0078','supports'),
('C0136','X0076','supports'),
('C0136','X0079','supports'),
('C0137','X0079','supports'),
('C0138','X0079','supports'),
('C0139','X0077','supports'),
('C0139','X0079','conflicts');

INSERT OR IGNORE INTO claim_evidence_profiles(
    claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES
('C0127','NARRATIVE_FACT','author_statement','supports','Explicit list in narrative text.'),
('C0128','AUTHOR_INFERENCE','author_inference','questions','Author presents the link as probable.'),
('C0129','ARCHIVE_SYNTHESIS','archive_synthesis','supports','Combined from multiple dated narrative passages.'),
('C0130','NARRATIVE_FACT','author_statement','supports','Explicit title-grant context.'),
('C0131','ARCHIVE_SYNTHESIS','archive_synthesis','supports','Multiple narrative passages reconciled.'),
('C0132','NARRATIVE_FACT','author_statement','supports','Approximate scale reported by author.'),
('C0133','ARCHIVE_SYNTHESIS','archive_synthesis','supports','Whole-book negative finding.'),
('C0134','ARCHIVE_SYNTHESIS','archive_synthesis','supports','Whole-book negative finding.'),
('C0135','ARCHIVE_SYNTHESIS','archive_synthesis','supports','Identity collision resolved from index and bibliography context.'),
('C0136','NARRATIVE_FACT','author_statement','supports','Explicit lineage.'),
('C0137','ARCHIVE_SYNTHESIS','archive_synthesis','supports','Chronological reconciliation of Chapter 4.'),
('C0138','AUTHOR_SYNTHESIS','author_statement','presents','Political interpretation belongs to the book author.'),
('C0139','ARCHIVE_SYNTHESIS','archive_synthesis','unresolved','Conflict between two passages in S0001.');

-- Identity exclusions prevent future accidental merges.
INSERT OR IGNORE INTO identity_exclusions(
    exclusion_id,person_id,excluded_identity_text,reason,evidence_basis
) VALUES
('IX001','P0011','Later Mohammad-Hossein Khan of the Nosrat al-Molk / Hesam al-Molk line',
 'The book explicitly warns that compilers confused the early Ashiqloo chief with a later namesake.',
 'S0001 narrative'),
('IX002','P0003','Mohammad-Hasan Khan E''temad al-Saltaneh, court historian',
 'Same honorific title, different person.',
 'S0001 narrative and title dispute'),
('IX003','P0003','Mostafa-Qoli Khan Qashqai',
 'Different tribal identity and historical episode.',
 'S0001 narrative'),
('IX004','P0004','Abdollah Khan Sarem al-Saltaneh',
 'Different branch, generation, and title despite similar name.',
 'S0001 narrative'),
('IX005','P0008','Gholamhossein Gharagozloo, author of Hegmataneh ta Hamadan',
 'Bibliographic author is not the archive owner''s grandfather.',
 'S0001 bibliography/index'),
('IX006','P0040','Mahmoud Khan Naser al-Molk',
 'Grandfather and predecessor who bore the same title.',
 'S0001 narrative lineage');

-- Mark dossier status and source-level quality.
UPDATE person_dossiers SET
    status='silver_s0001_reconciled',
    generated_from_migration='0013',
    updated_at='2026-07-11T23:59:00Z'
WHERE person_id IN ('P0011','P0003','P0004','P0005','P0007','P0008','P0040');

INSERT OR REPLACE INTO person_reconciliation(
    person_id,wave_id,dossier_level,reconciliation_status,
    identity_collision_reviewed,relationships_reviewed,timeline_reviewed,citations_reviewed,
    unresolved_summary,updated_at
) VALUES
('P0011','RW001','silver','complete_for_source',1,1,1,1,
 'Shahbaz relationship remains probable; direct parent link to Haji Mohammad Khan is unverified; some namesake references remain unresolved.',
 '2026-07-11T23:59:00Z'),
('P0003','RW001','silver','complete_for_source',1,1,1,1,
 'Exact birth/death dates, full estate list, and details of Urmia governorship remain open.',
 '2026-07-11T23:59:00Z'),
('P0004','RW001','silver','complete_for_source',1,1,1,1,
 'Exact dates, wives, and full list of approximately 120 landed properties remain open.',
 '2026-07-11T23:59:00Z'),
('P0005','RW001','silver','complete_for_source',1,1,1,1,
 'Amir Arfa title-grant date, office, wife, dates, and personal estates remain unknown.',
 '2026-07-11T23:59:00Z'),
('P0007','RW001','silver','complete_for_source',1,1,1,1,
 'Book provides no independent biography; dates, spouse, children, estates, and career require external sources.',
 '2026-07-11T23:59:00Z'),
('P0008','RW001','silver','complete_for_source',1,1,1,1,
 'Book provides no secure biography; Majles service, study abroad, estates, dates, and Amiri surname adoption require external verification.',
 '2026-07-11T23:59:00Z'),
('P0040','RW001','silver','complete_for_source',1,1,1,1,
 'Mehdi Khan child identification conflicts internally; exact details of some appointments and family matters require external verification.',
 '2026-07-11T23:59:00Z');

-- High-priority research questions generated by reconciliation.
INSERT OR IGNORE INTO research_questions(question_id,question,status,priority,notes) VALUES
('Q0008','Was Shahbaz Khan definitely the father of the early Mohammad-Hossein Khan, or only his predecessor?','open','high','P0011; S0001 treats this as inference.'),
('Q0009','What were Mostafa-Qoli Khan E''temad al-Saltaneh''s exact birth and death dates?','open','medium','P0003'),
('Q0010','Can Abdollah Khan''s approximately 120 villages be individually identified?','open','high','P0004'),
('Q0011','When and why was the title Amir Arfa'' granted to Mohtaj-Ali Khan?','open','high','P0005'),
('Q0012','Can civil, property, or family records confirm Gholam-Ali Khan''s dates, spouse, children, and estates?','open','high','P0007'),
('Q0013','When did Gholamhossein Khan or his branch formally adopt the surname Amiri?','open','high','P0008'),
('Q0014','Did Gholamhossein Khan serve as a Majles representative for Hamadan, and in which term?','open','high','P0008; family testimony requires official verification.'),
('Q0015','Who is the Mehdi Khan called son of Naser al-Molk in the Chapter 2 regimental passage?','open','high','P0040/P0064; conflicts with Chapter 4 child list.');

INSERT OR REPLACE INTO metadata(key,value) VALUES('archive_version','2.2.0');
INSERT OR REPLACE INTO metadata(key,value) VALUES('master_reconciliation_wave_1','complete');
INSERT OR REPLACE INTO metadata(key,value) VALUES('reconciliation_policy',
 'Text-first; author inference qualified; user testimony explicitly labeled; genealogy diagrams supporting-only unless corroborated.');
