-- Migration 0035
-- Majmooe Asaar: Abdollah Khan Amir Nezam Sarakhs/Naseriyeh mission enrichment
-- Baseline: v2.8.1 / migration 0034
-- Policy: enrich events, places, claims, citations, and research questions.
-- This migration does NOT alter canonical genealogy topology.
-- Transaction control is intentionally omitted; apply_migration.py owns the transaction.

UPDATE metadata SET value='2.8.2' WHERE key='database_version';
INSERT OR REPLACE INTO metadata(key,value) VALUES('last_migration','0035');
INSERT OR REPLACE INTO metadata(key,value) VALUES('updated_at','2026-08-03T23:40:00Z');
INSERT OR REPLACE INTO metadata(key,value) VALUES('historical_enrichment_checkpoint','Majmooe Asaar Sarakhs/Naseriyeh mission');

-- Ensure Source S0200 from migration 0034 is available.
INSERT INTO sources(source_id,short_title,full_title,author,publication_year,source_type,file_name,notes)
SELECT 'S0200','Majmooe Asaar','مجموعه آثار حاجی عبدالله خان قراگوزلو امیر نظام همدانی',
       'Haji Abdollah Khan Gharagozloo; edited by Enayatollah Majidi',NULL,'edited primary-source collection',
       'Majmooe Asaar - PDF.pdf',
       'Collection containing Abdollah Khan''s writings and reports, including the Sarakhs/Naseriyeh report and Kitabche-ye Merv.'
WHERE NOT EXISTS (SELECT 1 FROM sources WHERE source_id='S0200');

-- ---------------------------------------------------------------------------
-- Places: use qualified names to avoid conflating common fort names elsewhere.
-- ---------------------------------------------------------------------------

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0200','Sarakhs','سرخس','frontier city/region',NULL,
       'Historic northeastern Iranian frontier region discussed extensively in Abdollah Khan''s 1294–1296 AH mission reports.'
WHERE NOT EXISTS (
  SELECT 1 FROM places
  WHERE lower(preferred_name_en)='sarakhs' OR preferred_name_fa='سرخس'
);

CREATE TEMP TABLE _sar_place_map(
  place_key TEXT PRIMARY KEY,
  place_id TEXT NOT NULL
);

INSERT INTO _sar_place_map(place_key,place_id)
SELECT 'sarakhs', place_id FROM places
WHERE lower(preferred_name_en)='sarakhs' OR preferred_name_fa='سرخس'
ORDER BY CASE WHEN place_id='L0200' THEN 0 ELSE 1 END, place_id
LIMIT 1;

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0201','Naseriyeh Fortress','قلعه ناصریه','fortress',
       (SELECT place_id FROM _sar_place_map WHERE place_key='sarakhs'),
       'Qajar frontier fortress at Sarakhs; principal setting of Abdollah Khan''s Sarakhs report.'
WHERE NOT EXISTS (
  SELECT 1 FROM places
  WHERE lower(preferred_name_en) IN ('naseriyeh fortress','naserieh fortress')
     OR preferred_name_fa='قلعه ناصریه'
);

INSERT INTO _sar_place_map(place_key,place_id)
SELECT 'naseriyeh', place_id FROM places
WHERE lower(preferred_name_en) IN ('naseriyeh fortress','naserieh fortress')
   OR preferred_name_fa='قلعه ناصریه'
ORDER BY CASE WHEN place_id='L0201' THEN 0 ELSE 1 END, place_id
LIMIT 1;

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0202','Old Sarakhs (Sarakhs-e Kohneh)','سرخس کهنه','historic settlement',
       (SELECT place_id FROM _sar_place_map WHERE place_key='sarakhs'),
       'Older Sarakhs settlement distinguished in the source from Naseriyeh Fortress; described as about one farsakh away.'
WHERE NOT EXISTS (
  SELECT 1 FROM places
  WHERE lower(preferred_name_en) IN ('old sarakhs','old sarakhs (sarakhs-e kohneh)','sarakhs-e kohneh')
     OR preferred_name_fa='سرخس کهنه'
);

INSERT INTO _sar_place_map(place_key,place_id)
SELECT 'old_sarakhs', place_id FROM places
WHERE lower(preferred_name_en) IN ('old sarakhs','old sarakhs (sarakhs-e kohneh)','sarakhs-e kohneh')
   OR preferred_name_fa='سرخس کهنه'
