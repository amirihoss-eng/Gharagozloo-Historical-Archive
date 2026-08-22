-- Canonicalize Amirzadeh Khanom and Akhtar Piran from verified family evidence.
PRAGMA foreign_keys = ON;

INSERT OR IGNORE INTO persons(person_id,preferred_name_en,preferred_name_fa,sex,birth_date_text,death_date_text,branch,summary,verification_status,created_at,updated_at) VALUES
('P0182','Amirzadeh Khanom Gharagozloo','امیرزاده خانم قراگزلو','F',NULL,NULL,'Ashiqloo / Hesam al-Molk','Daughter of Mohammad-Hossein Khan Hesam al-Molk Gharagozloo P0022; wife of Mahmoud Khan Piran, Enayat al-Molk Hamadani; mother of Akhtar Piran P0183. Her identity and marriage are preserved in family-verified photograph A0240, and her motherhood of Akhtar is confirmed by direct archive-owner testimony based on consultation with older family members.','confirmed','2026-08-22T00:00:00Z','2026-08-22T00:00:00Z'),
('P0183','Akhtar Piran','اختر پیران','F',NULL,NULL,'Piran / Amiri maternal line','Daughter of Amirzadeh Khanom Gharagozloo P0182; spouse of Gholamhossein Khan Amiri Gharagozloo P0008; mother of Dr. Alireza Amiri Gharagozloo P0009 and paternal grandmother of archive owner Hossein Gholi Amiri Gharagozloo P0010. Immediate relationships are confirmed by direct archive-owner family testimony.','confirmed','2026-08-22T00:00:00Z','2026-08-22T00:00:00Z');

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0182','Amirzadeh Khanom','en','short-form',0),('P0182','امیرزاده خانم','fa','short-form',0),
('P0183','Akhtar Piran','en','canonical',1),('P0183','اختر پیران','fa','canonical',1);

INSERT OR IGNORE INTO relationships(relationship_id,person1_id,relationship_type,person2_id,notes,verification_status) VALUES
('R0164','P0022','parent_of','P0182','Family-verified photograph A0240 identifies Amirzadeh Khanom as a daughter of Hossein Khan Hesam al-Molk I P0022.','confirmed'),
('R0165','P0182','parent_of','P0183','Direct archive-owner family testimony dated 2026-08-22, confirmed after consultation with older family members: Amirzadeh Khanom was the mother of Akhtar Piran.','confirmed'),
('R0166','P0183','spouse_of','P0008','Direct archive-owner family testimony identifies Akhtar Piran as the spouse of Gholamhossein Khan Amiri Gharagozloo P0008.','confirmed'),
('R0167','P0183','parent_of','P0009','Direct archive-owner family testimony identifies Akhtar Piran as the mother of Dr. Alireza Amiri Gharagozloo P0009 and therefore the paternal grandmother of P0010.','confirmed');

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0240','P0182','subject','Family-verified photographs of Amirzadeh Khanom; canonical identity established in migration 0056.');
UPDATE artifacts SET notes='VERIFIED family identification. Linked to canonical P0182 in migration 0056; caption identifies her as daughter of P0022 and wife of Mahmoud Khan Piran / Enayat al-Molk.' WHERE artifact_id='A0240';

INSERT OR IGNORE INTO citations(citation_id,source_id,page_printed,page_file,locator_text,quoted_text,notes) VALUES
('X1516','S0204','61',NULL,'Family-verified photographs and caption for Amirzadeh Khanom',NULL,'Supports Amirzadeh Khanom P0182 as daughter of P0022 and identifies her as wife of Mahmoud Khan Piran / Enayat al-Molk.'),
('X1517','S0002',NULL,NULL,'Direct archive-owner family testimony, 2026-08-22 — Amirzadeh Khanom and Akhtar Piran maternal line',NULL,'Hossein Gholi Amiri Gharagozloo confirms, after consultation with older family members, that Amirzadeh Khanom was the mother of his paternal grandmother Akhtar Piran. The same family context identifies Akhtar as spouse of P0008 and mother of P0009.');

INSERT OR IGNORE INTO claims(claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes) VALUES
('C1554','person','P0182','parentage','Amirzadeh Khanom P0182 is a daughter of Mohammad-Hossein Khan Hesam al-Molk Gharagozloo P0022.','confirmed','active','Family-verified photograph caption.'),
('C1555','person','P0183','parentage','Akhtar Piran P0183 is a daughter of Amirzadeh Khanom Gharagozloo P0182.','confirmed','active','Direct family testimony confirmed through older family members.'),
('C1556','person','P0183','spouse','Akhtar Piran P0183 is the spouse of Gholamhossein Khan Amiri Gharagozloo P0008.','confirmed','active','Direct archive-owner family testimony.'),
('C1557','person','P0009','maternal_parentage','Dr. Alireza Amiri Gharagozloo P0009 is a son of Akhtar Piran P0183.','confirmed','active','Direct archive-owner family testimony.');
INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C1554','X1516','supports'),('C1555','X1517','supports'),('C1556','X1517','supports'),('C1557','X1517','supports');

INSERT OR IGNORE INTO entity_citations(entity_citation_id,entity_type,entity_id,citation_id,support_type,notes) VALUES
('EC1515','person','P0182','X1516','supports','Family-verified identity and paternal placement.'),
('EC1516','person','P0182','X1517','supports','Direct family testimony for motherhood of Akhtar.'),
('EC1517','person','P0183','X1517','supports','Direct family testimony for identity and immediate family placement.'),
('EC1518','relationship','R0164','X1516','supports','Family-verified photograph caption.'),
('EC1519','relationship','R0165','X1517','supports','Confirmed older-family testimony.'),
('EC1520','relationship','R0166','X1517','supports','Direct family testimony.'),
('EC1521','relationship','R0167','X1517','supports','Direct family testimony.');

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary) VALUES
('2026-08-22T00:00:00Z','person','P0182','add','Canonicalized family-verified Amirzadeh Khanom and linked A0240.'),
('2026-08-22T00:00:00Z','person','P0183','add','Added Akhtar Piran as the confirmed maternal bridge into the Amiri paternal line.'),
('2026-08-22T00:00:00Z','relationship','R0165','add','Added confirmed mother-child relationship P0182 Amirzadeh Khanom -> P0183 Akhtar Piran.'),
('2026-08-22T00:00:00Z','relationship','R0167','add','Connected Akhtar Piran P0183 to her son P0009, preserving the existing paternal line.');
INSERT OR REPLACE INTO metadata(key,value) VALUES('amiri_piran_maternal_line','Confirmed P0022 -> P0182 Amirzadeh Khanom -> P0183 Akhtar Piran -> P0009 Dr. Alireza -> P0010 Hossein Gholi.');
