-- Migration 0042
-- Majmooe Asaar: Fars Fiscal Administration enrichment
-- Baseline: v2.8.8 / migration 0041
--
-- Scope:
--   * Resaleh-ye Maliat-e Fars / Treatise on Fars Taxation
--   * Provincial fiscal structure, intermediary capture, tribal and khalesegi systems
--   * Darab and Laristan examples
--   * Pishkesh, tafavot-e amal, customary dues, arbitrary exactions
--   * "Baqi-ye Fars" / arrears as an accounting problem
--
-- IMPORTANT:
--   * This migration preserves Abdollah Khan's fiscal analysis as source-attributed interpretation.
--   * Historical monetary figures are stored as source figures, not audited modern accounts.
--   * Damaged OCR/names in the final arrears section are NOT normalized or guessed.
--   * No canonical genealogy relationships are changed.
--   * Transaction control is intentionally omitted because apply_migration.py owns it.

UPDATE metadata SET value='2.8.9' WHERE key='database_version';
INSERT OR REPLACE INTO metadata(key,value) VALUES('last_migration','0042');
INSERT OR REPLACE INTO metadata(key,value) VALUES('updated_at','2026-08-04T03:05:00Z');
INSERT OR REPLACE INTO metadata(key,value) VALUES(
    'historical_enrichment_checkpoint',
    'Majmooe Asaar Fars Fiscal Administration'
);

INSERT INTO sources(source_id,short_title,full_title,author,publication_year,source_type,file_name,notes)
SELECT 'S0200','Majmooe Asaar','مجموعه آثار حاجی عبدالله خان قراگوزلو امیر نظام همدانی',
       'Haji Abdollah Khan Gharagozloo; edited by Enayatollah Majidi',NULL,
       'edited primary-source collection','Majmooe Asaar - PDF.pdf',
       'Collection containing Abdollah Khan''s treatise on taxation and provincial fiscal administration in Fars.'
WHERE NOT EXISTS (SELECT 1 FROM sources WHERE source_id='S0200');

-- ---------------------------------------------------------------------------
-- Places
-- ---------------------------------------------------------------------------
CREATE TEMP TABLE _frs_place_map(place_key TEXT PRIMARY KEY, place_id TEXT NOT NULL);

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0310','Fars','فارس','province/region',NULL,
       'Province analyzed in Abdollah Khan''s fiscal treatise.'
WHERE NOT EXISTS (SELECT 1 FROM places WHERE lower(preferred_name_en)='fars' OR preferred_name_fa='فارس');
INSERT INTO _frs_place_map SELECT 'fars',place_id FROM places
WHERE lower(preferred_name_en)='fars' OR preferred_name_fa='فارس'
ORDER BY CASE WHEN place_id='L0310' THEN 0 ELSE 1 END, place_id LIMIT 1;

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0311','Darab','داراب','district',(SELECT place_id FROM _frs_place_map WHERE place_key='fars'),
       'District used by Abdollah Khan as an example of intermediary fiscal capture.'
WHERE NOT EXISTS (SELECT 1 FROM places WHERE lower(preferred_name_en)='darab' OR preferred_name_fa='داراب');
INSERT INTO _frs_place_map SELECT 'darab',place_id FROM places
WHERE lower(preferred_name_en)='darab' OR preferred_name_fa='داراب'
ORDER BY CASE WHEN place_id='L0311' THEN 0 ELSE 1 END, place_id LIMIT 1;

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0312','Laristan','لارستان','district/region',(SELECT place_id FROM _frs_place_map WHERE place_key='fars'),
       'District/region used in the treatise to illustrate khalesegi revenue and intermediary margins.'
WHERE NOT EXISTS (SELECT 1 FROM places WHERE lower(preferred_name_en)='laristan' OR preferred_name_fa='لارستان');
INSERT INTO _frs_place_map SELECT 'laristan',place_id FROM places
WHERE lower(preferred_name_en)='laristan' OR preferred_name_fa='لارستان'
ORDER BY CASE WHEN place_id='L0312' THEN 0 ELSE 1 END, place_id LIMIT 1;

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0313','Qir-o Karzin','قیر و کارزین','district',(SELECT place_id FROM _frs_place_map WHERE place_key='fars'),
       'Named among khalesegi-style fiscal districts in Fars.'
