-- Migration 0043
-- Majmooe Asaar: Editorial Notes & Identity Enrichment
-- Baseline: v2.8.9 / migration 0042
--
-- Scope:
--   * Enayatollah Majidi's editorial notes and introductory commentary
--   * Secondary corroboration of Abdollah Khan chronology
--   * Identity clarification / ambiguity tracking
--   * Secondary estate/property evidence
--   * Contextual office/title clarification
--
-- IMPORTANT:
--   * Editorial notes are SECONDARY evidence and remain distinct from Abdollah Khan's primary writings.
--   * No canonical genealogy changes.
--   * No forced identity merges where the editor/source traditions remain ambiguous.
--   * Property claims remain secondary and incomplete.
--   * Existing primary events are corroborated, not duplicated unnecessarily.
--   * Transaction control omitted because apply_migration.py owns it.

UPDATE metadata SET value='2.9.0' WHERE key='database_version';
INSERT OR REPLACE INTO metadata(key,value) VALUES('last_migration','0043');
INSERT OR REPLACE INTO metadata(key,value) VALUES('updated_at','2026-08-04T03:40:00Z');
INSERT OR REPLACE INTO metadata(key,value) VALUES(
    'historical_enrichment_checkpoint',
    'Majmooe Asaar Editorial Notes and Identity Enrichment'
);

INSERT INTO sources(source_id,short_title,full_title,author,publication_year,source_type,file_name,notes)
SELECT 'S0201','Majmooe Asaar Editorial Notes',
       'توضیحات و تعلیقات مجموعه آثار حاجی عبدالله خان قراگوزلو امیر نظام همدانی',
       'Enayatollah Majidi',NULL,'editorial notes / secondary source',
       'Majmooe Asaar - PDF.pdf',
       'Modern editorial introduction, annotations, biographical notes, identity clarifications and secondary contextual references accompanying Abdollah Khan''s primary writings.'
WHERE NOT EXISTS (SELECT 1 FROM sources WHERE source_id='S0201');

-- ---------------------------------------------------------------------------
-- Secondary corroboration claims for Abdollah Khan chronology
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO citations(citation_id,source_id,page_printed,page_file,locator_text,quoted_text,notes) VALUES
('X1300','S0201',NULL,NULL,'Editor introduction: Astarabad to Fars chronology',
 'Majidi summarizes Abdollah Khan''s appointment to Astarabad in 1298 AH, Khuzestan service from 1305 AH, presentation of the Arabistan/Lorestan report in Rabi I 1308 AH, and Shiraz service by 1309 AH.',
 'Secondary chronological corroboration.'),
('X1301','S0201',NULL,NULL,'Editor notes: title transfers to sons',
 'Majidi states that Hossein Qoli Khan received Sa''ed al-Saltaneh, while Mohtaj Ali Khan received Ejlal al-Mamalek; Hossein Qoli later became Amir Nezam and inherited Sardar Akram.',
 'Secondary title/identity clarification.'),
('X1302','S0201',NULL,NULL,'Editor notes: Hajji Sayyah Mahallati and Sadiq al-Sultan',
 'Majidi identifies Hajji Sayyah Mahallati more fully and identifies Sadiq al-Sultan as Hajji Reza Khan, son of Aqa Mohammad Ali Sarraf, associated with the military treasury.',
 'Secondary identity clarification.'),
('X1303','S0201',NULL,NULL,'Editor notes: Samsam al-Molk ambiguity',
 'Majidi explicitly notes uncertainty in source traditions concerning Ali Naqi Khan Samsam al-Molk and wording that can appear to combine Samsam al-Molk with Zulfaqar Khan.',
 'Identity-reconciliation note.'),
('X1304','S0201',NULL,NULL,'Editor notes: Sadiq al-Molk diplomatic biography',
 'Majidi identifies Sadiq al-Molk, son of Mirza Mohammad Nuri Mazandarani, and summarizes diplomatic offices including Paris, the Foreign Ministry and Sofia.',
 'Secondary contextual biography.'),
('X1305','S0201',NULL,NULL,'Editor introduction: Abdollah Khan estates and Tehran properties',
 'Majidi reports secondary estimates of Abdollah Khan''s landed holdings and describes three Tehran gardens/properties inherited by his sons, including property later associated with the Italian Embassy and Endowments administration.',
 'Secondary property evidence; incomplete and requires parcel/identity reconciliation.'),
('X1306','S0201',NULL,NULL,'Editor notes: unresolved fate of Amir Nezam properties',
 'Majidi states that the later fate of several named Amir Nezam properties is not known.',
 'Secondary evidence of incomplete estate reconstruction.'),
