-- Chapter 1: origins and historical development through the Zand period.
-- Printed pages 11-54.
-- Evidence policy: narrative text first; author inference and competing origin theories
-- are explicitly classified and are not flattened into established genealogy.

INSERT OR IGNORE INTO citations(
    citation_id,source_id,page_printed,page_file,locator_text,quoted_text,notes
) VALUES
('X0069','S0001','11-19',NULL,'Chapter 1, section 1-1: tribal origins and competing theories',NULL,'Textual discussion of origin traditions and historiography.'),
('X0070','S0001','20-24',NULL,'Chapter 1, section 1-2-1: Gharagozloo in the Seljuk period',NULL,'Narrative and quoted historical-source evidence.'),
('X0071','S0001','25-29',NULL,'Chapter 1, section 1-2-2: Timurid-period traditions',NULL,'Narrative-text evidence with explicit uncertainty.'),
('X0072','S0001','29-43',NULL,'Chapter 1, section 1-2-3: Safavid period',NULL,'Narrative and quoted historical-source evidence.'),
('X0073','S0001','43-46',NULL,'Chapter 1, section 1-2-4: fall of the Safavids to the death of Nader Shah',NULL,'Narrative and quoted historical-source evidence.'),
('X0074','S0001','46-51',NULL,'Chapter 1, section 1-2-5: alliance with the Zands',NULL,'Narrative and quoted historical-source evidence.'),
('X0075','S0001','51-54',NULL,'Chapter 1, section 1-3: family genealogy and historical cautions',NULL,'Narrative discussion of genealogy and evidentiary limits.');

INSERT OR IGNORE INTO organizations(
    organization_id,preferred_name_en,preferred_name_fa,organization_type,
    parent_organization_id,date_text,description,verification_status
) VALUES
('ORG0201','Oghuz','اغوز / غز','tribe',NULL,NULL,'Broad Turkic tribal grouping discussed in the origin chapter.','confirmed'),
('ORG0202','Bozok','بوزوق','tribal_branch','ORG0201',NULL,'Major Oghuz division used in the author''s origin discussion.','confirmed'),
('ORG0203','Bigdili','بیگدلی','tribal_branch','ORG0202',NULL,'Oghuz branch to which the author considers a Gharagozloo connection probable.','confirmed'),
('ORG0204','Shamlu','شاملو','tribe',NULL,NULL,'Tribal confederation with which several authors associate the Gharagozloos.','confirmed'),
('ORG0205','Qizilbash','قزلباش','other',NULL,NULL,'Safavid military-political confederation in which the Gharagozloos are described as participating.','confirmed'),
('ORG0206','Zand alliance','ائتلاف زندیه','other',NULL,'mid-12th century AH','Political-military alliance supporting Karim Khan Zand.','confirmed');

INSERT OR IGNORE INTO organization_names(
    organization_id,name_text,language,name_type,is_preferred
) VALUES
('ORG0201','Oghuz','en','preferred',1),
('ORG0201','Ghuzz','en','alias',0),
('ORG0201','غز','fa','alias',0),
('ORG0202','Bozok','en','preferred',1),
('ORG0203','Bigdili','en','preferred',1),
('ORG0203','Bigdeli','en','alias',0),
('ORG0204','Shamlu','en','preferred',1),
('ORG0205','Qizilbash','en','preferred',1);

INSERT OR IGNORE INTO places(
    place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes
) VALUES
('L0036','Ray','ری','city',NULL,'Seljuk and Khwarazmian conflict setting.'),
('L0037','Kahran Fortress','قلعه کهران','fortress',NULL,'Fortress near the Aras associated with Tughril III''s imprisonment.'),
('L0038','Balkh','بلخ','city/region',NULL,'Timurid-Safavid conflict setting.'),
('L0039','Gharjistan','غرجستان','region',NULL,'Area in which Amir Jafar Ali Gharagoz served Mohammad-Zaman Mirza.'),
('L0040','Kerman','کرمان','province/city',NULL,'Governorship of Ebrahim Khan Gharagozloo in 1129 AH.'),
('L0041','Tabriz','تبریز','city',NULL,'Site of resistance to Afghan forces in 1138 AH.'),
('L0042','Zahab','زهاب','region',NULL,'Governorship granted to Mohammad-Hossein Khan under the Zands.'),
('L0043','Yazd','یزد','city/province',NULL,'Zand-era military operations involving Gharagozloo forces.'),
('L0044','Kohgiluyeh','کهگیلویه','region',NULL,'Zand-era mission led by Mohammad-Hossein Khan.'),
('L0045','Qazvin','قزوین','city',NULL,'Zand-Qajar conflict involving Gharagozloo forces.');

