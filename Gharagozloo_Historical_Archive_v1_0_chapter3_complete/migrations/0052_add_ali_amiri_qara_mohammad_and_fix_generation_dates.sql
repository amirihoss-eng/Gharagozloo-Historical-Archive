-- 0052_add_ali_amiri_qara_mohammad_and_fix_generation_dates.sql
-- Archive v2.9.9 — living Amiri branch addition + Qara Mohammad family-tradition origin.

PRAGMA foreign_keys = ON;

INSERT OR IGNORE INTO persons(
    person_id, preferred_name_en, preferred_name_fa, sex,
    birth_date_text, death_date_text, branch, summary,
    verification_status, created_at, updated_at
) VALUES (
    'P0178','Ali Amiri Gharagozloo','علی امیری قراگوزلو','M',
    NULL,NULL,'Amiri branch',
    'Son of Gholamhossein Khan Amiri Gharagozloo P0008 and brother of Dr. Alireza Amiri Gharagozloo P0009. Added from direct archive-owner family testimony; a family-verified photograph A0219 shows him with his father.',
    'confirmed','2026-08-08T00:00:00Z','2026-08-08T00:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0178','Ali Gharagozloo','en','short-form',0),
('P0178','Ali Amiri','en','short-form',0);

INSERT OR IGNORE INTO relationships(
    relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES (
    'R0160','P0008','parent_of','P0178',
    'Direct archive-owner family testimony: Gholamhossein Khan Amiri Gharagozloo had two sons, Dr. Alireza Amiri Gharagozloo P0009 and Ali Amiri Gharagozloo P0178. A0219 independently preserves a family-verified photograph of father and son.',
    'confirmed'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0219','P0178','subject','Family-verified caption identifies Ali Amiri Gharagozloo with his father P0008.');

UPDATE artifacts
SET notes='VERIFIED in supplied family compilation. Both captioned people are now linked: P0008 Gholamhossein Khan Amiri Gharagozloo and P0178 Ali Amiri Gharagozloo.'
WHERE artifact_id='A0219';

INSERT OR IGNORE INTO persons(
    person_id, preferred_name_en, preferred_name_fa, sex,
    birth_date_text, death_date_text, branch, summary,
    verification_status, created_at, updated_at
) VALUES (
    'P0179','Qara Mohammad Gharagozloo','قرا محمد قراگوزلو','M',
    NULL,NULL,'Hajilou',
    'Family-tradition remote ancestor (jad-e a’la) of the Hajilou Gharagozloo branch in Majmooe Asaar. The transmitted account says he was from the nobility of Turkestan, migrated to Iran amid internal conflict around the early Safavid period and the end of Timurid rule, reached the area later called Tasaran, married the daughter of the local chief Ajam Beg, and remained there. The exact intermediate genealogy connecting him to the later documented Hajilou trunk remains unresolved.',
    'provisional','2026-08-08T00:00:00Z','2026-08-08T00:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0179','Qara Mohammad','en','short-form',0),
('P0179','Ghara Mohammad','en','variant',0),
('P0179','قرا محمد','fa','short-form',0);

INSERT OR IGNORE INTO relationships(
    relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES (
    'R0161','P0179','ancestral_hypothesis','P0094',
    'Majmooe Asaar calls Qara Mohammad the remote ancestor of the Hajilou branch and preserves additional intermediate family-tradition names in the opening genealogy. This edge means ancestry only; it does NOT assert that Qara Mohammad was the direct father of P0094 Haji Mohammad Jafar Khan.',
    'possible'
);

INSERT OR IGNORE INTO citations(
    citation_id,source_id,page_printed,page_file,locator_text,quoted_text,notes
) VALUES
('X1514','S0003','10-13',NULL,
 'Editor introduction: transmitted Hajilou genealogy beginning with Qara Mohammad',
 NULL,
 'The source explicitly calls Qara Mohammad the remote ancestor of the Hajilou branch, describes him as a nobleman of Turkestan who migrated to Iran in the early Safavid/end-Timurid setting, and narrates his settlement near Tasaran.'),
('X1515','S0002',NULL,NULL,
 'Direct archive-owner family testimony, 2026-08-08 — children of Gholamhossein Khan Amiri Gharagozloo',
 NULL,
 'Archive owner confirms P0008 had two sons: P0009 Dr. Alireza Amiri Gharagozloo and P0178 Ali Amiri Gharagozloo.');

INSERT OR IGNORE INTO claims(
    claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES
('C1551','person','P0179','family_tradition_ancestry',
 'Qara Mohammad is named in Majmooe Asaar as the remote ancestor of the Hajilou Gharagozloo branch.',
 'confirmed','active',
 'Confirmed as a statement preserved in the family-tradition source; the exact later genealogical chain is not independently proven.'),
('C1552','person','P0179','migration_origin',
 'The transmitted account says Qara Mohammad was from the nobility of Turkestan and migrated to Iran around the early Safavid period/end of Timurid rule, later settling near Tasaran.',
 'confirmed','active',
 'Confirmed only as the narrative reported by Majmooe Asaar.'),
('C1553','person','P0178','parentage',
 'Ali Amiri Gharagozloo is a son of Gholamhossein Khan Amiri Gharagozloo P0008 and brother of P0009 Dr. Alireza Amiri Gharagozloo.',
 'confirmed','active',
 'Direct family testimony from the archive owner; family-verified photograph A0219 also identifies Ali with his father.');

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C1551','X1514','supports'),
('C1552','X1514','supports'),
('C1553','X1515','supports');

INSERT OR IGNORE INTO research_questions(question_id,question,status,priority,notes) VALUES
('Q0166',
 'Can the intermediate generations between Qara Mohammad and the later documented Hajilou trunk be reconciled person-by-person across Majmooe Asaar, Alvandi, and the canonical archive?',
 'open','high',
 'Majmooe Asaar preserves a longer family-tradition sequence, but this migration deliberately avoids converting it wholesale into direct parent-child topology until reconciled.');

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary) VALUES
('2026-08-08T00:00:00Z','person','P0178','add','Added Ali Amiri Gharagozloo as confirmed son of P0008 and brother of P0009; linked existing VERIFIED artifact A0219.'),
('2026-08-08T00:00:00Z','person','P0179','add','Added Qara Mohammad as the named remote Hajilou ancestor reported in Majmooe Asaar, with explicit family-tradition/provisional status.'),
('2026-08-08T00:00:00Z','relationship','R0161','add','Added dotted non-parental ancestry hypothesis from Qara Mohammad to the later documented Hajilou trunk; intermediate genealogy remains unresolved.'),
('2026-08-08T00:00:00Z','explorer','generation_context','fix','Removed fabricated 30-year generation estimates; undated generations now display Date range not established.');
