-- Migration 0039
-- Abdollah Khan Amir Nezam: Mecca pilgrimage and international-travel enrichment
-- Baseline: v2.8.5 / migration 0038
--
-- Scope:
--   * Surviving Safarnameh-ye Makkah (Mecca travelogue), 1319 AH
--   * International travel network through Caucasus / Ottoman / Egypt / Red Sea
--   * Cholera crisis in Mecca
--   * Pilgrimage-administration criticism
--   * Meeting with the Sharif of Mecca
--   * References to earlier European journeys and missing Europe travelogue
--
-- Evidence policy:
--   * Abdollah Khan's direct diary observations are distinguished from his accusations,
--     estimates, and later editorial interpretations.
--   * The missing Europe travelogue is NOT treated as a source currently possessed.
--   * No canonical genealogy relationships are changed.
--   * No unidentified companions are forced into canonical person records.
--   * Transaction control is omitted because apply_migration.py owns the transaction.

UPDATE metadata SET value='2.8.6' WHERE key='database_version';
INSERT OR REPLACE INTO metadata(key,value) VALUES('last_migration','0039');
INSERT OR REPLACE INTO metadata(key,value) VALUES('updated_at','2026-08-04T01:45:00Z');
INSERT OR REPLACE INTO metadata(key,value) VALUES(
    'historical_enrichment_checkpoint',
    'Abdollah Khan Mecca pilgrimage and international travel'
);

INSERT INTO sources(source_id,short_title,full_title,author,publication_year,source_type,file_name,notes)
SELECT 'S0200','Majmooe Asaar','مجموعه آثار حاجی عبدالله خان قراگوزلو امیر نظام همدانی',
       'Haji Abdollah Khan Gharagozloo; edited by Enayatollah Majidi',NULL,
       'edited primary-source collection','Majmooe Asaar - PDF.pdf',
       'Collection containing Abdollah Khan''s Mecca travelogue and editor''s notes identifying a referenced but not reproduced Europe travelogue.'
WHERE NOT EXISTS (SELECT 1 FROM sources WHERE source_id='S0200');

-- ---------------------------------------------------------------------------
-- Explorer/publication roll-up
-- ---------------------------------------------------------------------------
UPDATE persons
SET summary='Haji Abdollah Khan Gharagozloo (Sa''ed al-Saltaneh, later Sardar Akram and Amir Nezam) was a senior Qajar military commander, provincial administrator, landholder, author, minister, Majles deputy, and international traveler. In addition to his reports on Sarakhs and Khuzestan, his surviving Mecca travelogue from 1319 AH records a journey through the Caucasus, Ottoman and Egyptian transport networks to Jeddah and Mecca, detailed observations of pilgrimage administration, a severe cholera outbreak, and a meeting with the Sharif of Mecca. His writings also refer to earlier European travel, including Rome, Paris, St. Petersburg and Moscow, although the separate Europe travelogue itself has not yet been located. He died in Hamadan on 23 Sha''ban 1334 AH (1916 CE).',
    updated_at='2026-08-04T01:45:00Z'
WHERE person_id='P0004';

UPDATE person_dossiers
SET file_path='docs/dossiers/P0004_ABDOLLAH_KHAN_AMIR_NEZAM.md',
    status='multi_source_historical_enrichment_v2.8.6',
    evidence_policy='Curated narrative derives from cited archive claims/events. First-person observations, accusations, estimates, editor interpretations, and missing-source references remain explicitly distinguished.',
    generated_from_migration='0039',
    updated_at='2026-08-04T01:45:00Z'
WHERE person_id='P0004';