('X1307','S0201',NULL,NULL,'Editor/primary context: Behbud Khan in Kalat',
 'The Kalat material associates an earlier cavalry-tax arrangement with the late Behbud Khan, but the editor does not provide a sufficiently secure full identity for canonical reconciliation.',
 'Identity remains unresolved.');

-- ---------------------------------------------------------------------------
-- Claims
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO claims(claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes) VALUES
('C1300','person','P0004','secondary_astarabad_appointment',
 'Majidi secondarily corroborates Abdollah Khan''s appointment as governor of Astarabad on 24 Jumada II 1298 AH.',
 'confirmed','active','Secondary corroboration; do not duplicate existing primary event if already present.'),
('C1301','person','P0004','secondary_khuzestan_service',
 'Majidi secondarily corroborates Abdollah Khan''s Khuzestan service beginning in 1305 AH under/with Hossein Qoli Khan Nezam al-Saltaneh Mafi.',
 'confirmed','active','Secondary corroboration.'),
('C1302','person','P0004','secondary_report_presentation',
 'Majidi states that the Arabistan/Lorestan report was presented in Rabi I 1308 AH.',
 'confirmed','active','Secondary corroboration.'),
('C1303','person','P0004','secondary_shiraz_service',
 'Majidi states that Abdollah Khan was in Shiraz by 1309 AH with responsibility for guarding the city and citadel.',
 'confirmed','active','Secondary corroboration.'),
('C1304','person','P0004','estate_estimate_69_villages',
 'Majidi reports a secondary estimate that Abdollah Khan held approximately sixty-nine villages.',
 'probable','active','Secondary estimate; exact estate list unresolved.'),
('C1305','person','P0004','estate_population_ranges',
 'Majidi reports secondary estimates that populations of individual villages ranged roughly from 150 to 2,000.',
 'probable','active','Secondary estimate.'),
('C1306','person','P0004','tehran_three_gardens',
 'Majidi reports that Abdollah Khan apparently possessed three gardens/properties in Tehran that passed to his sons.',
 'probable','active','Secondary property claim; parcels and succession need reconciliation.'),
('C1307','person','P0004','estate_reconstruction_incomplete',
 'Majidi explicitly indicates that the later fate of several Amir Nezam properties is unknown.',
 'confirmed','active','Secondary evidence that estate reconstruction remains incomplete.'),
('C1308','person','P0004','editorial_property_layer',
 'Property claims in Majidi''s commentary should be treated as secondary evidence distinct from Abdollah Khan''s own writings.',
 'confirmed','active','Archive evidence-layer policy applied to this source.'),
('C1309','person','P0004','editorial_chronology_layer',
 'Majidi''s chronology provides secondary corroboration for events already supported by Abdollah Khan''s writings and other archive evidence.',
 'confirmed','active','Avoid duplicate event inflation.');

-- Title-transfer corroborations are attached to P0004 as family-context claims.
-- This avoids altering genealogy and avoids assuming/rewriting canonical child IDs.
INSERT OR IGNORE INTO claims(claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes) VALUES
('C1310','person','P0004','secondary_son_title_transfer_hossein_qoli',
 'Majidi states that Abdollah Khan''s son Hossein Qoli Khan received the title Sa''ed al-Saltaneh and later became Amir Nezam / Sardar Akram.',
 'confirmed','active','Secondary family/title corroboration; no genealogy or person-ID change.'),
('C1311','person','P0004','secondary_son_title_transfer_mohtaj_ali',
 'Majidi states that Abdollah Khan''s son Mohtaj Ali Khan received the title Ejlal al-Mamalek.',
 'confirmed','active','Secondary family/title corroboration; no genealogy or person-ID change.');

-- Contextual identity claims remain textual unless reconciled to canonical person IDs.
INSERT OR IGNORE INTO claims(claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes) VALUES
('C1312','person','P0004','editorial_context_hajji_sayyah_identity',
 'Majidi identifies Hajji Sayyah Mahallati more fully as Hajji Mirza Mohammad Ali, son of Molla Mohammad Reza Mahallati.',
 'confirmed','active','Contextual identity; canonical person creation deferred unless needed by event graph.'),
('C1313','person','P0004','editorial_context_sadiq_al_sultan_identity',
 'Majidi identifies Sadiq al-Sultan as Hajji Reza Khan Sadiq al-Sultan, son of Aqa Mohammad Ali Sarraf, associated with the military treasury.',
 'confirmed','active','Contextual identity; canonical creation deferred.'),