INSERT OR IGNORE INTO persons(
    person_id,preferred_name_en,preferred_name_fa,sex,birth_date_text,death_date_text,
    branch,summary,verification_status,created_at,updated_at
) VALUES
('P0066','Amir Gharagoz (Seljuk period)','امیر قراگوز','M',NULL,NULL,NULL,
 'Commander named in the late Seljuk narrative; associated with Sultan Tughril III and the conspiracy against Qizil Arslan.',
 'confirmed','2026-07-12T01:00:00Z','2026-07-12T01:00:00Z'),
('P0067','Badr al-Din Gharagoz','بدرالدین قراگوز','M',NULL,NULL,NULL,
 'Governor of Hamadan named in the struggles following the death of Qizil Arslan.',
 'confirmed','2026-07-12T01:00:00Z','2026-07-12T01:00:00Z'),
('P0068','Amir Jafar Ali Gharagoz','امیر جعفرعلی قراگوز','M',NULL,'925 AH',NULL,
 'Veteran commander serving Mohammad-Zaman Mirza; killed while acting as an envoy in 925 AH. His connection to the later Gharagozloos is explicitly uncertain.',
 'confirmed','2026-07-12T01:00:00Z','2026-07-12T01:00:00Z'),
('P0069','Amir Mohammad Gharagoz','امیر محمد قراگوز','M',NULL,NULL,NULL,
 'Named among the Qizilbash officers accompanying Humayun from Qandahar toward Kabul in 952 AH.',
 'confirmed','2026-07-12T01:00:00Z','2026-07-12T01:00:00Z'),
('P0070','Ebrahim Khan Gharagozloo (Safavid governor)','ابراهیم خان قراگوزلو','M',NULL,NULL,NULL,
 'Safavid official who served as beglerbeg of Astarabad, Gilan, and Mazandaran and was appointed governor of Kerman in 1129 AH.',
 'confirmed','2026-07-12T01:00:00Z','2026-07-12T01:00:00Z'),
('P0071','Kalb Ali Qasem Aqa Gharagozloo','کلبعلی قاسم آقا قراگوزلو','M',NULL,NULL,NULL,
 'Leader named in a report of resistance to Afghan forces near Tabriz in 1138 AH.',
 'confirmed','2026-07-12T01:00:00Z','2026-07-12T01:00:00Z'),
('P0072','Shahbaz Khan Gharagozloo','شهبازخان قراگوزلو','M',NULL,'between 1161 and 1163 AH?',NULL,
 'Gharagozloo leader who joined Karim Khan Zand with a force described as two thousand men.',
 'confirmed','2026-07-12T01:00:00Z','2026-07-12T01:00:00Z'),
('P0073','Nasrollah Khan Gharagozloo','نصرالله خان قراگوزلو','M',NULL,NULL,NULL,
 'Influential Zand-era Gharagozloo commander and political actor.',
 'confirmed','2026-07-12T01:00:00Z','2026-07-12T01:00:00Z');

INSERT OR IGNORE INTO events(
    event_id,event_type,title,date_text,place_id,description,verification_status
) VALUES
('E0063','political-military','Conspiracy against Qizil Arslan',NULL,NULL,
 'Sultan Tughril III asked Amir Gharagoz to kill Qizil Arslan during a reception, then abandoned the plan; after disclosure, Gharagoz was blinded.',
 'confirmed'),
('E0064','urban conflict','Fighting in Hamadan after Qizil Arslan''s death','588 AH?','L0001',
 'Badr al-Din Gharagoz and the Atabeg faction fought supporters of Majd al-Dowleh in Hamadan; the narrative says a severe earthquake interrupted the fighting.',
 'confirmed'),
('E0065','military service','Amir Jafar Ali serves Mohammad-Zaman Mirza','922-925 AH','L0038',
 'Amir Jafar Ali Gharagoz appears among the commanders of Mohammad-Zaman Mirza in the struggles around Balkh and Gharjistan.',
 'confirmed'),
('E0066','death','Killing of Amir Jafar Ali Gharagoz','925 AH','L0039',
 'Sent as an envoy during negotiations, Amir Jafar Ali was killed by Ebrahim Sultan Musellu.',
 'confirmed'),
('E0067','military expedition','Amir Mohammad Gharagoz accompanies Humayun','952 AH',NULL,
 'Amir Mohammad Gharagoz is named among officers moving with Humayun from Qandahar toward Kabul.',
 'confirmed'),
('E0068','appointment','Ebrahim Khan appointed governor of Kerman','1129 AH','L0040',
 'After earlier governorships in Astarabad, Gilan, and Mazandaran, Ebrahim Khan Gharagozloo was appointed to Kerman.',
 'confirmed'),
('E0069','defense','Resistance to Afghan forces near Tabriz','1138 AH / 1725 CE','L0041',
 'A report names Kalb Ali Qasem Aqa Gharagozloo as a leader of defenders who took refuge in a small fortress and were later killed after a false promise of safety.',
 'confirmed'),
