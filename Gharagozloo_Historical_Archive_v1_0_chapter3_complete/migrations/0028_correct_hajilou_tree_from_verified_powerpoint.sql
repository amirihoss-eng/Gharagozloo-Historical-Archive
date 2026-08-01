-- Archive v2.7.0 — Correct the Hajilou graph from the verified PowerPoint
--
-- Authoritative reconstruction for this migration:
--   Gharagozloo_Hajilou_Family_Tree_Excel (3).pptx
--   plus the archive owner's three explicit spelling corrections:
--     * Assas/Hasan -> Assad Khan
--     * Haqssan/Hasan Agha -> Hassan Agha
--     * ShiaAli -> Shir Ali Khan
--
-- Scope:
--   * Correct only the Hajilou branches represented in the verified PowerPoint.
--   * Do not alter Haji Mohammad Khan Jeyhunabadi (P0001) or any descendant
--     of the Jeyhunabadi branch.
--
-- Major relationship corrections:
--   1. Khair Allah, Abdollah, and Aman Allah are children of Karim Khan,
--      not children of Ali Khan.
--   2. Noor Allah and Nasr Allah are both children of Habib Allah Khan.
--   3. Soltan Fath Ali is a child of Shir Ali Beg, not Mohammad Vali Beg.
--   4. Soltan Fath Ali has no child shown in the verified PowerPoint.
--   5. Assad Khan and Fath Ali Khan are children of Zolfaghar Khan.
--   6. Mohammad Khan Hajilou has four shown children, including one
--      unnamed/highly uncertain child.
--
-- The migration intentionally leaves the entire P0001 Jeyhunabadi branch
-- untouched.

INSERT OR IGNORE INTO citations(
  citation_id,source_id,page_printed,page_file,locator_text,quoted_text,notes
) VALUES(
  'X0109','U0001',NULL,NULL,
  'Verified PowerPoint connector reconstruction of the Hajilou family tree, 2026-07-31',
  NULL,
  'The archive owner reconstructed the family tree in PowerPoint using explicit parent-child connector objects and generation colors, then verified the assistant-generated conventional tree. This citation supports the relationship corrections in migration 0028.'
);

-- -------------------------------------------------------------------------
-- Relationship corrections from the verified connector objects
-- -------------------------------------------------------------------------

UPDATE relationships
SET person1_id='P0135',
    notes='Verified PowerPoint connectors identify Khair Allah Khan as a child of Karim Khan (P0135), not Ali Khan (P0130).',
    verification_status='confirmed'
WHERE relationship_id='R0109'
  AND person2_id='P0132';

UPDATE relationships
SET person1_id='P0135',
    notes='Verified PowerPoint connectors identify Abdollah Khan as a child of Karim Khan (P0135), not Ali Khan (P0130).',
    verification_status='confirmed'
WHERE relationship_id='R0110'
  AND person2_id='P0133';

UPDATE relationships
SET person1_id='P0135',
    notes='Verified PowerPoint connectors identify Aman Allah Khan as a child of Karim Khan (P0135), not Ali Khan (P0130).',
    verification_status='confirmed'
WHERE relationship_id='R0111'
  AND person2_id='P0134';

UPDATE relationships
SET person1_id='P0138',
    notes='Verified PowerPoint connectors identify Noor Allah Khan as a child of Habib Allah Khan (P0138), alongside Nasr Allah Khan.',
    verification_status='confirmed'
WHERE relationship_id='R0116'
  AND person2_id='P0139';

UPDATE relationships
SET person1_id='P0143',
    notes='Verified PowerPoint connectors identify Soltan Fath Ali (P0141) as a child of Shir Ali Beg (P0143), not Mohammad Vali Beg.',
    verification_status='probable'
WHERE relationship_id='R0118'
  AND person2_id='P0141';

-- The earlier spreadsheet interpretation created a spurious Hasan child under
-- Soltan Fath Ali. The verified PowerPoint contains no such relationship.
-- Preserve the person record only as superseded audit history, but remove the
-- unsupported graph edge so the node does not appear in the family tree.
DELETE FROM relationships
WHERE relationship_id='R0119' AND person2_id='P0142';

UPDATE persons
SET summary='Superseded provisional node created from the earlier spreadsheet interpretation. The verified PowerPoint contains no separate child beneath Soltan Fath Ali. This record is retained only for audit history and is disconnected from the canonical graph.',
    verification_status='provisional',
    updated_at='2026-07-31T18:47:00-07:00'
WHERE person_id='P0142';

UPDATE claims
SET status='superseded',
    confidence='unverified',
    notes='Superseded after verification of the PowerPoint connector objects; no separate child is shown beneath Soltan Fath Ali.'
