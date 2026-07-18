-- Archive v2.6.4 — Reconstruct the older Hajilou trunk from S0001
--
-- Evidence used:
--   * S0001 narrative, printed pp. 58–59
--   * S0001 Figure 4, printed p. 213
--   * Human-verified reading of the Persian labels in Figure 4
--
-- Important source conflict:
--   Figure 4 places Haji Mina Khan among the five sons of Haji Abdollah Khan.
--   The prose on p. 58 can be read as placing Haji Mina among the sons of
--   Haji Mohammad Jafar Khan. The canonical graph follows Figure 4 for now,
--   but the edge remains disputed and the conflict is preserved explicitly.

INSERT OR IGNORE INTO citations(
  citation_id, source_id, page_printed, page_file, locator_text, quoted_text, notes
) VALUES
(
  'X0093','S0001','58-59',NULL,
  'Chapter 2 — early Hajilou leadership and genealogy',
  NULL,
  'The narrative identifies Haji Mohammad Jafar Khan as Hajilou chief in the Zand period; states that Haji Abdollah Khan was his son and had five male children; identifies Haji Safar as a son of Haji Abdollah; and names Haji Fazlollah Royani, Haji Mohammad Khan Jeyhunabadi, Nasrollah Khan Korijani, and Haji Mina Khan Kabudarahangi in the early Hajilou family discussion.'
),
(
  'X0094','S0001','213',NULL,
  'Figure 4 — older Hajilou trunk above the Jeyhunabadi line',
  NULL,
  'The diagram shows Haji Mohammad Jafar Khan above Haji Abdollah Khan and places five branch heads beneath Haji Abdollah: Haji Fazlollah Khan, Nasrollah Khan, Haji Safar Khan, Haji Mina Khan Kabudarahangi, and Haji Mohammad Khan Jeyhunabadi. Persian labels were reviewed directly with the archive owner.'
);

INSERT OR IGNORE INTO persons(
  person_id, preferred_name_en, preferred_name_fa, sex,
  birth_date_text, death_date_text, branch, summary,
  verification_status, created_at, updated_at
) VALUES
(
  'P0094','Haji Mohammad Jafar Khan Gharagozloo',
  'حاجی محمدجعفر خان قراگوزلو','M',NULL,NULL,'Hajilou',
  'Zand-period head of the Hajilou branch in S0001. The prose and Figure 4 identify Haji Abdollah Khan as his son.',
  'confirmed','2026-07-18T04:00:00Z','2026-07-18T04:00:00Z'
),
(
  'P0095','Haji Abdollah Khan Gharagozloo',
  'حاجی عبدالله خان قراگوزلو','M',NULL,NULL,'Hajilou',
  'Hajilou elder and chief in the time of Karim Khan Zand; described as a governor of Hamadan. S0001 states that he was the son of Haji Mohammad Jafar Khan and had five male children.',
  'confirmed','2026-07-18T04:00:00Z','2026-07-18T04:00:00Z'
),
(
  'P0096','Haji Fazlollah Khan Royani Gharagozloo',
  'حاجی فضل‌الله خان رویانی قراگوزلو','M',NULL,NULL,'Hajilou / Royani',
  'Early Hajilou figure named in the prose and shown in Figure 4 as one of the five branch heads below Haji Abdollah Khan.',
  'probable','2026-07-18T04:00:00Z','2026-07-18T04:00:00Z'
),
(
  'P0097','Haji Safar Khan Gharagozloo',
  'حاجی صفر خان قراگوزلو','M',NULL,NULL,'Hajilou',
  'Son of Haji Abdollah Khan in the narrative and Figure 4; father of the later Haji Mohammad Jafar known as Majzub Ali Shah Kabudarahangi.',
  'confirmed','2026-07-18T04:00:00Z','2026-07-18T04:00:00Z'
),
(
  'P0098','Haji Mina Khan Kabudarahangi Gharagozloo',
  'حاجی مینا خان کبودراهنگی قراگوزلو','M',NULL,NULL,'Hajilou / Kabudarahangi',
  'Early Hajilou statesman described as an adviser to Agha Mohammad Khan Qajar. Figure 4 places him among the five sons of Haji Abdollah Khan, while the prose may place him one generation earlier; parentage remains disputed.',
  'confirmed','2026-07-18T04:00:00Z','2026-07-18T04:00:00Z'
);

UPDATE persons
SET branch='Hajilou / Korijani',
    summary='Influential Zand-era Hajilou commander and political actor. S0001 names him as Nasrollah Khan Korijani and Figure 4 places him among the five branch heads beneath Haji Abdollah Khan.',
    updated_at='2026-07-18T04:00:00Z'
WHERE person_id='P0073';

UPDATE persons
SET summary='Hajilou elder of the Jeyhunabadi line. Figure 4 places him among the five sons of Haji Abdollah Khan; he is the earliest previously established ancestor of the archive owner''s direct line.',
    updated_at='2026-07-18T04:00:00Z'
