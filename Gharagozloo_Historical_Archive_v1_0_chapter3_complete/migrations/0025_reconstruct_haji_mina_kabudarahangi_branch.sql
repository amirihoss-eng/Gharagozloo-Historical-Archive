-- Archive v2.6.7 — Reconstruct the Haji Mina Khan Kabudarahangi branch
--
-- Primary evidence:
--   * S0001 Figure 4, printed p. 213
--   * Human-confirmed Persian readings and branch structure
--   * S0001 narrative, printed p. 58, for Haji Mina's identity and role
--
-- Confirmed Figure 4 structure:
--
-- Haji Mina Khan Kabudarahangi
-- ├── Morteza Qoli Khan
-- │   ├── Mansur al-Molk
-- │   │   ├── Hasan Agha
-- │   │   └── Soltan Ali Khan
-- │   └── Mohammad Mirza Khan
-- │       ├── Mohammad Hossein Khan
-- │       └── Sarhang Mohammad Hossein Khan
-- └── Shir Ali Khan
--
-- Important parentage conflict:
-- Figure 4 places Haji Mina beneath Haji Abdollah Khan, while the prose
-- explicitly names Haji Mina among the sons of Haji Mohammad Jafar Khan.
-- This migration does not alter the already-disputed canonical parent edge.

INSERT OR IGNORE INTO citations(
  citation_id, source_id, page_printed, page_file, locator_text, quoted_text, notes
) VALUES
(
  'X0103','S0001','213',NULL,
  'Figure 4 — Haji Mina Khan Kabudarahangi branch',
  NULL,
  'Figure 4 shows Haji Mina Khan with two sons and the descendant structure entered by this migration. The branch geometry and Persian labels were read directly and confirmed by the archive owner.'
),
(
  'X0104','S0001','58',NULL,
  'Chapter 2 — Haji Mina Khan Kabudarahangi',
  NULL,
  'The prose names Haji Mina Khan Kabudarahangi among the sons of Haji Mohammad Jafar Khan and identifies him as an adviser and state counsellor to Agha Mohammad Khan Qajar. This conflicts with his placement beneath Haji Abdollah Khan in Figure 4.'
);

UPDATE persons
SET summary='Early Hajilou figure of the Kabudarahangi line and adviser/state counsellor to Agha Mohammad Khan Qajar. Figure 4 shows two sons, Morteza Qoli Khan and Shir Ali Khan, and a multi-generation descendant branch. His parentage remains disputed because Figure 4 places him under Haji Abdollah Khan while the prose names him among the sons of Haji Mohammad Jafar Khan.',
    verification_status='confirmed',
    updated_at='2026-07-18T07:00:00Z'
WHERE person_id='P0098';

INSERT OR IGNORE INTO persons(
  person_id, preferred_name_en, preferred_name_fa, sex,
  birth_date_text, death_date_text, branch, summary,
  verification_status, created_at, updated_at
) VALUES
(
  'P0107',
  'Morteza Qoli Khan Kabudarahangi Gharagozloo',
  'مرتضی‌قلی خان کبودراهنگی قراگوزلو',
  'M',NULL,NULL,'Hajilou / Kabudarahangi',
  'Son of Haji Mina Khan Kabudarahangi in S0001 Figure 4. The Kabudarahangi qualifier is used editorially to distinguish him from the Ashiqloo/Sangestani Morteza Qoli Khan already in the archive.',
  'probable','2026-07-18T07:00:00Z','2026-07-18T07:00:00Z'
),
(
  'P0108',
  'Shir Ali Khan Kabudarahangi Gharagozloo',
  'شیرعلی خان کبودراهنگی قراگوزلو',
  'M',NULL,NULL,'Hajilou / Kabudarahangi',
  'Son of Haji Mina Khan Kabudarahangi in S0001 Figure 4. The Kabudarahangi qualifier is an editorial disambiguation from the separately documented Herat combatant of the same name.',
  'probable','2026-07-18T07:00:00Z','2026-07-18T07:00:00Z'
),
(
  'P0109',
  'Mansur al-Molk Gharagozloo',
  'منصورالملک قراگوزلو',
  'M',NULL,NULL,'Hajilou / Kabudarahangi',
  'Child of Morteza Qoli Khan in S0001 Figure 4. The diagram supplies the title-form Mansur al-Molk; the underlying personal name is not yet established.',
  'probable','2026-07-18T07:00:00Z','2026-07-18T07:00:00Z'
),
(
  'P0110',
  'Mohammad Mirza Khan Gharagozloo',
  'محمدمیرزا خان قراگوزلو',
  'M',NULL,NULL,'Hajilou / Kabudarahangi',
  'Child of Morteza Qoli Khan in S0001 Figure 4 and father of two separately drawn sons named Mohammad Hossein Khan.',
  'probable','2026-07-18T07:00:00Z','2026-07-18T07:00:00Z'
),
(
  'P0111',
  'Hasan Agha Gharagozloo',
  'حسن آقا قراگوزلو',
  'M',NULL,NULL,'Hajilou / Kabudarahangi',
  'Child of Mansur al-Molk in S0001 Figure 4.',
  'probable','2026-07-18T07:00:00Z','2026-07-18T07:00:00Z'
),
(
  'P0112',
  'Soltan Ali Khan Gharagozloo',
  'سلطان‌علی خان قراگوزلو',
  'M',NULL,NULL,'Hajilou / Kabudarahangi',
  'Child of Mansur al-Molk in S0001 Figure 4.',
  'probable','2026-07-18T07:00:00Z','2026-07-18T07:00:00Z'
),
(
  'P0113',
  'Mohammad Hossein Khan Kabudarahangi Gharagozloo',
  'محمدحسین خان کبودراهنگی قراگوزلو',
  'M',NULL,NULL,'Hajilou / Kabudarahangi',
  'One of two distinct sons of Mohammad Mirza Khan shown in S0001 Figure 4. The Kabudarahangi qualifier is an editorial disambiguation.',
  'probable','2026-07-18T07:00:00Z','2026-07-18T07:00:00Z'
),
(
  'P0114',
  'Sarhang Mohammad Hossein Khan Kabudarahangi Gharagozloo',
  'سرهنگ محمدحسین خان کبودراهنگی قراگوزلو',
  'M',NULL,NULL,'Hajilou / Kabudarahangi',
  'One of two distinct sons of Mohammad Mirza Khan shown in S0001 Figure 4; this individual is distinguished by the military rank Sarhang.',
  'probable','2026-07-18T07:00:00Z','2026-07-18T07:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0107','Morteza Qoli Khan Kabudarahangi Gharagozloo','en','canonical',1),
