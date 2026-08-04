-- Migration 0041
-- Majmooe Asaar: Kalat Naderi Frontier enrichment
-- Baseline: v2.8.7 / migration 0040
--
-- Scope:
--   * Three distinct Kalat Naderi reports preserved in Majmooe Asaar
--   * Report 1: resources, livestock, pasture, fuel, local economy, broad defense logic
--   * Report 2: 1302 AH strategic defense survey, force structure, artillery, cavalry reform
--   * Report 3: repair/engineering inspection, gates, approaches, towers, logistics, costs
--
-- IMPORTANT:
--   * The three Kalat reports remain distinct source layers.
--   * Report 2 date = 1302 AH confirmed.
--   * Report 3 date is NOT normalized without firmer source evidence.
--   * 75 vs 79 pedestrian approaches are preserved as probable progressive survey refinement.
--   * No canonical genealogy relationships are changed.
--   * No uncertain local identities are forced into canonical person records.
--   * Transaction control is intentionally omitted because apply_migration.py owns it.

UPDATE metadata SET value='2.8.8' WHERE key='database_version';
INSERT OR REPLACE INTO metadata(key,value) VALUES('last_migration','0041');
INSERT OR REPLACE INTO metadata(key,value) VALUES('updated_at','2026-08-04T02:40:00Z');
INSERT OR REPLACE INTO metadata(key,value) VALUES(
    'historical_enrichment_checkpoint',
    'Majmooe Asaar Kalat Naderi Frontier'
);

INSERT INTO sources(source_id,short_title,full_title,author,publication_year,source_type,file_name,notes)
SELECT 'S0200','Majmooe Asaar','مجموعه آثار حاجی عبدالله خان قراگوزلو امیر نظام همدانی',
       'Haji Abdollah Khan Gharagozloo; edited by Enayatollah Majidi',NULL,
       'edited primary-source collection','Majmooe Asaar - PDF.pdf',
       'Collection containing three distinct Kalat Naderi reports by Abdollah Khan, including a 1302 AH strategic report and a separate repair-inspection booklet.'
WHERE NOT EXISTS (SELECT 1 FROM sources WHERE source_id='S0200');

-- ---------------------------------------------------------------------------
-- Places
-- ---------------------------------------------------------------------------
CREATE TEMP TABLE _kal_place_map(place_key TEXT PRIMARY KEY, place_id TEXT NOT NULL);

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0290','Kalat Naderi','کلات نادری','fortified region',NULL,
       'Mountain fortress region surveyed by Abdollah Khan in three distinct reports.'
WHERE NOT EXISTS (SELECT 1 FROM places WHERE lower(preferred_name_en) IN ('kalat naderi','kalat') OR preferred_name_fa='کلات نادری');
INSERT INTO _kal_place_map SELECT 'kalat',place_id FROM places
WHERE lower(preferred_name_en) IN ('kalat naderi','kalat') OR preferred_name_fa='کلات نادری'
ORDER BY CASE WHEN place_id='L0290' THEN 0 ELSE 1 END, place_id LIMIT 1;

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0291','Darband-e Arghavan Shah','دربند ارغوان شاه','mountain pass/gate',(SELECT place_id FROM _kal_place_map WHERE place_key='kalat'),
       'One of the five principal Kalat entrances; surviving/partly usable defensive works described.'
WHERE NOT EXISTS (SELECT 1 FROM places WHERE lower(preferred_name_en)='darband-e arghavan shah');
INSERT INTO _kal_place_map SELECT 'arghavan',place_id FROM places
WHERE lower(preferred_name_en)='darband-e arghavan shah'
ORDER BY CASE WHEN place_id='L0291' THEN 0 ELSE 1 END, place_id LIMIT 1;

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0292','Darband-e Kashtani','دربند کشتانی','mountain pass/gate',(SELECT place_id FROM _kal_place_map WHERE place_key='kalat'),
       'One of the five principal Kalat entrances.'
WHERE NOT EXISTS (SELECT 1 FROM places WHERE lower(preferred_name_en)='darband-e kashtani');
INSERT INTO _kal_place_map SELECT 'kashtani',place_id FROM places
WHERE lower(preferred_name_en)='darband-e kashtani'
ORDER BY CASE WHEN place_id='L0292' THEN 0 ELSE 1 END, place_id LIMIT 1;

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0293','Darband-e Chub Mast','دربند چوب مست','mountain pass/gate',(SELECT place_id FROM _kal_place_map WHERE place_key='kalat'),
       'One of the five principal Kalat entrances.'
