-- Archive v2.6.2 — Figure 4 corrective reading and Alireza branch reconstruction
--
-- Scope:
--   1. Correct the provisional P0085 reading from Mahmoud Khan to Majid Khan,
--      while preserving the already entered Majid -> Ali-Akbar -> Mehdi chain.
--   2. Add the two children shown under Alireza Khan (P0083) in S0001 Figure 4.
--   3. Add the four children shown under the upper child, using the readings
--      supplied by the project editor directly from the printed Persian figure.
--
-- Evidence policy:
--   The parent-child structure is explicit in the printed genealogy and is
--   recorded as probable (diagram-supported). Names with unresolved words are
--   retained as partial readings and explicitly documented rather than guessed.

INSERT OR IGNORE INTO citations(
  citation_id, source_id, page_printed, page_file,
  locator_text, quoted_text, notes
) VALUES
(
  'X0092','S0001','213',NULL,
  'Figure 4 — Hajilou genealogy; Alireza Khan descendant group',
  NULL,
  'The printed chart shows two children under Alireza Khan. The upper child has four children. Readings were checked directly from the Persian figure with project-editor assistance. The upper child''s full descriptor and a possible trailing descriptor after Asadollah Khan remain unresolved.'
);

-- Correct P0085 without deleting the research history of the superseded reading.
UPDATE persons
SET preferred_name_en='Majid Khan Gharagozloo',
    preferred_name_fa='مجید خان قراگوزلو',
    summary='Son of Sartip Mohammad-Baqer Khan Gharagozloo in S0001 Figure 4. Earlier entered as Mahmoud Khan; direct review of the Persian chart corrected the reading to Majid Khan. The existing Majid -> Ali-Akbar -> Mehdi line is preserved.',
    updated_at='2026-07-18T02:00:00Z'
WHERE person_id='P0085';

UPDATE person_names
SET is_preferred=0,
    name_type='superseded_reading'
WHERE person_id='P0085'
  AND name_text IN ('Mahmoud Khan Gharagozloo','محمود خان قراگوزلو');

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0085','Majid Khan Gharagozloo','en','canonical',1),
('P0085','مجید خان قراگوزلو','fa','canonical',1);

UPDATE relationships
SET notes='Figure 4 depicts Majid Khan as a son of Sartip Mohammad-Baqer Khan. The name was corrected from the earlier provisional reading Mahmoud Khan.',
    verification_status='probable'
WHERE relationship_id='R0061';

UPDATE relationships
SET notes='Figure 4 shows the sequence Majid Khan -> Ali-Akbar Khan.',
    verification_status='probable'
WHERE relationship_id='R0062';

UPDATE persons
SET summary='Shown in S0001 Figure 4 as son of Majid Khan of the Mohammad-Baqer Khan Hajilou family group.',
    updated_at='2026-07-18T02:00:00Z'
WHERE person_id='P0086';

UPDATE persons
SET summary='Shown in S0001 Figure 4 as son of Ali-Akbar Khan and grandson of Majid Khan in the Mohammad-Baqer Khan Hajilou family group.',
    updated_at='2026-07-18T02:00:00Z'
WHERE person_id='P0087';

UPDATE claims
SET object_text='Alireza Khan, Kazem Khan, Mostafa-Qoli Khan E''temad al-Saltaneh, and Majid Khan',
    notes='The four-son grouping is read from the printed genealogy. Mostafa-Qoli is independently corroborated by prose. The collateral sons are diagram-supported; the earlier Mahmoud reading was corrected to Majid.'
WHERE claim_id='C0163';

UPDATE claims
SET object_text='Sartip Mohammad-Baqer Khan Gharagozloo',
    notes='Diagram-supported relationship in S0001 Figure 4; personal name corrected from Mahmoud to Majid.'
WHERE claim_id='C0166';

