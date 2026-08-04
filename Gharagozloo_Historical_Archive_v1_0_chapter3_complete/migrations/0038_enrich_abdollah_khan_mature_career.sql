-- Migration 0038
-- Abdollah Khan Amir Nezam: mature career, constitutional-era politics, and death
-- Baseline: v2.8.4 / migration 0037
--
-- Scope: c.1309–1334 AH
-- Sources: primarily Majmooe Asaar editor's introduction / biographical synthesis,
--          with source viewpoints preserved as viewpoints where applicable.
--
-- IMPORTANT
-- * No canonical genealogy relationships are changed.
-- * No uncertain local identities are created.
-- * Political accusations and retrospective judgments are stored as attributed claims.
-- * Transaction control is intentionally omitted; apply_migration.py owns the transaction.

UPDATE metadata SET value='2.8.5' WHERE key='database_version';
INSERT OR REPLACE INTO metadata(key,value) VALUES('last_migration','0038');
INSERT OR REPLACE INTO metadata(key,value) VALUES('updated_at','2026-08-04T01:15:00Z');
INSERT OR REPLACE INTO metadata(key,value) VALUES(
    'historical_enrichment_checkpoint',
    'Abdollah Khan mature career and constitutional-era enrichment'
);

-- Ensure the primary source exists.
INSERT INTO sources(source_id,short_title,full_title,author,publication_year,source_type,file_name,notes)
SELECT 'S0200','Majmooe Asaar','مجموعه آثار حاجی عبدالله خان قراگوزلو امیر نظام همدانی',
       'Haji Abdollah Khan Gharagozloo; edited by Enayatollah Majidi',NULL,
       'edited primary-source collection','Majmooe Asaar - PDF.pdf',
       'Collection containing Abdollah Khan''s writings and an editor''s biographical introduction.'
WHERE NOT EXISTS (SELECT 1 FROM sources WHERE source_id='S0200');

-- ---------------------------------------------------------------------------
-- Publication-facing person data
-- ---------------------------------------------------------------------------
UPDATE persons
SET death_date_text = '23 Sha''ban 1334 AH / 1916 CE',
    summary = 'Haji Abdollah Khan Gharagozloo (Sa''ed al-Saltaneh, later Sardar Akram and Amir Nezam) was a senior Qajar military commander, provincial administrator, landholder, author, minister, and later Majles deputy in the Amir Nezam branch of the Hajilou Gharagozloo family. Son of Mostafa Qoli Khan E''temad al-Saltaneh, he served on the Sarakhs frontier in 1294–1296 AH, governed Astarabad, commanded the Fadavi Regiment in Khuzestan and Fars, and left detailed reports on frontier defense, roads, irrigation, trade, military logistics, and provincial administration. His later career included political imprisonment in 1310 AH, renewed command in Fars, the Khuzestan governorship as Sardar Akram from 1314 AH, opposition to the early constitutional movement, restoration to royal favor as Amir Nezam, service as Minister of Finance, and election from Hamadan to the Third Majles in 1332 AH. He died in Hamadan on 23 Sha''ban 1334 AH (1916 CE).',
    updated_at = '2026-08-04T01:15:00Z'
WHERE person_id='P0004';

