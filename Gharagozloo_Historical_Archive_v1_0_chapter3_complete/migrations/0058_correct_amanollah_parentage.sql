-- Correct the confirmed Figure 3 parentage of Amanollah Khan Baha al-Molk.
-- Preserve the former Nabi -> Amanollah interpretation as superseded history.
PRAGMA foreign_keys = ON;

-- Retain the incorrect relationship record and its provenance, but remove it
-- from active canonical topology.
UPDATE relationships
SET verification_status='superseded',
    notes='Superseded in migration 0058 after confirmed rereading of S0001 Figure 3 (X0115): Figure 3 places Amanollah Khan Baha al-Molk beneath Mahmoud Khan, not directly beneath Nabi Khan. The former prose-based interpretation is retained here for audit history.'
WHERE relationship_id='R0022'
  AND person1_id='P0013'
  AND relationship_type='parent_of'
  AND person2_id='P0031';

-- Nabi -> Mahmoud already exists as confirmed R0014. Add only the missing
-- Mahmoud -> Amanollah edge shown in Figure 3.
INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES (
  'R0169','P0014','parent_of','P0031',
  'S0001 Figure 3 (X0115, printed p. 212) places Amanollah Khan Baha al-Molk beneath Mahmoud Khan in the Ashiqloo genealogy.',
  'confirmed'
);

UPDATE persons
SET summary='Son of Mahmoud Khan Gharagozloo P0014; founder of the Baha al-Molk Abshini family.',
    updated_at='2026-08-22T21:00:00Z'
WHERE person_id='P0031';

-- Preserve the earlier claim verbatim but mark it superseded.
UPDATE claims
SET status='superseded',
    notes='Superseded in migration 0058. Confirmed rereading of S0001 Figure 3 (X0115) establishes Mahmoud Khan P0014, not Nabi Khan P0013, as Amanollah''s father. Original claim and X0029 provenance retained for history.'
WHERE claim_id='C0059'
  AND subject_type='person'
  AND subject_id='P0031';

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES (
  'C1561','person','P0031','parentage',
  'Amanollah Khan Baha al-Molk Gharagozloo P0031 was a son of Mahmoud Khan Gharagozloo P0014.',
  'confirmed','active','Confirmed from the literal bracket structure of S0001 Figure 3, printed page 212.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C1561','X0115','supports');

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES
('EC1530','relationship','R0014','X0115','supports','Figure 3 confirms Nabi Khan P0013 -> Mahmoud Khan P0014.'),
('EC1531','relationship','R0169','X0115','supports','Figure 3 confirms Mahmoud Khan P0014 -> Amanollah Khan P0031.'),
('EC1532','person','P0031','X0115','supports','Figure 3 supports Amanollah''s corrected canonical placement.'),
('EC1533','research_question','Q0040','X0115','supports','Confirmed figure reading resolves the earlier compression-versus-parentage question.'),
('EC1534','evidence_conflict','CF006','X0115','supports','Confirmed figure reading resolves the preserved parentage conflict.');

-- Preserve the original competing statements while recording the confirmed
-- resolution and canonical action.
UPDATE evidence_conflicts
SET resolution_status='resolved',
    notes='Resolved in migration 0058 after confirmed rereading of S0001 Figure 3 (X0115). The figure asserts Nabi -> Mahmoud -> Amanollah. Canonical relationship R0022 was superseded and R0169 added; the former interpretation remains preserved as evidence history.'
WHERE conflict_id='CF006';

UPDATE research_questions
SET status='resolved',
    notes='Resolved in migration 0058 by confirmed direct reading of S0001 Figure 3 (X0115): the bracket structure asserts Nabi Khan P0013 -> Mahmoud Khan P0014 -> Amanollah Khan Baha al-Molk P0031. R0022 is superseded and R0169 is canonical.'
WHERE question_id='Q0040';

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary) VALUES
('2026-08-22T21:00:00Z','relationship','R0022','supersede','Superseded the incorrect active Nabi Khan P0013 -> Amanollah Khan P0031 relationship while preserving its history and provenance.'),
('2026-08-22T21:00:00Z','relationship','R0169','add','Added confirmed Mahmoud Khan P0014 -> Amanollah Khan Baha al-Molk P0031 from S0001 Figure 3.'),
('2026-08-22T21:00:00Z','claim','C0059','supersede','Superseded the former direct Nabi-to-Amanollah parentage claim; retained its original citation history.'),
('2026-08-22T21:00:00Z','claim','C1561','add','Added confirmed Amanollah parentage under Mahmoud Khan with X0115.'),
('2026-08-22T21:00:00Z','evidence_conflict','CF006','resolve','Resolved the Figure 3 parentage conflict in favor of Nabi -> Mahmoud -> Amanollah.'),
('2026-08-22T21:00:00Z','research_question','Q0040','resolve','Closed the Amanollah Figure 3 compression-versus-parentage question.'),
('2026-08-22T21:00:00Z','person','P0031','correct','Corrected Amanollah Khan Baha al-Molk summary to identify Mahmoud Khan P0014 as his father.');

INSERT OR REPLACE INTO metadata(key,value) VALUES
('archive_version','2.10.2'),
('ashiqloo_amanollah_parentage_0058','Confirmed S0001 Figure 3 chain P0013 Nabi Khan -> P0014 Mahmoud Khan -> P0031 Amanollah Khan Baha al-Molk. R0022 and C0059 preserved as superseded history; R0169 and C1561 are active canonical records.');