UPDATE claims
SET object_text='Majid Khan Gharagozloo of the Hajilou/Jeyhunabadi line',
    notes='Diagram-supported relationship in S0001 Figure 4; parent name corrected from Mahmoud to Majid.'
WHERE claim_id='C0167';

UPDATE entity_citations
SET notes='Figure 4 identification; provisional Mahmoud reading corrected to Majid after direct Persian review.'
WHERE entity_citation_id='EC0125';

-- Add Alireza Khan's two children and the four children of the upper child.
INSERT OR IGNORE INTO persons(
  person_id, preferred_name_en, preferred_name_fa, sex,
  birth_date_text, death_date_text, branch, summary,
  verification_status, created_at, updated_at
) VALUES
(
  'P0088','Alireza Khan Abadi Gharagozloo','علیرضا خان آبادی قراگوزلو','M',
  NULL,NULL,'Hajilou / Jeyhunabadi',
  'Upper child of Alireza Khan (P0083) in S0001 Figure 4. The chart is read as Alireza Khan with one or more unresolved words before an ending read as Abadi. This is a distinct person from his father despite the repeated given name.',
  'provisional','2026-07-18T02:00:00Z','2026-07-18T02:00:00Z'
),
(
  'P0089','Noor Mohammad Khan Gharagozloo','نورمحمد خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Jeyhunabadi',
  'Lower child of Alireza Khan (P0083) in S0001 Figure 4.',
  'provisional','2026-07-18T02:00:00Z','2026-07-18T02:00:00Z'
),
(
  'P0090','Asadollah Khan Gharagozloo','اسدالله خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Jeyhunabadi',
  'Child of Alireza Khan Abadi (P0088) in S0001 Figure 4. A possible trailing descriptor remains unresolved.',
  'provisional','2026-07-18T02:00:00Z','2026-07-18T02:00:00Z'
),
(
  'P0091','Panahollah Khan Jalal al-Saltaneh Gharagozloo','پناه‌الله خان جلال‌السلطنه قراگوزلو','M',
  NULL,NULL,'Hajilou / Jeyhunabadi',
  'Child of Alireza Khan Abadi (P0088) in S0001 Figure 4; chart reading includes the title Jalal al-Saltaneh.',
  'provisional','2026-07-18T02:00:00Z','2026-07-18T02:00:00Z'
),
(
  'P0092','Seyfollah Khan Jalali Gharagozloo','سیف‌الله خان جلالی قراگوزلو','M',
  NULL,NULL,'Hajilou / Jeyhunabadi',
  'Child of Alireza Khan Abadi (P0088) in S0001 Figure 4; chart reading includes the descriptor Jalali.',
  'provisional','2026-07-18T02:00:00Z','2026-07-18T02:00:00Z'
),
(
  'P0093','Hossein Ali Khan Fath al-Saltaneh Gharagozloo','حسینعلی خان فتح‌السلطنه قراگوزلو','M',
  NULL,NULL,'Hajilou / Jeyhunabadi',
  'Child of Alireza Khan Abadi (P0088) in S0001 Figure 4; chart reading includes the title Fath al-Saltaneh.',
  'provisional','2026-07-18T02:00:00Z','2026-07-18T02:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0088','Alireza Khan Abadi Gharagozloo','en','canonical',1),
('P0088','علیرضا خان آبادی قراگوزلو','fa','canonical',1),
('P0088','Alireza Khan [full descriptor unresolved] Abadi','en','partial_chart_reading',0),
('P0089','Noor Mohammad Khan Gharagozloo','en','canonical',1),
('P0089','نورمحمد خان قراگوزلو','fa','canonical',1),
('P0090','Asadollah Khan Gharagozloo','en','canonical',1),
('P0090','اسدالله خان قراگوزلو','fa','canonical',1),
('P0091','Panahollah Khan Jalal al-Saltaneh Gharagozloo','en','canonical',1),
('P0091','پناه‌الله خان جلال‌السلطنه قراگوزلو','fa','canonical',1),
('P0092','Seyfollah Khan Jalali Gharagozloo','en','canonical',1),
('P0092','سیف‌الله خان جلالی قراگوزلو','fa','canonical',1),
('P0093','Hossein Ali Khan Fath al-Saltaneh Gharagozloo','en','canonical',1),
('P0093','حسینعلی خان فتح‌السلطنه قراگوزلو','fa','canonical',1);

