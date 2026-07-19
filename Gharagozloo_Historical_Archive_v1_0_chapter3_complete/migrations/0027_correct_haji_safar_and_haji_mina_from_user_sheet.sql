-- Archive v2.6.9 — Correct Haji Safar and Haji Mina branches
--
-- Basis:
--   User-supplied row/column reconstruction dated 2026-07-18.
--
-- User notation:
--   ?  = uncertain reading
--   ?? = highly uncertain / unreadable
--
-- This migration preserves the Nasrollah Khan branch unchanged because the
-- user's sheet confirms the existing chain:
--   Nasrollah Khan -> Gholam Khan -> Noor Ali Khan
--
-- Corrections made:
--   1. Majzub Ali Shah's first child is unnamed/unknown, not Abd al-Javad.
--   2. The third child is Agha Abdol Hamid, not Abd al-Majid.
--   3. Mirza Ali-Naqi's uncertain descriptor is preserved as
--      "? Abadi Mojtahed" rather than promoted into the canonical name.
--   4. Mohammad Mirza Khan's first son is Mohammad Hassan Khan, not
--      Mohammad Hossein Khan.
--   5. Soltan Ali Khan's reading remains probable because the user marked it ?.

INSERT OR IGNORE INTO citations(
  citation_id,source_id,page_printed,page_file,locator_text,quoted_text,notes
) VALUES(
  'X0108','U0001',NULL,NULL,
  'User-supplied remaining Hajilou branches sheet, 2026-07-18',
  NULL,
  'Row/column reconstruction covering the Nasrollah Khan, Haji Safar Khan, and Haji Mina Khan branches. The archive owner defined ? as uncertain and ?? as highly uncertain.'
);

-- -------------------------------------------------------------------------
-- Haji Safar / Majzub Ali Shah branch corrections
-- -------------------------------------------------------------------------

UPDATE persons
SET preferred_name_en='Unnamed son of Sheikh Mohammad Jafar Khan Majzub Ali Shah',
    preferred_name_fa='پسر نامعلوم شیخ محمدجعفر خان مجذوب‌علیشاه',
    summary='First child shown beneath Sheikh Mohammad Jafar Khan Majzub Ali Shah in the user-supplied reconstruction. The name is unreadable and was marked ?? by the archive owner. The earlier Abd al-Javad reading is superseded.',
    verification_status='provisional',
    updated_at='2026-07-18T09:00:00Z'
WHERE person_id='P0100';

UPDATE person_names
SET is_preferred=0,
    name_type=CASE
      WHEN name_type='canonical' THEN 'superseded_reading'
      ELSE name_type
    END
WHERE person_id='P0100';

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0100','Unnamed son of Sheikh Mohammad Jafar Khan Majzub Ali Shah','en','canonical',1),
('P0100','پسر نامعلوم شیخ محمدجعفر خان مجذوب‌علیشاه','fa','canonical',1),
('P0100','??','und','user_transcription_with_uncertainty',0);

UPDATE persons
SET preferred_name_en='Agha Abdol Hamid Gharagozloo',
    preferred_name_fa='آقا عبدالحامد قراگوزلو',
    summary='One of the five children of Sheikh Mohammad Jafar Khan Majzub Ali Shah in the user-supplied reconstruction. The earlier Abd al-Majid reading is superseded.',
    verification_status='confirmed',
    updated_at='2026-07-18T09:00:00Z'
WHERE person_id='P0102';

UPDATE person_names
SET is_preferred=0,
    name_type=CASE
      WHEN name_type='canonical' THEN 'superseded_reading'
      ELSE name_type
    END
WHERE person_id='P0102';

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0102','Agha Abdol Hamid Gharagozloo','en','canonical',1),
('P0102','آقا عبدالحامد قراگوزلو','fa','canonical',1),
('P0102','Agha Abd Allah Hamid','en','user_form',0);

UPDATE persons
SET summary='One of the five children of Sheikh Mohammad Jafar Khan Majzub Ali Shah. The archive owner read the row as Mirza Ali Naghi ? Abadi Mojtahed; only the certain core name remains canonical.',
    verification_status='probable',
    updated_at='2026-07-18T09:00:00Z'
WHERE person_id='P0103';

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0103','Mirza Ali Naghi ? Abadi Mojtahed','en','user_transcription_with_uncertainty',0),
('P0103','میرزا علی‌نقی ؟ آبادی مجتهد','fa','user_transcription_with_uncertainty',0);

UPDATE relationships
SET notes='The user-supplied reconstruction shows an unnamed first child beneath Majzub Ali Shah; the name was marked ??. Earlier Abd al-Javad identification is superseded.',
    verification_status='provisional'
WHERE relationship_id='R0077';

UPDATE relationships
SET notes='The user-supplied reconstruction identifies this child as Agha Abdol Hamid.',
    verification_status='confirmed'
WHERE relationship_id='R0079';

UPDATE claims
SET object_text='Unnamed child of Sheikh Mohammad Jafar Khan Majzub Ali Shah (P0099)',
    confidence='possible',
    notes='The child is present in the chart, but the archive owner marked the name ??; earlier Abd al-Javad reading superseded.'
WHERE claim_id='C0194';

UPDATE claims
SET object_text='Agha Abdol Hamid, child of Sheikh Mohammad Jafar Khan Majzub Ali Shah (P0099)',
    confidence='confirmed',
    notes='Corrected from the earlier Abd al-Majid reading using the user-supplied branch reconstruction.'
WHERE claim_id='C0196';

