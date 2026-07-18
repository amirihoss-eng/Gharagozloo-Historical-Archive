-- Archive v2.6.0 — Hajilou/Ashiqloo backbone correction
--
-- Purpose:
--   Correct the graph-level conflation between the early Ashiqloo chief
--   Mohammad-Hossein Khan (P0011) and the Hajilou Jeyhunabadi/Amir Nezam line.
--
-- Evidence policy:
--   S0001 treats Mohammad-Hossein Khan as an Ashiqloo chief and identifies
--   Haji Mohammad Khan Jeyhunabadi and his descendants as Hajilou. The book
--   does not establish P0011 as the father of P0001. Migration 0013 already
--   downgraded R0011 to unverified; this migration removes that edge from the
--   canonical relationship graph while preserving the former hypothesis as a
--   disputed archival claim.

-- Preserve the rejected hypothesis before removing it from the graph.
INSERT OR IGNORE INTO claims(
  claim_id, subject_type, subject_id, predicate, object_text,
  confidence, status, notes
) VALUES (
  'C0159', 'person', 'P0001', 'formerly proposed parentage',
  'Mohammad-Hossein Khan Gharagozloo (P0011) was formerly placed as the father of Haji Mohammad Khan Jeyhunabadi (P0001).',
  'disputed', 'superseded',
  'Rejected for the canonical graph: S0001 identifies the two men with different branches and does not establish a parent-child relationship.'
);

INSERT OR IGNORE INTO citations(
  citation_id, source_id, page_printed, page_file,
  locator_text, quoted_text, notes
) VALUES
(
  'X0088', 'S0001', '59-61', NULL,
  'Chapter 2 branch and landed-family classification', NULL,
  'Textual evidence distinguishing the Hajilou and Ashiqloo lines and identifying the Jeyhunabadi/Amir Nezam family as Hajilou.'
),
(
  'X0089', 'S0001', '212-213', NULL,
  'Figures 3 and 4: separate Ashiqloo and Hajilou genealogies', NULL,
  'Visual corroboration that the book presents Ashiqloo and Hajilou as separate genealogical reconstructions; diagram evidence remains secondary to prose.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0159','X0088','contradicts'),
('C0159','X0089','contradicts');

-- Remove any evidence links attached to the obsolete graph edge, then the edge.
DELETE FROM entity_citations
WHERE entity_type='relationship' AND entity_id='R0011';

DELETE FROM relationships
WHERE relationship_id='R0011'
   OR (
      person1_id='P0011'
      AND relationship_type='parent_of'
      AND person2_id='P0001'
   );

-- Correct explicit branch assignments for the secure Jeyhunabadi/Amir Nezam line.
UPDATE persons SET
  branch='Hajilou',
  summary='Hajilou elder of the Jeyhunabadi line and the earliest securely connected ancestor of the archive owner''s direct line within S0001. The book does not establish him as a son of the early Ashiqloo chief Mohammad-Hossein Khan.',
  updated_at='2026-07-17T00:00:00Z'
WHERE person_id='P0001';

UPDATE persons SET branch='Hajilou', updated_at='2026-07-17T00:00:00Z'
WHERE person_id IN ('P0002','P0003','P0004','P0005','P0006');

-- Make the branch distinction explicit on the early Ashiqloo chief.
UPDATE persons SET
  branch='Ashiqloo',
  summary='Early Ashiqloo chief and father of five named Ashiqloo sons in S0001. He is not established by the book as the father of Haji Mohammad Khan Jeyhunabadi of the Hajilou line.',
  updated_at='2026-07-17T00:00:00Z'
WHERE person_id='P0011';

-- Record positive, source-based branch claims.
INSERT OR IGNORE INTO claims(
  claim_id, subject_type, subject_id, predicate, object_text,
  confidence, status, notes
) VALUES
(
  'C0160','person','P0001','branch affiliation','Hajilou',
  'confirmed','active','S0001 identifies the Jeyhunabadi/Amir Nezam family line as Hajilou.'
),
(
  'C0161','person','P0011','branch affiliation','Ashiqloo',
  'confirmed','active','S0001 identifies Mohammad-Hossein Khan as the early chief of the Ashiqloo line.'
),
(
  'C0162','person','P0001','earliest secure direct-line root',
  'Haji Mohammad Khan Jeyhunabadi is the earliest securely connected root of the archive owner''s displayed direct line pending reconstruction of earlier Hajilou generations.',
  'confirmed','active','This is an archive-level conclusion limited to the evidence currently established from S0001.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0160','X0088','supports'),
('C0160','X0089','supports'),
('C0161','X0088','supports'),
('C0161','X0089','supports'),
('C0162','X0088','supports');

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id, entity_type, entity_id, citation_id, support_type, notes
) VALUES
('EC0119','person','P0001','X0088','supports','Hajilou branch classification and direct-line context.'),
('EC0120','person','P0001','X0089','supports','Hajilou genealogy figure; secondary visual evidence.'),
('EC0121','person','P0011','X0088','supports','Ashiqloo branch classification.'),
('EC0122','person','P0011','X0089','supports','Ashiqloo genealogy figure; secondary visual evidence.');

-- Keep the unresolved earlier Hajilou reconstruction visible as research work,
-- rather than silently adding uncertain parent-child edges.
INSERT OR IGNORE INTO research_questions(question_id,question,status,priority,notes) VALUES
(
  'Q0015',
  'What exact sequence in S0001 Figure 4 connects the Zand-era Hajilou leadership of Haji Mohammad Jafar Khan to Haji Mohammad Khan Jeyhunabadi?',
  'open','high',
  'Requires careful transcription of the Hajilou genealogy and corroboration from surrounding prose before adding any canonical edge.'
),
(
  'Q0016',
  'Which early Hajilou persons in S0001 can be connected by explicit parent-child statements rather than diagram-only inference?',
  'open','high',
  'Book-only reconstruction must remain independent of the withheld handwritten family tree until the verification phase.'
);

-- Refresh reconciliation notes for the two pivotal records.
UPDATE person_reconciliation SET
  unresolved_summary='Canonical link to Haji Mohammad Khan Jeyhunabadi removed: the two men belong to separate Ashiqloo and Hajilou reconstructions. Shahbaz parentage remains probable within the Ashiqloo line.',
  updated_at='2026-07-17T00:00:00Z'
WHERE person_id='P0011';

UPDATE person_dossiers SET
  status='silver_s0001_reconciled',
  generated_from_migration='0018',
  updated_at='2026-07-17T00:00:00Z'
WHERE person_id IN ('P0001','P0002','P0003','P0004','P0005','P0006','P0011');

INSERT OR REPLACE INTO metadata(key,value) VALUES('archive_version','2.6.0');
INSERT OR REPLACE INTO metadata(key,value) VALUES(
  'hajilou_ashiqloo_backbone_correction',
  'Removed the unsupported P0011-to-P0001 parent edge; established Haji Mohammad Khan Jeyhunabadi as the earliest secure root of the displayed Hajilou direct line pending older Hajilou reconstruction.'
);