WHERE NOT EXISTS (SELECT 1 FROM places WHERE lower(preferred_name_en)='darband-e chub mast');
INSERT INTO _kal_place_map SELECT 'chub_mast',place_id FROM places
WHERE lower(preferred_name_en)='darband-e chub mast'
ORDER BY CASE WHEN place_id='L0293' THEN 0 ELSE 1 END, place_id LIMIT 1;

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0294','Darband-e Nafta','دربند نفتا','mountain pass/gate',(SELECT place_id FROM _kal_place_map WHERE place_key='kalat'),
       'One of the five principal Kalat entrances; artillery and defensive works described.'
WHERE NOT EXISTS (SELECT 1 FROM places WHERE lower(preferred_name_en)='darband-e nafta');
INSERT INTO _kal_place_map SELECT 'nafta',place_id FROM places
WHERE lower(preferred_name_en)='darband-e nafta'
ORDER BY CASE WHEN place_id='L0294' THEN 0 ELSE 1 END, place_id LIMIT 1;

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0295','Darband-e Dehcheh','دربند دهچه','mountain pass/gate',(SELECT place_id FROM _kal_place_map WHERE place_key='kalat'),
       'One of the five principal Kalat entrances.'
WHERE NOT EXISTS (SELECT 1 FROM places WHERE lower(preferred_name_en)='darband-e dehcheh');
INSERT INTO _kal_place_map SELECT 'dehcheh',place_id FROM places
WHERE lower(preferred_name_en)='darband-e dehcheh'
ORDER BY CASE WHEN place_id='L0295' THEN 0 ELSE 1 END, place_id LIMIT 1;

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0296','Kobud Gonbad','کبود گنبد','settlement/position',(SELECT place_id FROM _kal_place_map WHERE place_key='kalat'),
       'Kalat position where two artillery pieces were reported lying without carriages.'
WHERE NOT EXISTS (SELECT 1 FROM places WHERE lower(preferred_name_en)='kobud gonbad' OR preferred_name_fa='کبود گنبد');
INSERT INTO _kal_place_map SELECT 'kobud_gonbad',place_id FROM places
WHERE lower(preferred_name_en)='kobud gonbad' OR preferred_name_fa='کبود گنبد'
ORDER BY CASE WHEN place_id='L0296' THEN 0 ELSE 1 END, place_id LIMIT 1;

-- ---------------------------------------------------------------------------
-- Events / source-work boundaries
-- ---------------------------------------------------------------------------
INSERT INTO events(event_id,event_type,title,date_text,place_id,description,verification_status)
SELECT 'E0300','historical_report',
       'Kalat Naderi Report 1 — resources and strategic economy',
       'date not normalized',
       (SELECT place_id FROM _kal_place_map WHERE place_key='kalat'),
       'First Kalat report describing livestock, pasture, fuel, agricultural resources, local economic potential and broad artillery/defense logic.',
       'confirmed'
WHERE NOT EXISTS (SELECT 1 FROM events WHERE event_id='E0300');
INSERT OR IGNORE INTO event_persons(event_id,person_id,role)
VALUES('E0300','P0004','author and inspector');

INSERT INTO events(event_id,event_type,title,date_text,place_id,description,verification_status)
SELECT 'E0301','historical_report',
       'Kalat Naderi Report 2 — strategic defense survey',
       '1302 AH',
       (SELECT place_id FROM _kal_place_map WHERE place_key='kalat'),
       'Second Kalat report, explicitly dated 1302 AH, covering self-sufficiency, principal entrances, pedestrian routes, manpower, cavalry reform and artillery placement.',
       'confirmed'
WHERE NOT EXISTS (SELECT 1 FROM events WHERE event_id='E0301');
INSERT OR IGNORE INTO event_persons(event_id,person_id,role)
VALUES('E0301','P0004','frontier officer, author and strategic surveyor');

INSERT INTO events(event_id,event_type,title,date_text,place_id,description,verification_status)
SELECT 'E0302','engineering_inspection',
       'Kalat repair inspection and engineering survey',
       'date not normalized',
       (SELECT place_id FROM _kal_place_map WHERE place_key='kalat'),
       'Third Kalat report: detailed inspection of the five principal passes, 79 pedestrian approaches, bridges, guardhouses, towers, troop accommodation, repair logistics and budgets.',
       'confirmed'
