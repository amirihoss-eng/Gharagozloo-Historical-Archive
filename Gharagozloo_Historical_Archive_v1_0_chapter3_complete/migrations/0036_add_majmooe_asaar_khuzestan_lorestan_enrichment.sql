-- Migration 0036
-- Majmooe Asaar: Abdollah Khan Amir Nezam Khuzestan/Lorestan mission enrichment
-- Baseline: v2.8.2 / migration 0035
-- Policy: enrich events, places, claims, citations, and research questions.
-- This migration does NOT alter canonical genealogy topology.
-- Transaction control is intentionally omitted; apply_migration.py owns the transaction.

UPDATE metadata SET value='2.8.3' WHERE key='database_version';
INSERT OR REPLACE INTO metadata(key,value) VALUES('last_migration','0036');
INSERT OR REPLACE INTO metadata(key,value) VALUES('updated_at','2026-08-04T00:20:00Z');
INSERT OR REPLACE INTO metadata(key,value) VALUES('historical_enrichment_checkpoint','Majmooe Asaar Khuzestan/Lorestan mission');

INSERT INTO sources(source_id,short_title,full_title,author,publication_year,source_type,file_name,notes)
SELECT 'S0200','Majmooe Asaar','مجموعه آثار حاجی عبدالله خان قراگوزلو امیر نظام همدانی',
       'Haji Abdollah Khan Gharagozloo; edited by Enayatollah Majidi',NULL,'edited primary-source collection',
       'Majmooe Asaar - PDF.pdf',
       'Collection containing Abdollah Khan''s writings, including the Khuzestan/Lorestan travel report.'
WHERE NOT EXISTS (SELECT 1 FROM sources WHERE source_id='S0200');

-- ---------------------------------------------------------------------------
-- Places
-- ---------------------------------------------------------------------------
CREATE TEMP TABLE _khu_place_map(place_key TEXT PRIMARY KEY, place_id TEXT NOT NULL);

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0210','Khuzestan','خوزستان','province/region',NULL,
       'Principal region of Abdollah Khan''s 1305–1308 AH military-administrative mission.'
WHERE NOT EXISTS (SELECT 1 FROM places WHERE lower(preferred_name_en)='khuzestan' OR preferred_name_fa='خوزستان');
INSERT INTO _khu_place_map SELECT 'khuzestan',place_id FROM places
 WHERE lower(preferred_name_en)='khuzestan' OR preferred_name_fa='خوزستان'
 ORDER BY CASE WHEN place_id='L0210' THEN 0 ELSE 1 END, place_id LIMIT 1;

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0211','Dezful','دزفول','city',(SELECT place_id FROM _khu_place_map WHERE place_key='khuzestan'),
       'Principal early operational base of the Fadavi Regiment during the Khuzestan mission.'
WHERE NOT EXISTS (SELECT 1 FROM places WHERE lower(preferred_name_en)='dezful' OR preferred_name_fa='دزفول');
INSERT INTO _khu_place_map SELECT 'dezful',place_id FROM places
 WHERE lower(preferred_name_en)='dezful' OR preferred_name_fa='دزفول'
 ORDER BY CASE WHEN place_id='L0211' THEN 0 ELSE 1 END, place_id LIMIT 1;

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0212','Shushtar','شوشتر','city',(SELECT place_id FROM _khu_place_map WHERE place_key='khuzestan'),
       'Major city described in detail by Abdollah Khan; later base for portions of the regiment.'
WHERE NOT EXISTS (SELECT 1 FROM places WHERE lower(preferred_name_en)='shushtar' OR preferred_name_fa='شوشتر');
INSERT INTO _khu_place_map SELECT 'shushtar',place_id FROM places
 WHERE lower(preferred_name_en)='shushtar' OR preferred_name_fa='شوشتر'
 ORDER BY CASE WHEN place_id='L0212' THEN 0 ELSE 1 END, place_id LIMIT 1;

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0213','Shush (Susa)','شوش','ancient city/site',(SELECT place_id FROM _khu_place_map WHERE place_key='khuzestan'),
       'Ancient ruined city near the shrine of the Prophet Daniel, described on the Dezful corridor.'
