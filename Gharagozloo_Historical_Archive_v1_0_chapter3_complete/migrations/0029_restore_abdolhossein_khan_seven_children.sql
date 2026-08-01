-- Archive v2.7.1 — Restore all seven children of Abdolhossein Khan Farkhari
--
-- Verified direct children:
--   Mohammad Morad Beg; Fath Ali Beg; Mohammad Vali Beg; Shir Ali Beg;
--   Ghasem Khan; Moosa Khan; Mohammad Khan Hajilou.
--
-- Migration 0026 placed the first three beneath Hossein Ali Khan.
-- This migration reparents only those three people and preserves all existing
-- descendants beneath them.
--
-- Haji Mohammad Khan Jeyhunabadi (P0001) and descendants are untouched.

INSERT OR IGNORE INTO citations(
  citation_id,source_id,page_printed,page_file,locator_text,quoted_text,notes
) VALUES(
  'X0110','U0001',NULL,NULL,
  'Verified PowerPoint correction — seven children of Abdolhossein Khan Farkhari, 2026-07-31',
  NULL,
  'The archive owner confirmed that Mohammad Morad Beg, Fath Ali Beg, and Mohammad Vali Beg are direct children of Abdolhossein Khan Farkhari.'
);

UPDATE relationships
SET person1_id='P0118',
    notes='Corrected from Hossein Ali Khan to Abdolhossein Khan Farkhari using the verified PowerPoint.',
    verification_status='confirmed'
WHERE relationship_id='R0104' AND person2_id='P0127';

UPDATE relationships
SET person1_id='P0118',
    notes='Corrected from Hossein Ali Khan to Abdolhossein Khan Farkhari using the verified PowerPoint.',
    verification_status='confirmed'
WHERE relationship_id='R0105' AND person2_id='P0128';

UPDATE relationships
SET person1_id='P0118',
    notes='Corrected from Hossein Ali Khan to Abdolhossein Khan Farkhari using the verified PowerPoint.',
    verification_status='confirmed'
WHERE relationship_id='R0106' AND person2_id='P0129';

UPDATE relationships
SET person1_id='P0127',
    notes='Corrected from Heidar Qoli Khan to Mohammad Morad Beg using the verified PowerPoint. Karim Khan is one of Mohammad Morad Beg’s four direct children.',
    verification_status='confirmed'
WHERE relationship_id='R0112' AND person2_id='P0135';

UPDATE claims
SET object_text='Child of Abdolhossein Khan Farkhari Gharagozloo (P0118)',
    confidence='confirmed',
    notes='Corrected using the verified PowerPoint.'
WHERE claim_id IN ('C0233','C0234','C0235');

UPDATE claims
SET object_text='Child of Mohammad Morad Beg Gharagozloo (P0127)',
    confidence='confirmed',
    notes='Corrected from Heidar Qoli Khan to Mohammad Morad Beg using the verified PowerPoint.'
WHERE claim_id='C0241';

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0233','X0110','supports'),
('C0234','X0110','supports'),
('C0235','X0110','supports'),
('C0241','X0110','supports');

UPDATE persons
SET summary='Direct child of Abdolhossein Khan Farkhari in the verified Hajilou PowerPoint tree. His descendant group remains attached beneath him.',
    updated_at='2026-07-31T20:34:00-07:00'
WHERE person_id='P0127';

UPDATE persons
SET summary='Direct child of Abdolhossein Khan Farkhari in the verified Hajilou PowerPoint tree. No descendants are shown beneath him in that source.',
    updated_at='2026-07-31T20:34:00-07:00'
WHERE person_id IN ('P0128','P0129');

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES
('EC0241','person','P0127','X0110','supports','Verified as a direct child of Abdolhossein Khan Farkhari.'),
('EC0242','person','P0128','X0110','supports','Verified as a direct child of Abdolhossein Khan Farkhari.'),
('EC0243','person','P0129','X0110','supports','Verified as a direct child of Abdolhossein Khan Farkhari.'),
('EC0244','person','P0135','X0110','supports','Verified as a direct child of Mohammad Morad Beg.');

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary) VALUES
(
  '2026-07-31T20:34:00-07:00','relationship','R0104-R0106','correct',
  'Restored Mohammad Morad Beg, Fath Ali Beg, and Mohammad Vali Beg as direct children of Abdolhossein Khan Farkhari, giving him seven direct children.'
),
(
  '2026-07-31T20:34:00-07:00','relationship','R0112','correct',
  'Restored Karim Khan as a direct child of Mohammad Morad Beg.'
),
(
  '2026-07-31T20:34:00-07:00','scope','P0001','preserve',
  'Migration 0029 made no changes to Haji Mohammad Khan Jeyhunabadi or descendants.'
);

INSERT OR REPLACE INTO metadata(key,value) VALUES('archive_version','2.7.1');
INSERT OR REPLACE INTO metadata(key,value) VALUES(
  'abdolhossein_farkhari_children',
  'Seven direct children verified: Mohammad Morad Beg, Fath Ali Beg, Mohammad Vali Beg, Shir Ali Beg, Ghasem Khan, Moosa Khan, and Mohammad Khan Hajilou.'
);