WHERE NOT EXISTS (SELECT 1 FROM events WHERE event_id='E0302');
INSERT OR IGNORE INTO event_persons(event_id,person_id,role)
VALUES('E0302','P0004','inspector and repair planner');

-- ---------------------------------------------------------------------------
-- Citations
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO citations(citation_id,source_id,page_printed,page_file,locator_text,quoted_text,notes) VALUES
('X1100','S0200',NULL,NULL,'Kalat Report 1: livestock, pasture and carrying capacity',
 'Abdollah Khan estimates internal livestock capacity, actual sheep holdings, seasonal grazing, and year-round horse pasture in Kalat.',
 'Source-stated estimates.'),
('X1101','S0200',NULL,NULL,'Kalat Report 1: fuel, pistachio woodland and local resources',
 'The report discusses Shir Kuh fuel resources, wild pistachio growth and local agricultural/economic potential.',
 'Environmental/economic observations.'),
('X1102','S0200',NULL,NULL,'Kalat Report 1: cumin and underused economic resources',
 'Abdollah Khan argues that abundant local cumin could potentially cover Kalat''s tax burden if collected efficiently.',
 'Authorial economic assessment.'),
('X1103','S0200',NULL,NULL,'Kalat Report 1: local production and provisioning capacity',
 'The report gives household, work-animal and grain-production estimates and argues that Kalat could provision a much larger population than required for defense.',
 'Source-stated demographic/agricultural estimates.'),
('X1104','S0200',NULL,NULL,'Kalat Report 1: seasonal resource collection near Kashtani and Chub Mast',
 'The report describes outside collectors from Tabas gathering a locally abundant plant/resource for months at a time.',
 'Botanical identification remains unresolved.'),
('X1105','S0200',NULL,NULL,'Kalat Report 2 (1302 AH): five gates, c.75 footpaths, self-sufficiency',
 'Abdollah Khan describes five principal entrances, approximately seventy-five additional pedestrian routes, and Kalat''s internally available food and water.',
 'Second Kalat report; 1302 AH.'),
('X1106','S0200',NULL,NULL,'Kalat Report 2: manpower reduction and fortification economics',
 'After fortifying vulnerable approaches, Abdollah Khan argues that roughly two to three hundred soldiers could secure Kalat and that construction costs could be recovered from recurring savings.',
 'Authorial defense/finance analysis.'),
('X1107','S0200',NULL,NULL,'Kalat Report 2: cavalry reform',
 'The report describes reduction of a nominal 300-cavalry establishment to 100 reliable mounted men, with pay and fiscal-return estimates.',
 'Historical administrative figures.'),
('X1108','S0200',NULL,NULL,'Kalat Report 2: six artillery pieces',
 'The report places two useful guns at Nafta, two poorly oriented pieces at Arghavan Shah, and two pieces without carriages at Kobud Gonbad.',
 'Artillery infrastructure assessment.'),
('X1109','S0200',NULL,NULL,'Kalat Report 3: five named darbands and old defensive architecture',
 'The repair inspection names Arghavan Shah, Kashtani, Chub Mast, Nafta and Dehcheh and describes bridges, guardhouses and old towers.',
 'Third Kalat report.'),
('X1110','S0200',NULL,NULL,'Kalat Report 3: 79 personally inspected pedestrian approaches',
 'Abdollah Khan says he personally climbed and inspected seventy-nine pedestrian approaches and assessed how each should be blocked or fortified.',
 'First-person engineering/field inspection.'),
('X1111','S0200',NULL,NULL,'Kalat Report 3: water and material logistics',
 'The report discusses carrying material half to one farsakh, using spring rainwater, and transporting water in skins where necessary.',
 'Construction logistics.'),
('X1112','S0200',NULL,NULL,'Kalat Report 3: repair durability and Behbud Khan comparison',
 'Abdollah Khan contrasts durable Naderi construction with recent repairs under Behbud Khan that had quickly failed.',
 'Authorial engineering judgment.'),
('X1113','S0200',NULL,NULL,'Kalat Report 3: repair budgets and corruption risk',
 'The report estimates durable strategic work at around 5,000 tomans under competent oversight and warns that far greater spending could still produce poor construction under dishonest management.',
 'Authorial budget/governance analysis.'),
('X1114','S0200',NULL,NULL,'Kalat Report 3: government complex and grain storage',
 'The report proposes functional repairs to the government/mausoleum complex, stables, walls and a granary for at least 2,000 kharvars of wheat.',
 'Administrative/logistical recommendations.');