-- ---------------------------------------------------------------------------
-- Places
-- ---------------------------------------------------------------------------
CREATE TEMP TABLE _pil_place_map(place_key TEXT PRIMARY KEY, place_id TEXT NOT NULL);

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0250','Mecca','مکه','city',NULL,'Principal destination of Abdollah Khan''s 1319 AH pilgrimage travelogue.'
WHERE NOT EXISTS (SELECT 1 FROM places WHERE lower(preferred_name_en)='mecca' OR preferred_name_fa='مکه');
INSERT INTO _pil_place_map SELECT 'mecca',place_id FROM places
WHERE lower(preferred_name_en)='mecca' OR preferred_name_fa='مکه'
ORDER BY CASE WHEN place_id='L0250' THEN 0 ELSE 1 END, place_id LIMIT 1;

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0251','Jeddah','جده','port city',NULL,'Red Sea port used by Abdollah Khan on the Mecca pilgrimage route.'
WHERE NOT EXISTS (SELECT 1 FROM places WHERE lower(preferred_name_en)='jeddah' OR preferred_name_fa='جده');
INSERT INTO _pil_place_map SELECT 'jeddah',place_id FROM places
WHERE lower(preferred_name_en)='jeddah' OR preferred_name_fa='جده'
ORDER BY CASE WHEN place_id='L0251' THEN 0 ELSE 1 END, place_id LIMIT 1;

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0252','Istanbul','استانبول','city',NULL,'Major Ottoman hub on Abdollah Khan''s international pilgrimage route.'
WHERE NOT EXISTS (SELECT 1 FROM places WHERE lower(preferred_name_en)='istanbul' OR preferred_name_fa='استانبول');
INSERT INTO _pil_place_map SELECT 'istanbul',place_id FROM places
WHERE lower(preferred_name_en)='istanbul' OR preferred_name_fa='استانبول'
ORDER BY CASE WHEN place_id='L0252' THEN 0 ELSE 1 END, place_id LIMIT 1;

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0253','Alexandria','اسکندریه','port city',NULL,'Mediterranean port on the through-ticket route from Istanbul toward Jeddah.'
WHERE NOT EXISTS (SELECT 1 FROM places WHERE lower(preferred_name_en)='alexandria' OR preferred_name_fa='اسکندریه');
INSERT INTO _pil_place_map SELECT 'alexandria',place_id FROM places
WHERE lower(preferred_name_en)='alexandria' OR preferred_name_fa='اسکندریه'
ORDER BY CASE WHEN place_id='L0253' THEN 0 ELSE 1 END, place_id LIMIT 1;

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0254','Suez','سوئز','port city',NULL,'Egyptian port and railway terminus on Abdollah Khan''s route to Jeddah.'
WHERE NOT EXISTS (SELECT 1 FROM places WHERE lower(preferred_name_en)='suez' OR preferred_name_fa='سوئز');
INSERT INTO _pil_place_map SELECT 'suez',place_id FROM places
WHERE lower(preferred_name_en)='suez' OR preferred_name_fa='سوئز'
ORDER BY CASE WHEN place_id='L0254' THEN 0 ELSE 1 END, place_id LIMIT 1;

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0255','Ismailia','اسماعیلیه','city/rail stage',NULL,'Railway stage noted by Abdollah Khan between Alexandria/Egypt and Suez.'
WHERE NOT EXISTS (SELECT 1 FROM places WHERE lower(preferred_name_en)='ismailia' OR preferred_name_fa='اسماعیلیه');
INSERT INTO _pil_place_map SELECT 'ismailia',place_id FROM places
WHERE lower(preferred_name_en)='ismailia' OR preferred_name_fa='اسماعیلیه'
ORDER BY CASE WHEN place_id='L0255' THEN 0 ELSE 1 END, place_id LIMIT 1;

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0256','Baku','باکو','city/transport hub',NULL,'Caucasus transport hub in Abdollah Khan''s discussion of routes toward Istanbul.'
WHERE NOT EXISTS (SELECT 1 FROM places WHERE lower(preferred_name_en)='baku' OR preferred_name_fa='باکو');
INSERT INTO _pil_place_map SELECT 'baku',place_id FROM places
WHERE lower(preferred_name_en)='baku' OR preferred_name_fa='باکو'
ORDER BY CASE WHEN place_id='L0256' THEN 0 ELSE 1 END, place_id LIMIT 1;

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0257','Tiflis (Tbilisi)','تفلیس','city/transport hub',NULL,'Caucasus rail route option discussed by Abdollah Khan.'
WHERE NOT EXISTS (SELECT 1 FROM places WHERE lower(preferred_name_en) IN ('tiflis','tiflis (tbilisi)','tbilisi') OR preferred_name_fa='تفلیس');
INSERT INTO _pil_place_map SELECT 'tiflis',place_id FROM places
WHERE lower(preferred_name_en) IN ('tiflis','tiflis (tbilisi)','tbilisi') OR preferred_name_fa='تفلیس'
ORDER BY CASE WHEN place_id='L0257' THEN 0 ELSE 1 END, place_id LIMIT 1;

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0258','Batum (Batumi)','باطوم','port city/transport hub',NULL,'Black Sea route option discussed by Abdollah Khan.'
WHERE NOT EXISTS (SELECT 1 FROM places WHERE lower(preferred_name_en) IN ('batum','batum (batumi)','batumi') OR preferred_name_fa='باطوم');
INSERT INTO _pil_place_map SELECT 'batum',place_id FROM places
WHERE lower(preferred_name_en) IN ('batum','batum (batumi)','batumi') OR preferred_name_fa='باطوم'
ORDER BY CASE WHEN place_id='L0258' THEN 0 ELSE 1 END, place_id LIMIT 1;

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0259','Sevastopol','سواستوپل','port city',NULL,'Northern Black Sea route option discussed by Abdollah Khan.'
WHERE NOT EXISTS (SELECT 1 FROM places WHERE lower(preferred_name_en)='sevastopol' OR preferred_name_fa='سواستوپل');
INSERT INTO _pil_place_map SELECT 'sevastopol',place_id FROM places
WHERE lower(preferred_name_en)='sevastopol' OR preferred_name_fa='سواستوپل'
ORDER BY CASE WHEN place_id='L0259' THEN 0 ELSE 1 END, place_id LIMIT 1;