WHERE NOT EXISTS (SELECT 1 FROM places WHERE lower(preferred_name_en)='qir-o karzin' OR preferred_name_fa='قیر و کارزین');
INSERT INTO _frs_place_map SELECT 'qir_karzin',place_id FROM places
WHERE lower(preferred_name_en)='qir-o karzin' OR preferred_name_fa='قیر و کارزین'
ORDER BY CASE WHEN place_id='L0313' THEN 0 ELSE 1 END, place_id LIMIT 1;

INSERT INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes)
SELECT 'L0314','Behbahan','بهبهان','district/region',(SELECT place_id FROM _frs_place_map WHERE place_key='fars'),
       'Named among districts discussed in relation to Fars fiscal administration.'
WHERE NOT EXISTS (SELECT 1 FROM places WHERE lower(preferred_name_en)='behbahan' OR preferred_name_fa='بهبهان');
INSERT INTO _frs_place_map SELECT 'behbahan',place_id FROM places
WHERE lower(preferred_name_en)='behbahan' OR preferred_name_fa='بهبهان'
ORDER BY CASE WHEN place_id='L0314' THEN 0 ELSE 1 END, place_id LIMIT 1;

-- ---------------------------------------------------------------------------
-- Main source event
-- ---------------------------------------------------------------------------
INSERT INTO events(event_id,event_type,title,date_text,place_id,description,verification_status)
SELECT 'E0320','historical_treatise',
       'Abdollah Khan''s Treatise on Fars Taxation',
       'date not normalized',
       (SELECT place_id FROM _frs_place_map WHERE place_key='fars'),
       'Fiscal treatise analyzing how revenue moved from cultivators and tribal households through local intermediaries and provincial government, and why top-level tax relief might fail to benefit ordinary taxpayers.',
       'confirmed'
WHERE NOT EXISTS (SELECT 1 FROM events WHERE event_id='E0320');
INSERT OR IGNORE INTO event_persons(event_id,person_id,role)
VALUES('E0320','P0004','author and fiscal analyst');

-- ---------------------------------------------------------------------------
-- Citations
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO citations(citation_id,source_id,page_printed,page_file,locator_text,quoted_text,notes) VALUES
('X1200','S0200',NULL,NULL,'Treatise on Fars taxation: general fiscal chain',
 'Abdollah Khan argues that appointing a just governor is insufficient unless fiscal relations among central government, provincial government, subordinate officials and taxpayers are explicitly bounded.',
 'Core reform argument.'),
('X1201','S0200',NULL,NULL,'Treatise on Fars taxation: arbabi versus khalesegi/tribal systems',
 'The treatise distinguishes landed-property tax systems from khalesegi and tribal arrangements and describes different avenues for abuse.',
 'Administrative typology.'),
('X1202','S0200',NULL,NULL,'Darab example and tafavot-e amal',
 'The Darab example gives a combined tax and operational-difference figure around 27,000 tomans and argues that reducing the provincial demand would not necessarily reach cultivators.',
 'Source-stated fiscal example.'),
('X1203','S0200',NULL,NULL,'Khalesegi-style revenue and customary shares',
 'The treatise discusses districts including Qir-o Karzin, Laristan, Darab and Behbahan, customary shares such as ushr/khoms, and arrangements compared to leasing.',
 'Fiscal-system description.'),
('X1204','S0200',NULL,NULL,'Tribal taxation: Qashqai, Arab and Baharlu',
 'Abdollah Khan says tribal households paid customary dues through kadkhodas and subordinate chiefs and argues that reductions at higher levels might not reduce household payments.',
 'Tribal fiscal administration.'),
('X1205','S0200',NULL,NULL,'Laristan and Haji Rostam Khan',
 'The source identifies Haji Rostam Khan son of Fath Ali Khan Lari and gives large source-estimated margins above official tax, including a reported 32,000 toman tafavot-e amal payment to Fars government.',
 'Historical source figures, not audited accounts.'),
