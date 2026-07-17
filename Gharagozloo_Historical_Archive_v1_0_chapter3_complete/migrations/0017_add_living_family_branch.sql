-- Archive v2.5 — Living Family integration
-- Adds the immediate living descendants and spouses supplied directly by
-- Hossein Gholi Amiri Gharagozloo on 2026-07-14.
-- This migration does not modify or delete any existing historical record.

INSERT OR IGNORE INTO sources(
    source_id, short_title, full_title, author, publication_year,
    source_type, file_name, notes
) VALUES (
    'S0002',
    'Family testimony — Hossein Gholi Amiri Gharagozloo',
    'Direct family testimony supplied by Hossein Gholi Amiri Gharagozloo for the Gharagozloo Historical Archive',
    'Hossein Gholi Amiri Gharagozloo',
    '2026',
    'family testimony',
    NULL,
    'Primary family-source record for the modern Amiri Gharagozloo branch. Living-person details are intentionally limited to names and immediate relationships.'
);

INSERT OR IGNORE INTO citations(
    citation_id, source_id, page_printed, page_file, locator_text, quoted_text, notes
) VALUES (
    'X0087',
    'S0002',
    NULL,
    NULL,
    'Conversation testimony dated 2026-07-14: immediate family of Dr. Alireza and Hossein Gholi Amiri Gharagozloo',
    NULL,
    'Supports the names and immediate parent/spouse relationships inserted by migration 0017.'
);

INSERT OR IGNORE INTO persons(
    person_id, preferred_name_en, preferred_name_fa, sex,
    birth_date_text, death_date_text, branch, summary,
    verification_status, created_at, updated_at
) VALUES
('P0076','Yassaman Amiri Gharagozloo',NULL,'F',NULL,NULL,'Amiri branch',
 'Daughter of Dr. Alireza Amiri Gharagozloo and sister of Hossein Gholi Amiri Gharagozloo. Spouse of Amir Navab; mother of Yalda and Aryana Navab.',
 'confirmed','2026-07-14T00:00:00Z','2026-07-14T00:00:00Z'),
('P0077','Amir Navab',NULL,'M',NULL,NULL,'Living family / Navab',
 'Spouse of Yassaman Amiri Gharagozloo and father of Yalda and Aryana Navab.',
 'confirmed','2026-07-14T00:00:00Z','2026-07-14T00:00:00Z'),
('P0078','Yalda Navab',NULL,'F',NULL,NULL,'Living family / Navab',
 'Daughter of Yassaman Amiri Gharagozloo and Amir Navab.',
 'confirmed','2026-07-14T00:00:00Z','2026-07-14T00:00:00Z'),
('P0079','Aryana Navab',NULL,'F',NULL,NULL,'Living family / Navab',
 'Daughter of Yassaman Amiri Gharagozloo and Amir Navab.',
 'confirmed','2026-07-14T00:00:00Z','2026-07-14T00:00:00Z'),
('P0080','Roya Yaghmai',NULL,'F',NULL,NULL,'Living family / Yaghmai',
 'Spouse of Hossein Gholi Amiri Gharagozloo and mother of Raha and Saam Amiri Gharagozloo.',
 'confirmed','2026-07-14T00:00:00Z','2026-07-14T00:00:00Z'),
('P0081','Raha Amiri Gharagozloo',NULL,'F',NULL,NULL,'Amiri branch',
 'Daughter of Hossein Gholi Amiri Gharagozloo and Roya Yaghmai.',
 'confirmed','2026-07-14T00:00:00Z','2026-07-14T00:00:00Z'),
('P0082','Saam Amiri Gharagozloo',NULL,'M',NULL,NULL,'Amiri branch',
 'Son of Hossein Gholi Amiri Gharagozloo and Roya Yaghmai.',
 'confirmed','2026-07-14T00:00:00Z','2026-07-14T00:00:00Z');

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0076','Yassaman Amiri Gharagozloo','en','canonical',1),
('P0077','Amir Navab','en','canonical',1),
('P0078','Yalda Navab','en','canonical',1),
('P0079','Aryana Navab','en','canonical',1),
('P0080','Roya Yaghmai','en','canonical',1),
('P0081','Raha Amiri Gharagozloo','en','canonical',1),
('P0082','Saam Amiri Gharagozloo','en','canonical',1);