ORDER BY CASE WHEN place_id='L0202' THEN 0 ELSE 1 END, place_id
LIMIT 1;

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0203','Qal''eh Now (Sarakhs)','قلعه نو','fort/outpost',
       (SELECT place_id FROM _sar_place_map WHERE place_key='sarakhs'),
       'Small river-side outpost above Sarakhs used to protect workers at the water-control works.'
WHERE NOT EXISTS (
  SELECT 1 FROM places
  WHERE lower(preferred_name_en)='qal''eh now (sarakhs)'
);

INSERT INTO _sar_place_map(place_key,place_id)
SELECT 'qaleh_now', place_id FROM places
WHERE lower(preferred_name_en)='qal''eh now (sarakhs)'
ORDER BY CASE WHEN place_id='L0203' THEN 0 ELSE 1 END, place_id
LIMIT 1;

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0204','Qal''eh Qassab (Sarakhs)','قلعه قصاب','fort/ruin',
       (SELECT place_id FROM _sar_place_map WHERE place_key='sarakhs'),
       'Ancient ruined and uninhabited fort described upstream from Sarakhs.'
WHERE NOT EXISTS (
  SELECT 1 FROM places
  WHERE lower(preferred_name_en)='qal''eh qassab (sarakhs)'
);

INSERT INTO _sar_place_map(place_key,place_id)
SELECT 'qaleh_qassab', place_id FROM places
WHERE lower(preferred_name_en)='qal''eh qassab (sarakhs)'
ORDER BY CASE WHEN place_id='L0204' THEN 0 ELSE 1 END, place_id
LIMIT 1;

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0205','Qushid Khan Fortress (Sarakhs)','قلعه قوشید خان','fort/ruin',
       (SELECT place_id FROM _sar_place_map WHERE place_key='sarakhs'),
       'Ruined fortress near Sarakhs associated in Abdollah Khan''s account with the Teke leader Qushid Khan.'
WHERE NOT EXISTS (
  SELECT 1 FROM places
  WHERE lower(preferred_name_en)='qushid khan fortress (sarakhs)'
);

INSERT INTO _sar_place_map(place_key,place_id)
SELECT 'qushid_fort', place_id FROM places
WHERE lower(preferred_name_en)='qushid khan fortress (sarakhs)'
ORDER BY CASE WHEN place_id='L0205' THEN 0 ELSE 1 END, place_id
LIMIT 1;

-- ---------------------------------------------------------------------------
-- Events
-- ---------------------------------------------------------------------------

INSERT INTO events(event_id,event_type,title,date_text,place_id,description,verification_status)
SELECT 'E0200','frontier_assignment',
       'Abdollah Khan Amir Nezam''s Sarakhs frontier mission',
       '1294–1296 AH',
       (SELECT place_id FROM _sar_place_map WHERE place_key='naseriyeh'),
       'Government frontier service at Sarakhs/Naseriyeh during which Abdollah Khan observed garrison life, geography, water, agriculture, Turkmen communities, and administrative conditions, and prepared reports for the Qajar court.',
       'confirmed'
WHERE NOT EXISTS (SELECT 1 FROM events WHERE event_id='E0200');

INSERT OR IGNORE INTO event_persons(event_id,person_id,role)
VALUES('E0200','P0004','frontier officer and observer-author');

INSERT INTO events(event_id,event_type,title,date_text,place_id,description,verification_status)
SELECT 'E0201','population_displacement',
       'Salur relocation to Old Sarakhs and forced movement toward Merv',
       'prior to 1294 AH; historical narrative in Kitabche-ye Merv',
       (SELECT place_id FROM _sar_place_map WHERE place_key='old_sarakhs'),
       'Abdollah Khan''s historical account describes Salur relocation under Iranian protection to Old Sarakhs, followed roughly six months later by a Teke force that compelled them toward Merv.',
       'probable'
WHERE NOT EXISTS (SELECT 1 FROM events WHERE event_id='E0201');

INSERT INTO events(event_id,event_type,title,date_text,place_id,description,verification_status)
SELECT 'E0202','military_campaign',
       'Abbas Mirza siege of Sarakhs in Abdollah Khan''s historical account',
       'ca. 1247 AH',
       (SELECT place_id FROM _sar_place_map WHERE place_key='sarakhs'),
       'Kitabche-ye Merv recounts an earlier Abbas Mirza campaign against Sarakhs and reports the liberation and capture of large numbers of captives. These figures are transmitted historical claims, not Abdollah Khan''s eyewitness observations.',
       'probable'