WHERE NOT EXISTS (SELECT 1 FROM places WHERE lower(preferred_name_en) IN ('shush','shush (susa)','susa') OR preferred_name_fa='شوش');
INSERT INTO _khu_place_map SELECT 'shush',place_id FROM places
 WHERE lower(preferred_name_en) IN ('shush','shush (susa)','susa') OR preferred_name_fa='شوش'
 ORDER BY CASE WHEN place_id='L0213' THEN 0 ELSE 1 END, place_id LIMIT 1;

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0214','Ahvaz','اهواز','city',(SELECT place_id FROM _khu_place_map WHERE place_key='khuzestan'),
       'Khuzestan city and irrigation/river-infrastructure setting discussed by Abdollah Khan.'
WHERE NOT EXISTS (SELECT 1 FROM places WHERE lower(preferred_name_en)='ahvaz' OR preferred_name_fa='اهواز');
INSERT INTO _khu_place_map SELECT 'ahvaz',place_id FROM places
 WHERE lower(preferred_name_en)='ahvaz' OR preferred_name_fa='اهواز'
 ORDER BY CASE WHEN place_id='L0214' THEN 0 ELSE 1 END, place_id LIMIT 1;

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0215','Falahiyah','فلاحیه','town/district',(SELECT place_id FROM _khu_place_map WHERE place_key='khuzestan'),
       'Lower Khuzestan district and scene of the 1305–1308 AH Fadavi deployment and local political crisis.'
WHERE NOT EXISTS (SELECT 1 FROM places WHERE lower(preferred_name_en)='falahiyah' OR preferred_name_fa='فلاحیه');
INSERT INTO _khu_place_map SELECT 'falahiyah',place_id FROM places
 WHERE lower(preferred_name_en)='falahiyah' OR preferred_name_fa='فلاحیه'
 ORDER BY CASE WHEN place_id='L0215' THEN 0 ELSE 1 END, place_id LIMIT 1;

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0216','Hoveyzeh','حویزه','town/district',(SELECT place_id FROM _khu_place_map WHERE place_key='khuzestan'),
       'Town and tribal-political district described extensively by Abdollah Khan.'
WHERE NOT EXISTS (SELECT 1 FROM places WHERE lower(preferred_name_en) IN ('hoveyzeh','howeyzeh') OR preferred_name_fa='حویزه');
INSERT INTO _khu_place_map SELECT 'hoveyzeh',place_id FROM places
 WHERE lower(preferred_name_en) IN ('hoveyzeh','howeyzeh') OR preferred_name_fa='حویزه'
 ORDER BY CASE WHEN place_id='L0216' THEN 0 ELSE 1 END, place_id LIMIT 1;

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0217','Mohammerah','محمره','port city',(SELECT place_id FROM _khu_place_map WHERE place_key='khuzestan'),
       'Lower Karun/Shatt al-Arab port city, commercial and military setting in Abdollah Khan''s report.'
WHERE NOT EXISTS (SELECT 1 FROM places WHERE lower(preferred_name_en) IN ('mohammerah','muhammarah') OR preferred_name_fa='محمره');
INSERT INTO _khu_place_map SELECT 'mohammerah',place_id FROM places
 WHERE lower(preferred_name_en) IN ('mohammerah','muhammarah') OR preferred_name_fa='محمره'
 ORDER BY CASE WHEN place_id='L0217' THEN 0 ELSE 1 END, place_id LIMIT 1;

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0218','Govanak (Khuzestan)','گوانک','road stage/village',(SELECT place_id FROM _khu_place_map WHERE place_key='khuzestan'),
       'Intermediate road stage between Dezful and Shushtar; source describes saline water and Bakhtiari Chahar-Lang residents.'
WHERE NOT EXISTS (SELECT 1 FROM places WHERE lower(preferred_name_en)='govanak (khuzestan)');
INSERT INTO _khu_place_map SELECT 'govanak',place_id FROM places
 WHERE lower(preferred_name_en)='govanak (khuzestan)'
 ORDER BY CASE WHEN place_id='L0218' THEN 0 ELSE 1 END, place_id LIMIT 1;

