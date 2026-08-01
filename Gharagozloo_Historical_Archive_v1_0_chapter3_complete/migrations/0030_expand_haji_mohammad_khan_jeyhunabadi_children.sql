-- Archive v2.7.2 — Expand Haji Mohammad Khan Jeyhunabadi's children
--
-- User-confirmed structure supplied on 2026-07-31:
--
-- Haji Mohammad Khan Jeyhunabadi
-- ├── Mohammad Baqer Khan
-- ├── Zolfaghar Khan
-- ├── Haji Yavar Mohammad Gholi Khan
-- │   ├── Fath Ali Khan
-- │   └── Sarhang Mohammad Amin Khan
-- ├── Haji Hamze Khan
-- │   ├── Haji Sadegh Khan
-- │   └── Haji Ali Khan
-- └── Kazem Khan
--     ├── ? Khan
--     ├── Haji Ali Khan
--     └── Sharif Khan
--
-- Important identity handling:
--   * Existing P0084 Kazem Khan is reparented from Mohammad Baqer Khan to
--     Haji Mohammad Khan Jeyhunabadi rather than duplicated.
--   * The two Haji Ali Khans are entered as separate people because they have
--     different fathers.
--   * "? Khan" is retained as an unnamed/provisional person.

INSERT OR IGNORE INTO citations(
  citation_id,source_id,page_printed,page_file,locator_text,quoted_text,notes
) VALUES(
  'X0111','U0001',NULL,NULL,
  'User-confirmed Jeyhunabadi branch expansion, 2026-07-31',
  NULL,
  'The archive owner supplied the sibling and descendant structure for Haji Mohammad Khan Jeyhunabadi, including one unreadable child recorded as ? Khan.'
);

-- -------------------------------------------------------------------------
-- Reparent the existing Kazem Khan instead of creating a duplicate.
-- -------------------------------------------------------------------------

UPDATE relationships
SET person1_id='P0001',
    notes='Corrected by the archive owner: Kazem Khan is a direct child of Haji Mohammad Khan Jeyhunabadi, not Mohammad Baqer Khan.',
    verification_status='confirmed'
WHERE relationship_id='R0060'
  AND person2_id='P0084';

UPDATE persons
SET branch='Hajilou / Jeyhunabadi',
    summary='Direct child of Haji Mohammad Khan Jeyhunabadi. The archive owner confirmed three children beneath him: an unnamed ? Khan, Haji Ali Khan, and Sharif Khan.',
    verification_status='confirmed',
    updated_at='2026-07-31T20:50:00-07:00'
WHERE person_id='P0084';

-- -------------------------------------------------------------------------
-- New direct children of Haji Mohammad Khan Jeyhunabadi.
-- -------------------------------------------------------------------------

INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES
(
  'P0158','Zolfaghar Khan Gharagozloo','ذوالفقار خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Jeyhunabadi',
  'Direct child of Haji Mohammad Khan Jeyhunabadi in the user-confirmed family reconstruction.',
  'confirmed','2026-07-31T20:50:00-07:00','2026-07-31T20:50:00-07:00'
),
(
  'P0159','Haji Yavar Mohammad Gholi Khan Gharagozloo','حاجی یاور محمدقلی خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Jeyhunabadi',
  'Direct child of Haji Mohammad Khan Jeyhunabadi and father of Fath Ali Khan and Sarhang Mohammad Amin Khan.',
  'confirmed','2026-07-31T20:50:00-07:00','2026-07-31T20:50:00-07:00'
),
(
  'P0160','Haji Hamze Khan Gharagozloo','حاجی حمزه خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Jeyhunabadi',
  'Direct child of Haji Mohammad Khan Jeyhunabadi and father of Haji Sadegh Khan and Haji Ali Khan.',
  'confirmed','2026-07-31T20:50:00-07:00','2026-07-31T20:50:00-07:00'
);

-- -------------------------------------------------------------------------
-- Descendants of Haji Yavar Mohammad Gholi Khan.
-- -------------------------------------------------------------------------

INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES
(
  'P0161','Fath Ali Khan Gharagozloo','فتحعلی خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Jeyhunabadi',
  'Child of Haji Yavar Mohammad Gholi Khan in the user-confirmed Jeyhunabadi branch.',
  'confirmed','2026-07-31T20:50:00-07:00','2026-07-31T20:50:00-07:00'
),
(
  'P0162','Sarhang Mohammad Amin Khan Gharagozloo','سرهنگ محمدامین خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Jeyhunabadi',
  'Child of Haji Yavar Mohammad Gholi Khan; distinguished by the military rank Sarhang.',
  'confirmed','2026-07-31T20:50:00-07:00','2026-07-31T20:50:00-07:00'
);

