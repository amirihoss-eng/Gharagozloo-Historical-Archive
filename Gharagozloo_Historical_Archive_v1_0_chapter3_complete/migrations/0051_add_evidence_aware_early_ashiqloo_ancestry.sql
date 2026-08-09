-- 0051_add_evidence_aware_early_ashiqloo_ancestry.sql
-- Archive v2.9.8 — evidence-aware early Ashiqloo ancestry.
--
-- This migration DOES NOT invent a common Hajilou/Ashiqloo ancestor.
-- The shared Gharagozloo context node is UI-only.
--
-- Source basis:
--   S0001 (Reza Alvandi, Gharagozloos and Their Role...)
--   Chapter 2, pp. 59-60:
--     * Alvandi says Mohammad Hossein Khan is probably the son of Shahbaz Khan,
--       citing Golestaneh's report that leadership passed to Shahbaz's eldest son
--       Mohammad Hossein after Shahbaz's death.
--     * Alvandi separately says it is possible that Shahbaz was among the
--       descendants of Safavid-era Ebrahim Khan Gharagozloo, explicitly treating
--       that as conjecture.
--
-- No Hajilou canonical parent-child topology is changed.

PRAGMA foreign_keys = ON;

INSERT OR IGNORE INTO relationships(
    relationship_id, person1_id, relationship_type, person2_id, notes, verification_status
) VALUES (
    'R0158','P0072','parent_of','P0011',
    'Alvandi treats Shahbaz Khan as the probable father of Mohammad Hossein Khan. The inference rests on Golestaneh''s succession account: Shahbaz, head of the Ashiqloo line, died in old age and leadership passed to his eldest son Mohammad Hossein. This is probable, not proven parentage.',
    'probable'
);

INSERT OR IGNORE INTO relationships(
    relationship_id, person1_id, relationship_type, person2_id, notes, verification_status
) VALUES (
    'R0159','P0070','ancestral_hypothesis','P0072',
    'Alvandi raises the possibility that Shahbaz Khan was among the descendants of Safavid-era Ebrahim Khan Gharagozloo. This is an ancestry hypothesis only and is NOT a direct parent-child assertion.',
    'possible'
);

INSERT OR IGNORE INTO citations(
    citation_id, source_id, page_printed, page_file, locator_text, quoted_text, notes
) VALUES
('X1512','S0001','59-60',NULL,
 'Chapter 2 — early Ashiqloo leadership and succession from Shahbaz Khan to Mohammad Hossein Khan',
 NULL,
 'Supports only probable father-son reconstruction; Alvandi frames the relationship as a probability based on Golestaneh.'),
('X1513','S0001','60',NULL,
 'Chapter 2 — conjectured earlier ancestry of Shahbaz Khan',
 NULL,
 'Alvandi explicitly presents descent from Safavid Ebrahim Khan as a possibility/conjecture, not established genealogy.');

INSERT OR IGNORE INTO claims(
    claim_id, subject_type, subject_id, predicate, object_text, confidence, status, notes
) VALUES
('C1549','person','P0011','parentage',
 'Shahbaz Khan Gharagozloo was probably the father of Mohammad Hossein Khan Gharagozloo.',
 'probable','active',
 'Evidence-layer reconstruction from Alvandi/Golestaneh succession narrative; represented by dashed graph line.'),
('C1550','person','P0072','ancestry_hypothesis',
 'Shahbaz Khan Gharagozloo may have been among the descendants of Safavid-era Ebrahim Khan Gharagozloo.',
 'possible','active',
 'Not direct parentage. Represented by dotted graph line as a historical ancestry hypothesis.');

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C1549','X1512','supports'),
('C1550','X1513','supports');

UPDATE persons
SET branch='Ashiqloo',
    summary='Gharagozloo leader who joined Karim Khan Zand with a force described as two thousand men. Alvandi, drawing on Golestaneh, treats Shahbaz Khan as the probable father/predecessor of Mohammad Hossein Khan P0011; this parentage is not proven.',
    updated_at='2026-08-05T00:00:00Z'
WHERE person_id='P0072';

UPDATE persons
SET summary='Early Ashiqloo chief and father of five named Ashiqloo sons in S0001. Alvandi treats Shahbaz Khan P0072 as his probable father based on the reported succession from Shahbaz to his eldest son Mohammad Hossein. He is not established by the book as the father of Haji Mohammad Khan Jeyhunabadi of the Hajilou line.',
    updated_at='2026-08-05T00:00:00Z'
WHERE person_id='P0011';

UPDATE persons
SET summary='Safavid official who served as beglerbeg of Astarabad, Gilan, and Mazandaran and was appointed governor of Kerman in 1129 AH. Alvandi raises only a conjectural possibility that Shahbaz Khan P0072 descended from him; the archive does not treat this as direct parentage.',
    updated_at='2026-08-05T00:00:00Z'
WHERE person_id='P0070';

INSERT OR IGNORE INTO research_questions(question_id,question,status,priority,notes) VALUES
('Q0164',
 'Can the proposed descent of Shahbaz Khan Gharagozloo from Safavid-era Ebrahim Khan Gharagozloo be independently corroborated?',
 'open','high',
 'Currently only a historical hypothesis in S0001; do not promote to direct parentage without additional evidence.'),
('Q0165',
 'Who was the specific named common ancestor, if recoverable, of the surviving Hajilou and Ashiqloo genealogical trunks?',
 'open','high',
 'Explorer now uses a non-person historical context node to show common Gharagozloo tribal ancestry without inventing a father.');

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary) VALUES
('2026-08-05T00:00:00Z','relationship','R0158','add',
 'Added probable Shahbaz Khan → Mohammad Hossein Khan parentage with source citation and evidence-aware graph status.'),
('2026-08-05T00:00:00Z','relationship','R0159','add',
 'Added non-parental ancestry hypothesis from Safavid Ebrahim Khan to Shahbaz Khan; explicitly marked possible.'),
('2026-08-05T00:00:00Z','explorer','CTX_GHARAGOZLOO','design',
 'Explorer uses a UI-only common Gharagozloo ancestry context node; no fictional person was added to archive.sqlite.');