-- ---------------------------------------------------------------------------
-- Events
-- ---------------------------------------------------------------------------
INSERT INTO events(event_id,event_type,title,date_text,place_id,description,verification_status)
SELECT 'E0210','military_assignment',
       'Abdollah Khan Amir Nezam''s Khuzestan/Lorestan mission',
       '1305–1308 AH',
       (SELECT place_id FROM _khu_place_map WHERE place_key='khuzestan'),
       'Approximately two-and-a-half-year military-administrative mission in Khuzestan under Nezam al-Saltaneh Mafi, documented by Abdollah Khan in his travel/report booklet.',
       'confirmed'
WHERE NOT EXISTS (SELECT 1 FROM events WHERE event_id='E0210');
INSERT OR IGNORE INTO event_persons(event_id,person_id,role)
VALUES('E0210','P0004','commander of the Fadavi Regiment and observer-author');

INSERT INTO events(event_id,event_type,title,date_text,place_id,description,verification_status)
SELECT 'E0211','military_deployment',
       'Fadavi Regiment deployment to Falahiyah, Ahvaz and Hoveyzeh',
       'during 1305–1308 AH mission',
       (SELECT place_id FROM _khu_place_map WHERE place_key='falahiyah'),
       'The Fadavi Regiment moved from its Dezful base to Falahiyah during a summer crisis, remained about two months, then operated toward Ahvaz and Hoveyzeh.',
       'confirmed'
WHERE NOT EXISTS (SELECT 1 FROM events WHERE event_id='E0211');
INSERT OR IGNORE INTO event_persons(event_id,person_id,role)
VALUES('E0211','P0004','regimental commander');

INSERT INTO events(event_id,event_type,title,date_text,place_id,description,verification_status)
SELECT 'E0212','political_crisis',
       'Falahiyah political crisis and government intervention',
       'during 1305–1308 AH mission',
       (SELECT place_id FROM _khu_place_map WHERE place_key='falahiyah'),
       'Government mediation and subsequent military pressure altered the local balance between Sheikh Abdollah Khan and Sheikh Ja''far Khan; Sheikh Abdollah withdrew toward Mohammerah and Sheikh Ja''far was accepted as local governor.',
       'confirmed'
WHERE NOT EXISTS (SELECT 1 FROM events WHERE event_id='E0212');

INSERT INTO events(event_id,event_type,title,date_text,place_id,description,verification_status)
SELECT 'E0213','infrastructure_assessment',
       'Abdollah Khan''s Ahvaz irrigation and dam assessment',
       'during 1305–1308 AH mission',
       (SELECT place_id FROM _khu_place_map WHERE place_key='ahvaz'),
       'Assessment of the old Ahvaz dam and canal system, with staged recommendations for irrigation development and settlement before major reconstruction.',
       'confirmed'
WHERE NOT EXISTS (SELECT 1 FROM events WHERE event_id='E0213');
INSERT OR IGNORE INTO event_persons(event_id,person_id,role)
VALUES('E0213','P0004','observer and reform advocate');

-- ---------------------------------------------------------------------------
-- Citations — page_file refers to PDF page numbers in Majmooe Asaar - PDF.pdf.
-- Page ranges are intentionally broad where the report spans several topics.
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO citations(citation_id,source_id,page_printed,page_file,locator_text,quoted_text,notes) VALUES
('X0700','S0200',NULL,53,'Khuzestan/Lorestan report opening and mission framing',
 'Abdollah Khan frames the work as the result of roughly two and a half years in Khuzestan and observation of the Lorestan road.',
 'Primary-source report by Abdollah Khan.'),
('X0701','S0200',NULL,62,'Khuzestan climate and regional geography',
 'The report compares the climate of Dezful, Shushtar, Falahiyah and Mohammerah and describes the river systems of Khuzestan.',
 'Firsthand regional observations.'),
('X0702','S0200',NULL,67,'Military forces in Khuzestan and Fadavi deployment',
 'The Fadavi Regiment arrived before Nezam al-Saltaneh, camped outside Dezful, then moved toward Falahiyah, Ahvaz and Hoveyzeh.',
 'Military-service narrative.'),
