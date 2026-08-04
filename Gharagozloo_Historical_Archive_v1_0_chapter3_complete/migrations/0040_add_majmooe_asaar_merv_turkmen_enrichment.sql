-- Migration 0040
-- Majmooe Asaar: Merv & Turkmen Frontier enrichment
-- Baseline: v2.8.6 / migration 0039
--
-- Scope:
--   * Kitabcheh-ye Merv, completed 1296 AH
--   * Teke / Salur political, military, social, economic, and environmental observations
--   * Qushid Khan, Tejen, Qarli Band, Khiva conflict, Merv leadership fragmentation
--
-- IMPORTANT:
--   * This migration keeps the Merv booklet distinct from the Sarakhs/Naseriyeh report.
--   * No canonical genealogy relationships are changed.
--   * Authorial judgments remain explicitly attributed to Abdollah Khan.
--   * Historical figures are represented primarily through claims/events until identity reconciliation is complete.
--   * Transaction control is intentionally omitted because apply_migration.py owns it.

UPDATE metadata SET value='2.8.7' WHERE key='database_version';
INSERT OR REPLACE INTO metadata(key,value) VALUES('last_migration','0040');
INSERT OR REPLACE INTO metadata(key,value) VALUES('updated_at','2026-08-04T02:10:00Z');
INSERT OR REPLACE INTO metadata(key,value) VALUES(
    'historical_enrichment_checkpoint',
    'Majmooe Asaar Merv and Turkmen Frontier'
);

INSERT INTO sources(source_id,short_title,full_title,author,publication_year,source_type,file_name,notes)
SELECT 'S0200','Majmooe Asaar','مجموعه آثار حاجی عبدالله خان قراگوزلو امیر نظام همدانی',
       'Haji Abdollah Khan Gharagozloo; edited by Enayatollah Majidi',NULL,
       'edited primary-source collection','Majmooe Asaar - PDF.pdf',
       'Collection containing Abdollah Khan''s Kitabcheh-ye Merv, completed in 1296 AH.'
WHERE NOT EXISTS (SELECT 1 FROM sources WHERE source_id='S0200');

-- ---------------------------------------------------------------------------
-- Places
-- ---------------------------------------------------------------------------
CREATE TEMP TABLE _mrv_place_map(place_key TEXT PRIMARY KEY, place_id TEXT NOT NULL);

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0270','Merv','مرو','city/region',NULL,'Principal geographic focus of Abdollah Khan''s Kitabcheh-ye Merv.'
WHERE NOT EXISTS (SELECT 1 FROM places WHERE lower(preferred_name_en)='merv' OR preferred_name_fa='مرو');
INSERT INTO _mrv_place_map SELECT 'merv',place_id FROM places
WHERE lower(preferred_name_en)='merv' OR preferred_name_fa='مرو'
ORDER BY CASE WHEN place_id='L0270' THEN 0 ELSE 1 END, place_id LIMIT 1;

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0271','Tejen','تجن','river/region',NULL,'Tejen River and settlement zone discussed in relation to Teke migration, irrigation and Qarli Band.'
WHERE NOT EXISTS (SELECT 1 FROM places WHERE lower(preferred_name_en)='tejen' OR preferred_name_fa='تجن');
INSERT INTO _mrv_place_map SELECT 'tejen',place_id FROM places
WHERE lower(preferred_name_en)='tejen' OR preferred_name_fa='تجن'
ORDER BY CASE WHEN place_id='L0271' THEN 0 ELSE 1 END, place_id LIMIT 1;

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0272','Qarli Band','قرلی بند','dam/irrigation work',(SELECT place_id FROM _mrv_place_map WHERE place_key='tejen'),
       'Historical irrigation barrier associated by the source with Araz Khan and agricultural expansion.'
WHERE NOT EXISTS (SELECT 1 FROM places WHERE lower(preferred_name_en)='qarli band' OR preferred_name_fa='قرلی بند');
INSERT INTO _mrv_place_map SELECT 'qarli_band',place_id FROM places
WHERE lower(preferred_name_en)='qarli band' OR preferred_name_fa='قرلی بند'
ORDER BY CASE WHEN place_id='L0272' THEN 0 ELSE 1 END, place_id LIMIT 1;

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0273','Qushid Khan Fortress','قلعه قوشید خان','fortress',NULL,
       'Fortress near Sarakhs associated with Qushid Khan and later used in the conflict with Mohammad Amin Khan of Khiva.'