-- ---------------------------------------------------------------------------
-- Places used by the mature-career events
-- ---------------------------------------------------------------------------
CREATE TEMP TABLE _ak_place_map(place_key TEXT PRIMARY KEY, place_id TEXT NOT NULL);

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0230','Shiraz','شیراز','city',NULL,'Provincial capital of Fars and a major setting in Abdollah Khan''s later military career.'
WHERE NOT EXISTS (SELECT 1 FROM places WHERE lower(preferred_name_en)='shiraz' OR preferred_name_fa='شیراز');
INSERT INTO _ak_place_map
SELECT 'shiraz',place_id FROM places
WHERE lower(preferred_name_en)='shiraz' OR preferred_name_fa='شیراز'
ORDER BY CASE WHEN place_id='L0230' THEN 0 ELSE 1 END, place_id LIMIT 1;

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0231','Hamadan','همدان','city/region',NULL,'Home region and recurrent political base of Abdollah Khan Amir Nezam.'
WHERE NOT EXISTS (SELECT 1 FROM places WHERE lower(preferred_name_en)='hamadan' OR preferred_name_fa='همدان');
INSERT INTO _ak_place_map
SELECT 'hamadan',place_id FROM places
WHERE lower(preferred_name_en)='hamadan' OR preferred_name_fa='همدان'
ORDER BY CASE WHEN place_id='L0231' THEN 0 ELSE 1 END, place_id LIMIT 1;

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0232','Tehran','تهران','city',NULL,'Capital; setting for imprisonment, War Ministry proceedings, cabinet service, and parliamentary activity.'
WHERE NOT EXISTS (SELECT 1 FROM places WHERE lower(preferred_name_en)='tehran' OR preferred_name_fa='تهران');
INSERT INTO _ak_place_map
SELECT 'tehran',place_id FROM places
WHERE lower(preferred_name_en)='tehran' OR preferred_name_fa='تهران'
ORDER BY CASE WHEN place_id='L0232' THEN 0 ELSE 1 END, place_id LIMIT 1;

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0233','Tabriz','تبریز','city',NULL,'Setting for the 1326 AH royalist campaign against constitutionalist Tabriz.'
WHERE NOT EXISTS (SELECT 1 FROM places WHERE lower(preferred_name_en)='tabriz' OR preferred_name_fa='تبریز');
INSERT INTO _ak_place_map
SELECT 'tabriz',place_id FROM places
WHERE lower(preferred_name_en)='tabriz' OR preferred_name_fa='تبریز'
ORDER BY CASE WHEN place_id='L0233' THEN 0 ELSE 1 END, place_id LIMIT 1;

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0234','Kurdistan','کردستان','province/region',NULL,'Province connected with Abdollah Khan''s blocked 1325 AH nomination and later governorship.'
WHERE NOT EXISTS (SELECT 1 FROM places WHERE lower(preferred_name_en)='kurdistan' OR preferred_name_fa='کردستان');
INSERT INTO _ak_place_map
SELECT 'kurdistan',place_id FROM places
WHERE lower(preferred_name_en)='kurdistan' OR preferred_name_fa='کردستان'
ORDER BY CASE WHEN place_id='L0234' THEN 0 ELSE 1 END, place_id LIMIT 1;

-- ---------------------------------------------------------------------------
-- Events
-- ---------------------------------------------------------------------------
INSERT INTO events(event_id,event_type,title,date_text,place_id,description,verification_status)
SELECT 'E0230','military_assignment',
       'Guarding Shiraz and the citadel with the Fadavi Regiment',
       '1309 AH',
       (SELECT place_id FROM _ak_place_map WHERE place_key='shiraz'),
       'When Fars came under Nezam al-Saltaneh Mafi, Abdollah Khan went to Shiraz with the Fadavi Regiment and was assigned responsibility for guarding the city and citadel.',
       'confirmed'
WHERE NOT EXISTS (SELECT 1 FROM events WHERE event_id='E0230');
INSERT OR IGNORE INTO event_persons(event_id,person_id,role)
VALUES('E0230','P0004','Fadavi Regiment commander / city and citadel security');

INSERT INTO events(event_id,event_type,title,date_text,place_id,description,verification_status)
SELECT 'E0231','political_crisis',
       'Hamadan crisis, interrogation, imprisonment and chains',
       'Jumada I–Rajab 1310 AH',
       (SELECT place_id FROM _ak_place_map WHERE place_key='tehran'),
       'Following the Molla Abdollah Borujerdi crisis in Hamadan, Abdollah Khan was summoned with other Gharagozloo khans, interrogated in Tehran, imprisoned and put in chains. Sources differ on the political and financial motives behind the punishment.',
       'confirmed'
