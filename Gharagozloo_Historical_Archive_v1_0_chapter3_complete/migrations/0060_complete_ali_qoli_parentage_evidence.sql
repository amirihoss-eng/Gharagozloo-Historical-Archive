-- Complete the atomic evidence layer for Ali Qoli, the third established son of Amanollah Khan.
-- Evidence normalization only: the confirmed parent_of topology is unchanged.
PRAGMA foreign_keys = ON;

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES
('C1564','person','P0033','parentage',
 'Ali Qoli Khan Baha al-Molk P0033 was a son of Amanollah Khan Baha al-Molk Gharagozloo P0031.',
 'confirmed','active','Atomic parentage claim for existing confirmed relationship R0024; no topology change.');

-- Figure 3 supplies the diagram evidence; the already-catalogued prose citation
-- independently names Amanollah's three sons and their descendant branches.
INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C1564','X0115','supports'),
('C1564','X0029','supports');

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES
('EC1541','relationship','R0024','X0115','supports','Figure 3 confirms Amanollah Khan P0031 -> Ali Qoli Khan P0033.'),
('EC1542','relationship','R0024','X0029','supports','Alvandi prose independently names Ali Qoli Khan among Amanollah Khan''s sons.'),
('EC1543','person','P0033','X0115','supports','Figure 3 supports Ali Qoli Khan''s placement beneath Amanollah Khan.');

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary) VALUES
('2026-08-31T00:00:00Z','claim','C1564','add','Added explicit confirmed P0031 -> P0033 parentage claim using existing Alvandi Figure 3 and prose evidence.'),
('2026-08-31T00:00:00Z','entity_citation','EC1541-EC1543','add','Attached existing Alvandi evidence to relationship R0024 and person P0033 without changing topology.');

INSERT OR REPLACE INTO metadata(key,value) VALUES
('archive_version','2.10.4'),
('ashiqloo_ali_qoli_parentage_evidence_0060','Added atomic confirmed parentage claim C1564 for established relationship R0024, reusing S0001 citations X0115 and X0029; topology unchanged.');
