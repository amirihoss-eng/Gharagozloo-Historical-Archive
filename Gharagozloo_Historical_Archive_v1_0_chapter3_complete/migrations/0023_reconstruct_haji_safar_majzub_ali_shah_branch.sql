-- Archive v2.6.5 — Reconstruct the Haji Safar / Majzub Ali Shah branch
--
-- Primary evidence:
--   * S0001, printed pp. 58–59: Haji Mohammad Jafar (Majzub Ali Shah)
--     is the son of Haji Safar Khan and belongs to the Hajilou line.
--   * S0001, printed p. 107: death in Tabriz in 1239 AH and burial at
--     the shrine of Seyyed Hamzeh.
--   * S0001, Figure 4, printed p. 213: five sons.
--
-- Human reading of Figure 4 was supplemented by independent published
-- biographical lists to resolve two hard-to-read labels:
--   A = Abd al-Javad
--   C = Abd al-Majid
--
-- The extra descriptor after Mirza Ali-Naqi remains unresolved and is
-- recorded as a research question rather than guessed.

INSERT OR IGNORE INTO citations(
  citation_id, source_id, page_printed, page_file, locator_text, quoted_text, notes
) VALUES
(
  'X0095','S0001','58-59',NULL,
  'Chapter 2 — Hajilou genealogy and Majzub Ali Shah',
  NULL,
  'Identifies Majzub Ali Shah Kabudarahangi as the son of Haji Safar Khan and grandson of Haji Abdollah Khan in the Hajilou branch.'
),
(
  'X0096','S0001','213',NULL,
  'Figure 4 — Haji Safar / Majzub Ali Shah branch',
  NULL,
  'Shows Haji Safar Khan, his son Mohammad Jafar Khan Majzub Ali Shah, and five sons of Majzub Ali Shah. Labels were reviewed directly with the archive owner.'
),
(
  'X0097','S0001','107',NULL,
  'Chapter 3, section 5-2-3 — death of Majzub Ali Shah',
  NULL,
  'States that Sheikh Mohammad Jafar Khan, son of Haji Safar Khan and titled Majzub Ali Shah, died in Tabriz in 1239 AH and was buried at the shrine of Seyyed Hamzeh.'
);

INSERT OR IGNORE INTO places(
  place_id, preferred_name_en, preferred_name_fa, place_type, parent_place_id, notes
) VALUES
(
  'L0046','Shrine of Seyyed Hamzeh, Tabriz','مزار سید حمزه، تبریز',
  'shrine','L0020',
  'Burial place of Sheikh Mohammad Jafar Khan Majzub Ali Shah according to S0001.'
);

INSERT OR IGNORE INTO titles(title_id,title_en,title_fa,meaning_notes) VALUES
(
  'T0029','Majzub Ali Shah','مجذوب‌علیشاه',
  'Nimatullahi Sufi title borne by Sheikh Mohammad Jafar Khan Kabudarahangi.'
);

INSERT OR IGNORE INTO persons(
  person_id, preferred_name_en, preferred_name_fa, sex,
  birth_date_text, death_date_text, branch, summary,
  verification_status, created_at, updated_at
) VALUES
(
  'P0099',
  'Sheikh Mohammad Jafar Khan Majzub Ali Shah Kabudarahangi Gharagozloo',
  'شیخ محمدجعفر خان مجذوب‌علیشاه کبودراهنگی قراگوزلو',
  'M',NULL,'1239 AH','Hajilou / Kabudarahangi',
  'Son of Haji Safar Khan and grandson of Haji Abdollah Khan. A prominent Nimatullahi mystic titled Majzub Ali Shah. S0001 reports that he died in Tabriz in 1239 AH and was buried at the shrine of Seyyed Hamzeh.',
  'confirmed','2026-07-18T05:00:00Z','2026-07-18T05:00:00Z'
),
(
  'P0100',
  'Abd al-Javad Gharagozloo',
  'عبدالجواد قراگوزلو',
  'M',NULL,NULL,'Hajilou / Kabudarahangi',
  'One of the five sons of Sheikh Mohammad Jafar Khan Majzub Ali Shah shown in S0001 Figure 4. The difficult chart label is independently corroborated as Abd al-Javad.',
  'probable','2026-07-18T05:00:00Z','2026-07-18T05:00:00Z'
),
(
  'P0101',
  'Agha Mohammad Ebrahim Gharagozloo',
  'آقا محمدابراهیم قراگوزلو',
  'M',NULL,NULL,'Hajilou / Kabudarahangi',
  'One of the five sons of Sheikh Mohammad Jafar Khan Majzub Ali Shah shown in S0001 Figure 4.',
  'probable','2026-07-18T05:00:00Z','2026-07-18T05:00:00Z'
),
(
  'P0102',
  'Abd al-Majid Gharagozloo',
  'عبدالمجید قراگوزلو',
  'M',NULL,NULL,'Hajilou / Kabudarahangi',
  'One of the five sons of Sheikh Mohammad Jafar Khan Majzub Ali Shah shown in S0001 Figure 4. The difficult chart label is independently corroborated as Abd al-Majid.',
  'probable','2026-07-18T05:00:00Z','2026-07-18T05:00:00Z'
),
(
  'P0103',
  'Mirza Ali-Naqi Gharagozloo',
  'میرزا علی‌نقی قراگوزلو',
  'M',NULL,NULL,'Hajilou / Kabudarahangi',
  'One of the five sons of Sheikh Mohammad Jafar Khan Majzub Ali Shah shown in S0001 Figure 4. The chart appears to add a scholarly or place descriptor, but the exact phrase remains unresolved.',
  'probable','2026-07-18T05:00:00Z','2026-07-18T05:00:00Z'
),
(
  'P0104',
  'Mirza Lotfollah Gharagozloo',
  'میرزا لطف‌الله قراگوزلو',
  'M',NULL,NULL,'Hajilou / Kabudarahangi',
  'One of the five sons of Sheikh Mohammad Jafar Khan Majzub Ali Shah shown in S0001 Figure 4.',
  'probable','2026-07-18T05:00:00Z','2026-07-18T05:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0099','Sheikh Mohammad Jafar Khan Majzub Ali Shah Kabudarahangi Gharagozloo','en','canonical',1),