WHERE NOT EXISTS (SELECT 1 FROM events WHERE event_id='E0231');
INSERT OR IGNORE INTO event_persons(event_id,person_id,role)
VALUES('E0231','P0004','accused/detained notable');

INSERT INTO events(event_id,event_type,title,date_text,place_id,description,verification_status)
SELECT 'E0232','appointment',
       'Renewed command of Fars forces after imprisonment',
       'Ramadan–Shawwal 1310 AH',
       (SELECT place_id FROM _ak_place_map WHERE place_key='hamadan'),
       'Within months of his imprisonment Abdollah Khan was appointed to lead the Fars forces; he returned through Hamadan/Shurin to organize military and estate affairs before moving south.',
       'confirmed'
WHERE NOT EXISTS (SELECT 1 FROM events WHERE event_id='E0232');
INSERT OR IGNORE INTO event_persons(event_id,person_id,role)
VALUES('E0232','P0004','commander of Fars forces');

INSERT INTO events(event_id,event_type,title,date_text,place_id,description,verification_status)
SELECT 'E0233','government_office',
       'Deputy governorship of Fars and Shiraz unrest',
       'Ramadan 1311 AH',
       (SELECT place_id FROM _ak_place_map WHERE place_key='shiraz'),
       'After Nezam al-Saltaneh Mafi was removed, Abdollah Khan became deputy governor of Fars. His regiment was involved in suppressing unrest in Shiraz; the source reports about seven or eight deaths, after which he resigned.',
       'confirmed'
WHERE NOT EXISTS (SELECT 1 FROM events WHERE event_id='E0233');
INSERT OR IGNORE INTO event_persons(event_id,person_id,role)
VALUES('E0233','P0004','deputy governor of Fars');

INSERT INTO events(event_id,event_type,title,date_text,place_id,description,verification_status)
SELECT 'E0234','government_office',
       'Governor and military head of Khuzestan as Sardar Akram',
       'Dhu al-Qa''dah 1314 AH',
       (SELECT place_id FROM places WHERE lower(preferred_name_en)='khuzestan' OR preferred_name_fa='خوزستان' ORDER BY place_id LIMIT 1),
       'Abdollah Khan, now Sardar Akram, took over the Khuzestan governorship from Ahmad Khan Ala al-Dowleh and served as provincial governor and military head.',
       'confirmed'
WHERE NOT EXISTS (SELECT 1 FROM events WHERE event_id='E0234');
INSERT OR IGNORE INTO event_persons(event_id,person_id,role)
VALUES('E0234','P0004','governor and military head of Khuzestan');

INSERT INTO events(event_id,event_type,title,date_text,place_id,description,verification_status)
SELECT 'E0235','political_transition',
       'Loss of command and blocked Kurdistan appointment',
       'Muharram–Safar 1325 AH',
       (SELECT place_id FROM _ak_place_map WHERE place_key='tehran'),
       'Abdollah Khan''s Amir Noyan/Sardar Akram command was abolished and his Fars military salary stopped. A subsequent nomination to govern Kurdistan was blocked by the Majles.',
       'confirmed'
WHERE NOT EXISTS (SELECT 1 FROM events WHERE event_id='E0235');
INSERT OR IGNORE INTO event_persons(event_id,person_id,role)
VALUES('E0235','P0004','displaced senior military notable');

INSERT INTO events(event_id,event_type,title,date_text,place_id,description,verification_status)
SELECT 'E0236','military_political_crisis',
       'Fadavi wage protest, War Ministry questioning and dismissal',
       '27 Rabi II 1326 AH',
       (SELECT place_id FROM _ak_place_map WHERE place_key='tehran'),
       'Fadavi soldiers protested unpaid wages in Tehran. Abdollah Khan was summoned to the War Ministry, questioned before officials and Majles deputies, and removed from government office.',
       'confirmed'