WHERE claim_id='C0248';

-- -------------------------------------------------------------------------
-- Correct names explicitly verified by the archive owner
-- -------------------------------------------------------------------------

UPDATE persons
SET preferred_name_en='Assad Khan Gharagozloo',
    preferred_name_fa='اسد خان قراگوزلو',
    summary='Child of Zolfaghar Khan in the verified Hajilou PowerPoint tree. The earlier provisional Hasan/Assas reading is superseded; the archive owner confirmed Assad Khan.',
    verification_status='confirmed',
    updated_at='2026-07-31T18:47:00-07:00'
WHERE person_id='P0145';

UPDATE person_names
SET is_preferred=0,
    name_type=CASE
      WHEN name_type='canonical' THEN 'superseded_reading'
      ELSE name_type
    END
WHERE person_id='P0145';

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0145','Assad Khan Gharagozloo','en','canonical',1),
('P0145','اسد خان قراگوزلو','fa','canonical',1),
('P0145','Assas Khan ??','en','powerpoint_uncertain_form',0);

UPDATE persons
SET preferred_name_en='Hassan Agha Gharagozloo',
    preferred_name_fa='حسن آقا قراگوزلو',
    summary='Child of Mansur al-Molk in the Haji Mina/Kabudarahangi branch. The archive owner confirmed the English spelling Hassan Agha.',
    verification_status='confirmed',
    updated_at='2026-07-31T18:47:00-07:00'
WHERE person_id='P0111';

UPDATE person_names
SET is_preferred=0
WHERE person_id='P0111';

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0111','Hassan Agha Gharagozloo','en','canonical',1),
('P0111','حسن آقا قراگوزلو','fa','canonical',1),
('P0111','Haqssan Agha','en','powerpoint_misspelling',0);

UPDATE persons
SET preferred_name_en='Shir Ali Khan Kabudarahangi Gharagozloo',
    preferred_name_fa='شیرعلی خان کبودراهنگی قراگوزلو',
    summary='Son of Haji Mina Khan Kabudarahangi in the verified PowerPoint tree. The archive owner confirmed the reading Shir Ali Khan.',
    verification_status='confirmed',
    updated_at='2026-07-31T18:47:00-07:00'
WHERE person_id='P0108';

UPDATE person_names
SET is_preferred=0
WHERE person_id='P0108';

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0108','Shir Ali Khan Kabudarahangi Gharagozloo','en','canonical',1),
('P0108','شیرعلی خان کبودراهنگی قراگوزلو','fa','canonical',1),
('P0108','ShiaAli Khan','en','powerpoint_misspelling',0);

-- -------------------------------------------------------------------------
-- Add the unnamed fourth child shown under Mohammad Khan Hajilou
-- -------------------------------------------------------------------------

INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0157',
  'Unnamed child of Mohammad Khan Hajilou',
  'فرزند نامعلوم محمد خان حاجیلو',
  'M',NULL,NULL,'Hajilou / Royani',
  'One of four children shown beneath Mohammad Khan Hajilou in the verified PowerPoint. The label is ?? and the exact name is unknown.',
  'provisional',
  '2026-07-31T18:47:00-07:00',
  '2026-07-31T18:47:00-07:00'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0157','Unnamed child of Mohammad Khan Hajilou','en','canonical',1),
('P0157','فرزند نامعلوم محمد خان حاجیلو','fa','canonical',1),
('P0157','??','und','powerpoint_uncertain_form',0);

INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0134','P0153','parent_of','P0157',
  'Verified PowerPoint connectors show an additional unnamed child, labelled ??, beneath Mohammad Khan Hajilou.',
  'provisional'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0263','person','P0157','parentage',
  'Child of Mohammad Khan Hajilou Gharagozloo (P0153)',
  'unverified','active',
  'The relationship is visible in the verified PowerPoint, but the child’s name is unreadable and represented as ??.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0263','X0109','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0263','USER_SUPPLIED','user_supplied','presents',
  'Relationship derived from an explicit connector object in the archive owner’s verified PowerPoint.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES
('EC0237','person','P0157','X0109','supports','Unnamed child shown by a PowerPoint connector beneath Mohammad Khan Hajilou.'),
('EC0238','person','P0145','X0109','supports','Archive owner corrected the name to Assad Khan.'),
('EC0239','person','P0111','X0109','supports','Archive owner corrected the English spelling to Hassan Agha.'),
('EC0240','person','P0108','X0109','supports','Archive owner corrected the name to Shir Ali Khan.');

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0157','mentioned','Unnamed child under Mohammad Khan Hajilou in the verified PowerPoint tree.');