WHERE NOT EXISTS (SELECT 1 FROM events WHERE event_id='E0202');

-- ---------------------------------------------------------------------------
-- Citations to Source S0200. Page locators refer to printed pages/sections.
-- Quoted_text fields are concise source summaries, not long quotations.
-- ---------------------------------------------------------------------------

INSERT OR IGNORE INTO citations(citation_id,source_id,page_printed,page_file,locator_text,quoted_text,notes) VALUES
('X0600','S0200','35',NULL,'Editor''s introduction: Sarakhs mission and manuscript attribution',
 'Abdollah Khan is identified as son of Mostafa Qoli Khan E''temad al-Saltaneh and colonel of the Fadavi Regiment during his Sarakhs service.',
 'Editorial introduction identifying the author and mission context.'),
('X0601','S0200','84–92',NULL,'Report on Sarakhs and Naseriyeh Fortress: route, fortress and defensive setting',
 'The report describes Naseriyeh Fortress, its gates, nearby forts, patrols, and the Sarakhs defensive landscape.',
 'Firsthand report by Abdollah Khan.'),
('X0602','S0200','92–95',NULL,'Report on Sarakhs and Naseriyeh Fortress: garrison life and security',
 'Soldiers stood night guard and also performed daytime water, fuel, patrol and frontier-security duties.',
 'Firsthand observation and administrative assessment.'),
('X0603','S0200','94–95',NULL,'Report on Sarakhs and Naseriyeh Fortress: manpower reform proposal',
 'Abdollah Khan argues that twenty-seven useful cavalrymen would be more effective than two hundred subsidized kharalchi households.',
 'Author''s reform proposal, not an objective statistical conclusion.'),
('X0604','S0200','95–99',NULL,'Report on Sarakhs and Naseriyeh Fortress: climate, river and local environment',
 'The report describes severe winter conditions, river behavior, water works, surrounding terrain and local environmental conditions.',
 'Firsthand and locally reported observations.'),
('X0605','S0200','97–99',NULL,'Report on Sarakhs and Naseriyeh Fortress: Qal''eh Now and Qal''eh Qassab',
 'Qal''eh Now had a permanent twenty-five-man garrison to protect dam workers; Qal''eh Qassab was an old uninhabited ruin.',
 'Source-stated historical distances are preserved in claims without modern conversion.'),
('X0606','S0200','98–102',NULL,'Report on Sarakhs and Naseriyeh Fortress: agriculture and water supply',
 'Abdollah Khan describes fertile soil, grain and fodder production, water shortages, wells and annual dam work.',
 'Mix of direct observation, local testimony and administrative estimates.'),
('X0607','S0200','100–102',NULL,'Report on Sarakhs and Naseriyeh Fortress: closing fiscal and agricultural recommendations',
 'The report proposes local cultivation, reduced ration dependency and cash valuation tied to Mashhad grain prices.',
 'Author''s administrative recommendations.'),
('X0608','S0200','103–104',NULL,'Kitabche-ye Merv: purpose and source criticism',
 'Abdollah Khan says he investigated Turkmen conditions during nearly two years at Sarakhs and cautions that oral tribal histories are not fully reliable.',
 'Important source-critical statement by the author.'),
('X0609','S0200','106–108',NULL,'Kitabche-ye Merv: Salur relocation and conflict',
 'The account describes Salur cooperation with Iranian forces, relocation to Old Sarakhs, and later forced movement toward Merv.',
 'Historical narrative based substantially on Turkmen informants rather than eyewitness observation.'),
('X0610','S0200','106–108',NULL,'Kitabche-ye Merv: Teke force under Qushid Khan and Khajqa Sardar',
 'The source reports a force of about three thousand cavalry and infantry sent against the Salur under Khajqa Sardar.',
 'Source-stated approximate force size; preserve as attributed historical testimony.'),
('X0611','S0200','103–110',NULL,'Kitabche-ye Merv: Teke, Salur, Merv and Sarakhs historical geography',
 'The account connects Teke and Salur communities to Merv, Akhal, Tejen, Zurabad and Sarakhs and describes migration, irrigation and political pressure.',
 'Regional ethnographic/historical material with mixed evidence basis.'),
('X0612','S0200','1296 AH colophon',NULL,'Report colophon',
 'The Sarakhs report closes with a composition date of 1296 AH.',
 'Direct dating statement in the work.');