WHERE NOT EXISTS (SELECT 1 FROM events WHERE event_id='E0236');
INSERT OR IGNORE INTO event_persons(event_id,person_id,role)
VALUES('E0236','P0004','Fadavi commander questioned and dismissed');

INSERT INTO events(event_id,event_type,title,date_text,place_id,description,verification_status)
SELECT 'E0237','royal_restoration',
       'Restoration to royal favor and grant of the title Amir Nezam',
       '1326 AH',
       (SELECT place_id FROM _ak_place_map WHERE place_key='tehran'),
       'After Mohammad Ali Shah''s coup against the constitutional order, Abdollah Khan was recalled, received a royal decree and robe of honor, and was granted the title Amir Nezam.',
       'confirmed'
WHERE NOT EXISTS (SELECT 1 FROM events WHERE event_id='E0237');
INSERT OR IGNORE INTO event_persons(event_id,person_id,role)
VALUES('E0237','P0004','restored royalist commander / Amir Nezam');

INSERT INTO events(event_id,event_type,title,date_text,place_id,description,verification_status)
SELECT 'E0238','military_campaign',
       'Command of Hamadan forces in the Tabriz campaign',
       'Ramadan 1326 AH',
       (SELECT place_id FROM _ak_place_map WHERE place_key='tabriz'),
       'Abdollah Khan Amir Nezam commanded Hamadan regiments within the royalist forces operating against constitutionalist Tabriz.',
       'confirmed'
WHERE NOT EXISTS (SELECT 1 FROM events WHERE event_id='E0238');
INSERT OR IGNORE INTO event_persons(event_id,person_id,role)
VALUES('E0238','P0004','commander of Hamadan forces');

INSERT INTO events(event_id,event_type,title,date_text,place_id,description,verification_status)
SELECT 'E0239','cabinet_office',
       'Service as Minister of Finance',
       '1327 AH; again 1333 AH',
       (SELECT place_id FROM _ak_place_map WHERE place_key='tehran'),
       'Abdollah Khan served as Minister of Finance in a 1327 AH cabinet and later again in the Ayn al-Dowleh cabinet in 1333 AH.',
       'confirmed'
WHERE NOT EXISTS (SELECT 1 FROM events WHERE event_id='E0239');
INSERT OR IGNORE INTO event_persons(event_id,person_id,role)
VALUES('E0239','P0004','Minister of Finance');

INSERT INTO events(event_id,event_type,title,date_text,place_id,description,verification_status)
SELECT 'E0240','government_office',
       'Governorship of Kurdistan',
       'by 1328 AH',
       (SELECT place_id FROM _ak_place_map WHERE place_key='kurdistan'),
       'The editor''s biography identifies Abdollah Khan as governor of Kurdistan by 1328 AH; the precise beginning of the tenure remains uncertain.',
       'probable'
WHERE NOT EXISTS (SELECT 1 FROM events WHERE event_id='E0240');
INSERT OR IGNORE INTO event_persons(event_id,person_id,role)
VALUES('E0240','P0004','governor of Kurdistan');

INSERT INTO events(event_id,event_type,title,date_text,place_id,description,verification_status)
SELECT 'E0241','political_military_episode',
       'Salar al-Dowleh uprising alignment and subsequent government service',
       'c.1330 AH',
       (SELECT place_id FROM _ak_place_map WHERE place_key='hamadan'),
       'During the Salar al-Dowleh crisis Abdollah Khan first associated his force with Salar al-Dowleh while maintaining operational distance, then joined government forces under Farmanfarma after Salar al-Dowleh retreated.',
       'confirmed'
WHERE NOT EXISTS (SELECT 1 FROM events WHERE event_id='E0241');
INSERT OR IGNORE INTO event_persons(event_id,person_id,role)
VALUES('E0241','P0004','regional military notable');