('P0099','شیخ محمدجعفر خان مجذوب‌علیشاه کبودراهنگی قراگوزلو','fa','canonical',1),
('P0099','Haji Mohammad Jafar Khan Majzub Ali Shah','en','title_form',0),
('P0099','حاجی محمدجعفر خان مجذوب‌علیشاه','fa','title_form',0),
('P0100','Abd al-Javad Gharagozloo','en','canonical',1),
('P0100','عبدالجواد قراگوزلو','fa','canonical',1),
('P0101','Agha Mohammad Ebrahim Gharagozloo','en','canonical',1),
('P0101','آقا محمدابراهیم قراگوزلو','fa','canonical',1),
('P0102','Abd al-Majid Gharagozloo','en','canonical',1),
('P0102','عبدالمجید قراگوزلو','fa','canonical',1),
('P0103','Mirza Ali-Naqi Gharagozloo','en','canonical',1),
('P0103','میرزا علی‌نقی قراگوزلو','fa','canonical',1),
('P0104','Mirza Lotfollah Gharagozloo','en','canonical',1),
('P0104','میرزا لطف‌الله قراگوزلو','fa','canonical',1);

INSERT OR IGNORE INTO person_titles(person_id,title_id,date_text,notes) VALUES
(
  'P0099','T0029',NULL,
  'Title printed in Figure 4 and used in the narrative account.'
);

INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES
(
  'R0076','P0097','parent_of','P0099',
  'Explicitly stated in the Chapter 2 prose and shown in Figure 4.',
  'confirmed'
),
(
  'R0077','P0099','parent_of','P0100',
  'Figure 4 shows Abd al-Javad among the five sons of Majzub Ali Shah.',
  'probable'
),
(
  'R0078','P0099','parent_of','P0101',
  'Figure 4 shows Agha Mohammad Ebrahim among the five sons of Majzub Ali Shah.',
  'probable'
),
(
  'R0079','P0099','parent_of','P0102',
  'Figure 4 shows Abd al-Majid among the five sons of Majzub Ali Shah.',
  'probable'
),
(
  'R0080','P0099','parent_of','P0103',
  'Figure 4 shows Mirza Ali-Naqi among the five sons of Majzub Ali Shah.',
  'probable'
),
(
  'R0081','P0099','parent_of','P0104',
  'Figure 4 shows Mirza Lotfollah among the five sons of Majzub Ali Shah.',
  'probable'
);

INSERT OR IGNORE INTO events(
  event_id,event_type,title,date_text,place_id,description,verification_status
) VALUES
(
  'E0075','death',
  'Death and burial of Sheikh Mohammad Jafar Khan Majzub Ali Shah',
  '1239 AH','L0046',
  'Majzub Ali Shah died while visiting Tabriz and was buried at the shrine of Seyyed Hamzeh.',
  'confirmed'
);

INSERT OR IGNORE INTO event_persons(event_id,person_id,role) VALUES
('E0075','P0099','deceased');

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,
  confidence,status,notes
) VALUES
(
  'C0189','person','P0099','parentage',
  'Son of Haji Safar Khan Gharagozloo (P0097)',
  'confirmed','active',
  'Explicit in S0001 prose and Figure 4.'
),
(
  'C0190','person','P0099','held title',
  'Majzub Ali Shah',
  'confirmed','active',
  'Used in both narrative and Figure 4.'
),
(
  'C0191','person','P0099','death',
  'Died in Tabriz in 1239 AH',
  'confirmed','active',
  'Narrative account in S0001.'
),
(
  'C0192','person','P0099','burial',
  'Buried at the shrine of Seyyed Hamzeh in Tabriz',
  'confirmed','active',
  'Narrative account in S0001.'
),
(
  'C0193','person','P0099','children count',
  'Five sons',
  'probable','active',
  'Figure 4 displays five sons.'
),
(
  'C0194','person','P0100','parentage',
  'Son of Sheikh Mohammad Jafar Khan Majzub Ali Shah (P0099)',
  'probable','active','Figure 4.'
),
(
  'C0195','person','P0101','parentage',
  'Son of Sheikh Mohammad Jafar Khan Majzub Ali Shah (P0099)',
  'probable','active','Figure 4.'
),
(
  'C0196','person','P0102','parentage',
  'Son of Sheikh Mohammad Jafar Khan Majzub Ali Shah (P0099)',
  'probable','active','Figure 4.'
),
(
  'C0197','person','P0103','parentage',
  'Son of Sheikh Mohammad Jafar Khan Majzub Ali Shah (P0099)',
  'probable','active','Figure 4.'
),
(
  'C0198','person','P0104','parentage',
  'Son of Sheikh Mohammad Jafar Khan Majzub Ali Shah (P0099)',
  'probable','active','Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0189','X0095','supports'),