-- ---------------------------------------------------------------------------
-- Events
-- ---------------------------------------------------------------------------
INSERT INTO events(event_id,event_type,title,date_text,place_id,description,verification_status)
SELECT 'E0260','pilgrimage',
       'Abdollah Khan Amir Nezam''s Mecca pilgrimage',
       '1319 AH',
       (SELECT place_id FROM _pil_place_map WHERE place_key='mecca'),
       'International pilgrimage journey documented in Abdollah Khan''s surviving Safarnameh-ye Makkah, including transport, urban, administrative, religious, and public-health observations.',
       'confirmed'
WHERE NOT EXISTS (SELECT 1 FROM events WHERE event_id='E0260');
INSERT OR IGNORE INTO event_persons(event_id,person_id,role)
VALUES('E0260','P0004','pilgrim, traveler and diarist');

INSERT INTO events(event_id,event_type,title,date_text,place_id,description,verification_status)
SELECT 'E0261','public_health_crisis',
       'Cholera crisis during Abdollah Khan''s pilgrimage in Mecca',
       'Dhu al-Hijjah 1319 AH',
       (SELECT place_id FROM _pil_place_map WHERE place_key='mecca'),
       'A serious cholera outbreak affected pilgrims, altered onward travel plans, and forms a major closing episode of Abdollah Khan''s Mecca diary.',
       'confirmed'
WHERE NOT EXISTS (SELECT 1 FROM events WHERE event_id='E0261');
INSERT OR IGNORE INTO event_persons(event_id,person_id,role)
VALUES('E0261','P0004','eyewitness diarist');

INSERT INTO events(event_id,event_type,title,date_text,place_id,description,verification_status)
SELECT 'E0262','bereavement',
       'Death of Abdollah Khan''s wife during the Mecca pilgrimage',
       '15 Dhu al-Hijjah 1319 AH',
       (SELECT place_id FROM _pil_place_map WHERE place_key='mecca'),
       'The editor''s notes report that Abdollah Khan''s wife, already suffering from heart palpitations and worsened by the cholera illness and severe heat, died after completing the pilgrimage rites as far as possible.',
       'confirmed'
WHERE NOT EXISTS (SELECT 1 FROM events WHERE event_id='E0262');
INSERT OR IGNORE INTO event_persons(event_id,person_id,role)
VALUES('E0262','P0004','bereaved husband');