-- ---------------------------------------------------------------------------
-- Atomic claims: Abdollah Khan, mission, fortress, daily life, reform,
-- water/agriculture, and Kitabche-ye Merv historical testimony.
-- ---------------------------------------------------------------------------

INSERT OR IGNORE INTO claims(claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes) VALUES
('C0600','person','P0004','frontier_service','Abdollah Khan Amir Nezam served on a government frontier assignment at Sarakhs/Naseriyeh from approximately 1294 to 1296 AH.','confirmed','active','Mission chronology from the editor''s introduction and Kitabche-ye Merv opening.'),
('C0601','person','P0004','authorship','Abdollah Khan authored the Report on Sarakhs and Naseriyeh Fortress, completed or dated 1296 AH.','confirmed','active','Authorial attribution and report colophon.'),
('C0602','person','P0004','military_rank','During the Sarakhs mission Abdollah Khan is identified as a colonel (sarhang) of the Fadavi Regiment.','confirmed','active','Structured military-command linkage should be added only after exact current military-unit/organization IDs are reconciled.'),
('C0603','event','E0200','garrison_duty','At Naseriyeh soldiers performed night guard while also undertaking daytime duties involving water works, fuel collection, patrols and response to Turkmen incursions.','confirmed','active','Firsthand description of garrison burden.'),
('C0604','event','E0200','fuel_logistics','Fuel scarcity forced soldiers to leave the fortress several times each month to collect firewood, and weaker soldiers sometimes purchased it at high prices from Turkmen suppliers.','confirmed','active','Firsthand observation.'),
('C0605','event','E0200','frontier_hardship','Abdollah Khan judged service at Sarakhs to be harder on soldiers than service at Iran''s other frontiers because they were rarely free from duty.','confirmed','active','Explicit contemporary assessment by the author.'),
('C0606','person','P0004','administrative_reform','Abdollah Khan proposed replacing two hundred subsidized kharalchi households with twenty-seven useful cavalrymen as a more effective use of state resources.','confirmed','active','Author''s reform proposal; preserve as his judgment.'),
('C0607','person','P0004','agricultural_reform','Abdollah Khan proposed expanding local cultivation and reducing dependence on government grain rations, with produce valued against official Mashhad grain prices.','confirmed','active','Author''s administrative recommendation.'),
('C0608','place',(SELECT place_id FROM _sar_place_map WHERE place_key='naseriyeh'),'fortress_description','Abdollah Khan described Naseriyeh as a strongly built fortified settlement with houses, a bazaar and multiple defensive works.','confirmed','active','Avoid normalizing uncertain architectural headcounts and dimensions until visually rechecked.'),
('C0609','place',(SELECT place_id FROM _sar_place_map WHERE place_key='naseriyeh'),'garrison_structure','Naseriyeh functioned as both a rotating military garrison and a settlement containing permanently resident military households with wives and children.','confirmed','active','Exact roster numbers remain a separate research question.'),
('C0610','place',(SELECT place_id FROM _sar_place_map WHERE place_key='qaleh_now'),'outpost_garrison','Qal''eh Now was described as a small fort about one-quarter farsakh above Sarakhs with a permanent garrison of twenty-five soldiers.','confirmed','active','Source-stated historical distance retained without modern conversion.'),
('C0611','place',(SELECT place_id FROM _sar_place_map WHERE place_key='qaleh_now'),'waterworks_protection','Qal''eh Now protected workers maintaining the Sarakhs river dam and irrigation works, giving them a refuge in case of attack.','confirmed','active','Firsthand defensive-infrastructure description.'),
('C0612','place',(SELECT place_id FROM _sar_place_map WHERE place_key='qaleh_qassab'),'ruined_fort','Qal''eh Qassab was described as an old uninhabited ruin approximately one and one-half farsakhs above Sarakhs.','confirmed','active','Source-stated historical distance retained without modern conversion.'),
('C0613','place',(SELECT place_id FROM _sar_place_map WHERE place_key='qushid_fort'),'historical_association','The ruined Qushid Khan Fortress near Sarakhs was associated in Abdollah Khan''s account with the Teke leader Qushid Khan and an earlier Teke presence.','probable','active','Historical association reported in Kitabche-ye Merv/Sarakhs material.'),
('C0614','event','E0200','water_infrastructure','Sarakhs garrison operations depended on river-control infrastructure, and large numbers of soldiers could be required to rebuild or maintain diversion works when water was low.','confirmed','active','Firsthand observation; exact workforce figures should remain source-attributed.'),
('C0615','event','E0200','water_shortage','During Abdollah Khan''s two-year stay, Sarakhs experienced periods when river water failed to reach the settlement and residents relied on wells.','confirmed','active','Firsthand time-bounded observation.'),
('C0616','person','P0004','water_reform','Abdollah Khan recommended construction of one or more cisterns to provide a more reliable reserve when river water was interrupted.','confirmed','active','Author''s infrastructure recommendation.'),
('C0617','event','E0200','agricultural_observation','Abdollah Khan described Sarakhs soil as highly fertile, with abundant melons and watermelons, productive wheat and repeated alfalfa harvests.','confirmed','active','Combines his observation with local testimony; historical yield ratios are intentionally not normalized here.'),
('C0618','person','P0004','ethnographic_investigation','During his Sarakhs service Abdollah Khan deliberately investigated the conditions, customs, population and life of Turkmen communities around Merv and Sarakhs and compiled the Kitabche-ye Merv.','confirmed','active','Purpose statement at the beginning of Kitabche-ye Merv.'),
('C0619','person','P0004','source_criticism','Abdollah Khan explicitly cautioned that Turkmen tribal histories were transmitted orally and could not be regarded as fully reliable; he therefore questioned elders he considered comparatively trustworthy.','confirmed','active','Important statement about the evidence basis of the historical/tribal narrative.'),
('C0620','event','E0201','salur_state_support','The Kitabche-ye Merv reports that Salur groups supplied Iranian government forces with provisions and furnished about five hundred cavalry.','probable','active','Historical testimony from informants, not Abdollah Khan''s eyewitness observation.'),
('C0621','event','E0201','salur_relocation','The source reports that Salur households were relocated under Iranian government support to Old Sarakhs, while about five hundred households remained at Zurabad.','probable','active','Source-stated household count and relocation narrative.'),
('C0622','event','E0201','garrison_context','The Qara''i Regiment was garrisoning Naseriyeh Fortress during the Salur relocation episode described in Kitabche-ye Merv.','probable','active','Historical narrative; structured military-unit link deferred pending current unit-ID reconciliation.'),
('C0623','event','E0201','teke_attack','About six months after the Salur gathered at Sarakhs, the source says Qushid Khan sent approximately three thousand cavalry and infantry under Khajqa Sardar against them.','probable','active','Approximate force size and names are source-attributed historical testimony.'),
('C0624','event','E0201','forced_displacement','Khajqa Sardar''s force seized Salur livestock and compelled the Salur to leave Sarakhs for Merv, where they lived among the Teke.','probable','active','Historical narrative from Kitabche-ye Merv.'),
('C0625','event','E0201','complex_outcome','The same account says the displaced Salur families were protected during the journey and their livestock was restored, while also portraying their later condition among the Teke as subordinate and impoverished.','probable','active','Preserves the source''s internally complex portrayal rather than flattening it.'),
('C0626','event','E0202','campaign_captives','In Abdollah Khan''s transmitted historical account, Abbas Mirza''s Sarakhs campaign freed about three thousand Shiite captives and resulted in about five thousand Turkmen captives being taken toward Mashhad.','probable','active','These are source-reported figures from a non-eyewitness historical narrative and are not independently verified here.');