('X0703','S0200',NULL,70,'Shahsevan cavalry and artillery at Shushtar',
 'Aqajan Khan Sartip served with Shahsevan cavalry and as deputy governor of Dezful; old artillery at Shushtar required repair.',
 'Personnel and military-infrastructure observations.'),
('X0704','S0200',NULL,73,'Hoveyzeh agricultural and tribal geography',
 'The report describes dry farming, grazing, and major tribal settlements around Hoveyzeh.',
 'Contemporary regional description.'),
('X0705','S0200',NULL,78,'Bani Saleh and Bani Torof',
 'The report describes Bani Saleh leaders, seasonal grazing and cultivation, and comments on Bani Torof territorial power.',
 'Household figures require reconciliation before normalization.'),
('X0706','S0200',NULL,84,'Dezful–Shush corridor and local security',
 'Shush and the shrine of Daniel are described in relation to Dezful; Karim Khan and government cavalry are associated with local security.',
 'Road, antiquity and security observations.'),
('X0707','S0200',NULL,91,'Dezful urban economy and bridge',
 'Dezful is described as comparatively prosperous, with markets, caravanserais, bathhouses, long-distance trade and a damaged bridge under local repair.',
 'Contemporary urban/economic description.'),
('X0708','S0200',NULL,92,'Falahiyah political crisis and Sheikh Ja''far Khan',
 'The source describes the conflict involving Sheikh Abdollah Khan, Sheikh Ja''far Khan, government mediation, troops and artillery.',
 'Political-military episode.'),
('X0709','S0200',NULL,103,'Ahvaz and Mohammerah infrastructure and shipping',
 'Abdollah Khan discusses Ahvaz irrigation works and argues for better port and shipping procedures at Mohammerah.',
 'Infrastructure and commercial reform proposals.'),
('X0710','S0200',NULL,111,'Lower Khuzestan military dispositions',
 'The report describes troops, artillery and military deployments around Shushtar, Ahvaz and Mohammerah.',
 'Military-service account.'),
('X0711','S0200',NULL,121,'Hoveyzeh/Falahiyah political administration',
 'The report discusses Hoveyzeh ruling families, fiscal assignments, Mowla Motalleb Khan and the political weight of Bani Torof.',
 'Political-administrative observations.');