INSERT INTO events(event_id,event_type,title,date_text,place_id,description,verification_status)
SELECT 'E0263','diplomatic_social_encounter',
       'Meeting with the Sharif of Mecca',
       '17 Dhu al-Hijjah 1319 AH',
       (SELECT place_id FROM _pil_place_map WHERE place_key='mecca'),
       'Abdollah Khan visited the Sharif of Mecca, refused the customary hand-kissing gesture described to him by the Iranian consul, and raised concerns about pilgrims and administration.',
       'confirmed'
WHERE NOT EXISTS (SELECT 1 FROM events WHERE event_id='E0263');
INSERT OR IGNORE INTO event_persons(event_id,person_id,role)
VALUES('E0263','P0004','Iranian notable and pilgrim visitor');

INSERT INTO events(event_id,event_type,title,date_text,place_id,description,verification_status)
SELECT 'E0264','travel',
       'International transport route toward the Hijaz',
       '1319 AH',
       (SELECT place_id FROM _pil_place_map WHERE place_key='istanbul'),
       'Abdollah Khan compared Caucasus and Black Sea routes to Istanbul and then used an integrated ship-and-rail route through Alexandria and Suez toward Jeddah.',
       'confirmed'
WHERE NOT EXISTS (SELECT 1 FROM events WHERE event_id='E0264');
INSERT OR IGNORE INTO event_persons(event_id,person_id,role)
VALUES('E0264','P0004','traveler and route observer');

-- ---------------------------------------------------------------------------
-- Citations
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO citations(citation_id,source_id,page_printed,page_file,locator_text,quoted_text,notes) VALUES
('X0900','S0200','205–332',NULL,'Safarnameh-ye Makkah: overall work and 1319 AH pilgrimage',
 'Abdollah Khan''s Mecca travelogue records the international route, pilgrimage, administration, illness, and observations of cities and transport.',
 'Primary first-person travelogue; broad work-level citation.'),
('X0901','S0200',NULL,NULL,'Safarnameh-ye Makkah: Baku / Tiflis / Batum / Sevastopol route comparison',
 'Abdollah Khan compares rail and sea routes from Baku toward Istanbul, including travel time, cost and ticketing.',
 'First-person travel-route discussion.'),
('X0902','S0200',NULL,NULL,'Safarnameh-ye Makkah: Istanbul to Jeddah through-ticket',
 'The diary describes a through-ticket from Istanbul to Jeddah using ship travel to Alexandria, railway transport toward Suez, and another ship to Jeddah.',
 'First-person transport observation.'),
('X0903','S0200',NULL,NULL,'Safarnameh-ye Makkah: Alexandria–Suez railway',
 'The diary records railway staging and distance information between Alexandria/Egypt and Suez, including Ismailia.',
 'Historical transport data retained as source-stated.'),
('X0904','S0200',NULL,NULL,'Safarnameh-ye Makkah: arrival at Jeddah, 27 Dhu al-Qa''dah 1319 AH',
 'Abdollah Khan describes the dangerous rocky harbor approach and a local pilot boarding the ship to guide it into Jeddah.',
 'First-person maritime observation.'),
('X0905','S0200',NULL,NULL,'Safarnameh-ye Makkah: Iranian consular fees and pilgrim grievances',
 'Abdollah Khan alleges repeated passport, transport and other fee extraction from Iranian pilgrims and criticizes the Jeddah consular operation.',
 'Authorial accusation and reform judgment; not independently verified by this migration.'),
('X0906','S0200',NULL,NULL,'Safarnameh-ye Makkah: Mecca urban observations',
 'Abdollah Khan estimates Mecca''s population, describes multi-story stone-and-plaster houses and comments critically on street sanitation.',
 'First-person urban observation; numerical estimates remain source-attributed.'),
('X0907','S0200',NULL,NULL,'Safarnameh-ye Makkah: cholera and route decision, 13–15 Dhu al-Hijjah 1319 AH',
 'The diary records worsening cholera, reconsideration of the Medina route, use of estekhareh, numerous deaths, and delayed departure for lack of transport animals.',
 'First-person public-health and travel-decision account.'),
