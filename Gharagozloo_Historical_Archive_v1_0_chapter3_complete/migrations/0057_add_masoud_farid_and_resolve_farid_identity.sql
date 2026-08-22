-- Focused Khateraat-e Farid follow-up: add Masoud Farid, strengthen the
-- existing P0153 -> P0156 placement, resolve Q0035, and narrow Q0163.
PRAGMA foreign_keys = ON;

INSERT OR IGNORE INTO sources(
  source_id,short_title,full_title,author,publication_year,source_type,file_name,notes
) VALUES (
  'S0206',
  'Khateraat-e Farid',
  'Khateraat-e Farid: memoirs of Mirza Mohammad Ali Khan Farid al-Molk Hamadani, 1291-1334 AH',
  'Mirza Mohammad Ali Khan Farid al-Molk Hamadani; compiled by Masoud Farid Gharagozloo',
  NULL,
  'memoir',
  'Khateraat E Farid - 1.pdf',
  'Primary family memoir. The opening matter identifies Masoud Farid Gharagozloo as compiler; his signed introduction identifies the memoirist as his father, and the biographical introduction identifies the memoirist as a son of Mohammad Khan Hajilou.'
);

INSERT OR IGNORE INTO citations(
  citation_id,source_id,page_printed,page_file,locator_text,quoted_text,notes
) VALUES
(
  'X1518','S0206',NULL,'1',
  'Cover/title matter naming the memoir and compiler Masoud Farid Gharagozloo',
  NULL,
  'Identifies the work as the memoirs of Mirza Mohammad Ali Khan Farid al-Molk Hamadani and names Masoud Farid Gharagozloo as compiler.'
),
(
  'X1519','S0206',NULL,'4',
  'Opening biographical introduction beside the portrait of Farid al-Molk',
  'پدرم مرحوم میرزا محمد علی خان ملقب بفرید الملک پسر مرحوم محمدخان حاجیلو',
  'Directly supports Masoud Farid as son of the memoirist and independently supports P0153 Mohammad Khan Hajilou as father of P0156 Farid al-Molk.'
),
(
  'X1520','S0206','2','5',
  'Signed compiler introduction by Masoud Farid Gharagozloo, Tehran, Mordad 1351 SH',
  NULL,
  'Masoud signs the introduction and repeatedly describes the diary writer and London traveler as his father.'
);

INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,birth_date_text,death_date_text,
  branch,summary,verification_status,created_at,updated_at
) VALUES (
  'P0184','Masoud Farid Gharagozloo','مسعود فرید قراگزلو','M',NULL,NULL,
  'Hajilou / Royani',
  'Son of P0156 Mirza Mohammad Ali Khan Farid al-Molk Hamadani Gharagozloo and compiler of Khateraat-e Farid. The book''s opening matter names him as compiler, and his introduction explicitly identifies the memoirist as his father.',
  'confirmed','2026-08-22T20:00:00Z','2026-08-22T20:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0184','Masoud Farid Gharagozloo','en','canonical',1),
('P0184','مسعود فرید قراگزلو','fa','canonical',1),
('P0184','Masoud Farid','en','short-form',0),
('P0184','مسعود فرید','fa','short-form',0),
('P0184','Masud Farid Gharagozloo','en','alternate-transliteration',0),
('P0184','Masoud Farid (Gharagozloo)','en','source-form',0);

INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES (
  'R0168','P0156','parent_of','P0184',
  'Khateraat-e Farid opening matter and Masoud Farid''s signed introduction identify the memoirist P0156 as his father.',
  'confirmed'
);

-- Strengthen only the evidence/status of the existing canonical relationship.
UPDATE relationships
SET notes='Khateraat-e Farid independently identifies Farid al-Molk P0156 as a son of Mohammad Khan Hajilou P0153; this confirms the existing Figure 4 placement.',
    verification_status='confirmed'
WHERE relationship_id='R0133'
  AND person1_id='P0153'
  AND relationship_type='parent_of'
  AND person2_id='P0156';

UPDATE claims
SET confidence='confirmed',
    notes='Existing Figure 4 placement independently confirmed by Khateraat-e Farid opening biography, citation X1519.'