('E0070','military conflict','Defeat of Sarfaraz Beg Khodabandehlu after Nader Shah''s death',NULL,'L0001',
 'Gharagozloo forces defended their Hamadan holdings, defeated Sarfaraz Beg, and destroyed his force after months of conflict.',
 'confirmed'),
('E0071','alliance','Gharagozloo alliance with Karim Khan Zand','after 1161 AH',NULL,
 'Shahbaz Khan, Mohammad-Hossein Khan, and Nasrollah Khan are associated with the Gharagozloo decision to support Karim Khan Zand.',
 'confirmed'),
('E0072','appointment','Mohammad-Hossein Khan granted government of Zahab',NULL,'L0042',
 'The Zand administration granted Mohammad-Hossein Khan authority over Zahab.',
 'confirmed'),
('E0073','military mission','Gharagozloo forces sent toward Yazd','1194 AH','L0043',
 'Nasrollah Khan and Ebrahim Khan Gharagozloo commanded forces sent by Ali-Morad Khan to assist the governor of Yazd.',
 'confirmed'),
('E0074','military mission','Mohammad-Hossein Khan sent to Kohgiluyeh','1195 AH','L0044',
 'A document records forces under Mohammad-Hossein Khan Gharagozloo being sent to Kohgiluyeh.',
 'confirmed');

INSERT OR IGNORE INTO event_persons(event_id,person_id,role) VALUES
('E0063','P0066','participant'),
('E0064','P0067','governor and commander'),
('E0065','P0068','commander'),
('E0066','P0068','envoy and victim'),
('E0067','P0069','officer'),
('E0068','P0070','appointee'),
('E0069','P0071','defender/leader'),
('E0071','P0072','tribal leader'),
('E0071','P0011','political advocate/commander'),
('E0071','P0073','political advocate/commander'),
('E0072','P0011','governor'),
('E0073','P0073','commander'),
('E0074','P0011','commander');

INSERT OR IGNORE INTO organization_memberships(
    membership_id,person_id,organization_id,membership_role,date_text,notes,verification_status
) VALUES
('OM0006','P0069','ORG0205','Qizilbash officer','952 AH',
 'Named among officers supporting Humayun; the surrounding list is dominated by Qizilbash/Shamlu figures.',
 'probable'),
('OM0007','P0072','ORG0206','allied tribal leader','after 1161 AH',
 'Joined Karim Khan Zand with Gharagozloo forces.',
 'confirmed'),
('OM0008','P0011','ORG0206','commander and political ally',NULL,
 'Named among influential Gharagozloo leaders supporting the Zand alliance.',
 'confirmed'),
('OM0009','P0073','ORG0206','commander and political ally',NULL,
 'Named among influential Gharagozloo leaders supporting the Zand alliance.',
 'confirmed');

-- Create the normalized governorship role defensively.
INSERT OR IGNORE INTO roles(
    role_id,preferred_name_en,preferred_name_fa,role_category,description
) VALUES
('ROLE0012','Governor','حاکم','government_office',
 'Provincial or urban governorship.');

-- Reinsert assignment after defensive role creation if needed.
INSERT OR IGNORE INTO person_role_assignments(
    assignment_id,person_id,role_id,organization_id,place_id,date_text,start_date_text,
    end_date_text,appointing_authority_text,notes,verification_status
) VALUES
('PRA0006','P0067','ROLE0012',NULL,'L0001',NULL,NULL,NULL,NULL,
 'Narrative identifies Badr al-Din Gharagoz as governor of Hamadan.',
 'confirmed'),
('PRA0007','P0070','ROLE0012',NULL,'L0040','1129 AH',NULL,NULL,'Safavid court',
 'Appointed governor of Kerman.',
 'confirmed');