('X0908','S0200',NULL,NULL,'Editor notes: death of Abdollah Khan''s wife, 15 Dhu al-Hijjah 1319 AH',
 'The editor explains that Abdollah Khan''s wife became critically ill during the pilgrimage and died on 15 Dhu al-Hijjah 1319 AH after the rites.',
 'Editor commentary based on the travelogue context.'),
('X0909','S0200',NULL,NULL,'Safarnameh-ye Makkah: 17 Dhu al-Hijjah meeting with the Sharif of Mecca',
 'Abdollah Khan describes visiting the Sharif, refusing the customary hand-kissing gesture, and discussing pilgrim concerns.',
 'First-person social and political encounter.'),
('X0910','S0200',NULL,NULL,'Safarnameh-ye Makkah: final sacred-site visits and surviving end of diary',
 'The closing entries include visits to the cemetery associated with Abu Talib and other sacred figures before the surviving diary ends.',
 'Closing portion of the surviving travelogue.'),
('X0911','S0200',NULL,NULL,'Editor introduction: referenced but missing Europe travelogue',
 'The editor states that Abdollah Khan refers in the Mecca travelogue to a separate European travelogue that was not among the eight works located for this volume.',
 'Important source-preservation note; the Europe travelogue itself is not treated as available evidence.'),
('X0912','S0200',NULL,NULL,'Surviving writings: retrospective references to European travel',
 'The surviving writings/editorial synthesis refer to Abdollah Khan having visited European cities including Rome, Paris, St. Petersburg and Moscow and to meeting the King of Italy.',
 'Retrospective references, not a substitute for the missing Europe diary.');