INSERT OR IGNORE INTO relationships(
    relationship_id, person1_id, relationship_type, person2_id,
    notes, verification_status
) VALUES
('R0047','P0009','parent_of','P0076','Dr. Alireza is the father of Yassaman.','confirmed'),
('R0048','P0010','sibling_of','P0076','Hossein and Yassaman are siblings.','confirmed'),
('R0049','P0076','spouse_of','P0077','Yassaman is married to Amir Navab.','confirmed'),
('R0050','P0076','parent_of','P0078','Yassaman is the mother of Yalda Navab.','confirmed'),
('R0051','P0077','parent_of','P0078','Amir Navab is the father of Yalda Navab.','confirmed'),
('R0052','P0076','parent_of','P0079','Yassaman is the mother of Aryana Navab.','confirmed'),
('R0053','P0077','parent_of','P0079','Amir Navab is the father of Aryana Navab.','confirmed'),
('R0054','P0010','spouse_of','P0080','Hossein is married to Roya Yaghmai.','confirmed'),
('R0055','P0010','parent_of','P0081','Hossein is the father of Raha Amiri Gharagozloo.','confirmed'),
('R0056','P0080','parent_of','P0081','Roya Yaghmai is the mother of Raha Amiri Gharagozloo.','confirmed'),
('R0057','P0010','parent_of','P0082','Hossein is the father of Saam Amiri Gharagozloo.','confirmed'),
('R0058','P0080','parent_of','P0082','Roya Yaghmai is the mother of Saam Amiri Gharagozloo.','confirmed');

INSERT OR IGNORE INTO claims(
    claim_id, subject_type, subject_id, predicate, object_text,
    confidence, status, notes
) VALUES
('C0152','person','P0076','is child of','Dr. Alireza Amiri Gharagozloo','confirmed','active','Direct family testimony.'),
('C0153','person','P0076','is spouse of','Amir Navab','confirmed','active','Direct family testimony.'),
('C0154','person','P0078','is child of','Yassaman Amiri Gharagozloo and Amir Navab','confirmed','active','Direct family testimony.'),
('C0155','person','P0079','is child of','Yassaman Amiri Gharagozloo and Amir Navab','confirmed','active','Direct family testimony.'),
('C0156','person','P0080','is spouse of','Hossein Gholi Amiri Gharagozloo','confirmed','active','Direct family testimony.'),
('C0157','person','P0081','is child of','Hossein Gholi Amiri Gharagozloo and Roya Yaghmai','confirmed','active','Direct family testimony.'),
('C0158','person','P0082','is child of','Hossein Gholi Amiri Gharagozloo and Roya Yaghmai','confirmed','active','Direct family testimony.');

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0152','X0087','supports'),
('C0153','X0087','supports'),
('C0154','X0087','supports'),
('C0155','X0087','supports'),
('C0156','X0087','supports'),
('C0157','X0087','supports'),
('C0158','X0087','supports');

INSERT OR IGNORE INTO entity_citations(
    entity_citation_id, entity_type, entity_id, citation_id, support_type, notes
) VALUES
('EC0101','person','P0076','X0087','supports','Direct family testimony.'),
('EC0102','person','P0077','X0087','supports','Direct family testimony.'),
('EC0103','person','P0078','X0087','supports','Direct family testimony.'),
('EC0104','person','P0079','X0087','supports','Direct family testimony.'),
('EC0105','person','P0080','X0087','supports','Direct family testimony.'),
('EC0106','person','P0081','X0087','supports','Direct family testimony.'),
('EC0107','person','P0082','X0087','supports','Direct family testimony.'),
('EC0108','relationship','R0047','X0087','supports','Direct family testimony.'),
('EC0109','relationship','R0049','X0087','supports','Direct family testimony.'),
('EC0110','relationship','R0050','X0087','supports','Direct family testimony.'),
('EC0111','relationship','R0051','X0087','supports','Direct family testimony.'),
('EC0112','relationship','R0052','X0087','supports','Direct family testimony.'),
('EC0113','relationship','R0053','X0087','supports','Direct family testimony.'),
('EC0114','relationship','R0054','X0087','supports','Direct family testimony.'),
('EC0115','relationship','R0055','X0087','supports','Direct family testimony.'),
('EC0116','relationship','R0056','X0087','supports','Direct family testimony.'),
('EC0117','relationship','R0057','X0087','supports','Direct family testimony.'),
('EC0118','relationship','R0058','X0087','supports','Direct family testimony.');

INSERT OR REPLACE INTO metadata(key,value) VALUES('archive_version','2.5.0');
INSERT OR REPLACE INTO metadata(key,value) VALUES(
    'living_family_integration',
    'Added the immediate families of Hossein Gholi and Yassaman Amiri Gharagozloo from direct family testimony.'
);