-- ---------------------------------------------------------------------------
-- Claims
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO claims(claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes) VALUES
('C1100','person','P0004','kalat_three_reports','Majmooe Asaar preserves three distinct Kalat Naderi reports by Abdollah Khan, including a 1302 AH strategic report and a separate repair-inspection booklet.','confirmed','active','Source-work boundary claim.'),
('C1101','event','E0300','sheep_capacity','Abdollah Khan estimated that Kalat could internally sustain roughly six thousand sheep without outside pasture.','confirmed','active','Source-stated estimate.'),
('C1102','event','E0300','mare_capacity','Abdollah Khan estimated that Kalat could internally sustain roughly five hundred mares.','confirmed','active','Source-stated estimate.'),
('C1103','event','E0300','actual_sheep_holdings','The source reports actual sheep holdings around twelve thousand.','confirmed','active','Historical estimate.'),
('C1104','event','E0300','seasonal_pasture','The report describes prolonged seasonal pasture availability in Kalat''s mountain and valley environment.','confirmed','active','Environmental observation.'),
('C1105','event','E0300','fuel_resources','Brushwood from Shir Kuh and other local mountain vegetation served as major fuel resources.','confirmed','active','Environmental/economic observation.'),
('C1106','event','E0300','wild_pistachio','The report describes substantial wild pistachio growth in areas behind the Kalat mountains.','confirmed','active','Environmental observation.'),
('C1107','event','E0300','cumin_abundance','Abdollah Khan describes abundant Maku''i cumin in and around Kalat.','confirmed','active','Source terminology retained.'),
('C1108','event','E0300','cumin_tax_potential','Abdollah Khan argues that organized cumin collection could potentially cover Kalat''s entire tax obligation.','confirmed','active','Authorial economic assessment, not audited fiscal fact.'),
('C1109','event','E0300','local_resource_capture','Abdollah Khan believed local inhabitants could profit more from resources then being harvested seasonally by outsiders from Tabas near Kashtani and Chub Mast.','confirmed','active','Authorial economic recommendation; botanical term remains unresolved.'),
('C1110','event','E0300','population_provisioning','The report argues that Kalat''s internal food production could provision a population around ten thousand even though far fewer soldiers should be needed for defense.','confirmed','active','Authorial capacity estimate.'),
('C1111','event','E0301','self_sufficient_defense','Abdollah Khan considered Kalat unusually defensible because water and provisions could be produced within the fortified region.','confirmed','active','Strategic assessment.'),
('C1112','event','E0301','five_principal_entrances','Report 2 identifies five principal entrances suitable for routine passage of men and horses.','confirmed','active','Strategic geography.'),
('C1113','event','E0301','seventy_five_footpaths','Report 2 describes approximately seventy-five additional pedestrian routes, several of which could also admit horses.','confirmed','active','Survey estimate before more detailed repair inspection.'),
('C1114','event','E0301','reduced_garrison_estimate','After proper fortification, Abdollah Khan estimated that roughly two hundred to three hundred soldiers could secure Kalat.','confirmed','active','Authorial defense estimate.'),
('C1115','event','E0301','fortification_payback','He argued that fortification costs could be recovered within roughly one year through savings in recurring military salaries and rations.','confirmed','active','Authorial fiscal/defense analysis.'),
('C1116','event','E0301','cavalry_reform','The source describes an older nominal 300-cavalry establishment reorganized under Asef al-Dowleh into 100 reliable mounted men.','confirmed','active','Historical administrative claim.'),
('C1117','event','E0301','cavalry_pay','The reorganized cavalry were reported as receiving twenty tomans annually per rider.','confirmed','active','Source-stated pay figure.'),
('C1118','event','E0301','fiscal_return_after_reform','The source reports roughly four hundred tomans cash and four hundred kharvars in kind returning to the administration after cavalry expenses.','confirmed','active','Historical fiscal estimate.'),
('C1119','event','E0301','artillery_inventory','Report 2 records six artillery pieces in Kalat.','confirmed','active','Source-stated inventory.'),
('C1120','place',(SELECT place_id FROM _kal_place_map WHERE place_key='nafta'),'artillery_position','Two guns at Darband-e Nafta were described as operational/useful.','confirmed','active','Artillery placement.'),
('C1121','place',(SELECT place_id FROM _kal_place_map WHERE place_key='arghavan'),'artillery_position','Two guns at Arghavan Shah were described as badly oriented and effectively useless in their existing position.','confirmed','active','Authorial military assessment.'),
('C1122','place',(SELECT place_id FROM _kal_place_map WHERE place_key='kobud_gonbad'),'artillery_condition','Two guns at Kobud Gonbad were reported lying without carriages.','confirmed','active','Artillery condition.'),
('C1123','event','E0301','mountain_gun_recommendation','Abdollah Khan considered small mule-transported Austrian mountain guns especially suitable for Kalat.','confirmed','active','Authorial recommendation.'),
('C1124','event','E0302','five_named_darbands','Report 3 names Arghavan Shah, Kashtani, Chub Mast, Nafta and Dehcheh as the five principal darbands.','confirmed','active','Detailed engineering survey.'),
('C1125','event','E0302','seventy_nine_approaches','Abdollah Khan states that he personally inspected seventy-nine pedestrian approaches and worked out how each could be blocked or fortified.','confirmed','active','First-person field-inspection claim.'),
('C1126','event','E0302','route_count_refinement','The 75-route figure in Report 2 and 79-route figure in Report 3 are best preserved as probable progressive survey refinement rather than silently treated as identical.','probable','active','Archive reconciliation note, not source quotation.'),
('C1127','event','E0302','ruined_guard_posts','The source says many old guard towers had collapsed, forcing guards to live in tents or rock crevices.','confirmed','active','First-person inspection observation.'),
('C1128','event','E0302','material_transport','Construction materials sometimes had to be carried by people for roughly half a farsakh to a full farsakh to high work sites.','confirmed','active','Construction logistics.'),
('C1129','event','E0302','earthwork_routes','Abdollah Khan estimated that roughly twenty approaches could be blocked comparatively cheaply with earth/fill, while many others required masonry.','confirmed','active','Engineering recommendation.'),
('C1130','event','E0302','spring_water_strategy','He recommended beginning some high-elevation construction in early spring so rainwater could be collected for masonry work.','confirmed','active','Construction logistics recommendation.'),
('C1131','event','E0302','water_transport_cost','Where water had to be carried to work sites, the source gives a cost around ten shahis per water skin, varying by location.','confirmed','active','Source-stated construction cost.'),
('C1132','event','E0302','naderi_durability_standard','Abdollah Khan treated surviving Naderi construction as the appropriate standard of durability for new repairs.','confirmed','active','Authorial engineering judgment.'),
('C1133','event','E0302','behbud_repair_failure','He contrasted Naderi works with recent repairs under Behbud Khan that had reportedly deteriorated within only a few years.','confirmed','active','Authorial comparison.'),
('C1134','event','E0302','strategic_repair_budget','Abdollah Khan estimated that durable major defensive repairs could be carried out for roughly five thousand tomans under competent and honest supervision.','confirmed','active','Authorial budget estimate.'),
('C1135','event','E0302','corruption_warning','He warned that poor or dishonest management could spend around twenty thousand tomans and still produce weak, short-lived construction.','confirmed','active','Illustrative warning, not an audited corruption case.'),
('C1136','event','E0302','oversight_standard','Abdollah Khan recommended a trustworthy overseer who remained personally present, inspected workmanship, and had no financial self-interest in the work.','confirmed','active','Governance/engineering recommendation.'),
('C1137','event','E0302','government_complex_budget','For the government/mausoleum complex, he distinguished a fuller restoration around fifteen hundred tomans from a minimum functional repair around five hundred tomans.','confirmed','active','Different project scopes; not contradictory budgets.'),
('C1138','event','E0302','granary_capacity','He recommended a grain store capable of holding at least two thousand kharvars of wheat.','confirmed','active','Fortress logistics recommendation.'),
('C1139','person','P0004','kalat_administrative_style','Across the Kalat reports Abdollah Khan repeatedly links defensibility to internal provisioning, durable infrastructure, realistic manpower, careful budgeting and honest supervision.','probable','active','Archive synthesis based on multiple explicit recommendations.');