-- ---------------------------------------------------------------------------
-- Claims
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO claims(claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes) VALUES
('C0900','person','P0004','mecca_pilgrimage','Abdollah Khan undertook a Mecca pilgrimage in 1319 AH and left a surviving first-person travelogue of the journey.','confirmed','active','Primary-source authorship and travel event.'),
('C0901','event','E0264','route_comparison','Abdollah Khan compared alternative routes from Baku toward Istanbul via Tiflis/Batum and northern Black Sea connections, weighing time, price and comfort.','confirmed','active','First-person transport analysis.'),
('C0902','event','E0264','through_ticket_route','The diary describes an integrated Istanbul-to-Jeddah ticket using ship travel to Alexandria, rail transport through Egypt toward Suez, and ship travel from Suez to Jeddah.','confirmed','active','Historical transport network.'),
('C0903','event','E0264','egypt_rail_observation','Abdollah Khan recorded railway distance, stages and class-based fares on the Alexandria/Egypt–Suez corridor, including Ismailia.','confirmed','active','Source-stated transport data.'),
('C0904','place',(SELECT place_id FROM _pil_place_map WHERE place_key='jeddah'),'harbor_pilotage','On approaching Jeddah the diary describes dangerous rocky waters and a local pilot boarding the vessel to guide it safely into anchorage.','confirmed','active','First-person maritime observation.'),
('C0905','person','P0004','pilgrim_fee_accusation','Abdollah Khan accused the Iranian consular establishment associated with Jeddah of repeated fee extraction from Iranian pilgrims through passport, transport and related charges.','confirmed','active','Confirmed as an accusation made by the author; the underlying misconduct is not independently adjudicated here.'),
('C0906','person','P0004','deceased_pilgrim_property_accusation','Abdollah Khan alleged that belongings of Iranian pilgrims who died could be taken into consular control in ways he regarded as abusive.','confirmed','active','Authorial accusation, not independent finding of misconduct.'),
('C0907','person','P0004','consular_reform_recommendation','Abdollah Khan argued that Iranian pilgrims might be better served without the existing Jeddah consular arrangement and favored more direct dealings with the Sharif of Mecca.','confirmed','active','Authorial administrative recommendation.'),
('C0908','place',(SELECT place_id FROM _pil_place_map WHERE place_key='mecca'),'population_estimate','Abdollah Khan estimated Mecca''s population at approximately eighty thousand.','confirmed','active','Source-stated contemporary estimate.'),
('C0909','place',(SELECT place_id FROM _pil_place_map WHERE place_key='mecca'),'urban_architecture','Abdollah Khan described many Meccan houses as multi-story stone-and-plaster buildings and compared aspects of their form with buildings he had seen elsewhere.','confirmed','active','First-person urban observation.'),
('C0910','place',(SELECT place_id FROM _pil_place_map WHERE place_key='mecca'),'sanitation_observation','Abdollah Khan strongly criticized street sanitation in Mecca and reported raising the issue with the Sharif.','confirmed','active','First-person urban criticism.'),
('C0911','event','E0261','cholera_outbreak','A severe cholera outbreak in Mecca during Dhu al-Hijjah 1319 AH altered the plans of many pilgrims and Abdollah Khan''s own onward travel decisions.','confirmed','active','First-person diary account.'),
('C0912','person','P0004','estekhareh_travel_decision','Abdollah Khan records using estekhareh when deciding whether to continue toward Medina during the cholera outbreak.','confirmed','active','Direct self-report; this independently demonstrates personal use of estekhareh in travel decisions.'),
('C0913','event','E0261','bodies_seen','On 14 Dhu al-Hijjah 1319 AH Abdollah Khan reported seeing roughly fifty dead people along the road as cholera worsened.','confirmed','active','Source-stated eyewitness estimate.'),
('C0914','event','E0261','departure_delayed','On 15 Dhu al-Hijjah Abdollah Khan''s planned departure was delayed because transport animals could not be obtained.','confirmed','active','First-person diary entry.'),
('C0915','event','E0262','wife_death','Abdollah Khan''s wife died in Mecca on 15 Dhu al-Hijjah 1319 AH after severe illness during the pilgrimage.','confirmed','active','Editor notes indicate pre-existing heart palpitations and worsening illness amid cholera and heat; her personal identity remains unresolved.'),
('C0916','person','P0004','devotional_acts_for_others','During the final days in Mecca Abdollah Khan records performing devotional acts on behalf of the Shah, Atabak-e A''zam, Sepahsalar, his father, his mother and the late Haji Mohammad Khan.','confirmed','active','First-person diary; preserve as religious/personal practice.'),
('C0917','event','E0263','refused_hand_kissing','Before meeting the Sharif of Mecca Abdollah Khan was told that custom required kissing the Sharif''s hand; he explicitly refused and entered without doing so.','confirmed','active','First-person account of his own conduct.'),
('C0918','event','E0263','raised_pilgrim_concerns','During the meeting with the Sharif, Abdollah Khan raised concerns about pilgrim treatment and expressed appreciation for comparatively favorable treatment of Shi''i pilgrims.','confirmed','active','First-person encounter.'),
('C0919','person','P0004','sacred_site_visits','The closing diary entries record visits to the cemetery associated with Abu Talib and sites connected with Amina, Khadija, Abd al-Muttalib and Abd Manaf.','confirmed','active','Religious travel observation.'),
('C0920','person','P0004','surviving_diary_endpoint','The surviving Mecca travelogue does not provide a complete return-home itinerary after the final Mecca entries.','confirmed','active','Archive-level source-boundary statement.'),
('C0921','person','P0004','europe_travel_reference','Abdollah Khan''s surviving writings refer retrospectively to earlier European travel, including Rome, Paris, St. Petersburg and Moscow.','confirmed','active','Retrospective reference only; no full Europe diary is currently present in the source collection.'),
('C0922','person','P0004','king_of_italy_reference','The surviving writings/editorial synthesis report that Abdollah Khan referred to having met the King of Italy.','probable','active','Preserve as retrospective self-reference/editorial synthesis until the original Europe diary is located.'),
('C0923','person','P0004','missing_europe_travelogue','The editor states that Abdollah Khan referred to a separate European travelogue, but that work was not among the eight writings located and published in Majmooe Asaar.','confirmed','active','Source-preservation fact; do not treat the missing travelogue as directly available evidence.'),
('C0924','person','P0004','international_observational_style','The Mecca travelogue shows Abdollah Khan repeatedly comparing transport systems, prices, urban form, administration and public services across multiple countries and cities.','probable','active','Archive synthesis based on multiple direct observations; not a quotation.');