('X1206','S0200',NULL,NULL,'Customary dues versus arbitrary exactions',
 'Abdollah Khan distinguishes established principal/supplementary obligations from fines, gifts, bribes and arbitrary extractions imposed by officials.',
 'Authorial administrative judgment.'),
('X1207','S0200',NULL,NULL,'Pishkesh and intermediary capture',
 'The treatise argues that abolishing or reducing the governor''s pishkesh to Tehran would not necessarily reduce the burden borne by cultivators because lower-level customary margins could remain intact.',
 'Fiscal-incidence argument.'),
('X1208','S0200',NULL,NULL,'Maqdum and muayyan / bounded and defined fiscal relations',
 'Abdollah Khan argues that principal and supplementary obligations and the dealings among administrative layers should be made limited, explicit and defined.',
 'Core reform principle.'),
('X1209','S0200',NULL,NULL,'Baqi-ye Fars / arrears',
 'The source explains that some recorded Fars arrears could consist of tax already collected from taxpayers but spent by subordinate officials before remittance.',
 'Accounting interpretation; damaged final names/amounts excluded.');

-- ---------------------------------------------------------------------------
-- Claims
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO claims(claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes) VALUES
('C1200','person','P0004','fars_fiscal_treatise','Abdollah Khan authored a distinct treatise analyzing taxation and provincial fiscal administration in Fars.','confirmed','active','Source-work claim.'),
('C1201','event','E0320','fiscal_chain','The treatise analyzes revenue movement through a chain of central government, provincial governor, subordinate officials or tribal authorities, and cultivators/households.','confirmed','active','Administrative structure.'),
('C1202','event','E0320','good_governor_insufficient','Abdollah Khan argues that appointing an intelligent or just governor is insufficient unless relationships among fiscal layers are formally bounded and defined.','confirmed','active','Core reform argument.'),
('C1203','event','E0320','arbabi_vs_khalesegi','The treatise distinguishes landed/arbabi tax systems from khalesegi and tribal fiscal systems.','confirmed','active','Administrative typology.'),
('C1204','event','E0320','arbabi_abuse_channels','In landed-property systems, Abdollah Khan says abuse more often entered through bribes, gifts, fines and fabricated charges than through formal reassessment known to landowners.','confirmed','active','Authorial analysis.'),
('C1205','place',(SELECT place_id FROM _frs_place_map WHERE place_key='darab'),'darab_total_estimate','The Darab example gives tax plus tafavot-e amal at roughly twenty-seven thousand tomans.','confirmed','active','Source-stated figure.'),
('C1206','place',(SELECT place_id FROM _frs_place_map WHERE place_key='darab'),'relief_capture','Abdollah Khan argues that cutting the provincial demand on Darab would not automatically reduce what cultivators paid; the benefit could be retained by the district governor.','confirmed','active','Fiscal-incidence analysis.'),
('C1207','event','E0320','khalesegi_districts','Qir-o Karzin, Laristan, Darab and Behbahan are among districts cited in discussion of khalesegi-style fiscal arrangements.','confirmed','active','Named examples.'),
('C1208','event','E0320','customary_shares','The treatise discusses customary agricultural shares such as ushr and khoms, and in some contexts fixed dues associated with productive assets such as date palms.','confirmed','active','Historical tax categories.'),
('C1209','event','E0320','lease_comparison','Abdollah Khan compares some local revenue arrangements to leasing, where an administrator committed to pay above the formal assessment and sought profit through greater cultivation/output.','confirmed','active','Authorial institutional comparison.'),
('C1210','event','E0320','no_arbitrary_rate_increase','He argues that a customary one-tenth levy should not simply be converted to one-fifth under the pretext of raising more revenue.','confirmed','active','Authorial limit on extraction.'),
('C1211','event','E0320','tribal_examples','Qashqai, Arab and Baharlu groups are explicitly cited in discussion of tribal household taxation through kadkhodas and subordinate chiefs.','confirmed','active','Named tribal examples.'),
('C1212','event','E0320','tribal_relief_capture','Abdollah Khan argues that reducing state demands on tribal leadership would not necessarily reduce what ordinary tribal households paid.','confirmed','active','Fiscal-incidence analysis.'),
('C1213','place',(SELECT place_id FROM _frs_place_map WHERE place_key='laristan'),'haji_rostam_identity','The source identifies Haji Rostam Khan as son of Fath Ali Khan Lari in the Laristan fiscal example.','confirmed','active','Do not create canonical person record until identity reconciliation.'),
('C1214','place',(SELECT place_id FROM _frs_place_map WHERE place_key='laristan'),'haji_rostam_margin','The source estimates Haji Rostam Khan''s revenue above official government tax at roughly fifty to eighty thousand tomans.','confirmed','active','Historical source estimate, not audited account.'),
('C1215','place',(SELECT place_id FROM _frs_place_map WHERE place_key='laristan'),'laristan_tafavot','The source reports roughly thirty-two thousand tomans paid to the Fars government as tafavot-e amal in the Laristan example.','confirmed','active','Historical source figure.'),
('C1216','place',(SELECT place_id FROM _frs_place_map WHERE place_key='laristan'),'laristan_incidence','Abdollah Khan uses the Laristan case to argue that shifting revenue between the provincial governor and local administrator does not necessarily benefit cultivators.','confirmed','active','Fiscal-incidence argument.'),
('C1217','event','E0320','customary_vs_arbitrary','Abdollah Khan distinguishes customary principal and supplementary fiscal obligations from arbitrary fines and extractions.','confirmed','active','Authorial administrative distinction.'),
('C1218','event','E0320','peasant_complaint_cause','He attributes many cultivator complaints to excessive additional demands, fines and invented exactions imposed beyond customary obligations.','confirmed','active','Authorial interpretation of complaints.'),
('C1219','event','E0320','pishkesh_range','The treatise discusses Fars governors paying pishkesh on the order of roughly fifty to one hundred thousand tomans.','confirmed','active','Source-stated magnitude.'),
('C1220','event','E0320','pishkesh_not_root_cause','Abdollah Khan argues that pishkesh to Tehran was not by itself the root cause of lower-level exactions because customary intermediary margins could remain even if pishkesh disappeared.','confirmed','active','Fiscal-incidence argument.'),
('C1221','event','E0320','top_level_relief_not_enough','Abolishing a payment at the top of the fiscal chain does not, in Abdollah Khan''s analysis, guarantee relief at the bottom.','confirmed','active','Archive phrasing of explicit argument.'),
('C1222','event','E0320','bounded_defined_relations','His reform principle is that principal and supplementary obligations and dealings between each administrative layer should be explicitly limited and defined.','confirmed','active','Core reform principle.'),
('C1223','event','E0320','predictability_over_blanket_cut','The treatise emphasizes predictable obligations and constrained discretionary authority more than a blanket reduction of all customary taxation.','probable','active','Archive synthesis of repeated explicit arguments.'),
('C1224','event','E0320','baqi_definition','Abdollah Khan explains that some "baqi-ye Fars" arrears could represent revenue already collected from taxpayers but spent by subordinate officials before remittance.','confirmed','active','Accounting interpretation.'),
('C1225','event','E0320','arrears_not_taxpayer_default','Recorded arrears therefore did not necessarily mean that cultivators themselves had failed to pay.','confirmed','active','Direct implication stated in source discussion.'),
('C1226','event','E0320','accounting_can_hide_diversion','The treatise shows that provincial accounting categories could conceal diversion or non-remittance at intermediary levels.','probable','active','Archive synthesis; damaged final OCR names excluded.'),
('C1227','person','P0004','fiscal_analytical_style','In the Fars treatise Abdollah Khan focuses on incentives, intermediary capture, predictable rules, and the difference between formal liability and actual fiscal incidence.','probable','active','Archive synthesis based on the treatise''s recurring logic.');