INSERT INTO events(event_id,event_type,title,date_text,place_id,description,verification_status)
SELECT 'E0242','election',
       'Election to the Third Majles from Hamadan',
       '28 Rajab 1332 AH',
       (SELECT place_id FROM _ak_place_map WHERE place_key='hamadan'),
       'Abdollah Khan was elected as one of Hamadan''s deputies to the Third Majles with a source-reported 4,829 votes.',
       'confirmed'
WHERE NOT EXISTS (SELECT 1 FROM events WHERE event_id='E0242');
INSERT OR IGNORE INTO event_persons(event_id,person_id,role)
VALUES('E0242','P0004','elected Majles deputy for Hamadan');

INSERT INTO events(event_id,event_type,title,date_text,place_id,description,verification_status)
SELECT 'E0243','death',
       'Death of Haji Abdollah Khan Amir Nezam',
       '23 Sha''ban 1334 AH / 1916 CE',
       (SELECT place_id FROM _ak_place_map WHERE place_key='hamadan'),
       'The editor reports that Abdollah Khan died on Sunday, 23 Sha''ban 1334 AH (1916 CE), after a partial stroke while the effects of the First World War had reached Hamadan.',
       'confirmed'
WHERE NOT EXISTS (SELECT 1 FROM events WHERE event_id='E0243');
INSERT OR IGNORE INTO event_persons(event_id,person_id,role)
VALUES('E0243','P0004','decedent');

-- ---------------------------------------------------------------------------
-- Citations to Majmooe Asaar introduction / biography
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO citations(citation_id,source_id,page_printed,page_file,locator_text,quoted_text,notes) VALUES
('X0800','S0200','15','16','Editor introduction: Sarakhs through Fars transition',
 'The editor traces Abdollah Khan from Sarakhs and Astarabad to Khuzestan and the 1309 AH move to Shiraz with responsibility for city and citadel security.',
 'Biographical synthesis in the editor''s introduction.'),
('X0801','S0200','16–17','17','Editor introduction: Hamadan crisis and return to command',
 'The editor describes the 1310 AH Hamadan crisis, detention in Tehran, and Abdollah Khan''s rapid return to military command.',
 'Political chronology; motives for punishment are discussed through competing accounts.'),
('X0802','S0200','17','18','Editor introduction: Fars deputy governorship and Khuzestan appointment',
 'The editor follows the 1311 AH Fars deputy governorship, Shiraz unrest and later appointment to govern Khuzestan as Sardar Akram.',
 'Biographical synthesis.'),
('X0803','S0200','18–19','19','Editor introduction: constitutional-era opposition, grain crisis, and 1325 AH reversal',
 'The editor records opposition to the Majles, Hamadan grain complaints, abolition of command and the blocked Kurdistan nomination.',
 'Political claims remain source-attributed.'),
('X0804','S0200','19–20','20','Editor introduction: 1326 AH protest, restoration and Tabriz campaign',
 'The editor describes the Fadavi wage protest, War Ministry proceedings, restoration under Mohammad Ali Shah and the Amir Nezam title.',
 'Biographical synthesis.'),
('X0805','S0200','20','21','Editor introduction: finance ministry, Kurdistan, excavation controversy and Salar al-Dowleh',
 'The editor records later offices and controversies, including the finance ministry, Kurdistan, Kordabad excavations and Salar al-Dowleh episode.',
 'Some passages report accusations or hostile assessments and must remain attributed.'),
('X0806','S0200','21','22','Editor introduction: Third Majles, later finance ministry, and death',
 'The editor records election from Hamadan with 4,829 votes, later finance-ministry service, and death on 23 Sha''ban 1334 AH / 1916 CE.',
 'Late-career chronology and death.'),
('X0807','S0200','21–22','22','Mosaddegh retrospective criticism of Amir Nezam as finance minister',
 'A retrospective account attributed to Mohammad Mosaddegh criticizes Amir Nezam''s financial-administrative competence and use of divination in appointments.',
 'Store as attributed retrospective criticism, not neutral fact.');