WHERE NOT EXISTS (SELECT 1 FROM places WHERE lower(preferred_name_en)='qushid khan fortress');
INSERT INTO _mrv_place_map SELECT 'qushid_fort',place_id FROM places
WHERE lower(preferred_name_en)='qushid khan fortress'
ORDER BY CASE WHEN place_id='L0273' THEN 0 ELSE 1 END, place_id LIMIT 1;

-- ---------------------------------------------------------------------------
-- Events
-- ---------------------------------------------------------------------------
INSERT INTO events(event_id,event_type,title,date_text,place_id,description,verification_status)
SELECT 'E0280','historical_report',
       'Completion of Abdollah Khan''s Kitabcheh-ye Merv',
       '1296 AH',
       (SELECT place_id FROM _mrv_place_map WHERE place_key='merv'),
       'Abdollah Khan completed a structured report on Merv and the Turkmen frontier, including political history, tribal organization, warfare, agriculture, markets, irrigation, military capacity, and social relations.',
       'confirmed'
WHERE NOT EXISTS (SELECT 1 FROM events WHERE event_id='E0280');
INSERT OR IGNORE INTO event_persons(event_id,person_id,role)
VALUES('E0280','P0004','author and compiler');

INSERT INTO events(event_id,event_type,title,date_text,place_id,description,verification_status)
SELECT 'E0281','irrigation_development',
       'Qarli Band irrigation development at Tejen',
       'before 1296 AH; historical account',
       (SELECT place_id FROM _mrv_place_map WHERE place_key='qarli_band'),
       'The Merv booklet associates Araz Khan with construction of Qarli Band on the Tejen and links the work to expanded cultivation and grain prosperity.',
       'confirmed'
WHERE NOT EXISTS (SELECT 1 FROM events WHERE event_id='E0281');

INSERT INTO events(event_id,event_type,title,date_text,place_id,description,verification_status)
SELECT 'E0282','military_conflict',
       'Khivan attack and Teke defense near Sarakhs',
       'historical episode recounted in Kitabcheh-ye Merv',
       (SELECT place_id FROM _mrv_place_map WHERE place_key='qushid_fort'),
       'Mohammad Amin Khan of Khiva advanced toward Sarakhs, surrounded Qushid Khan''s fortress, and was defeated after Teke sorties; the source says Mohammad Amin Khan was killed and Mir Ahmad Khan Jamshidi organized the surviving retreat.',
       'confirmed'
WHERE NOT EXISTS (SELECT 1 FROM events WHERE event_id='E0282');

INSERT INTO events(event_id,event_type,title,date_text,place_id,description,verification_status)
SELECT 'E0283','political_fragmentation',
       'Fragmentation of Merv leadership after Qushid Khan',
       'after Qushid Khan''s death',
       (SELECT place_id FROM _mrv_place_map WHERE place_key='merv'),
       'The source says no single Merv khan was accepted by all Teke after Qushid Khan, with authority divided among several major chiefs and elders.',
       'confirmed'
WHERE NOT EXISTS (SELECT 1 FROM events WHERE event_id='E0283');

-- ---------------------------------------------------------------------------
-- Citations
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO citations(citation_id,source_id,page_printed,page_file,locator_text,quoted_text,notes) VALUES
('X1000','S0200',NULL,NULL,'Kitabcheh-ye Merv: work boundary and completion',
 'The Merv booklet is a distinct work by Abdollah Khan and ends with a completion date of 1296 AH.',
 'Primary-source work boundary.'),
('X1001','S0200',NULL,NULL,'Kitabcheh-ye Merv: Teke divisions, Tejen and Qarli Band',
 'The source describes Aqtemish and Taqtemish divisions, Tejen settlement, Araz Khan, Qarli Band and the agricultural effects of irrigation.',
 'Ethnographic and environmental description.'),
('X1002','S0200',NULL,NULL,'Kitabcheh-ye Merv: Khvajam Shokur Aq-Saqal',
 'The source describes Khvajam Shokur as an influential Teke leader associated with movements between Tejen and Sarakhs and a large following.',
 'Historical political/tribal narrative.'),
('X1003','S0200',NULL,NULL,'Kitabcheh-ye Merv: rise of Qushid Khan',
 'The source recounts Qushid Khan''s selection as commander, later fortress building, and expansion of influence toward Tejen.',
 'Historical political-military narrative.'),