-- ---------------------------------------------------------------------------
-- Claim-citation links
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C1200','X1200','supports'),
('C1201','X1200','supports'),
('C1202','X1200','supports'),
('C1203','X1201','supports'),
('C1204','X1201','supports'),
('C1205','X1202','supports'),
('C1206','X1202','supports'),
('C1207','X1203','supports'),
('C1208','X1203','supports'),
('C1209','X1203','supports'),
('C1210','X1203','supports'),
('C1211','X1204','supports'),
('C1212','X1204','supports'),
('C1213','X1205','supports'),
('C1214','X1205','supports'),
('C1215','X1205','supports'),
('C1216','X1205','supports'),
('C1217','X1206','supports'),
('C1218','X1206','supports'),
('C1219','X1207','supports'),
('C1220','X1207','supports'),
('C1221','X1207','supports'),
('C1222','X1208','supports'),
('C1223','X1206','supports'),
('C1223','X1208','supports'),
('C1224','X1209','supports'),
('C1225','X1209','supports'),
('C1226','X1209','supports'),
('C1227','X1200','supports'),
('C1227','X1207','supports'),
('C1227','X1208','supports');

-- ---------------------------------------------------------------------------
-- Direct provenance
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO entity_citations(entity_citation_id,entity_type,entity_id,citation_id,support_type,notes) VALUES
('EC1200','event','E0320','X1200','supports','Fars fiscal treatise and central reform argument.'),
('EC1201','place',(SELECT place_id FROM _frs_place_map WHERE place_key='darab'),'X1202','supports','Darab fiscal example.'),
('EC1202','place',(SELECT place_id FROM _frs_place_map WHERE place_key='laristan'),'X1205','supports','Laristan / Haji Rostam Khan example.'),
('EC1203','event','E0320','X1207','supports','Pishkesh and intermediary-capture argument.'),
('EC1204','event','E0320','X1209','supports','Baqi-ye Fars accounting interpretation.');

