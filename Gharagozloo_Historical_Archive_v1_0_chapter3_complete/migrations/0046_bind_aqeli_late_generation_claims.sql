-- Migration 0046
-- Bind reviewed Aqeli late-generation claims from E0400 to canonical person records
-- Baseline: v2.9.2 / migration 0045
-- No genealogy topology changes.

UPDATE metadata SET value='2.9.3' WHERE key='database_version';
INSERT OR REPLACE INTO metadata(key,value) VALUES('last_migration','0046');
INSERT OR REPLACE INTO metadata(key,value) VALUES('updated_at','2026-08-04T03:05:00Z');

-- Hossein Qoli Khan Amir Nezam II -> P0012
UPDATE claims
SET subject_type='person', subject_id='P0012'
WHERE claim_id IN (
  'C1510','C1511','C1512','C1513','C1514','C1515',
  'C1516','C1517','C1518','C1519','C1520','C1521'
)
AND subject_type='event' AND subject_id='E0400';

-- Mohtaj Ali Khan Amir Arfa' -> P0005
UPDATE claims
SET subject_type='person', subject_id='P0005'
WHERE claim_id IN ('C1537','C1538','C1539','C1540')
AND subject_type='event' AND subject_id='E0400';

-- Mansur Ali Khan Sardar Akram -> P0006
UPDATE claims
SET subject_type='person', subject_id='P0006'
WHERE claim_id IN ('C1541','C1542','C1543','C1544','C1545')
AND subject_type='event' AND subject_id='E0400';

-- Gholamhossein Khan Amiri Gharagozloo -> P0008
UPDATE claims
SET subject_type='person', subject_id='P0008'
WHERE claim_id IN ('C1530','C1531','C1532','C1533','C1534','C1535','C1536')
AND subject_type='event' AND subject_id='E0400';

-- Direct entity citations
INSERT OR IGNORE INTO entity_citations(
    entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES
('EC1510','person','P0012','X1501','supports','Aqeli biography attached to canonical Hossein Qoli Khan Amir Nezam II.'),
('EC1511','person','P0005','X1505','supports','Aqeli biography attached to canonical Mohtaj Ali Khan Amir Arfa.'),
('EC1512','person','P0006','X1506','supports','Aqeli biography attached to canonical Mansur Ali Khan Sardar Akram.'),
('EC1513','person','P0008','X1503','supports','Aqeli biography attached to canonical Gholamhossein Khan Amiri Gharagozloo.'),
('EC1514','person','P0008','X1504','supports','Aqeli waqf evidence attached to canonical Gholamhossein Khan Amiri Gharagozloo.');

-- Resolve identity-binding research question
UPDATE research_questions
SET status='resolved',
    notes=COALESCE(notes,'') || ' Resolved in migration 0046 using live canonical IDs: P0012 Hossein Qoli Khan, P0005 Mohtaj Ali Khan, P0006 Mansur Ali Khan, P0008 Gholamhossein Khan Amiri.'
WHERE question_id='Q0161';

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES
('2026-08-04T03:05:00Z','person','P0012','aqeli_identity_binding','Bound reviewed Aqeli claims from E0400 to Hossein Qoli Khan Amir Nezam II.'),
('2026-08-04T03:05:00Z','person','P0005','aqeli_identity_binding','Bound reviewed Aqeli claims from E0400 to Mohtaj Ali Khan Amir Arfa.'),
('2026-08-04T03:05:00Z','person','P0006','aqeli_identity_binding','Bound reviewed Aqeli claims from E0400 to Mansur Ali Khan Sardar Akram.'),
('2026-08-04T03:05:00Z','person','P0008','aqeli_identity_binding','Bound reviewed Aqeli claims from E0400 to Gholamhossein Khan Amiri Gharagozloo.'),
('2026-08-04T03:05:00Z','migration','0046','apply','Bound reviewed Aqeli late-generation claims to exact canonical person records; genealogy unchanged.');