INSERT OR IGNORE INTO claims(
    claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES
('C0117','source','S0001','origin_hypothesis',
 'The author favors an Oghuz-Turkic origin and considers a connection through Bigdili and Shamlu plausible.',
 'probable','active','Author synthesis; organizational affiliation, not a biological genealogy.'),
('C0118','source','S0001','mongol_origin_hypothesis',
 'The theory that the Gharagozloos first entered Iran as a Mongol-period group is discussed but rejected by the author.',
 'disputed','active','Rejected hypothesis preserved for historiographical transparency.'),
('C0119','source','S0001','shamlu_affiliation',
 'Several earlier writers describe the Gharagozloos as a branch or remnant of the Shamlu.',
 'possible','active','Competing scholarly opinion.'),
('C0120','source','S0001','qizilbash_affiliation',
 'The book describes the Gharagozloos as joining or belonging to the Qizilbash political-military world by the late fifteenth or early Safavid period.',
 'probable','active','Author synthesis.'),
('C0121','person','P0068','identity_connection',
 'It is uncertain whether Amir Jafar Ali Gharagoz belonged to the same Gharagozloo grouping later prominent in Hamadan.',
 'possible','active','The author explicitly preserves uncertainty.'),
('C0122','person','P0069','identity_connection',
 'Amir Mohammad Gharagoz may represent continued Gharagozloo service among Timurid or Mughal forces, but the identification is not conclusive.',
 'possible','active','Author inference.'),
('C0123','source','S0001','safavid_service',
 'Gharagozloo figures held military, court, and provincial offices under the Safavids.',
 'confirmed','active','Narrative synthesis from named examples.'),
('C0124','source','S0001','hamadan_consolidation',
 'By the eighteenth century the Gharagozloos possessed significant landed and military power in the Hamadan region.',
 'confirmed','active','Narrative synthesis.'),
('C0125','source','S0001','zand_alliance',
 'The Gharagozloos became important allies of Karim Khan Zand and participated in campaigns against his rivals.',
 'confirmed','active','Narrative and cited chronicle evidence.'),
('C0126','source','S0001','chapter_1_evidentiary_caution',
 'The chapter repeatedly distinguishes named historical actors from later genealogical reconstruction and acknowledges major gaps in continuous descent.',
 'confirmed','active','Methodological conclusion.');

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0117','X0069','supports'),
('C0118','X0069','supports'),
('C0119','X0069','supports'),
('C0120','X0069','supports'),
('C0121','X0071','supports'),
('C0122','X0072','supports'),
('C0123','X0072','supports'),
('C0124','X0073','supports'),
('C0125','X0074','supports'),
('C0126','X0075','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
    claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES
('C0117','AUTHOR_SYNTHESIS','author_inference','prefers',
 'The connection is organizational/tribal and should not be presented as a continuous family pedigree.'),
('C0118','REJECTED_HYPOTHESIS','scholarly_opinion','rejects',
 'Retained to document historiography, not as an active origin conclusion.'),
('C0119','SCHOLARLY_OPINION','scholarly_opinion','presents',
 'Attributed to earlier writers including Malcolm and others discussed by the author.'),
('C0120','AUTHOR_SYNTHESIS','author_inference','prefers',
 'Historical affiliation rather than blood descent.'),
('C0121','AUTHOR_INFERENCE','author_inference','unresolved',
 'The name Gharagoz may be personal rather than tribal.'),
('C0122','AUTHOR_INFERENCE','author_inference','unresolved',
 'Possible continuity is discussed but not proved.'),
('C0123','NARRATIVE_FACT','author_statement','supports',
 'Supported by named Safavid-period officeholders and military actors.'),
('C0124','AUTHOR_SYNTHESIS','author_statement','supports',
 'Synthesizes military and landed evidence.'),
('C0125','NARRATIVE_FACT','author_statement','supports',
 'Supported by chronicle reports and named commanders.'),
('C0126','AUTHOR_SYNTHESIS','author_statement','supports',
 'Records the chapter''s methodological caution.');

INSERT OR IGNORE INTO entity_citations(
    entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES
('EC0030','person','P0066','X0070','supports',NULL),
('EC0031','person','P0067','X0070','supports',NULL),
('EC0032','person','P0068','X0071','supports','Identity connection to later Gharagozloos remains uncertain.'),
('EC0033','person','P0069','X0072','supports','Identity connection remains provisional.'),
('EC0034','person','P0070','X0072','supports',NULL),
('EC0035','person','P0071','X0073','supports',NULL),
('EC0036','person','P0072','X0074','supports',NULL),
('EC0037','person','P0073','X0074','supports',NULL),
('EC0038','event','E0063','X0070','supports',NULL),
('EC0039','event','E0064','X0070','supports',NULL),
('EC0040','event','E0065','X0071','supports',NULL),
('EC0041','event','E0066','X0071','supports',NULL),
('EC0042','event','E0067','X0072','supports',NULL),
('EC0043','event','E0068','X0072','supports',NULL),
('EC0044','event','E0069','X0073','supports',NULL),
('EC0045','event','E0070','X0074','supports',NULL),
('EC0046','event','E0071','X0074','supports',NULL),
('EC0047','event','E0072','X0074','supports',NULL),
('EC0048','event','E0073','X0074','supports',NULL),
('EC0049','event','E0074','X0074','supports',NULL);

INSERT OR REPLACE INTO metadata(key,value) VALUES('archive_version','2.1.0');
INSERT OR REPLACE INTO metadata(key,value) VALUES('chapter_1_status','structured_mining_complete_v1');
INSERT OR REPLACE INTO metadata(key,value) VALUES(
    'chapter_1_evidence_policy',
    'Competing origin theories and author inferences remain explicitly classified; no uncertain ancient-to-modern genealogy is asserted.'
);