-- ---------------------------------------------------------------------------
-- Atomic claims
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO claims(claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes) VALUES
('C0700','person','P0004','khuzestan_service','Abdollah Khan served in Khuzestan for approximately two and a half years during the 1305–1308 AH period and documented the mission in a dedicated report.','confirmed','active','Primary-source mission framing.'),
('C0701','event','E0210','initial_base','The Fadavi Regiment reached Khuzestan before Nezam al-Saltaneh and initially camped outside Dezful.','confirmed','active','Firsthand military narrative.'),
('C0702','event','E0211','summer_deployment','During the Falahiyah crisis the Fadavi Regiment marched in extreme summer heat, remained at Falahiyah about two months, and then moved toward Ahvaz and Hoveyzeh.','confirmed','active','Firsthand service narrative.'),
('C0703','event','E0211','climate_hardship','Abdollah Khan described Falahiyah as exceptionally hot and oppressive, with severe humid sharji conditions, hot winds and dangerous scorpions.','confirmed','active','Authorial observation; source-stated temperature measurements are not normalized here.'),
('C0704','event','E0211','garrison_disposition','After order was restored, four detachments were left as garrisons in Falahiyah and Hoveyzeh while most of the regiment returned to Shushtar.','confirmed','active','Military disposition.'),
('C0705','event','E0211','mohammerah_detachment','Before the New Year, one hundred soldiers and fifty military musicians accompanied Nezam al-Saltaneh toward Mohammerah.','confirmed','active','Source-stated troop and musician numbers.'),
('C0706','place',(SELECT place_id FROM _khu_place_map WHERE place_key='dezful'),'urban_economy','Abdollah Khan described Dezful as comparatively prosperous and reported about three hundred shops, five caravanserais and ten bathhouses.','confirmed','active','Contemporary estimate by the author.'),
('C0707','place',(SELECT place_id FROM _khu_place_map WHERE place_key='dezful'),'long_distance_trade','Merchants of Dezful and Shushtar maintained commercial relationships extending to Bombay/India and traded goods including wool, borage, lambskins and opium.','confirmed','active','Trade geography reported by Abdollah Khan.'),
('C0708','place',(SELECT place_id FROM _khu_place_map WHERE place_key='dezful'),'bridge_condition','Abdollah Khan described the Dezful bridge as having twenty-one major arches and reported a partial collapse that temporarily forced travelers to cross by raft.','confirmed','active','Historical measurements and condition should remain source-attributed.'),
('C0709','place',(SELECT place_id FROM _khu_place_map WHERE place_key='shush'),'route_relation','Shush and the shrine of the Prophet Daniel were described as approximately four farsakhs from Dezful.','confirmed','active','Historical distance retained in farsakhs.'),
('C0710','place',(SELECT place_id FROM _khu_place_map WHERE place_key='govanak'),'road_stage','Govanak was an intermediate stage on the Dezful–Shushtar road, with saline water and Bakhtiari Chahar-Lang residents.','confirmed','active','Road-stage observation.'),
('C0711','place',(SELECT place_id FROM _khu_place_map WHERE place_key='shushtar'),'route_relation','Abdollah Khan gave the Dezful–Shushtar road as approximately ten farsakhs and described a stretch beyond Govanak with no fresh water.','confirmed','active','Historical distance and water conditions.'),
('C0712','place',(SELECT place_id FROM _khu_place_map WHERE place_key='shushtar'),'river_geography','At Shushtar the river system divided into the Shatit and Karun branches as described by Abdollah Khan.','confirmed','active','Contemporary hydrological description.'),
('C0713','place',(SELECT place_id FROM _khu_place_map WHERE place_key='shushtar'),'population_estimate','Abdollah Khan estimated Shushtar at roughly four thousand households and about twenty-two thousand people.','confirmed','active','Source-stated contemporary estimate.'),
('C0714','place',(SELECT place_id FROM _khu_place_map WHERE place_key='shushtar'),'artillery_inventory','The report records twenty-one old muzzle-loading guns at Shushtar, many without carriages, with some repaired for operations toward Falahiyah and Ahvaz.','confirmed','active','Source-stated military inventory.'),
('C0715','person','P0004','infrastructure_reform','At Ahvaz Abdollah Khan recommended staged canal development before committing the state to full reconstruction of the old dam.','confirmed','active','Authorial reform proposal.'),
('C0716','event','E0213','cost_estimate','Abdollah Khan estimated that full reconstruction of the Ahvaz dam and related canals might cost more than one hundred fifty thousand tomans.','confirmed','active','Contemporary source estimate, not modernized.'),
('C0717','person','P0004','port_reform','Abdollah Khan criticized delays caused by shipping through Basra before Mohammerah and advocated more direct, formal port procedures at Mohammerah/Sahebqaraniyeh.','confirmed','active','Authorial administrative recommendation.'),
('C0718','place',(SELECT place_id FROM _khu_place_map WHERE place_key='falahiyah'),'urban_economy','Falahiyah was described as roughly five hundred households with about one hundred shops and commercial ties to Shushtar and Mohammerah.','confirmed','active','Contemporary estimate and commercial observation.'),
('C0719','event','E0212','local_independence','At Nezam al-Saltaneh''s arrival, Sheikh Abdollah Khan was described as exercising effectively independent authority in Falahiyah.','confirmed','active','Political situation as reported by Abdollah Khan.'),
('C0720','event','E0212','mediation_attempt','The government first attempted to mediate the Falahiyah dispute and dispatched two detachments of Chaharmahal troops with an Austrian mountain gun.','confirmed','active','Political-military response.'),
('C0721','event','E0212','political_outcome','After the mediation failed and government forces approached, Sheikh Abdollah Khan withdrew toward Mohammerah and local sheikhs accepted Sheikh Ja''far Khan''s authority.','confirmed','active','Outcome of the crisis.'),
('C0722','event','E0212','authorial_assessment','Abdollah Khan judged Sheikh Ja''far Khan highly capable and particularly suitable for governing Falahiyah.','confirmed','active','Explicit authorial judgment, not a neutral fact.'),
('C0723','place',(SELECT place_id FROM _khu_place_map WHERE place_key='hoveyzeh'),'ruling_lineage','Abdollah Khan described the government of Hoveyzeh as historically associated with descendants of Sayyid Mohammad ibn Falah.','confirmed','active','Historical-political framing from the report.'),
('C0724','place',(SELECT place_id FROM _khu_place_map WHERE place_key='hoveyzeh'),'fiscal_governance','During Nezam al-Saltaneh''s administration, Mowla Nasrollah Khan was assigned Hoveyzeh and associated territories for an annual fiscal obligation reported as six thousand tomans.','confirmed','active','Source-stated fiscal arrangement.'),
('C0725','place',(SELECT place_id FROM _khu_place_map WHERE place_key='hoveyzeh'),'political_leverage','Abdollah Khan regarded Mowla Motalleb Khan''s prestige among Arab groups as useful political leverage over the Bani Torof even when he was out of office.','confirmed','active','Authorial political assessment.'),
('C0726','place',(SELECT place_id FROM _khu_place_map WHERE place_key='hoveyzeh'),'bani_torof_power','Abdollah Khan described the Bani Torof as controlling important fertile lands and regarded excessive growth of their political power as a problem requiring balance.','confirmed','active','Authorial assessment; preserve attribution.'),
('C0727','place',(SELECT place_id FROM _khu_place_map WHERE place_key='hoveyzeh'),'bani_saleh_geography','The Bani Saleh were described as a tent-dwelling group cultivating dry-farmed lands south of Hoveyzeh and grazing seasonally between the Karkheh River and Hoveyzeh.','confirmed','active','Contemporary ethnographic/geographic description.'),
('C0728','place',(SELECT place_id FROM _khu_place_map WHERE place_key='hoveyzeh'),'bani_saleh_leaders','The report names Mahudar, Haji Ne''mat and Mahawi as leaders associated with the Bani Saleh.','confirmed','active','Names preserved from source; normalized transliteration remains open.'),
('C0729','place',(SELECT place_id FROM _khu_place_map WHERE place_key='hoveyzeh'),'bani_saleh_force','The report attributes approximately fifteen hundred mounted men and riflemen to the Bani Saleh.','confirmed','active','Source-stated force estimate.'),
('C0730','place',(SELECT place_id FROM _khu_place_map WHERE place_key='hoveyzeh'),'demographic_uncertainty','The Bani Saleh passage contains apparently inconsistent household figures that should not be normalized until visually reconciled.','confirmed','active','Evidence-quality flag retained in claim layer.'),
('C0731','person','P0004','administrative_style','Across the Khuzestan report Abdollah Khan repeatedly evaluated roads, water, military readiness, settlement, agriculture, trade and local political authority as interdependent parts of provincial administration.','probable','active','Interpretive synthesis grounded in multiple explicit recommendations; not a direct quotation.');