-- ---------------------------------------------------------------------------
-- Claims
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO claims(claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes) VALUES
('C0800','person','P0004','shirazi_service','In 1309 AH Abdollah Khan went to Shiraz with the Fadavi Regiment and was assigned responsibility for guarding Shiraz and its citadel.','confirmed','active','Editor''s biographical synthesis.'),
('C0801','person','P0004','hamadan_crisis','In 1310 AH Abdollah Khan was drawn into the Molla Abdollah Borujerdi crisis, summoned to Tehran, imprisoned and put in chains.','confirmed','active','The fact of detention is secure; sources differ on motive and political framing.'),
('C0802','person','P0004','release_payment','A source cited in the historical literature records a 7,000-toman payment associated with Abdollah Khan''s release after the 1310 AH detention.','probable','active','Preserve as source-reported financial outcome, not a fully reconstructed legal judgment.'),
('C0803','person','P0004','fars_command_rehabilitation','Within months of the 1310 AH imprisonment Abdollah Khan was restored to command and appointed to lead the Fars forces.','confirmed','active','Major career reversal.'),
('C0804','person','P0004','fars_deputy_governor','In Ramadan 1311 AH Abdollah Khan became deputy governor of Fars after Nezam al-Saltaneh Mafi''s removal.','confirmed','active','Editor''s chronology.'),
('C0805','event','E0233','shirazi_casualties','The source reports roughly seven or eight deaths during the Shiraz confrontation involving Abdollah Khan''s regiment.','confirmed','active','Historical source estimate; do not normalize beyond the stated range.'),
('C0806','person','P0004','khuzestan_governor_1314','In Dhu al-Qa''dah 1314 AH Abdollah Khan Sardar Akram became governor and military head of Khuzestan, replacing Ahmad Khan Ala al-Dowleh.','confirmed','active','Editor and later Gharagozloo history corroborate this appointment.'),
('C0807','person','P0004','title_distribution_family','At the time of the 1314 AH Khuzestan appointment, Hossein Qoli Khan received his father''s former title Sa''ed al-Saltaneh and Mohtaj Ali Khan received Ejlal al-Mamalek.','confirmed','active','Title transfers are source-reported; no genealogy changes.'),
('C0808','person','P0004','royal_honor_1316','A jeweled sword was reportedly awarded to Abdollah Khan in 1316 AH in recognition of his Khuzestan service.','confirmed','active','Corroborated in the Gharagozloo history; retained here as a mature-career honor claim.'),
('C0809','person','P0004','landed_wealth','Later sources portray Abdollah Khan as a major landholder, with a source-stated figure of roughly 120 villages/properties across Hamadan, Arak and Khamseh late in life.','probable','active','The aggregate number should remain a historical estimate until estate-by-estate reconstruction.'),
('C0810','person','P0004','anti_constitutional_position','A report preserved by the editor portrays Abdollah Khan Sardar Akram as strongly opposed to the early Majles and constitutional movement in 1324 AH.','confirmed','active','Time-bounded political position; do not treat as immutable lifelong identity.'),
('C0811','person','P0004','grain_crisis_accusation','During a Hamadan grain crisis, townspeople and officials accused Abdollah Khan and other major khans of withholding grain.','confirmed','active','Accusation preserved as accusation, not established guilt.'),
('C0812','person','P0004','grain_crisis_response','Abdollah Khan later wrote to his steward indicating that he did not approve of hoarding grain.','confirmed','active','Self-defense/counter-evidence preserved alongside accusations.'),
('C0813','person','P0004','command_revoked_1325','In Muharram 1325 AH Abdollah Khan''s Amir Noyan/Sardar Akram command was abolished and his Fars military salary was stopped.','confirmed','active','Editor''s chronology.'),
('C0814','person','P0004','kurdistan_nomination_blocked','In Safar 1325 AH Abdollah Khan was nominated to govern Kurdistan, but the Majles blocked the appointment.','confirmed','active','Political reversal during constitutional period.'),
('C0815','person','P0004','fadavi_pay_crisis','On 27 Rabi II 1326 AH a Fadavi Regiment wage protest led to Abdollah Khan''s War Ministry questioning and dismissal from government office.','confirmed','active','Editor''s chronology.'),
('C0816','person','P0004','amir_nezam_restoration','After Mohammad Ali Shah''s coup against the constitutional order, Abdollah Khan was restored to royal favor and granted the title Amir Nezam.','confirmed','active','Royalist restoration.'),
('C0817','person','P0004','tabriz_campaign','In Ramadan 1326 AH Abdollah Khan Amir Nezam commanded Hamadan regiments in the royalist campaign against constitutionalist Tabriz.','confirmed','active','Politically sensitive event stated without advocacy.'),
('C0818','person','P0004','finance_minister','Abdollah Khan served as Minister of Finance in 1327 AH and later again in the Ayn al-Dowleh cabinet in 1333 AH.','confirmed','active','Cabinet service.'),
('C0819','person','P0004','mosaddegh_criticism','Mohammad Mosaddegh later criticized Amir Nezam''s competence as finance minister and alleged that he used divination when considering appointments.','confirmed','active','Retrospective criticism attributed to Mosaddegh, not adopted as archive judgment.'),
('C0820','person','P0004','kurdistan_governor','The editor identifies Abdollah Khan as governor of Kurdistan by 1328 AH, though the exact start date is uncertain.','probable','active','Keep date uncertainty explicit.'),
('C0821','person','P0004','kordabad_excavation_investigation','In 1328 AH officials investigated excavations on Abdollah Khan''s Kordabad property; reports accused him of extensive digging for antiquities, while he claimed to have purchased government authorization for 3,000 tomans.','confirmed','active','Investigation and competing claims preserved; no finding of guilt asserted.'),
('C0822','person','P0004','salar_al_dowleh_episode','During the Salar al-Dowleh crisis around 1330 AH Abdollah Khan first associated his force with Salar al-Dowleh while remaining somewhat separate, then joined government forces under Farmanfarma after Salar retreated.','confirmed','active','Sequence preserved separately from the editor''s harsher interpretation.'),
('C0823','person','P0004','third_majles_election','On 28 Rajab 1332 AH Abdollah Khan was elected as one of Hamadan''s deputies to the Third Majles with a source-reported 4,829 votes.','confirmed','active','Major political reversal from earlier anti-Majles stance.'),
('C0824','person','P0004','death','Abdollah Khan died on Sunday, 23 Sha''ban 1334 AH (1916 CE), after a partial stroke while the First World War had reached Hamadan.','confirmed','active','Editor''s biographical statement.'),
('C0825','person','P0004','political_trajectory','Abdollah Khan''s later career moved from early opposition to the constitutional movement and royalist military service to eventual election as a Third Majles deputy.','probable','active','Archive synthesis derived from dated events; not a direct quotation.');