-- -------------------------------------------------------------------------
-- Descendants of Haji Hamze Khan.
-- -------------------------------------------------------------------------

INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES
(
  'P0163','Haji Sadegh Khan Gharagozloo','حاجی صادق خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Jeyhunabadi',
  'Child of Haji Hamze Khan in the user-confirmed Jeyhunabadi branch.',
  'confirmed','2026-07-31T20:50:00-07:00','2026-07-31T20:50:00-07:00'
),
(
  'P0164','Haji Ali Khan, son of Haji Hamze Khan','حاجی علی خان، فرزند حاجی حمزه خان','M',
  NULL,NULL,'Hajilou / Jeyhunabadi',
  'Child of Haji Hamze Khan. The parent qualifier distinguishes him from the separate Haji Ali Khan who is a child of Kazem Khan.',
  'confirmed','2026-07-31T20:50:00-07:00','2026-07-31T20:50:00-07:00'
);

-- -------------------------------------------------------------------------
-- Descendants of Kazem Khan.
-- -------------------------------------------------------------------------

INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES
(
  'P0165','Unnamed Khan, child of Kazem Khan','خان نامعلوم، فرزند کاظم خان','M',
  NULL,NULL,'Hajilou / Jeyhunabadi',
  'One of three children of Kazem Khan. The archive owner supplied the reading as ? Khan, so the personal name remains unknown.',
  'provisional','2026-07-31T20:50:00-07:00','2026-07-31T20:50:00-07:00'
),
(
  'P0166','Haji Ali Khan, son of Kazem Khan','حاجی علی خان، فرزند کاظم خان','M',
  NULL,NULL,'Hajilou / Jeyhunabadi',
  'Child of Kazem Khan. The parent qualifier distinguishes him from the separate Haji Ali Khan who is a child of Haji Hamze Khan.',
  'confirmed','2026-07-31T20:50:00-07:00','2026-07-31T20:50:00-07:00'
),
(
  'P0167','Sharif Khan Gharagozloo','شریف خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Jeyhunabadi',
  'Child of Kazem Khan in the user-confirmed Jeyhunabadi branch.',
  'confirmed','2026-07-31T20:50:00-07:00','2026-07-31T20:50:00-07:00'
);

-- Names
INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0158','Zolfaghar Khan Gharagozloo','en','canonical',1),
('P0158','ذوالفقار خان قراگوزلو','fa','canonical',1),
('P0159','Haji Yavar Mohammad Gholi Khan Gharagozloo','en','canonical',1),
('P0159','حاجی یاور محمدقلی خان قراگوزلو','fa','canonical',1),
('P0160','Haji Hamze Khan Gharagozloo','en','canonical',1),
('P0160','حاجی حمزه خان قراگوزلو','fa','canonical',1),
('P0161','Fath Ali Khan Gharagozloo','en','canonical',1),
('P0161','فتحعلی خان قراگوزلو','fa','canonical',1),
('P0162','Sarhang Mohammad Amin Khan Gharagozloo','en','canonical',1),
('P0162','سرهنگ محمدامین خان قراگوزلو','fa','canonical',1),
('P0163','Haji Sadegh Khan Gharagozloo','en','canonical',1),
('P0163','حاجی صادق خان قراگوزلو','fa','canonical',1),
('P0164','Haji Ali Khan, son of Haji Hamze Khan','en','canonical',1),
('P0164','حاجی علی خان، فرزند حاجی حمزه خان','fa','canonical',1),
('P0164','Haji Ali Khan','en','short_form',0),
('P0165','Unnamed Khan, child of Kazem Khan','en','canonical',1),
('P0165','خان نامعلوم، فرزند کاظم خان','fa','canonical',1),
('P0165','? Khan','en','user_transcription_with_uncertainty',0),
('P0166','Haji Ali Khan, son of Kazem Khan','en','canonical',1),
('P0166','حاجی علی خان، فرزند کاظم خان','fa','canonical',1),
('P0166','Haji Ali Khan','en','short_form',0),
('P0167','Sharif Khan Gharagozloo','en','canonical',1),
('P0167','شریف خان قراگوزلو','fa','canonical',1);