('X1004','S0200',NULL,NULL,'Kitabcheh-ye Merv: Mohammad Amin Khan of Khiva campaign',
 'The source narrates Mohammad Amin Khan''s advance, the siege near Sarakhs, Teke sorties, his death, and Mir Ahmad Khan Jamshidi''s organized retreat.',
 'Historical battle narrative.'),
('X1005','S0200',NULL,NULL,'Kitabcheh-ye Merv: post-Qushid leadership structure',
 'The source says leadership fragmented after Qushid Khan and names Baba Khan, Araz Morad Khan, Beg Morad Khan, Nur Verdi Khan and other elders.',
 'Political leadership description.'),
('X1006','S0200',NULL,NULL,'Kitabcheh-ye Merv: Merv economy, markets, irrigation and fuel',
 'The source discusses irrigation dependence, agriculture, fuel gathering, periodic markets, labor mobilization and wealth distribution.',
 'Economic/environmental observations.'),
('X1007','S0200',NULL,NULL,'Kitabcheh-ye Merv: Teke military capacity',
 'Abdollah Khan comments on declining cavalry numbers and describes strong prone rifle infantry, including a reported effective range around 300 paces.',
 'Authorial military assessment.'),
('X1008','S0200',NULL,NULL,'Kitabcheh-ye Merv: Salur status under Teke rule',
 'The source portrays Salur communities as politically and economically subordinate in Merv, with limited land/water autonomy and social barriers.',
 'Ethnographic/social description; preserve source attribution.');