-- ---------------------------------------------------------------------------
-- Claim-citation links
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0700','X0700','supports'),
('C0701','X0702','supports'),
('C0702','X0702','supports'),
('C0703','X0702','supports'),
('C0704','X0702','supports'),
('C0705','X0702','supports'),
('C0706','X0707','supports'),
('C0707','X0707','supports'),
('C0708','X0707','supports'),
('C0709','X0706','supports'),
('C0710','X0706','supports'),
('C0711','X0706','supports'),
('C0712','X0701','supports'),
('C0713','X0701','supports'),
('C0714','X0703','supports'),
('C0715','X0709','supports'),
('C0716','X0709','supports'),
('C0717','X0709','supports'),
('C0718','X0708','supports'),
('C0719','X0708','supports'),
('C0720','X0708','supports'),
('C0721','X0708','supports'),
('C0722','X0708','supports'),
('C0723','X0711','supports'),
('C0724','X0711','supports'),
('C0725','X0711','supports'),
('C0726','X0711','supports'),
('C0727','X0705','supports'),
('C0728','X0705','supports'),
('C0729','X0705','supports'),
('C0730','X0705','supports'),
('C0731','X0700','supports'),
('C0731','X0709','supports'),
('C0731','X0711','supports');

-- Direct provenance for key entities/events.
INSERT OR IGNORE INTO entity_citations(entity_citation_id,entity_type,entity_id,citation_id,support_type,notes)
SELECT 'EC0700','event','E0210','X0700','supports','Mission framing and authorship context.'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE entity_citation_id='EC0700');
INSERT OR IGNORE INTO entity_citations(entity_citation_id,entity_type,entity_id,citation_id,support_type,notes)
SELECT 'EC0701','event','E0211','X0702','supports','Fadavi deployment and summer operation.'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE entity_citation_id='EC0701');
INSERT OR IGNORE INTO entity_citations(entity_citation_id,entity_type,entity_id,citation_id,support_type,notes)
SELECT 'EC0702','event','E0212','X0708','supports','Falahiyah political crisis.'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE entity_citation_id='EC0702');
INSERT OR IGNORE INTO entity_citations(entity_citation_id,entity_type,entity_id,citation_id,support_type,notes)
SELECT 'EC0703','place',(SELECT place_id FROM _khu_place_map WHERE place_key='dezful'),'X0707','supports','Dezful urban/economic description.'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE entity_citation_id='EC0703');
INSERT OR IGNORE INTO entity_citations(entity_citation_id,entity_type,entity_id,citation_id,support_type,notes)
SELECT 'EC0704','place',(SELECT place_id FROM _khu_place_map WHERE place_key='hoveyzeh'),'X0711','supports','Hoveyzeh political-administrative material.'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE entity_citation_id='EC0704');
INSERT OR IGNORE INTO entity_citations(entity_citation_id,entity_type,entity_id,citation_id,support_type,notes)
SELECT 'EC0705','event','E0213','X0709','supports','Ahvaz irrigation/dam assessment.'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE entity_citation_id='EC0705');