-- Fix accidental whitespace in predicate if the row above was inserted.
UPDATE claims SET predicate='teke_attack' WHERE claim_id='C0623';

-- ---------------------------------------------------------------------------
-- Claim-citation links
-- ---------------------------------------------------------------------------

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0600','X0600','supports'),
('C0600','X0608','supports'),
('C0601','X0600','supports'),
('C0601','X0612','supports'),
('C0602','X0600','supports'),
('C0603','X0602','supports'),
('C0604','X0602','supports'),
('C0605','X0602','supports'),
('C0606','X0603','supports'),
('C0607','X0607','supports'),
('C0608','X0601','supports'),
('C0609','X0602','supports'),
('C0610','X0605','supports'),
('C0611','X0605','supports'),
('C0612','X0605','supports'),
('C0613','X0611','supports'),
('C0614','X0606','supports'),
('C0615','X0606','supports'),
('C0616','X0606','supports'),
('C0617','X0606','supports'),
('C0618','X0608','supports'),
('C0619','X0608','supports'),
('C0620','X0609','supports'),
('C0621','X0609','supports'),
('C0622','X0609','supports'),
('C0623','X0610','supports'),
('C0624','X0609','supports'),
('C0625','X0609','supports'),
('C0626','X0611','supports');

-- High-value direct entity citations for Explorer provenance.
INSERT OR IGNORE INTO entity_citations(entity_citation_id,entity_type,entity_id,citation_id,support_type,notes)
SELECT 'EC0600','event','E0200','X0600','supports','Mission identity and chronology.'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE entity_citation_id='EC0600');