-- ---------------------------------------------------------------------------
-- Claims
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO claims(claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes) VALUES
('C1000','person','P0004','merv_booklet_authorship','Abdollah Khan authored Kitabcheh-ye Merv, a distinct report completed in 1296 AH.','confirmed','active','Keep distinct from the Sarakhs/Naseriyeh report.'),
('C1001','place',(SELECT place_id FROM _mrv_place_map WHERE place_key='merv'),'teke_divisions','The Merv booklet associates major Teke groupings with Aqtemish and Taqtemish branches and with Merv and Akhal.','confirmed','active','Source''s ethnographic classification.'),
('C1002','event','E0281','araz_khan_association','The source associates Araz Khan with building Qarli Band on the Tejen.','confirmed','active','Historical source attribution.'),
('C1003','event','E0281','agricultural_effect','The source links Qarli Band irrigation with expanded cultivation and improved grain prosperity.','confirmed','active','Historical economic/environmental claim.'),
('C1004','place',(SELECT place_id FROM _mrv_place_map WHERE place_key='tejen'),'khvajam_shokur_migration','Khvajam Shokur Aq-Saqal is described as an influential leader associated with movement of Teke groups between Tejen and Sarakhs.','confirmed','active','Historical political/tribal narrative.'),
('C1005','place',(SELECT place_id FROM _mrv_place_map WHERE place_key='tejen'),'khvajam_shokur_following','The source says roughly six thousand households eventually gathered under Khvajam Shokur''s authority.','confirmed','active','Source-stated demographic estimate.'),
('C1006','place',(SELECT place_id FROM _mrv_place_map WHERE place_key='tejen'),'khvajam_shokur_trade_control','Abdollah Khan portrays Khvajam Shokur as exercising severe coercive authority over trade and internal discipline.','confirmed','active','Authorial portrayal; not neutral character judgment.'),
('C1007','event','E0282','qushid_khan_commander','Qushid Khan is described as having been selected as commander during a major conflict involving Turkmen groups and Khiva.','confirmed','active','Historical narrative.'),
('C1008','place',(SELECT place_id FROM _mrv_place_map WHERE place_key='qushid_fort'),'founder_association','The source associates Qushid Khan with building the fortress later bearing his name near Sarakhs.','confirmed','active','Person-place association retained in claim layer pending person-ID reconciliation.'),
('C1009','event','E0282','khiva_advance','Mohammad Amin Khan of Khiva advanced from the Merv region toward Sarakhs and surrounded the Teke defensive concentration at Qushid Khan''s fortress.','confirmed','active','Historical battle narrative.'),
('C1010','event','E0282','teke_attempted_submission','Before the fighting, the Teke reportedly attempted submission through gifts of money and horses, which Mohammad Amin Khan rejected.','confirmed','active','Source''s sequence of events.'),
('C1011','event','E0282','teke_field_commanders','The source names Aman Sa''d Sardar and Bardi Niyaz Khan, son of Araz Khan, among Teke commanders during the battle.','confirmed','active','Names preserved from source; transliteration may need later normalization.'),
('C1012','event','E0282','mohammad_amin_khan_death','The source says Mohammad Amin Khan of Khiva was killed during the battle near Sarakhs.','confirmed','active','Historical claim as reported by Abdollah Khan.'),
('C1013','event','E0282','mir_ahmad_retreat','Mir Ahmad Khan Jamshidi is described as reorganizing the surviving Khivan army and withdrawing it in good order.','confirmed','active','Historical military narrative.'),
('C1014','event','E0283','no_single_ruler','After Qushid Khan''s death, the source says no single Merv khan was accepted by the entire Teke population.','confirmed','active','Political fragmentation.'),
('C1015','event','E0283','major_chiefs','The source identifies Araz Morad Khan, Beg Morad Khan, Baba Khan son of Qushid Khan, and Nur Verdi Khan among the principal chiefs in the fragmented leadership structure.','confirmed','active','Leadership names preserved from source.'),
('C1016','event','E0283','abdollah_leader_assessments','Abdollah Khan judges Nur Verdi Khan and Beg Morad Khan favorably while describing Baba Khan very negatively.','confirmed','active','Explicit authorial assessment, not neutral personality fact.'),
('C1017','place',(SELECT place_id FROM _mrv_place_map WHERE place_key='merv'),'irrigation_dependency','The Merv economy is described as highly dependent on river and dam irrigation, with major disorder when the dam failed.','confirmed','active','Environmental/economic observation.'),
('C1018','place',(SELECT place_id FROM _mrv_place_map WHERE place_key='merv'),'collective_dam_labor','The source describes mobilization of several thousand workers to repair damaged irrigation infrastructure.','confirmed','active','Source-stated labor scale.'),
('C1019','place',(SELECT place_id FROM _mrv_place_map WHERE place_key='merv'),'agricultural_products','The source describes strong production of melons, watermelons, pumpkins, grains and other field crops, while fruit gardens were relatively scarce.','confirmed','active','Contemporary agricultural description.'),
('C1020','place',(SELECT place_id FROM _mrv_place_map WHERE place_key='merv'),'fuel_sources','Camel-thorn shrubs and tamarisk are described as important fuel sources, with winter fuel stockpiling.','confirmed','active','Environmental/economic observation.'),
('C1021','place',(SELECT place_id FROM _mrv_place_map WHERE place_key='merv'),'weekly_markets','The source reports two weekly markets, on Mondays and Thursdays, near Qushid Khan''s house in the Taqtamish area.','confirmed','active','Commercial routine.'),
('C1022','place',(SELECT place_id FROM _mrv_place_map WHERE place_key='merv'),'wealth_distribution','Abdollah Khan estimates that large cash fortunes were uncommon among the Teke population of Merv.','confirmed','active','Authorial estimate; do not convert into modern wealth statistics.'),
('C1023','place',(SELECT place_id FROM _mrv_place_map WHERE place_key='merv'),'cavalry_decline','Abdollah Khan argues that Teke cavalry numbers had declined and that assembling even ten thousand mounted men would have been difficult in his time.','confirmed','active','Authorial military assessment.'),
('C1024','place',(SELECT place_id FROM _mrv_place_map WHERE place_key='merv'),'rifle_infantry_strength','Abdollah Khan describes Teke rifle infantry as formidable, including prone firing and an effective range he reports at around three hundred paces.','confirmed','active','Authorial military assessment.'),
('C1025','place',(SELECT place_id FROM _mrv_place_map WHERE place_key='merv'),'mirkan_term','The source uses the term mirkan for the type of Teke rifleman being described.','confirmed','active','Preserve source terminology.'),
('C1026','place',(SELECT place_id FROM _mrv_place_map WHERE place_key='merv'),'salur_subordination','The source portrays Salur communities in Merv as politically and economically subordinate to Teke power, including limited land and water autonomy.','confirmed','active','Ethnographic/social description; time- and source-bounded.'),
('C1027','place',(SELECT place_id FROM _mrv_place_map WHERE place_key='merv'),'salur_intermarriage_barriers','Abdollah Khan describes social barriers around intermarriage between Salur and Teke groups, while noting that wealth could sometimes override them.','confirmed','active','Historical social observation, not timeless generalization.'),
('C1028','person','P0004','merv_analytical_scope','In the Merv booklet Abdollah Khan combines political history, ethnography, warfare, irrigation, agriculture, markets, wealth and military analysis in one regional report.','probable','active','Archive synthesis derived from the work''s structure.');