INSERT OR IGNORE INTO relationships(
  relationship_id, person1_id, relationship_type, person2_id,
  notes, verification_status
) VALUES
('R0064','P0083','parent_of','P0088','Figure 4 shows the upper Alireza/Abadi-labeled person as a child of Alireza Khan P0083. Full descriptor remains partly unread.','probable'),
('R0065','P0083','parent_of','P0089','Figure 4 shows Noor Mohammad Khan as the lower child of Alireza Khan P0083.','probable'),
('R0066','P0088','parent_of','P0090','Figure 4 shows Asadollah Khan as a child of P0088.','probable'),
('R0067','P0088','parent_of','P0091','Figure 4 shows Panahollah Khan Jalal al-Saltaneh as a child of P0088.','probable'),
('R0068','P0088','parent_of','P0092','Figure 4 shows Seyfollah Khan Jalali as a child of P0088.','probable'),
('R0069','P0088','parent_of','P0093','Figure 4 shows Hossein Ali Khan Fath al-Saltaneh as a child of P0088.','probable');

INSERT OR IGNORE INTO titles(title_id,title_en,title_fa,meaning_notes) VALUES
('T0026','Jalal al-Saltaneh','جلال‌السلطنه','Qajar-era honorific/title as read in S0001 Figure 4.'),
('T0027','Fath al-Saltaneh','فتح‌السلطنه','Qajar-era honorific/title as read in S0001 Figure 4.');

INSERT OR IGNORE INTO person_titles(person_id,title_id,date_text,notes) VALUES
('P0091','T0026',NULL,'Title printed with Panahollah Khan in S0001 Figure 4.'),
('P0093','T0027',NULL,'Title printed with Hossein Ali Khan in S0001 Figure 4.');