WHERE person_id='P0001';

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0094','Haji Mohammad Jafar Khan Gharagozloo','en','canonical',1),
('P0094','حاجی محمدجعفر خان قراگوزلو','fa','canonical',1),
('P0095','Haji Abdollah Khan Gharagozloo','en','canonical',1),
('P0095','حاجی عبدالله خان قراگوزلو','fa','canonical',1),
('P0096','Haji Fazlollah Khan Royani Gharagozloo','en','canonical',1),
('P0096','حاجی فضل‌الله خان رویانی قراگوزلو','fa','canonical',1),
('P0097','Haji Safar Khan Gharagozloo','en','canonical',1),
('P0097','حاجی صفر خان قراگوزلو','fa','canonical',1),
('P0098','Haji Mina Khan Kabudarahangi Gharagozloo','en','canonical',1),
('P0098','حاجی مینا خان کبودراهنگی قراگوزلو','fa','canonical',1),
('P0073','Nasrollah Khan Korijani Gharagozloo','en','geographic_form',0),
('P0073','نصرالله خان کوریجانی قراگوزلو','fa','geographic_form',0);

INSERT OR IGNORE INTO identity_exclusions(
  exclusion_id, person_id, excluded_identity_text, reason, evidence_basis
) VALUES
(
  'IX007','P0096','Fazlollah Khan Gharagozloo (P0062), son of Mohammad-Hossein Khan Ashiqloo',
  'Same personal name, but a different branch, father, and generation.',
  'S0001 narrative and separate Figures 3–4'
);

INSERT OR IGNORE INTO relationships(
  relationship_id, person1_id, relationship_type, person2_id, notes, verification_status
) VALUES
(
  'R0070','P0094','parent_of','P0095',
  'Explicit in the Chapter 2 prose and represented in Figure 4.',
  'confirmed'
),
(
  'R0071','P0095','parent_of','P0096',
  'Figure 4 places Haji Fazlollah Khan Royani among the five branch heads below Haji Abdollah Khan; prose names him in the same early Hajilou family discussion.',
  'probable'
),
(
  'R0072','P0095','parent_of','P0073',
  'Figure 4 places Nasrollah Khan Korijani among the five branch heads below Haji Abdollah Khan; prose names him in the same early Hajilou family discussion.',
  'probable'
),
(
  'R0073','P0095','parent_of','P0097',
  'The prose explicitly traces Majzub Ali Shah through his father Haji Safar Khan to Haji Abdollah Khan; Figure 4 agrees.',
  'confirmed'
),
(
  'R0074','P0095','parent_of','P0098',
  'Figure 4 places Haji Mina Khan below Haji Abdollah Khan. The prose may instead place him among the sons of Haji Mohammad Jafar Khan; retained as disputed pending resolution.',
  'disputed'
),
(
  'R0075','P0095','parent_of','P0001',
  'Figure 4 places Haji Mohammad Khan Jeyhunabadi among the five branch heads below Haji Abdollah Khan; prose names him in the same early Hajilou family discussion.',
  'probable'
);