-- ---------------------------------------------------------------------------
-- Claim-citation links
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C1100','X1105','supports'),
('C1100','X1109','supports'),
('C1101','X1100','supports'),
('C1102','X1100','supports'),
('C1103','X1100','supports'),
('C1104','X1100','supports'),
('C1105','X1101','supports'),
('C1106','X1101','supports'),
('C1107','X1102','supports'),
('C1108','X1102','supports'),
('C1109','X1104','supports'),
('C1110','X1103','supports'),
('C1111','X1105','supports'),
('C1112','X1105','supports'),
('C1113','X1105','supports'),
('C1114','X1106','supports'),
('C1115','X1106','supports'),
('C1116','X1107','supports'),
('C1117','X1107','supports'),
('C1118','X1107','supports'),
('C1119','X1108','supports'),
('C1120','X1108','supports'),
('C1121','X1108','supports'),
('C1122','X1108','supports'),
('C1123','X1108','supports'),
('C1124','X1109','supports'),
('C1125','X1110','supports'),
('C1126','X1105','supports'),
('C1126','X1110','supports'),
('C1127','X1110','supports'),
('C1128','X1111','supports'),
('C1129','X1111','supports'),
('C1130','X1111','supports'),
('C1131','X1111','supports'),
('C1132','X1112','supports'),
('C1133','X1112','supports'),
('C1134','X1113','supports'),
('C1135','X1113','supports'),
('C1136','X1113','supports'),
('C1137','X1114','supports'),
('C1138','X1114','supports'),
('C1139','X1106','supports'),
('C1139','X1112','supports'),
('C1139','X1113','supports');