-- ---------------------------------------------------------------------------
-- Open research questions
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO research_questions(question_id,question,status,priority,notes) VALUES
('Q0070','What are the exact printed-page numbers and final normalized spellings for all Lorestan road stages in Abdollah Khan''s Khuzestan report?','open','high','Complete a page-by-page route extraction before creating every road-stage place entity.'),
('Q0071','How should the apparently inconsistent Bani Saleh household figures in the Hoveyzeh section be reconciled?','open','high','The passage appears to contain both roughly 1,000 and 500 household figures; verify the printed page and whether they refer to different groups/subdivisions.'),
('Q0072','Which existing archive records, if any, correspond to Aqajan Khan Sartip, Karim Khan son of Baqer Khan, Khoda-Karam Khan, Sheikh Ja''far Khan, Sheikh Abdollah Khan, Mowla Nasrollah Khan and Mowla Motalleb Khan?','open','high','Reconcile identities before creating new canonical person records to avoid duplicates.'),
('Q0073','Which existing military-unit records correspond to the Fadavi Regiment, Chaharmahal Regiment, Shahsevan cavalry and other Khuzestan forces?','open','high','Add structured military-unit/event links only after unit-ID reconciliation.'),
('Q0074','Can the historical Dezful bridge, Ahvaz dam/canals, Falahiyah government buildings and Mohammerah/Sahebqaraniyeh facilities be mapped to secure historical or modern coordinates?','open','medium','Use independent cartographic evidence; do not infer coordinates from farsakh statements alone.');

-- ---------------------------------------------------------------------------
-- Change log
-- ---------------------------------------------------------------------------
INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-04T00:20:00Z','migration','0036','apply','Added Majmooe Asaar Khuzestan/Lorestan mission historical enrichment; canonical genealogy topology unchanged.');
INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-04T00:20:00Z','event','E0210-E0213','insert','Added Khuzestan mission, Fadavi deployment, Falahiyah crisis and Ahvaz infrastructure-assessment events.');
INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-04T00:20:00Z','claim','C0700-C0731','insert','Added cited military, geographic, urban, economic, infrastructure, tribal and political claims from Abdollah Khan''s Khuzestan/Lorestan report.');
INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-04T00:20:00Z','database','archive','release','Prepared v2.8.3 Khuzestan/Lorestan historical enrichment checkpoint.');

DROP TABLE _khu_place_map;