INSERT OR IGNORE INTO entity_citations(entity_citation_id,entity_type,entity_id,citation_id,support_type,notes)
SELECT 'EC0601','place',(SELECT place_id FROM _sar_place_map WHERE place_key='naseriyeh'),'X0601','supports','Fortress and defensive setting.'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE entity_citation_id='EC0601');

INSERT OR IGNORE INTO entity_citations(entity_citation_id,entity_type,entity_id,citation_id,support_type,notes)
SELECT 'EC0602','place',(SELECT place_id FROM _sar_place_map WHERE place_key='qaleh_now'),'X0605','supports','Outpost and waterworks protection.'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE entity_citation_id='EC0602');

INSERT OR IGNORE INTO entity_citations(entity_citation_id,entity_type,entity_id,citation_id,support_type,notes)
SELECT 'EC0603','place',(SELECT place_id FROM _sar_place_map WHERE place_key='qaleh_qassab'),'X0605','supports','Ruined upstream fort.'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE entity_citation_id='EC0603');

INSERT OR IGNORE INTO entity_citations(entity_citation_id,entity_type,entity_id,citation_id,support_type,notes)
SELECT 'EC0604','event','E0201','X0609','supports','Salur relocation/displacement narrative.'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE entity_citation_id='EC0604');

INSERT OR IGNORE INTO entity_citations(entity_citation_id,entity_type,entity_id,citation_id,support_type,notes)
SELECT 'EC0605','event','E0202','X0611','supports','Abbas Mirza Sarakhs campaign as transmitted in Kitabche-ye Merv.'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE entity_citation_id='EC0605');

-- ---------------------------------------------------------------------------
-- Open research questions: deliberately preserve unresolved numerical/identity
-- details instead of forcing them into canonical records.
-- ---------------------------------------------------------------------------

INSERT OR IGNORE INTO research_questions(question_id,question,status,priority,notes) VALUES
('Q0060','What is the exact numerical roster of the Naseriyeh Fortress garrison in Abdollah Khan''s Sarakhs report?','open','high','Visually verify the printed/manuscript roster before normalizing all troop-category headcounts.'),
('Q0061','Who exactly were Baba Khan and his son, associated with Arab cavalry at Sarakhs?','open','medium','The passage clearly treats Baba Khan as a person and describes him as an experienced servant; full identity and genealogy remain unresolved.'),
('Q0062','Which existing military-unit and organization IDs correspond to the Fadavi Regiment and Qara''i Regiment in the current archive?','open','high','Do not create duplicate military units. Reconcile existing records first, then add structured military_commands/event-unit associations.'),
('Q0063','What normalized transliterations should be adopted for Qushid Khan, Khajqa/Khaja Sardar and several Sarakhs-area fort names?','open','medium','Preserve source forms until cross-source normalization is complete.'),
('Q0064','Can the Mashhad-to-Sarakhs route and its stopping places be fully reconstructed from Abdollah Khan''s report?','open','medium','The report does contain staged route material (including Mazduran and nearby stops); extract it as a later geography/map pass rather than mixing uncertain route details into this checkpoint.'),
('Q0065','Can the historical Sarakhs forts and waterworks be mapped to secure modern coordinates?','open','medium','Do not infer modern coordinates from historical farsakh distances alone; use independent cartographic/geographic evidence.');

-- ---------------------------------------------------------------------------
-- Change log
-- ---------------------------------------------------------------------------

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-03T23:40:00Z','migration','0035','apply','Added Majmooe Asaar Sarakhs/Naseriyeh mission historical enrichment; canonical genealogy topology unchanged.');

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-03T23:40:00Z','event','E0200-E0202','insert','Added Sarakhs frontier mission and two source-transmitted historical Sarakhs episodes.');

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-03T23:40:00Z','claim','C0600-C0626','insert','Added cited mission, garrison, logistics, water, agriculture, reform, Turkmen and Salur claims from Majmooe Asaar.');

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-03T23:40:00Z','database','archive','release','Prepared v2.8.2 Sarakhs/Naseriyeh historical enrichment checkpoint.');

DROP TABLE _sar_place_map;