-- ---------------------------------------------------------------------------
-- Claim citations
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0800','X0800','supports'),
('C0801','X0801','supports'),
('C0802','X0801','supports'),
('C0803','X0801','supports'),
('C0804','X0802','supports'),
('C0805','X0802','supports'),
('C0806','X0802','supports'),
('C0807','X0802','supports'),
('C0808','X0802','supports'),
('C0809','X0803','supports'),
('C0810','X0803','supports'),
('C0811','X0803','supports'),
('C0812','X0803','supports'),
('C0813','X0803','supports'),
('C0814','X0803','supports'),
('C0815','X0804','supports'),
('C0816','X0804','supports'),
('C0817','X0804','supports'),
('C0818','X0805','supports'),
('C0818','X0806','supports'),
('C0819','X0807','supports'),
('C0820','X0805','supports'),
('C0821','X0805','supports'),
('C0822','X0805','supports'),
('C0823','X0806','supports'),
('C0824','X0806','supports'),
('C0825','X0803','supports'),
('C0825','X0804','supports'),
('C0825','X0806','supports');

-- ---------------------------------------------------------------------------
-- Direct entity provenance
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO entity_citations(entity_citation_id,entity_type,entity_id,citation_id,support_type,notes) VALUES
('EC0800','event','E0231','X0801','supports','1310 AH detention and imprisonment.'),
('EC0801','event','E0233','X0802','supports','Fars deputy governorship and Shiraz unrest.'),
('EC0802','event','E0234','X0802','supports','1314 AH Khuzestan governorship.'),
('EC0803','event','E0237','X0804','supports','Restoration to favor and Amir Nezam title.'),
('EC0804','event','E0239','X0805','supports','Finance-ministry service.'),
('EC0805','event','E0242','X0806','supports','Third Majles election.'),
('EC0806','event','E0243','X0806','supports','Death date and circumstances.');