INSERT OR IGNORE INTO claims(
  claim_id, subject_type, subject_id, predicate, object_text,
  confidence, status, notes
) VALUES
('C0169','person','P0083','children shown in Figure 4','Alireza Khan Abadi (full descriptor partly unresolved) and Noor Mohammad Khan','probable','active','Two-child grouping read directly from the printed genealogy.'),
('C0170','person','P0088','is child of','Alireza Khan Gharagozloo (P0083)','probable','active','Diagram-supported relationship in S0001 Figure 4.'),
('C0171','person','P0089','is child of','Alireza Khan Gharagozloo (P0083)','probable','active','Diagram-supported relationship in S0001 Figure 4.'),
('C0172','person','P0088','children shown in Figure 4','Asadollah Khan; Panahollah Khan Jalal al-Saltaneh; Seyfollah Khan Jalali; Hossein Ali Khan Fath al-Saltaneh','probable','active','Four-child grouping read directly from the printed genealogy.'),
('C0173','person','P0090','is child of','Alireza Khan Abadi Gharagozloo (P0088)','probable','active','Diagram-supported relationship in S0001 Figure 4.'),
('C0174','person','P0091','is child of','Alireza Khan Abadi Gharagozloo (P0088)','probable','active','Diagram-supported relationship in S0001 Figure 4.'),
('C0175','person','P0092','is child of','Alireza Khan Abadi Gharagozloo (P0088)','probable','active','Diagram-supported relationship in S0001 Figure 4.'),
('C0176','person','P0093','is child of','Alireza Khan Abadi Gharagozloo (P0088)','probable','active','Diagram-supported relationship in S0001 Figure 4.'),
('C0177','person','P0091','held title','Jalal al-Saltaneh','probable','active','Title read from S0001 Figure 4.'),
('C0178','person','P0093','held title','Fath al-Saltaneh','probable','active','Title read from S0001 Figure 4.');

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0169','X0092','supports'),
('C0170','X0092','supports'),
('C0171','X0092','supports'),
('C0172','X0092','supports'),
('C0173','X0092','supports'),
('C0174','X0092','supports'),
('C0175','X0092','supports'),
('C0176','X0092','supports'),
('C0177','X0092','supports'),
('C0178','X0092','supports');

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id, entity_type, entity_id, citation_id, support_type, notes
) VALUES
('EC0133','person','P0088','X0092','supports','Partial name reading; full descriptor remains unresolved.'),
('EC0134','person','P0089','X0092','supports','Figure 4 identification.'),
('EC0135','person','P0090','X0092','supports','Figure 4 identification; possible trailing descriptor unresolved.'),
('EC0136','person','P0091','X0092','supports','Figure 4 identification and title.'),
('EC0137','person','P0092','X0092','supports','Figure 4 identification and Jalali descriptor.'),
('EC0138','person','P0093','X0092','supports','Figure 4 identification and title.'),
('EC0139','relationship','R0064','X0092','supports','Diagram-supported parent-child edge.'),
('EC0140','relationship','R0065','X0092','supports','Diagram-supported parent-child edge.'),
('EC0141','relationship','R0066','X0092','supports','Diagram-supported parent-child edge.'),
('EC0142','relationship','R0067','X0092','supports','Diagram-supported parent-child edge.'),
('EC0143','relationship','R0068','X0092','supports','Diagram-supported parent-child edge.'),
('EC0144','relationship','R0069','X0092','supports','Diagram-supported parent-child edge.'),
('EC0145','title','T0026','X0092','supports','Title read in Figure 4.'),
('EC0146','title','T0027','X0092','supports','Title read in Figure 4.');

UPDATE research_questions
SET status='in_progress',
    notes='Figure 4 structure and most descendant names are now entered. The upper child is read as Alireza Khan with an unresolved intervening descriptor ending in Abadi; the exact full reading remains open.'
WHERE question_id='Q0021';

UPDATE research_questions
SET question='Do prose or documentary sources in S0001 independently corroborate Kazem Khan, Majid Khan, Ali-Akbar Khan, and Mehdi Khan in the Jeyhunabadi Hajilou line?',
    notes='Current canonical inclusion is diagram-supported and therefore marked probable. The earlier Mahmoud reading has been corrected to Majid.'
WHERE question_id='Q0022';

INSERT OR IGNORE INTO research_questions(question_id,question,status,priority,notes) VALUES
('Q0023','What is the exact full descriptor between Alireza Khan and the ending read as Abadi for P0088 in S0001 Figure 4?','open','high','The given name and final Abadi reading are usable, but one or more intervening words remain unclear.'),
('Q0024','Is there an additional title or descriptor printed after Asadollah Khan (P0090) in S0001 Figure 4?','open','medium','The personal name is readable; a possible trailing element remains uncertain.');

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary) VALUES
('2026-07-18T02:00:00Z','person','P0085','correct','Corrected provisional Figure 4 reading from Mahmoud Khan to Majid Khan while preserving descendants.'),
('2026-07-18T02:00:00Z','family_group','P0083','expand','Added two children of Alireza Khan and four grandchildren from S0001 Figure 4, with uncertain readings explicitly flagged.');

INSERT OR REPLACE INTO metadata(key,value) VALUES('archive_version','2.6.2');
INSERT OR REPLACE INTO metadata(key,value) VALUES(
  'hajilou_figure4_alireza_branch',
  'Corrected Majid Khan and added the two-child/four-grandchild Alireza branch from S0001 Figure 4. Diagram-supported links remain probable; unresolved words are retained as open research questions.'
);