UPDATE entity_citations
SET notes='Corrected by the archive owner: the first child is present but unnamed/unknown; earlier Abd al-Javad reading superseded.'
WHERE entity_citation_id='EC0161';

UPDATE entity_citations
SET notes='Corrected by the archive owner to Agha Abdol Hamid; earlier Abd al-Majid reading superseded.'
WHERE entity_citation_id='EC0163';

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES
('EC0232','person','P0100','X0108','supports','User sheet marks this child ??, preserving an unnamed node.'),
('EC0233','person','P0102','X0108','supports','User sheet identifies Agha Abdol Hamid.'),
('EC0234','person','P0103','X0108','supports','User sheet preserves the uncertain Abadi/Mojtahed descriptor.');

UPDATE research_questions
SET notes='The archive owner read the descriptor as Mirza Ali Naghi ? Abadi Mojtahed. The exact wording remains unresolved and is not promoted into the canonical name.'
WHERE question_id='Q0026';

INSERT OR IGNORE INTO research_questions(
  question_id,question,status,priority,notes
) VALUES(
  'Q0036',
  'What is the name of the first unnamed child of Sheikh Mohammad Jafar Khan Majzub Ali Shah in Figure 4?',
  'open','high',
  'The archive owner marked this child as ?? in the row/column reconstruction. Earlier identification as Abd al-Javad is superseded.'
);

-- -------------------------------------------------------------------------
-- Haji Mina branch corrections
-- -------------------------------------------------------------------------

UPDATE persons
SET preferred_name_en='Mohammad Hassan Khan Kabudarahangi Gharagozloo',
    preferred_name_fa='محمدحسن خان کبودراهنگی قراگوزلو',
    summary='One of two children of Mohammad Mirza Khan in the Haji Mina/Kabudarahangi branch. Corrected from Mohammad Hossein Khan to Mohammad Hassan Khan using the user-supplied reconstruction.',
    verification_status='confirmed',
    updated_at='2026-07-18T09:00:00Z'
WHERE person_id='P0113';

UPDATE person_names
SET is_preferred=0,
    name_type=CASE
      WHEN name_type='canonical' THEN 'superseded_reading'
      ELSE name_type
    END
WHERE person_id='P0113';

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0113','Mohammad Hassan Khan Kabudarahangi Gharagozloo','en','canonical',1),
('P0113','محمدحسن خان کبودراهنگی قراگوزلو','fa','canonical',1),
('P0113','Mohammad Hassan Khan','en','user_form',0),
('P0113','محمدحسن خان','fa','user_form',0);

UPDATE persons
SET summary='Child of Mansur al-Molk in the Haji Mina/Kabudarahangi branch. The archive owner read the row as Soltan Ali ? Khan; the canonical name is retained as probable.',
    verification_status='probable',
    updated_at='2026-07-18T09:00:00Z'
WHERE person_id='P0112';

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0112','Soltan Ali ? Khan','en','user_transcription_with_uncertainty',0),
('P0112','سلطان‌علی ؟ خان','fa','user_transcription_with_uncertainty',0);

UPDATE relationships
SET notes='Corrected from Mohammad Hossein Khan to Mohammad Hassan Khan using the archive owner’s row/column reconstruction.',
    verification_status='confirmed'
WHERE relationship_id='R0090';

UPDATE claims
SET object_text='Mohammad Hassan Khan, son of Mohammad Mirza Khan (P0110)',
    confidence='confirmed',
    notes='Corrected from the earlier Mohammad Hossein Khan reading.'
WHERE claim_id='C0217';

UPDATE entity_citations
SET notes='Corrected by the archive owner to Mohammad Hassan Khan; earlier Mohammad Hossein reading superseded.'
WHERE entity_citation_id='EC0187';

DELETE FROM identity_exclusions
WHERE exclusion_id='IX010';

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES
('EC0235','person','P0112','X0108','supports','User sheet marks Soltan Ali ? Khan as uncertain.'),
('EC0236','person','P0113','X0108','supports','User sheet corrects the name to Mohammad Hassan Khan.');

INSERT OR IGNORE INTO research_questions(
  question_id,question,status,priority,notes
) VALUES(
  'Q0037',
  'What is the exact full reading of Soltan Ali Khan in the Haji Mina branch?',
  'open','medium',
  'The archive owner transcribed the row as SoltanAli ? Khan.'
);

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary) VALUES
(
  '2026-07-18T09:00:00Z','person','P0100','correct',
  'Replaced the unsupported Abd al-Javad reading with an unnamed child node marked highly uncertain.'
),
(
  '2026-07-18T09:00:00Z','person','P0102','correct',
  'Corrected Abd al-Majid to Agha Abdol Hamid.'
),
(
  '2026-07-18T09:00:00Z','person','P0113','correct',
  'Corrected Mohammad Hossein Khan to Mohammad Hassan Khan in the Haji Mina branch.'
),
(
  '2026-07-18T09:00:00Z','person','P0112','update',
  'Preserved the user-marked uncertainty in the Soltan Ali Khan reading.'
);

INSERT OR REPLACE INTO metadata(key,value) VALUES('archive_version','2.6.9');
INSERT OR REPLACE INTO metadata(key,value) VALUES(
  'remaining_hajilou_user_corrections',
  'Nasrollah branch confirmed unchanged. Haji Safar branch corrected to unnamed child / Agha Mohammad Ebrahim / Agha Abdol Hamid / Mirza Ali-Naqi ? Abadi Mojtahed / Mirza Lotf Allah. Haji Mina branch corrected to Mohammad Hassan Khan and uncertainty preserved for Soltan Ali Khan.'
);