-- ---------------------------------------------------------------------------
-- Research questions
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO research_questions(question_id,question,status,priority,notes) VALUES
('Q0120','What is the exact manuscript title and date of Abdollah Khan''s Fars taxation treatise?','open','high','Preserve current work boundary but do not invent a date.'),
('Q0121','Can the Darab figure of roughly 27,000 tomans and the Laristan figures of 50,000–80,000 tomans and 32,000 tomans be corroborated from contemporary provincial fiscal records?','open','medium','Current values remain source-stated figures.'),
('Q0122','Who exactly were Haji Rostam Khan and Fath Ali Khan Lari in Laristan administration, and do matching canonical person records already exist?','open','high','Reconcile before creating person IDs.'),
('Q0123','How were tafavot-e amal and pishkesh defined in Fars administrative practice across the period of this treatise?','open','medium','Need contemporaneous fiscal/legal sources to distinguish customary usage from Abdollah Khan''s analytical framing.'),
('Q0124','Can the damaged final baqi-ye Fars section be recovered from a cleaner scan, manuscript, or alternate edition so individual names and amounts can be safely extracted?','open','high','Do not normalize OCR-damaged names or figures from the current scan.'),
('Q0125','How do Abdollah Khan''s claims about Qashqai, Arab and Baharlu taxation compare with tribal fiscal records and other contemporary accounts?','open','medium','Useful for separating a provincial administrator''s model from actual practice across groups.'),
('Q0126','Can the institutional distinction Abdollah Khan draws between arbabi, khalesegi and tribal fiscal systems be mapped to formal Qajar administrative categories in other sources?','open','medium','Comparative archival research target.');

-- ---------------------------------------------------------------------------
-- Change log
-- ---------------------------------------------------------------------------
INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-04T03:05:00Z','migration','0042','apply','Added Majmooe Asaar Fars Fiscal Administration historical enrichment; canonical genealogy unchanged.');

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-04T03:05:00Z','event','E0320','insert','Added Abdollah Khan''s Fars taxation treatise as a distinct historical-analysis event.');

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-04T03:05:00Z','claim','C1200-C1227','insert','Added cited claims on Fars taxation, intermediary capture, tribal and khalesegi systems, pishkesh, tafavot-e amal, arbitrary exactions, and arrears.');

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-04T03:05:00Z','database','archive','release','Prepared v2.8.9 Fars Fiscal Administration enrichment checkpoint.');

DROP TABLE _frs_place_map;