-- ---------------------------------------------------------------------------
-- Direct provenance
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO entity_citations(entity_citation_id,entity_type,entity_id,citation_id,support_type,notes) VALUES
('EC1100','event','E0300','X1100','supports','Report 1 livestock/resource observations.'),
('EC1101','event','E0301','X1105','supports','Report 2 strategic defense survey, dated 1302 AH.'),
('EC1102','event','E0302','X1110','supports','Report 3 detailed repair/route inspection.'),
('EC1103','place',(SELECT place_id FROM _kal_place_map WHERE place_key='arghavan'),'X1109','supports','Arghavan Shah principal pass and defensive works.'),
('EC1104','place',(SELECT place_id FROM _kal_place_map WHERE place_key='nafta'),'X1109','supports','Nafta principal pass and defensive works.'),
('EC1105','place',(SELECT place_id FROM _kal_place_map WHERE place_key='kobud_gonbad'),'X1108','supports','Kobud Gonbad artillery condition.');

-- ---------------------------------------------------------------------------
-- Research questions
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO research_questions(question_id,question,status,priority,notes) VALUES
('Q0110','What are the exact manuscript titles and completion dates of Kalat Report 1 and the repair-inspection Report 3?','open','high','Report 2 is securely dated 1302 AH; do not normalize the other two without direct heading/manuscript evidence.'),
('Q0111','Can the 75 pedestrian routes in Report 2 and 79 approaches in Report 3 be reconciled precisely from the original manuscript wording and survey sequence?','open','medium','Current interpretation is probable progressive survey refinement.'),
('Q0112','Can the five principal darbands and the 79 approaches be mapped to secure historical or modern coordinates?','open','high','Important for Explorer map and future animation; require independent cartographic confirmation.'),
('Q0113','What is the correct botanical identification of the locally abundant resource gathered seasonally near Kashtani and Chub Mast by collectors from Tabas?','open','medium','Preserve Persian source terminology until verified.'),
('Q0114','Can Abdollah Khan''s livestock, grain, population, cavalry, artillery and repair-cost estimates be corroborated from Kalat administrative, military or fiscal records?','open','medium','Treat current figures as historical source estimates.'),
('Q0115','Who was Behbud Khan in the Kalat repair context, and what official responsibility did he hold when the short-lived repairs criticized by Abdollah Khan were made?','open','medium','Identity/office reconciliation before canonical person creation.'),
('Q0116','Which Asef al-Dowleh administration and date correspond exactly to the Kalat cavalry reform from 300 nominal cavalry to 100 reliable mounted men?','open','medium','Needed for precise event chronology and person/office links.');

-- ---------------------------------------------------------------------------
-- Change log
-- ---------------------------------------------------------------------------
INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-04T02:40:00Z','migration','0041','apply','Added Majmooe Asaar Kalat Naderi Frontier historical enrichment; canonical genealogy unchanged.');

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-04T02:40:00Z','event','E0300-E0302','insert','Added the three distinct Kalat report/inspection source events.');

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-04T02:40:00Z','claim','C1100-C1139','insert','Added cited Kalat resource, defense, artillery, engineering, logistics, fiscal and governance claims.');

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-04T02:40:00Z','database','archive','release','Prepared v2.8.8 Kalat Naderi Frontier enrichment checkpoint.');

DROP TABLE _kal_place_map;