('C1314','person','P0004','editorial_context_samsam_al_molk_ambiguity',
 'Majidi explicitly preserves ambiguity around the identity/name form of Samsam al-Molk, with Ali Naqi Khan Samsam al-Molk strongly indicated in one tradition but other wording potentially conflating him with Zulfaqar Khan.',
 'confirmed','active','Do not force identity merge.'),
('C1315','person','P0004','editorial_context_sadiq_al_molk_identity',
 'Majidi identifies Sadiq al-Molk as son of Mirza Mohammad Nuri Mazandarani and summarizes a diplomatic career involving Paris, the Foreign Ministry and Sofia.',
 'confirmed','active','Contextual biography; canonical person creation deferred unless needed.'),
('C1316','person','P0004','editorial_context_behbud_khan_unresolved',
 'The Kalat material names the late Behbud Khan in connection with an earlier cavalry-tax arrangement, but his full identity and office remain unresolved.',
 'confirmed','active','Identity-reconciliation candidate.'),
('C1317','person','P0004','editorial_identity_threshold',
 'Only editorial identities that materially affect chronology, role/title interpretation, property reconstruction, or existing unresolved claims should be promoted into canonical person records.',
 'confirmed','active','Archive curation rule for this annotation pass.');

-- ---------------------------------------------------------------------------
-- Claim-citation links
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C1300','X1300','supports'),
('C1301','X1300','supports'),
('C1302','X1300','supports'),
('C1303','X1300','supports'),
('C1304','X1305','supports'),
('C1305','X1305','supports'),
('C1306','X1305','supports'),
('C1307','X1306','supports'),
('C1308','X1305','supports'),
('C1309','X1300','supports'),
('C1310','X1301','supports'),
('C1311','X1301','supports'),
('C1312','X1302','supports'),
('C1313','X1302','supports'),
('C1314','X1303','supports'),
('C1315','X1304','supports'),
('C1316','X1307','supports'),
('C1317','X1302','supports'),
('C1317','X1303','supports'),
('C1317','X1305','supports');

-- ---------------------------------------------------------------------------
-- Identity conflicts / research questions
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO research_questions(question_id,question,status,priority,notes) VALUES
('Q0130','Can the Samsam al-Molk references be reconciled securely among Ali Naqi Khan Samsam al-Molk, Zulfaqar Khan, and variant combined name forms in the cited memoir traditions?','open','high','Do not merge identities until source wording and chronology are reconciled.'),
('Q0131','Should Hajji Sayyah Mahallati be promoted to a canonical person record based on his relevance to Abdollah Khan''s 1319 AH Mecca journey and related event graph?','open','medium','Identity is relatively clear; promotion depends on archive relevance threshold.'),
('Q0132','Should Sadiq al-Sultan (Hajji Reza Khan, son of Aqa Mohammad Ali Sarraf) be promoted to a canonical person record, and what exact military-treasury office should be normalized?','open','medium','Need office terminology reconciliation.'),
('Q0133','Who exactly was Behbud Khan in the Kalat fiscal/military context, and what office did he hold?','open','high','Existing Kalat research question reinforced by editorial pass.'),
('Q0134','Can Abdollah Khan''s reported approximately 69 villages be reconstructed property-by-property from deeds, waqf records, fiscal registers, or family papers?','open','high','Secondary estimate should not become a complete estate list without independent evidence.'),
('Q0135','Which three Tehran gardens/properties did Abdollah Khan own, how were they divided among his sons, and which parcel became associated with the Italian Embassy?','open','high','Requires property/parcel and succession reconciliation.'),
('Q0136','Which son or descendant is intended by each occurrence of "Amir Nezam II" in Majidi''s property discussion?','open','high','Do not attach property ownership until person reference is resolved.'),
('Q0137','Can Sadiq al-Molk''s diplomatic chronology be independently corroborated and linked to the exact travelogue episode in which he appears?','open','low','Contextual person; promote only if archive relevance warrants.');

-- ---------------------------------------------------------------------------
-- Change log
-- ---------------------------------------------------------------------------
INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-04T03:40:00Z','migration','0043','apply',
       'Added Majmooe Asaar editorial notes and identity enrichment; secondary evidence kept distinct from primary writings.');

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-04T03:40:00Z','source','S0201','insert',
       'Added Enayatollah Majidi editorial notes as a distinct secondary source layer.');

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-04T03:40:00Z','claim','C1300-C1317','insert',
       'Added secondary chronology, title, identity, estate/property and unresolved ambiguity claims.');

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-04T03:40:00Z','database','archive','release',
       'Prepared v2.9.0 Majmooe Asaar Editorial Notes and Identity Enrichment checkpoint.');