-- -------------------------------------------------------------------------
-- Update parentage claims to match the corrected connectors
-- -------------------------------------------------------------------------

UPDATE claims
SET object_text='Child of Karim Khan Gharagozloo (P0135)',
    confidence='confirmed',
    notes='Corrected from Ali Khan to Karim Khan using the verified PowerPoint connector objects.'
WHERE claim_id IN ('C0238','C0239','C0240');

UPDATE claims
SET object_text='Child of Habib Allah Khan Gharagozloo (P0138)',
    confidence='confirmed',
    notes='Corrected from Enayat Allah Khan to Habib Allah Khan using the verified PowerPoint connector objects.'
WHERE claim_id='C0245';

UPDATE claims
SET object_text='Child of Shir Ali Beg Gharagozloo (P0143)',
    confidence='probable',
    notes='Corrected from Mohammad Vali Beg to Shir Ali Beg using the verified PowerPoint connector objects.'
WHERE claim_id='C0247';

UPDATE claims
SET object_text='Child of Zolfaghar Khan Gharagozloo (P0144)',
    confidence='confirmed',
    notes='Name corrected to Assad Khan; parent-child relationship confirmed in the verified PowerPoint.'
WHERE claim_id='C0251';

-- -------------------------------------------------------------------------
-- Update summaries for corrected family groupings
-- -------------------------------------------------------------------------

UPDATE persons
SET summary='Child of Karim Khan Gharagozloo in the verified Hajilou PowerPoint tree.',
    updated_at='2026-07-31T18:47:00-07:00'
WHERE person_id IN ('P0132','P0133','P0134');

UPDATE persons
SET summary='Child of Habib Allah Khan Gharagozloo in the verified Hajilou PowerPoint tree.',
    updated_at='2026-07-31T18:47:00-07:00'
WHERE person_id='P0139';

UPDATE persons
SET summary='Child of Shir Ali Beg Gharagozloo in the verified Hajilou PowerPoint tree. The exact reading Soltan Fath Ali remains uncertain.',
    updated_at='2026-07-31T18:47:00-07:00'
WHERE person_id='P0141';

-- Preserve the corrected tree as an evidence conflict resolution.
UPDATE evidence_conflicts
SET resolution_status='resolved',
    notes='Resolved in favor of the archive owner’s verified PowerPoint connector reconstruction. The corrected canonical graph contains four immediate children of Haji Fazlollah and the exact later-generation connections implemented in migration 0028.'
WHERE conflict_id='CF005';

INSERT OR IGNORE INTO research_questions(
  question_id,question,status,priority,notes
) VALUES(
  'Q0038',
  'What is the name of the unnamed child of Mohammad Khan Hajilou shown as ?? in the verified PowerPoint tree?',
  'open','high',
  'The parent-child connector is verified, but the child’s label remains unreadable.'
);

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary) VALUES
(
  '2026-07-31T18:47:00-07:00','relationship','R0109-R0111','correct',
  'Reparented Khair Allah, Abdollah, and Aman Allah from Ali Khan to Karim Khan.'
),
(
  '2026-07-31T18:47:00-07:00','relationship','R0116','correct',
  'Reparented Noor Allah Khan from Enayat Allah Khan to Habib Allah Khan.'
),
(
  '2026-07-31T18:47:00-07:00','relationship','R0118','correct',
  'Reparented Soltan Fath Ali from Mohammad Vali Beg to Shir Ali Beg.'
),
(
  '2026-07-31T18:47:00-07:00','person','P0142','delete',
  'Disconnected the spurious Hasan node created by the earlier spreadsheet interpretation and retained it only as superseded audit history.'
),
(
  '2026-07-31T18:47:00-07:00','person','P0145','correct',
  'Corrected the name to Assad Khan and retained the verified parent Zolfaghar Khan.'
),
(
  '2026-07-31T18:47:00-07:00','person','P0157','insert',
  'Added the unnamed child shown beneath Mohammad Khan Hajilou.'
),
(
  '2026-07-31T18:47:00-07:00','scope','P0001','preserve',
  'Migration 0028 intentionally made no changes to Haji Mohammad Khan Jeyhunabadi or his descendants.'
);

INSERT OR REPLACE INTO metadata(key,value) VALUES('archive_version','2.7.0');
INSERT OR REPLACE INTO metadata(key,value) VALUES(
  'verified_hajilou_powerpoint_tree',
  'Canonical Hajilou relationships corrected from the archive owner’s verified PowerPoint connector objects. Haji Mohammad Khan Jeyhunabadi P0001 and descendants were explicitly excluded from the migration scope.'
);