('P0107','مرتضی‌قلی خان کبودراهنگی قراگوزلو','fa','canonical',1),
('P0107','Morteza Qoli Khan Gharagozloo','en','figure_form',0),
('P0107','مرتضی‌قلی خان قراگوزلو','fa','figure_form',0),
('P0108','Shir Ali Khan Kabudarahangi Gharagozloo','en','canonical',1),
('P0108','شیرعلی خان کبودراهنگی قراگوزلو','fa','canonical',1),
('P0108','Shir Ali Khan Gharagozloo','en','figure_form',0),
('P0108','شیرعلی خان قراگوزلو','fa','figure_form',0),
('P0109','Mansur al-Molk Gharagozloo','en','canonical',1),
('P0109','منصورالملک قراگوزلو','fa','canonical',1),
('P0110','Mohammad Mirza Khan Gharagozloo','en','canonical',1),
('P0110','محمدمیرزا خان قراگوزلو','fa','canonical',1),
('P0111','Hasan Agha Gharagozloo','en','canonical',1),
('P0111','حسن آقا قراگوزلو','fa','canonical',1),
('P0112','Soltan Ali Khan Gharagozloo','en','canonical',1),
('P0112','سلطان‌علی خان قراگوزلو','fa','canonical',1),
('P0113','Mohammad Hossein Khan Kabudarahangi Gharagozloo','en','canonical',1),
('P0113','محمدحسین خان کبودراهنگی قراگوزلو','fa','canonical',1),
('P0113','Mohammad Hossein Khan Gharagozloo','en','figure_form',0),
('P0113','محمدحسین خان قراگوزلو','fa','figure_form',0),
('P0114','Sarhang Mohammad Hossein Khan Kabudarahangi Gharagozloo','en','canonical',1),
('P0114','سرهنگ محمدحسین خان کبودراهنگی قراگوزلو','fa','canonical',1),
('P0114','Sarhang Mohammad Hossein Khan Gharagozloo','en','figure_form',0),
('P0114','سرهنگ محمدحسین خان قراگوزلو','fa','figure_form',0);

INSERT OR IGNORE INTO titles(title_id,title_en,title_fa,meaning_notes) VALUES
(
  'T0030','Mansur al-Molk','منصورالملک',
  'Qajar-era title-form printed in S0001 Figure 4; the underlying personal name of P0109 is not established.'
);

INSERT OR IGNORE INTO person_titles(person_id,title_id,date_text,notes) VALUES
(
  'P0109','T0030',NULL,
  'Figure 4 identifies this individual by the title Mansur al-Molk.'
),
(
  'P0114','T0011',NULL,
  'Figure 4 distinguishes this Mohammad Hossein Khan with the rank Sarhang.'
);

INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES
(
  'R0084','P0098','parent_of','P0107',
  'Figure 4 shows Morteza Qoli Khan as a son of Haji Mina Khan Kabudarahangi.',
  'probable'
),
(
  'R0085','P0098','parent_of','P0108',
  'Figure 4 shows Shir Ali Khan as a son of Haji Mina Khan Kabudarahangi.',
  'probable'
),
(
  'R0086','P0107','parent_of','P0109',
  'Figure 4 shows Mansur al-Molk as a child of Morteza Qoli Khan.',
  'probable'
),
(
  'R0087','P0107','parent_of','P0110',
  'Figure 4 shows Mohammad Mirza Khan as a child of Morteza Qoli Khan.',
  'probable'
),
(
  'R0088','P0109','parent_of','P0111',
  'Figure 4 shows Hasan Agha as a child of Mansur al-Molk.',
  'probable'
),
(
  'R0089','P0109','parent_of','P0112',
  'Figure 4 shows Soltan Ali Khan as a child of Mansur al-Molk.',
  'probable'
),
(
  'R0090','P0110','parent_of','P0113',
  'Figure 4 shows Mohammad Hossein Khan as one of two distinct sons of Mohammad Mirza Khan.',
  'probable'
),
(
  'R0091','P0110','parent_of','P0114',
  'Figure 4 shows Sarhang Mohammad Hossein Khan as the second distinct son of Mohammad Mirza Khan.',
  'probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,
  confidence,status,notes
) VALUES
(
  'C0209','person','P0098','held role',
  'Adviser and state counsellor to Agha Mohammad Khan Qajar',
  'confirmed','active',
  'Explicit in the S0001 narrative.'
),
(
  'C0210','person','P0098','children count',
  'Two sons shown in Figure 4',
  'probable','active',
  'Morteza Qoli Khan and Shir Ali Khan.'
),
(
  'C0211','person','P0107','parentage',
  'Son of Haji Mina Khan Kabudarahangi (P0098)',
  'probable','active','Figure 4.'
),
(
  'C0212','person','P0108','parentage',
  'Son of Haji Mina Khan Kabudarahangi (P0098)',
  'probable','active','Figure 4.'
),
(
  'C0213','person','P0109','parentage',
  'Child of Morteza Qoli Khan (P0107)',
  'probable','active','Figure 4.'
),
(
  'C0214','person','P0110','parentage',
  'Child of Morteza Qoli Khan (P0107)',
  'probable','active','Figure 4.'
),
(
  'C0215','person','P0111','parentage',
  'Child of Mansur al-Molk (P0109)',
  'probable','active','Figure 4.'
),
(
  'C0216','person','P0112','parentage',
  'Child of Mansur al-Molk (P0109)',
  'probable','active','Figure 4.'
),
(
  'C0217','person','P0113','parentage',
  'Son of Mohammad Mirza Khan (P0110)',
  'probable','active','Figure 4.'
),
(
  'C0218','person','P0114','parentage',
  'Son of Mohammad Mirza Khan (P0110)',
  'probable','active','Figure 4.'
),
(
  'C0219','person','P0109','held title',
  'Mansur al-Molk',
  'probable','active',
  'Figure 4 identifies the person by this title-form.'
),
(
  'C0220','person','P0114','held rank',
  'Sarhang',
  'probable','active',
  'Figure 4 prints the rank with the name.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0209','X0104','supports'),