WHERE claim_id='C0262'
  AND subject_type='person'
  AND subject_id='P0156';

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES
(
  'C1558','person','P0184','identity',
  'Masoud Farid Gharagozloo is the compiler of Khateraat-e Farid.',
  'confirmed','active','Named on the book''s opening matter and signed introduction.'
),
(
  'C1559','person','P0184','parentage',
  'Masoud Farid Gharagozloo P0184 is a son of Mirza Mohammad Ali Khan Farid al-Molk Hamadani Gharagozloo P0156.',
  'confirmed','active','Masoud explicitly identifies the memoirist as his father.'
),
(
  'C1560','person','P0156','identity_and_title',
  'P0156 is Mirza Mohammad Ali Khan, titled Farid al-Molk Hamadani, son of Mohammad Khan Hajilou P0153.',
  'confirmed','active','Independent primary-family memoir confirmation of identity, title, and placement.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0262','X1519','supports'),
('C1558','X1518','supports'),
('C1558','X1520','supports'),
('C1559','X1519','supports'),
('C1559','X1520','supports'),
('C1560','X1519','supports');

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES
('EC1522','person','P0184','X1518','supports','Opening matter identifies Masoud Farid Gharagozloo as compiler.'),
('EC1523','person','P0184','X1520','supports','Signed introduction identifies the compiler and his relationship to the memoirist.'),
('EC1524','relationship','R0168','X1519','supports','Direct father-son statement in the opening biography.'),
('EC1525','relationship','R0168','X1520','supports','Masoud repeatedly calls the memoirist his father.'),
('EC1526','person','P0156','X1519','supports','Confirms P0156 identity and Farid al-Molk title.'),
('EC1527','person','P0153','X1519','supports','Names Mohammad Khan Hajilou as father of Farid al-Molk.'),
('EC1528','relationship','R0133','X1519','supports','Independent support for the existing P0153 -> P0156 placement.'),
('EC1529','research_question','Q0035','X1519','supports','Evidence resolving the identity, title, and placement question.');

-- Preserve the question record and resolution history; change status and notes only.
UPDATE research_questions
SET status='resolved',
    notes='Resolved in migration 0057. Khateraat-e Farid identifies the memoirist as Mirza Mohammad Ali Khan Farid al-Molk and explicitly calls him a son of Mohammad Khan Hajilou, independently confirming P0153 -> P0156 (X1519).'
WHERE question_id='Q0035';

-- Narrow the question without changing any genealogy or resolving the conflict.
UPDATE research_questions
SET question='Is P0173 Manouchehr Gharagozloo the twentieth-century sports administrator, and who was his father: P0037 Alireza Khan Baha al-Molk or Mirza Taqi Khan?',
    status='open',
    notes='Unresolved identity/fatherage conflict. The current graph and Figure 3 place P0173 under P0037 Alireza Khan Baha al-Molk; competing biographical evidence identifies the twentieth-century sports administrator as a son of Mirza Taqi Khan; another source reports that Alireza had no children. Do not reparent or split P0173 until another independent source resolves whether these references concern one or two Manouchehrs.'
WHERE question_id='Q0163';

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary) VALUES
('2026-08-22T20:00:00Z','person','P0184','add','Added Masoud Farid Gharagozloo as the confirmed son of P0156 and compiler of Khateraat-e Farid.'),
('2026-08-22T20:00:00Z','relationship','R0168','add','Added confirmed parent-child relationship P0156 Farid al-Molk -> P0184 Masoud Farid.'),
('2026-08-22T20:00:00Z','relationship','R0133','evidence_enrichment','Strengthened the existing P0153 -> P0156 placement with independent Khateraat-e Farid evidence; topology unchanged.'),
('2026-08-22T20:00:00Z','research_question','Q0035','resolve','Resolved Farid al-Molk identity, title, and placement using citation X1519.'),
('2026-08-22T20:00:00Z','research_question','Q0163','narrow','Narrowed Q0163 to the unresolved P0173 identity/fatherage conflict; no reparenting or identity split.'),
('2026-08-22T20:00:00Z','source','S0206','add','Cataloged Khateraat-e Farid as the primary source for the focused Farid follow-up.');

INSERT OR REPLACE INTO metadata(key,value) VALUES
('archive_version','2.10.1'),
('farid_followup_0057','Added P0184 Masoud Farid under P0156; independently confirmed P0153 -> P0156; resolved Q0035; narrowed Q0163 without changing P0173 genealogy.');
