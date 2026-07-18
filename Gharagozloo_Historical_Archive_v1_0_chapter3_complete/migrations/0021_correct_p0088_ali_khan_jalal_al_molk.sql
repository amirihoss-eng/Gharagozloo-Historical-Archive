-- Archive v2.6.3 — Correct P0088 to Ali Khan Jalal al-Molk
--
-- Confirmed reading from S0001 Figure 4:
--   علی خان جلال‌الملک قراگوزلو
--   Ali Khan Jalal al-Molk Gharagozloo
--
-- Scope:
--   * Correct only the identity/name/title data for P0088.
--   * Preserve all existing parent-child relationships and descendants.
--   * Retain the earlier "Alireza Khan Abadi" reading as superseded research history.
--   * Resolve the open name-reading question and add Jalal al-Molk as a title.

UPDATE persons
SET preferred_name_en='Ali Khan Jalal al-Molk Gharagozloo',
    preferred_name_fa='علی خان جلال‌الملک قراگوزلو',
    summary='Son of Alireza Khan (P0083) in S0001 Figure 4. The printed name was confirmed as Ali Khan Jalal al-Molk Gharagozloo. Earlier provisional readings as Alireza Khan Abadi were superseded. His four recorded children and all existing relationships are preserved.',
    verification_status='probable',
    updated_at='2026-07-18T03:00:00Z'
WHERE person_id='P0088';

UPDATE person_names
SET is_preferred=0,
    name_type=CASE
      WHEN name_type='canonical' THEN 'superseded_reading'
      ELSE name_type
    END
WHERE person_id='P0088';

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0088','Ali Khan Jalal al-Molk Gharagozloo','en','canonical',1),
('P0088','علی خان جلال‌الملک قراگوزلو','fa','canonical',1),
('P0088','Ali Khan Jalal al-Molk','en','title_form',0),
('P0088','علی خان جلال‌الملک','fa','title_form',0);

UPDATE citations
SET notes='Figure 4 shows two children under Alireza Khan. The upper child has four children. The upper child''s name was confirmed directly from the Persian figure as Ali Khan Jalal al-Molk Gharagozloo. A possible trailing descriptor after Asadollah Khan remains unresolved.'
WHERE citation_id='X0092';

UPDATE relationships
SET notes='Figure 4 shows Ali Khan Jalal al-Molk Gharagozloo as the upper child of Alireza Khan P0083.',
    verification_status='probable'
WHERE relationship_id='R0064';

UPDATE relationships
SET notes='Figure 4 shows Asadollah Khan as a child of Ali Khan Jalal al-Molk Gharagozloo (P0088).'
WHERE relationship_id='R0066';

UPDATE relationships
SET notes='Figure 4 shows Panahollah Khan Jalal al-Saltaneh as a child of Ali Khan Jalal al-Molk Gharagozloo (P0088).'
WHERE relationship_id='R0067';

UPDATE relationships
SET notes='Figure 4 shows Seyfollah Khan Jalali as a child of Ali Khan Jalal al-Molk Gharagozloo (P0088).'
WHERE relationship_id='R0068';

UPDATE relationships
SET notes='Figure 4 shows Hossein Ali Khan Fath al-Saltaneh as a child of Ali Khan Jalal al-Molk Gharagozloo (P0088).'
WHERE relationship_id='R0069';

UPDATE persons
SET summary='Child of Ali Khan Jalal al-Molk Gharagozloo (P0088) in S0001 Figure 4. A possible trailing descriptor remains unresolved.',
    updated_at='2026-07-18T03:00:00Z'
WHERE person_id='P0090';

UPDATE persons
SET summary='Child of Ali Khan Jalal al-Molk Gharagozloo (P0088) in S0001 Figure 4; chart reading includes the title Jalal al-Saltaneh.',
    updated_at='2026-07-18T03:00:00Z'
WHERE person_id='P0091';

UPDATE persons
SET summary='Child of Ali Khan Jalal al-Molk Gharagozloo (P0088) in S0001 Figure 4; chart reading includes the descriptor Jalali.',
    updated_at='2026-07-18T03:00:00Z'
WHERE person_id='P0092';

UPDATE persons
SET summary='Child of Ali Khan Jalal al-Molk Gharagozloo (P0088) in S0001 Figure 4; chart reading includes the title Fath al-Saltaneh.',
    updated_at='2026-07-18T03:00:00Z'
WHERE person_id='P0093';

UPDATE claims
SET object_text='Ali Khan Jalal al-Molk and Noor Mohammad Khan',
    notes='Two-child grouping read directly from Figure 4. The upper child''s name was confirmed as Ali Khan Jalal al-Molk.'
WHERE claim_id='C0169';

UPDATE claims
SET object_text='Ali Khan Jalal al-Molk Gharagozloo (P0088)'
WHERE claim_id IN ('C0173','C0174','C0175','C0176');

UPDATE entity_citations
SET notes='Figure 4 identification confirmed as Ali Khan Jalal al-Molk Gharagozloo; earlier Alireza Khan Abadi reading superseded.'
WHERE entity_citation_id='EC0133';

INSERT OR IGNORE INTO titles(title_id,title_en,title_fa,meaning_notes) VALUES
('T0028','Jalal al-Molk','جلال‌الملک','Qajar-era honorific/title confirmed in S0001 Figure 4 for Ali Khan P0088.');

INSERT OR IGNORE INTO person_titles(person_id,title_id,date_text,notes) VALUES
('P0088','T0028',NULL,'Title printed with Ali Khan in S0001 Figure 4.');

INSERT OR IGNORE INTO claims(
  claim_id, subject_type, subject_id, predicate, object_text,
  confidence, status, notes
) VALUES
(
  'C0179','person','P0088','held title','Jalal al-Molk',
  'probable','active',
  'Title confirmed by direct reading of S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0179','X0092','supports');

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id, entity_type, entity_id, citation_id, support_type, notes
) VALUES
('EC0147','title','T0028','X0092','supports','Jalal al-Molk title confirmed in Figure 4.');

UPDATE research_questions
SET status='in_progress',
    notes='The upper child is now confirmed as Ali Khan Jalal al-Molk Gharagozloo, and the two-child/four-grandchild structure is entered. A possible trailing descriptor after Asadollah Khan remains unresolved.'
WHERE question_id='Q0021';

UPDATE research_questions
SET question='What is the exact full name and title of P0088 in S0001 Figure 4?',
    status='resolved',
    notes='Resolved by direct reading of the printed Persian figure: علی خان جلال‌الملک قراگوزلو — Ali Khan Jalal al-Molk Gharagozloo. Earlier Alireza Khan Abadi readings are superseded.'
WHERE question_id='Q0023';

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary) VALUES
(
  '2026-07-18T03:00:00Z','person','P0088','correct',
  'Corrected P0088 from the provisional Alireza Khan Abadi reading to Ali Khan Jalal al-Molk Gharagozloo; preserved all descendants and relationships.'
);

INSERT OR REPLACE INTO metadata(key,value) VALUES('archive_version','2.6.3');
INSERT OR REPLACE INTO metadata(key,value) VALUES(
  'hajilou_figure4_p0088_correction',
  'P0088 confirmed as Ali Khan Jalal al-Molk Gharagozloo (علی خان جلال‌الملک قراگوزلو). Earlier Alireza Khan Abadi reading retained only as superseded research history.'
);