INSERT OR IGNORE INTO claims(
  claim_id, subject_type, subject_id, predicate, object_text,
  confidence, status, notes
) VALUES
('C0180','person','P0094','branch leadership','Head of the Hajilou branch during the Zand period','confirmed','active','Explicit narrative statement in S0001.'),
('C0181','person','P0095','parentage','Son of Haji Mohammad Jafar Khan Gharagozloo (P0094)','confirmed','active','Explicit narrative statement and Figure 4.'),
('C0182','person','P0095','children count','Five male children','confirmed','active','Explicit narrative statement; Figure 4 presents five branch heads.'),
('C0183','person','P0096','parentage','Son of Haji Abdollah Khan Gharagozloo (P0095)','probable','active','Figure 4 reconstruction, supported contextually by the prose.'),
('C0184','person','P0073','parentage','Son of Haji Abdollah Khan Gharagozloo (P0095)','probable','active','Figure 4 reconstruction, supported contextually by the prose.'),
('C0185','person','P0097','parentage','Son of Haji Abdollah Khan Gharagozloo (P0095)','confirmed','active','Explicit narrative statement and Figure 4.'),
('C0186','person','P0098','parentage','Son of Haji Abdollah Khan Gharagozloo (P0095)','disputed','active','Figure 4 supports this placement, but the prose may place Haji Mina one generation earlier.'),
('C0187','person','P0001','parentage','Son of Haji Abdollah Khan Gharagozloo (P0095)','probable','active','Figure 4 reconstruction, supported contextually by the prose.'),
('C0188','person','P0098','alternative parentage','Possible son of Haji Mohammad Jafar Khan Gharagozloo (P0094)','disputed','active','A literal reading of the prose can place Haji Mina among the sons of Haji Mohammad Jafar Khan.');

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0180','X0093','supports'),
('C0181','X0093','supports'),
('C0181','X0094','supports'),
('C0182','X0093','supports'),
('C0182','X0094','supports'),
('C0183','X0094','supports'),
('C0183','X0093','supports'),
('C0184','X0094','supports'),
('C0184','X0093','supports'),
('C0185','X0093','supports'),
('C0185','X0094','supports'),
('C0186','X0094','supports'),
('C0186','X0093','conflicts'),
('C0187','X0094','supports'),
('C0187','X0093','supports'),
('C0188','X0093','supports'),
('C0188','X0094','conflicts');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES
('C0180','NARRATIVE_FACT','author_statement','supports','Direct narrative identification of the Zand-period Hajilou chief.'),
('C0181','NARRATIVE_FACT','author_statement','supports','Direct prose corroborated by Figure 4.'),
('C0182','NARRATIVE_FACT','author_statement','supports','The prose states that Haji Abdollah had five male children.'),
('C0183','GENEALOGICAL_DIAGRAM','genealogical_diagram','presents','Relationship reconstructed from Figure 4.'),
('C0184','GENEALOGICAL_DIAGRAM','genealogical_diagram','presents','Relationship reconstructed from Figure 4.'),
('C0185','NARRATIVE_FACT','author_statement','supports','Direct prose corroborated by Figure 4.'),
('C0186','GENEALOGICAL_DIAGRAM','genealogical_diagram','unresolved','Figure placement conflicts with a possible literal reading of the prose.'),
('C0187','GENEALOGICAL_DIAGRAM','genealogical_diagram','presents','Relationship reconstructed from Figure 4.'),
('C0188','NARRATIVE_FACT','author_statement','unresolved','Possible alternative parentage derived from the grammar of the prose passage.');

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES
('EC0148','person','P0094','X0093','supports','Narrative identification of early Hajilou chief.'),
('EC0149','person','P0094','X0094','supports','Figure 4 older trunk.'),
('EC0150','person','P0095','X0093','supports','Narrative identifies parentage and five sons.'),
('EC0151','person','P0095','X0094','supports','Figure 4 older trunk.'),
('EC0152','person','P0096','X0094','supports','Figure 4 branch head.'),
('EC0153','person','P0073','X0094','supports','Figure 4 branch head.'),
('EC0154','person','P0097','X0093','supports','Narrative parentage.'),
('EC0155','person','P0097','X0094','supports','Figure 4 branch head.'),
('EC0156','person','P0098','X0094','supports','Figure 4 branch head; parentage disputed.'),
('EC0157','person','P0001','X0094','supports','Figure 4 branch head.');

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0094','mentioned','Older Hajilou trunk root in Figure 4.'),
('A0015','P0095','mentioned','Older Hajilou trunk second generation in Figure 4.'),
('A0015','P0096','mentioned','Figure 4 branch head.'),
('A0015','P0073','mentioned','Figure 4 branch head.'),
('A0015','P0097','mentioned','Figure 4 branch head.'),
('A0015','P0098','mentioned','Figure 4 branch head.');

INSERT OR IGNORE INTO evidence_conflicts(
  conflict_id,entity_type,entity_id,conflict_topic,
  statement_a,statement_b,resolution_status,notes
) VALUES
(
  'CF004','person','P0098','parentage',
  'Figure 4 places Haji Mina Khan among the five sons of Haji Abdollah Khan.',
  'The Chapter 2 prose can be read as naming Haji Mina Khan among the sons of Haji Mohammad Jafar Khan.',
  'unresolved',
  'The canonical graph currently follows Figure 4 with a disputed edge. Do not upgrade this parentage until the prose/diagram discrepancy is resolved.'
);

INSERT OR IGNORE INTO research_questions(
  question_id,question,status,priority,notes
) VALUES
(
  'Q0025',
  'Was Haji Mina Khan Kabudarahangi the son of Haji Abdollah Khan or of Haji Mohammad Jafar Khan?',
  'open','high',
  'Figure 4 places him under Haji Abdollah; the prose may place him under Haji Mohammad Jafar. Seek the underlying Azkaei genealogy or another independent source.'
);

UPDATE research_questions
SET status='resolved',
    notes='Figure 4 and the Chapter 2 prose now reconstruct the direct line above Haji Mohammad Khan Jeyhunabadi through Haji Abdollah Khan to Haji Mohammad Jafar Khan. Haji Mina parentage remains separately open as Q0025.'
WHERE question_id='Q0019';

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary) VALUES
('2026-07-18T04:00:00Z','person','P0094','insert','Added Haji Mohammad Jafar Khan as the older Hajilou root.'),
('2026-07-18T04:00:00Z','person','P0095','insert','Added Haji Abdollah Khan and reconstructed his five-son grouping from Figure 4.'),
('2026-07-18T04:00:00Z','relationship','R0070-R0075','insert','Added the older Hajilou trunk and five branch-head relationships, preserving the Haji Mina conflict.'),
('2026-07-18T04:00:00Z','person','P0073','update','Classified Nasrollah Khan as Hajilou/Korijani and linked him into Figure 4.');

INSERT OR REPLACE INTO metadata(key,value) VALUES('archive_version','2.6.4');
INSERT OR REPLACE INTO metadata(key,value) VALUES(
  'hajilou_older_trunk',
  'Reconstructed Haji Mohammad Jafar Khan -> Haji Abdollah Khan -> five Figure 4 branch heads. Haji Mina parentage remains disputed.'
);