-- Relationships
INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES
('R0135','P0001','parent_of','P0158','User-confirmed direct child of Haji Mohammad Khan Jeyhunabadi.','confirmed'),
('R0136','P0001','parent_of','P0159','User-confirmed direct child of Haji Mohammad Khan Jeyhunabadi.','confirmed'),
('R0137','P0001','parent_of','P0160','User-confirmed direct child of Haji Mohammad Khan Jeyhunabadi.','confirmed'),
('R0138','P0159','parent_of','P0161','User-confirmed child of Haji Yavar Mohammad Gholi Khan.','confirmed'),
('R0139','P0159','parent_of','P0162','User-confirmed child of Haji Yavar Mohammad Gholi Khan.','confirmed'),
('R0140','P0160','parent_of','P0163','User-confirmed child of Haji Hamze Khan.','confirmed'),
('R0141','P0160','parent_of','P0164','User-confirmed child of Haji Hamze Khan.','confirmed'),
('R0142','P0084','parent_of','P0165','User-confirmed child of Kazem Khan; name unreadable as ? Khan.','provisional'),
('R0143','P0084','parent_of','P0166','User-confirmed child of Kazem Khan.','confirmed'),
('R0144','P0084','parent_of','P0167','User-confirmed child of Kazem Khan.','confirmed');

-- Claims and citations
INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES
('C0264','person','P0158','parentage','Child of Haji Mohammad Khan Jeyhunabadi (P0001)','confirmed','active','User-confirmed reconstruction.'),
('C0265','person','P0159','parentage','Child of Haji Mohammad Khan Jeyhunabadi (P0001)','confirmed','active','User-confirmed reconstruction.'),
('C0266','person','P0160','parentage','Child of Haji Mohammad Khan Jeyhunabadi (P0001)','confirmed','active','User-confirmed reconstruction.'),
('C0267','person','P0084','parentage','Child of Haji Mohammad Khan Jeyhunabadi (P0001)','confirmed','active','Corrected from Mohammad Baqer Khan.'),
('C0268','person','P0161','parentage','Child of Haji Yavar Mohammad Gholi Khan (P0159)','confirmed','active','User-confirmed reconstruction.'),
('C0269','person','P0162','parentage','Child of Haji Yavar Mohammad Gholi Khan (P0159)','confirmed','active','User-confirmed reconstruction.'),
('C0270','person','P0163','parentage','Child of Haji Hamze Khan (P0160)','confirmed','active','User-confirmed reconstruction.'),
('C0271','person','P0164','parentage','Child of Haji Hamze Khan (P0160)','confirmed','active','User-confirmed reconstruction.'),
('C0272','person','P0165','parentage','Child of Kazem Khan (P0084)','provisional','active','Relationship confirmed; name unreadable as ? Khan.'),
('C0273','person','P0166','parentage','Child of Kazem Khan (P0084)','confirmed','active','User-confirmed reconstruction.'),
('C0274','person','P0167','parentage','Child of Kazem Khan (P0084)','confirmed','active','User-confirmed reconstruction.');

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type)
SELECT claim_id,'X0111','supports'
FROM claims
WHERE claim_id BETWEEN 'C0264' AND 'C0274';

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
)
SELECT claim_id,'USER_SUPPLIED','user_supplied','presents',
       'Relationship supplied directly by the archive owner.'
FROM claims
WHERE claim_id BETWEEN 'C0264' AND 'C0274';

INSERT OR IGNORE INTO research_questions(
  question_id,question,status,priority,notes
) VALUES(
  'Q0039',
  'What is the personal name of the first child of Kazem Khan recorded only as ? Khan?',
  'open','high',
  'The relationship is user-confirmed, but the personal name is unreadable.'
);

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary) VALUES
(
  '2026-07-31T20:50:00-07:00','relationship','R0060','correct',
  'Reparented existing Kazem Khan from Mohammad Baqer Khan to Haji Mohammad Khan Jeyhunabadi.'
),
(
  '2026-07-31T20:50:00-07:00','person','P0158-P0167','insert',
  'Added ten new people to the Jeyhunabadi branch, including one unnamed provisional child.'
),
(
  '2026-07-31T20:50:00-07:00','relationship','R0135-R0144','insert',
  'Added ten user-confirmed parent-child relationships in the expanded Jeyhunabadi branch.'
);

INSERT OR REPLACE INTO metadata(key,value) VALUES('archive_version','2.7.2');
INSERT OR REPLACE INTO metadata(key,value) VALUES(
  'jeyhunabadi_branch_expansion',
  'Haji Mohammad Khan Jeyhunabadi now has five direct children: Mohammad Baqer, Zolfaghar, Haji Yavar Mohammad Gholi, Haji Hamze, and Kazem. Descendants were added beneath the latter three.'
);
