-- Complete the atomic evidence layer for two established sons of Amanollah Khan.
-- Evidence enrichment only: the confirmed parent_of topology is unchanged.
PRAGMA foreign_keys = ON;

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES
('C1562','person','P0032','parentage',
 'Hossein Qoli Khan Zia al-Molk Gharagozloo P0032 was a son of Amanollah Khan Baha al-Molk Gharagozloo P0031.',
 'confirmed','active','Atomic parentage claim for existing confirmed relationship R0023; no topology change.'),
('C1563','person','P0034','parentage',
 'Morteza Qoli Khan Gharagozloo P0034 was a son of Amanollah Khan Baha al-Molk Gharagozloo P0031.',
 'confirmed','active','Atomic parentage claim for existing confirmed relationship R0025; no topology change.');

-- Figure 3 supplies the diagram evidence; the already-catalogued prose citation
-- independently names Amanollah's three sons and their descendant branches.
INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C1562','X0115','supports'),
('C1562','X0029','supports'),
('C1563','X0115','supports'),
('C1563','X0029','supports');

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES
('EC1535','relationship','R0023','X0115','supports','Figure 3 confirms Amanollah Khan P0031 -> Hossein Qoli Khan P0032.'),
('EC1536','relationship','R0023','X0029','supports','Alvandi prose independently names Hossein Qoli Khan among Amanollah Khan''s sons.'),
('EC1537','relationship','R0025','X0115','supports','Figure 3 confirms Amanollah Khan P0031 -> Morteza Qoli Khan P0034.'),
('EC1538','relationship','R0025','X0029','supports','Alvandi prose independently names Morteza Qoli Khan among Amanollah Khan''s sons.'),
('EC1539','person','P0032','X0115','supports','Figure 3 supports Hossein Qoli Khan''s placement beneath Amanollah Khan.'),
('EC1540','person','P0034','X0115','supports','Figure 3 supports Morteza Qoli Khan''s placement beneath Amanollah Khan.');

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary) VALUES
('2026-08-31T00:00:00Z','claim','C1562','add','Added explicit confirmed P0031 -> P0032 parentage claim using existing Alvandi Figure 3 and prose evidence.'),
('2026-08-31T00:00:00Z','claim','C1563','add','Added explicit confirmed P0031 -> P0034 parentage claim using existing Alvandi Figure 3 and prose evidence.'),
('2026-08-31T00:00:00Z','entity_citation','EC1535-EC1540','add','Attached existing Alvandi evidence to relationships R0023/R0025 and persons P0032/P0034 without changing topology.');

INSERT OR REPLACE INTO metadata(key,value) VALUES
('archive_version','2.10.3'),
('ashiqloo_amanollah_sons_evidence_0059','Added atomic confirmed parentage claims C1562 and C1563 for established relationships R0023 and R0025, reusing S0001 citations X0115 and X0029; topology unchanged.');