-- ---------------------------------------------------------------------------
-- Claim-citation links
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0900','X0900','supports'),
('C0901','X0901','supports'),
('C0902','X0902','supports'),
('C0903','X0903','supports'),
('C0904','X0904','supports'),
('C0905','X0905','supports'),
('C0906','X0905','supports'),
('C0907','X0905','supports'),
('C0908','X0906','supports'),
('C0909','X0906','supports'),
('C0910','X0906','supports'),
('C0911','X0907','supports'),
('C0912','X0907','supports'),
('C0913','X0907','supports'),
('C0914','X0907','supports'),
('C0915','X0908','supports'),
('C0916','X0907','supports'),
('C0917','X0909','supports'),
('C0918','X0909','supports'),
('C0919','X0910','supports'),
('C0920','X0910','supports'),
('C0921','X0912','supports'),
('C0922','X0912','supports'),
('C0923','X0911','supports'),
('C0924','X0901','supports'),
('C0924','X0903','supports'),
('C0924','X0906','supports');

-- ---------------------------------------------------------------------------
-- Direct event provenance
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO entity_citations(entity_citation_id,entity_type,entity_id,citation_id,support_type,notes) VALUES
('EC0900','event','E0260','X0900','supports','Overall Mecca pilgrimage and surviving diary.'),
('EC0901','event','E0261','X0907','supports','Cholera crisis and travel decisions.'),
('EC0902','event','E0262','X0908','supports','Death of Abdollah Khan''s wife during pilgrimage.'),
('EC0903','event','E0263','X0909','supports','Meeting with the Sharif of Mecca.'),
('EC0904','event','E0264','X0902','supports','International transport route toward Jeddah.');

-- ---------------------------------------------------------------------------
-- Research questions
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO research_questions(question_id,question,status,priority,notes) VALUES
('Q0090','Can Abdollah Khan Amir Nezam''s missing Safarnameh-ye Europa (Europe travelogue) be located in a public archive, manuscript library, private collection or family papers?','open','high','The editor explicitly says Abdollah refers to this separate work in the Mecca travelogue, but it was not among the eight works located for Majmooe Asaar.'),
('Q0091','Who was Abdollah Khan''s wife who died in Mecca on 15 Dhu al-Hijjah 1319 AH?','open','high','The source clearly records her death but does not establish her identity in the currently extracted passage. Do not create a canonical person without independent identification.'),
('Q0092','Can the exact ship names, railway services, ticket classes and travel dates for the 1319 AH pilgrimage route be reconstructed page-by-page from the travelogue?','open','medium','Useful for future map/animation work; preserve source spellings and dates.'),
('Q0093','Can the Sharif of Mecca encountered by Abdollah Khan be securely identified from the diary/editor notes and external chronology?','open','medium','The editor appears to identify the Sharif of 1319 AH; verify before creating a canonical person record.'),
('Q0094','Can Abdollah Khan''s references to Rome, Paris, St. Petersburg, Moscow and the King of Italy be dated and tied to a specific first or second European journey?','open','high','Current evidence is retrospective and incomplete without the missing Europe diary.'),
('Q0095','How do Abdollah Khan''s accusations against the Iranian Jeddah consular establishment compare with Iranian diplomatic records and other pilgrim accounts from 1319 AH?','open','medium','Independent comparison is needed before evaluating the underlying misconduct claims.');

-- ---------------------------------------------------------------------------
-- Change log
-- ---------------------------------------------------------------------------
INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-04T01:45:00Z','migration','0039','apply','Added Abdollah Khan Mecca pilgrimage and international-travel enrichment; canonical genealogy unchanged.');

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-04T01:45:00Z','person','P0004','update','Expanded Explorer summary and dossier to include the 1319 AH Mecca travelogue and referenced European journeys.');

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-04T01:45:00Z','event','E0260-E0264','insert','Added pilgrimage, cholera, bereavement, Sharif meeting and international-route events.');

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-04T01:45:00Z','database','archive','release','Prepared v2.8.6 Pilgrimage and International Travel enrichment checkpoint.');

DROP TABLE _pil_place_map;