-- ---------------------------------------------------------------------------
-- Claim-citation links
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C1000','X1000','supports'),
('C1001','X1001','supports'),
('C1002','X1001','supports'),
('C1003','X1001','supports'),
('C1004','X1002','supports'),
('C1005','X1002','supports'),
('C1006','X1002','supports'),
('C1007','X1003','supports'),
('C1008','X1003','supports'),
('C1009','X1004','supports'),
('C1010','X1004','supports'),
('C1011','X1004','supports'),
('C1012','X1004','supports'),
('C1013','X1004','supports'),
('C1014','X1005','supports'),
('C1015','X1005','supports'),
('C1016','X1005','supports'),
('C1017','X1006','supports'),
('C1018','X1006','supports'),
('C1019','X1006','supports'),
('C1020','X1006','supports'),
('C1021','X1006','supports'),
('C1022','X1006','supports'),
('C1023','X1007','supports'),
('C1024','X1007','supports'),
('C1025','X1007','supports'),
('C1026','X1008','supports'),
('C1027','X1008','supports'),
('C1028','X1001','supports'),
('C1028','X1006','supports'),
('C1028','X1007','supports');

-- ---------------------------------------------------------------------------
-- Direct provenance
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO entity_citations(entity_citation_id,entity_type,entity_id,citation_id,support_type,notes) VALUES
('EC1000','event','E0280','X1000','supports','Merv booklet authorship and completion.'),
('EC1001','event','E0281','X1001','supports','Qarli Band / Tejen irrigation account.'),
('EC1002','event','E0282','X1004','supports','Khivan campaign and Teke defense.'),
('EC1003','event','E0283','X1005','supports','Post-Qushid leadership fragmentation.'),
('EC1004','place',(SELECT place_id FROM _mrv_place_map WHERE place_key='merv'),'X1006','supports','Merv economy and environmental observations.');

-- ---------------------------------------------------------------------------
-- Research questions
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO research_questions(question_id,question,status,priority,notes) VALUES
('Q0100','Which existing archive person records, if any, correspond to Qushid Khan, Baba Khan, Araz Morad Khan, Beg Morad Khan, Nur Verdi Khan, Araz Khan, Khvajam Shokur Aq-Saqal, Aman Sa''d Sardar, Bardi Niyaz Khan and Mir Ahmad Khan Jamshidi?','open','high','Reconcile before creating canonical person records to avoid duplicates and spelling variants.'),
('Q0101','Can the date of Mohammad Amin Khan of Khiva''s defeat and death near Sarakhs be fixed precisely from independent Khivan, Qajar, Russian or modern historical sources?','open','medium','Current migration preserves Abdollah Khan''s historical account without external normalization.'),
('Q0102','Can Qarli Band and Qushid Khan Fortress be mapped securely to historical or modern coordinates using independent cartographic evidence?','open','medium','Do not infer exact coordinates solely from textual distances.'),
('Q0103','How should the term mirkan in Abdollah Khan''s Teke military description be normalized linguistically and historically?','open','medium','Preserve source form until checked against Turkmen/Persian military terminology.'),
('Q0104','Can the source-stated figures for six thousand households, ten thousand cavalry, several thousand dam workers, and other demographic/military estimates be independently corroborated?','open','medium','Treat current figures as Abdollah Khan''s estimates.'),
('Q0105','How do Abdollah Khan''s descriptions of Salur subordination and Teke social hierarchy compare with other contemporary Turkmen, Qajar, Russian and European accounts?','open','medium','Needed to distinguish local observation from broader or enduring social patterns.');

-- ---------------------------------------------------------------------------
-- Change log
-- ---------------------------------------------------------------------------
INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-04T02:10:00Z','migration','0040','apply','Added Majmooe Asaar Merv and Turkmen Frontier historical enrichment; canonical genealogy unchanged.');

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-04T02:10:00Z','event','E0280-E0283','insert','Added Merv booklet, Tejen irrigation, Khivan conflict and post-Qushid political-fragmentation events.');

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-04T02:10:00Z','claim','C1000-C1028','insert','Added cited Merv political, military, social, economic and environmental claims.');

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-04T02:10:00Z','database','archive','release','Prepared v2.8.7 Merv and Turkmen Frontier enrichment checkpoint.');

DROP TABLE _mrv_place_map;