-- ---------------------------------------------------------------------------
-- Open research questions
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO research_questions(question_id,question,status,priority,notes) VALUES
('Q0080','What was Abdollah Khan Amir Nezam''s exact birth date or approximate birth year?','open','high','The editor explicitly states that his birth date is not known.'),
('Q0081','What is the best source-level reconciliation of the motives for Abdollah Khan''s 1310 AH imprisonment and the reported 7,000-toman release payment?','open','high','Preserve competing political, religious and financial explanations rather than collapsing them.'),
('Q0082','What were the exact start and end dates of Abdollah Khan''s Kurdistan governorship?','open','medium','The editor identifies him as governor by 1328 AH, but the beginning remains unclear.'),
('Q0083','Can the reported c.120 Abdollah Khan estates be reconstructed property-by-property from deeds, tax records, family papers and later inheritance accounts?','open','high','Do not treat the aggregate source estimate as a completed estate inventory.'),
('Q0084','What was the final administrative or legal outcome of the 1328 AH Kordabad antiquities excavation investigation?','open','medium','Current evidence preserves allegations, Abdollah Khan''s claimed authorization and the government inquiry, but not a final adjudication.'),
('Q0085','What exact dates and cabinets correspond to Abdollah Khan''s two terms as Minister of Finance?','open','medium','The introduction gives cabinet-level chronology; a later cabinet reconciliation can normalize exact start/end dates.');

-- ---------------------------------------------------------------------------
-- Dossier roll-up
-- ---------------------------------------------------------------------------
UPDATE person_dossiers
SET file_path='docs/dossiers/P0004_ABDOLLAH_KHAN_AMIR_NEZAM.md',
    status='multi_source_historical_enrichment_v2.8.5',
    evidence_policy='Curated narrative must be derived from cited archive claims/events; accusations, political viewpoints and retrospective criticism remain explicitly attributed.',
    generated_from_migration='0038',
    updated_at='2026-08-04T01:15:00Z'
WHERE person_id='P0004';

-- ---------------------------------------------------------------------------
-- Change log
-- ---------------------------------------------------------------------------
INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-04T01:15:00Z','migration','0038','apply','Added Abdollah Khan mature-career and constitutional-era historical enrichment, including death date; canonical genealogy unchanged.');

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-04T01:15:00Z','person','P0004','update','Updated Abdollah Khan death date and Explorer summary through 1334 AH / 1916 CE.');

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-04T01:15:00Z','event','E0230-E0243','insert','Added Fars, Hamadan, Khuzestan, constitutional-era, cabinet, Majles and death events.');

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-04T01:15:00Z','database','archive','release','Prepared v2.8.5 Abdollah Khan mature-career enrichment checkpoint.');

DROP TABLE _ak_place_map;