('C0210','X0103','supports'),
('C0211','X0103','supports'),
('C0212','X0103','supports'),
('C0213','X0103','supports'),
('C0214','X0103','supports'),
('C0215','X0103','supports'),
('C0216','X0103','supports'),
('C0217','X0103','supports'),
('C0218','X0103','supports'),
('C0219','X0103','supports'),
('C0220','X0103','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES
('C0209','NARRATIVE_FACT','author_statement','supports','Direct narrative description.'),
('C0210','GENEALOGICAL_DIAGRAM','genealogical_diagram','presents','Two sons shown in Figure 4.'),
('C0211','GENEALOGICAL_DIAGRAM','genealogical_diagram','presents','Relationship reconstructed from Figure 4.'),
('C0212','GENEALOGICAL_DIAGRAM','genealogical_diagram','presents','Relationship reconstructed from Figure 4.'),
('C0213','GENEALOGICAL_DIAGRAM','genealogical_diagram','presents','Relationship reconstructed from Figure 4.'),
('C0214','GENEALOGICAL_DIAGRAM','genealogical_diagram','presents','Relationship reconstructed from Figure 4.'),
('C0215','GENEALOGICAL_DIAGRAM','genealogical_diagram','presents','Relationship reconstructed from Figure 4.'),
('C0216','GENEALOGICAL_DIAGRAM','genealogical_diagram','presents','Relationship reconstructed from Figure 4.'),
('C0217','GENEALOGICAL_DIAGRAM','genealogical_diagram','presents','Relationship reconstructed from Figure 4.'),
('C0218','GENEALOGICAL_DIAGRAM','genealogical_diagram','presents','Relationship reconstructed from Figure 4.'),
('C0219','GENEALOGICAL_DIAGRAM','genealogical_diagram','presents','Title-form printed in Figure 4.'),
('C0220','GENEALOGICAL_DIAGRAM','genealogical_diagram','presents','Military rank printed in Figure 4.');

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES
('EC0179','person','P0098','X0103','supports','Figure 4 descendant branch.'),
('EC0180','person','P0098','X0104','supports','Narrative role and alternative parentage.'),
('EC0181','person','P0107','X0103','supports','Figure 4 child and descendant branch.'),
('EC0182','person','P0108','X0103','supports','Figure 4 child.'),
('EC0183','person','P0109','X0103','supports','Figure 4 title-form and descendants.'),
('EC0184','person','P0110','X0103','supports','Figure 4 descendant.'),
('EC0185','person','P0111','X0103','supports','Figure 4 descendant.'),
('EC0186','person','P0112','X0103','supports','Figure 4 descendant.'),
('EC0187','person','P0113','X0103','supports','Figure 4 descendant.'),
('EC0188','person','P0114','X0103','supports','Figure 4 descendant and rank.'),
('EC0189','title','T0030','X0103','supports','Mansur al-Molk title-form in Figure 4.');

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0107','mentioned','Figure 4 son of Haji Mina Khan.'),
('A0015','P0108','mentioned','Figure 4 son of Haji Mina Khan.'),
('A0015','P0109','mentioned','Figure 4 descendant titled Mansur al-Molk.'),
('A0015','P0110','mentioned','Figure 4 descendant.'),
('A0015','P0111','mentioned','Figure 4 descendant.'),
('A0015','P0112','mentioned','Figure 4 descendant.'),
('A0015','P0113','mentioned','Figure 4 descendant.'),
('A0015','P0114','mentioned','Figure 4 descendant with rank Sarhang.');

INSERT OR IGNORE INTO identity_exclusions(
  exclusion_id,person_id,excluded_identity_text,reason,evidence_basis
) VALUES
(
  'IX008','P0107',
  'Morteza Qoli Khan Gharagozloo (P0034), Ashiqloo/Sangestani line',
  'Same personal name, but Figure 4 places P0107 in the Hajilou/Kabudarahangi line as son of Haji Mina Khan.',
  'S0001 Figure 4 and existing P0034 genealogy'
),
(
  'IX009','P0108',
  'Shir Ali Khan Gharagozloo (P0016), Herat combatant',
  'The book does not explicitly identify the Herat combatant as Haji Mina Khan’s son; same-name identity remains unproven.',
  'S0001 Figure 4 versus Chapter 3 Herat account'
),
(
  'IX010','P0113',
  'Mohammad Hossein Khan Gharagozloo (P0011), early Ashiqloo chief',
  'Different branch, generation, and parentage.',
  'S0001 Figures 3 and 4'
),
(
  'IX011','P0114',
  'Mohammad Hossein Khan Kabudarahangi Gharagozloo (P0113)',
  'Figure 4 shows two separate sons of Mohammad Mirza Khan; one is distinguished by the rank Sarhang.',
  'S0001 Figure 4'
);

INSERT OR IGNORE INTO research_questions(
  question_id,question,status,priority,notes
) VALUES
(
  'Q0027',
  'What was the personal name of the Haji Mina descendant identified only as Mansur al-Molk in S0001 Figure 4?',
  'open','medium',
  'The diagram supplies the title منصورالملک but does not clearly provide an underlying personal name.'
);

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary) VALUES
(
  '2026-07-18T07:00:00Z','person','P0098','update',
  'Enriched Haji Mina Khan’s narrative role and added his complete Figure 4 descendant branch.'
),
(
  '2026-07-18T07:00:00Z','person','P0107-P0114','insert',
  'Added eight human-read descendants from the Haji Mina Khan Kabudarahangi branch.'
),
(
  '2026-07-18T07:00:00Z','relationship','R0084-R0091','insert',
  'Added the confirmed Figure 4 structure beneath Haji Mina Khan.'
);

INSERT OR REPLACE INTO metadata(key,value) VALUES('archive_version','2.6.7');
INSERT OR REPLACE INTO metadata(key,value) VALUES(
  'haji_mina_kabudarahangi_branch',
  'Reconstructed Haji Mina Khan -> Morteza Qoli Khan / Shir Ali Khan and six later descendants from Figure 4. Parentage conflict for Haji Mina remains unresolved as CF004/Q0025.'
);