('C0189','X0096','supports'),
('C0190','X0095','supports'),
('C0190','X0096','supports'),
('C0191','X0097','supports'),
('C0192','X0097','supports'),
('C0193','X0096','supports'),
('C0194','X0096','supports'),
('C0195','X0096','supports'),
('C0196','X0096','supports'),
('C0197','X0096','supports'),
('C0198','X0096','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES
('C0189','NARRATIVE_FACT','author_statement','supports','Direct prose corroborated by Figure 4.'),
('C0190','NARRATIVE_FACT','author_statement','supports','Title repeated in prose and diagram.'),
('C0191','NARRATIVE_FACT','author_statement','supports','Direct narrative death account.'),
('C0192','NARRATIVE_FACT','author_statement','supports','Direct narrative burial account.'),
('C0193','GENEALOGICAL_DIAGRAM','genealogical_diagram','presents','Five sons shown in Figure 4.'),
('C0194','GENEALOGICAL_DIAGRAM','genealogical_diagram','presents','Relationship reconstructed from Figure 4.'),
('C0195','GENEALOGICAL_DIAGRAM','genealogical_diagram','presents','Relationship reconstructed from Figure 4.'),
('C0196','GENEALOGICAL_DIAGRAM','genealogical_diagram','presents','Relationship reconstructed from Figure 4.'),
('C0197','GENEALOGICAL_DIAGRAM','genealogical_diagram','presents','Relationship reconstructed from Figure 4.'),
('C0198','GENEALOGICAL_DIAGRAM','genealogical_diagram','presents','Relationship reconstructed from Figure 4.');

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES
('EC0158','person','P0099','X0095','supports','Parentage and Hajilou identity.'),
('EC0159','person','P0099','X0096','supports','Figure 4 genealogy.'),
('EC0160','person','P0099','X0097','supports','Death and burial.'),
('EC0161','person','P0100','X0096','supports','Figure 4 child label.'),
('EC0162','person','P0101','X0096','supports','Figure 4 child label.'),
('EC0163','person','P0102','X0096','supports','Figure 4 child label.'),
('EC0164','person','P0103','X0096','supports','Figure 4 child label.'),
('EC0165','person','P0104','X0096','supports','Figure 4 child label.'),
('EC0166','title','T0029','X0095','supports','Majzub Ali Shah title in the narrative.'),
('EC0167','event','E0075','X0097','supports','Death and burial account.');

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0099','mentioned','Majzub Ali Shah in Figure 4.'),
('A0015','P0100','mentioned','Figure 4 son of Majzub Ali Shah.'),
('A0015','P0101','mentioned','Figure 4 son of Majzub Ali Shah.'),
('A0015','P0102','mentioned','Figure 4 son of Majzub Ali Shah.'),
('A0015','P0103','mentioned','Figure 4 son of Majzub Ali Shah.'),
('A0015','P0104','mentioned','Figure 4 son of Majzub Ali Shah.');

INSERT OR IGNORE INTO research_questions(
  question_id,question,status,priority,notes
) VALUES
(
  'Q0026',
  'What is the exact additional descriptor printed after Mirza Ali-Naqi in S0001 Figure 4?',
  'open','medium',
  'The chart appears to include a place or scholarly descriptor, possibly referring to Buyuk Abad and/or mujtahid status. Do not promote it into the canonical name until the wording is read confidently.'
);

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary) VALUES
(
  '2026-07-18T05:00:00Z','person','P0099','insert',
  'Added Sheikh Mohammad Jafar Khan Majzub Ali Shah Kabudarahangi with prose-supported biography.'
),
(
  '2026-07-18T05:00:00Z','person','P0100-P0104','insert',
  'Added the five sons shown beneath Majzub Ali Shah in S0001 Figure 4.'
),
(
  '2026-07-18T05:00:00Z','relationship','R0076-R0081','insert',
  'Reconstructed the Haji Safar to Majzub Ali Shah branch and the five-son grouping.'
);

INSERT OR REPLACE INTO metadata(key,value) VALUES('archive_version','2.6.5');
INSERT OR REPLACE INTO metadata(key,value) VALUES(
  'haji_safar_majzub_branch',
  'Reconstructed Haji Safar Khan -> Sheikh Mohammad Jafar Khan Majzub Ali Shah -> five sons. Mirza Ali-Naqi additional descriptor remains open as Q0026.'
);
