-- Archive v2.8.0 — Final Ashiqloo Figure 3 + prose reconciliation
--
-- Canonical policy approved by the archive owner:
--   * Figure 3 is the structural base.
--   * Explicit prose may add omitted generations.
--   * Where prose directly conflicts with Figure 3, prefer the stronger
--     explicit prose assertion in the canonical tree, but preserve the conflict.
--   * Where prose merely expresses doubt, retain Figure-3 relationships as
--     disputed rather than deleting them.
--
-- Hajilou genealogy topology is outside scope and is not changed.

INSERT OR IGNORE INTO citations(
  citation_id,source_id,page_printed,page_file,locator_text,quoted_text,notes
) VALUES
(
  'X0115','S0001','212',NULL,
  'Figure 3 — genealogy / notable men of the Ashiqloo Gharagozloo branch',
  NULL,
  'Literal Figure 3 structure transcribed and verified by the archive owner.'
),
(
  'X0116','S0001','59-61; 135-139; 164-186',NULL,
  'Narrative prose used to reconcile Figure 3',
  NULL,
  'Prose lineage passages used for omitted generations, sibling relationships, the Naser al-Molk line, and source conflicts.'
);

-- Eight missing people.
INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES
('P0170','Gholam Ali Khan Hesam al-Molk Gharagozloo','غلامعلی خان حسام‌الملک قراگوزلو','M',NULL,NULL,'Ashiqloo',
 'Son of Zeyn al-Abedin Khan in the reconciled Figure 3/prose Ashiqloo genealogy.',
 'confirmed','2026-08-01T09:10:00-07:00','2026-08-01T09:10:00-07:00'),
('P0171','Mehdi Qoli Khan Gharagozloo','مهدی‌قلی خان قراگوزلو','M',NULL,NULL,'Ashiqloo',
 'Direct son of Nabi Khan shown in Figure 3. Distinct from the later Mehdi Khan/Amir Tuman under Ahmad Sartip.',
 'confirmed','2026-08-01T09:10:00-07:00','2026-08-01T09:10:00-07:00'),
('P0172','Yahya Khan Gharagozloo','یحیی خان قراگوزلو','M',NULL,NULL,'Ashiqloo',
 'Child of Ali Qoli Khan Baha al-Molk in Figure 3.',
 'confirmed','2026-08-01T09:10:00-07:00','2026-08-01T09:10:00-07:00'),
('P0173','Manouchehr Gharagozloo','منوچهر قراگوزلو','M',NULL,NULL,'Ashiqloo',
 'Child of Alireza Khan Baha al-Molk in Figure 3.',
 'confirmed','2026-08-01T09:10:00-07:00','2026-08-01T09:10:00-07:00'),
('P0174','Fath Ali Khan Gharagozloo','فتحعلی خان قراگوزلو','M',NULL,NULL,'Ashiqloo',
 'Child of Fazlollah Khan in Figure 3.',
 'confirmed','2026-08-01T09:10:00-07:00','2026-08-01T09:10:00-07:00'),
('P0175','Mohammad Shafi Khan Gharagozloo','محمدشفیع خان قراگوزلو','M',NULL,NULL,'Ashiqloo',
 'Figure 3 presents him as a son of Abdollah Khan Sarem al-Dowleh. The prose later doubts that Abdollah had male children, so this parentage is retained as disputed.',
 'disputed','2026-08-01T09:10:00-07:00','2026-08-01T09:10:00-07:00'),
('P0176','Ezzat Allah Saremi','عزت‌الله صارمی','M',NULL,NULL,'Ashiqloo',
 'Figure 3 descendant of Mohammad Shafi Khan.',
 'confirmed','2026-08-01T09:10:00-07:00','2026-08-01T09:10:00-07:00'),
('P0177','Abdolhossein Khan Gharagozloo','عبدالحسین خان قراگوزلو','M',NULL,NULL,'Ashiqloo',
 'Figure 3 presents him as a son of Abdollah Khan Sarem al-Dowleh. The prose later doubts that Abdollah had male children, so this parentage is retained as disputed.',
 'disputed','2026-08-01T09:10:00-07:00','2026-08-01T09:10:00-07:00');

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0170','Gholam Ali Khan Hesam al-Molk Gharagozloo','en','canonical',1),
('P0170','غلامعلی خان حسام‌الملک قراگوزلو','fa','canonical',1),
('P0171','Mehdi Qoli Khan Gharagozloo','en','canonical',1),
('P0171','مهدی‌قلی خان قراگوزلو','fa','canonical',1),
('P0172','Yahya Khan Gharagozloo','en','canonical',1),
('P0172','یحیی خان قراگوزلو','fa','canonical',1),
('P0173','Manouchehr Gharagozloo','en','canonical',1),
('P0173','منوچهر قراگوزلو','fa','canonical',1),
('P0174','Fath Ali Khan Gharagozloo','en','canonical',1),
('P0174','فتحعلی خان قراگوزلو','fa','canonical',1),
('P0175','Mohammad Shafi Khan Gharagozloo','en','canonical',1),
('P0175','محمدشفیع خان قراگوزلو','fa','canonical',1),
('P0176','Ezzat Allah Saremi','en','canonical',1),
('P0176','عزت‌الله صارمی','fa','canonical',1),
('P0177','Abdolhossein Khan Gharagozloo','en','canonical',1),
('P0177','عبدالحسین خان قراگوزلو','fa','canonical',1);

-- Reuse existing people rather than duplicate them.
UPDATE persons
SET branch='Ashiqloo',
    updated_at='2026-08-01T09:10:00-07:00'
WHERE person_id='P0021';

UPDATE persons
SET branch='Ashiqloo / Baha al-Molk',
    updated_at='2026-08-01T09:10:00-07:00'
WHERE person_id='P0037';

UPDATE persons
SET branch='Ashiqloo / Naser al-Molk',
    updated_at='2026-08-01T09:10:00-07:00'
WHERE person_id IN ('P0038','P0041','P0042','P0043','P0064','P0065');

UPDATE persons
SET summary='Son of Ahmad Khan Sartip and Negar Khanom in the reconciled Figure 3/prose genealogy; later associated with command of the Mokhberan regiment. Distinct from P0171, the earlier Mehdi Qoli Khan who was a direct son of Nabi Khan.',
    branch='Ashiqloo / Naser al-Molk',
    updated_at='2026-08-01T09:10:00-07:00'
WHERE person_id='P0064';

UPDATE persons
SET summary='Son of Ahmad Khan Sartip and Negar Khanom; brother of Mehdi Khan and Naser al-Molk in the reconciled Figure 3/prose genealogy.',
    branch='Ashiqloo / Naser al-Molk',
    updated_at='2026-08-01T09:10:00-07:00'
WHERE person_id='P0065';

-- Fix the old Mehdi/Naser extraction error by reusing P0064 under Ahmad.
UPDATE relationships
SET person1_id='P0030',
    relationship_type='parent_of',
    verification_status='confirmed',
    notes='Reconciled from Figure 3 plus explicit later prose: Mehdi Khan is a son of Ahmad Khan Sartip and Negar Khanom, not a son of Naser al-Molk.'
WHERE relationship_id='R0039'
  AND person2_id='P0064';

-- Reparent Abdol Ali to Ahmad. Preserve the older military-passage ambiguity
-- in the evidence-conflict register below.
UPDATE relationships
SET person1_id='P0030',
    relationship_type='parent_of',
    verification_status='confirmed',
    notes='Canonical placement follows Figure 3 and explicit later prose: Abdol Ali Khan is a son of Ahmad Khan Sartip and Negar Khanom.'
WHERE relationship_id='R0040'
  AND person2_id='P0065';

-- Preserve one Mahmoud→Ahmad edge and supersede the duplicate.
UPDATE relationships
SET verification_status='superseded',
    notes='Duplicate of canonical relationship R0020; retained only for audit history.'
WHERE relationship_id='R0028';

-- Add missing/corrective canonical edges.
INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES
('R0147','P0023','parent_of','P0170','Figure 3/prose reconciliation: Gholam Ali is a son of Zeyn al-Abedin.','confirmed'),
('R0148','P0019','parent_of','P0021','Figure 3: Lotf Ali Khan is a son of Ali Khan Nosrat al-Molk.','confirmed'),
('R0149','P0013','parent_of','P0171','Figure 3: earlier Mehdi Qoli Khan is a direct son of Nabi Khan.','confirmed'),
('R0150','P0064','parent_of','P0038','Narrative evidence identifies Mohammad Ebrahim Khan as son of Mehdi Khan Amir Tuman.','confirmed'),
('R0151','P0033','parent_of','P0037','Figure 3 places Alireza Khan beneath Ali Qoli Khan Baha al-Molk.','confirmed'),
('R0152','P0033','parent_of','P0172','Figure 3: Yahya Khan is a child of Ali Qoli Khan Baha al-Molk.','confirmed'),
('R0153','P0037','parent_of','P0173','Figure 3: Manouchehr is a child of Alireza Khan.','confirmed'),
('R0154','P0062','parent_of','P0174','Figure 3: Fath Ali Khan is a child of Fazlollah Khan.','confirmed'),
('R0155','P0028','parent_of','P0175','Figure 3 positively presents Mohammad Shafi as a son; prose later doubts that Abdollah had male children. Conflict preserved.','disputed'),
('R0156','P0175','parent_of','P0176','Figure 3: Ezzat Allah Saremi descends from Mohammad Shafi Khan.','confirmed'),
('R0157','P0028','parent_of','P0177','Figure 3 positively presents Abdolhossein as a son; prose later doubts that Abdollah had male children. Conflict preserved.','disputed');

-- Claims for new/reconciled genealogy.
INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES
('C0278','person','P0170','parentage','Child of Zeyn al-Abedin Khan P0023','confirmed','active','Figure 3/prose reconciliation.'),
('C0279','person','P0021','parentage','Child of Ali Khan Nosrat al-Molk P0019','confirmed','active','Figure 3.'),
('C0280','person','P0171','parentage','Child of Nabi Khan P0013','confirmed','active','Figure 3; separate from P0064.'),
('C0281','person','P0064','parentage','Child of Ahmad Khan Sartip P0030 and Negar Khanom P0029','confirmed','active','Corrects an earlier extraction error that placed him beneath Naser al-Molk.'),
('C0282','person','P0065','parentage','Child of Ahmad Khan Sartip P0030 and Negar Khanom P0029','confirmed','active','Figure 3 plus explicit later prose; older military wording remains noted as an ambiguity.'),
('C0283','person','P0038','parentage','Child of Mehdi Khan P0064','confirmed','active','Narrative evidence.'),
('C0284','person','P0037','parentage','Child of Ali Qoli Khan Baha al-Molk P0033','confirmed','active','Figure 3.'),
('C0285','person','P0172','parentage','Child of Ali Qoli Khan Baha al-Molk P0033','confirmed','active','Figure 3.'),
('C0286','person','P0173','parentage','Child of Alireza Khan P0037','confirmed','active','Figure 3.'),
('C0287','person','P0174','parentage','Child of Fazlollah Khan P0062','confirmed','active','Figure 3.'),
('C0288','person','P0175','parentage','Figure 3 presents Mohammad Shafi Khan as a son of Abdollah Sarem al-Dowleh P0028','disputed','active','Prose says Abdollah probably had no male children; retain both assertions.'),
('C0289','person','P0176','parentage','Child of Mohammad Shafi Khan P0175','confirmed','active','Figure 3.'),
('C0290','person','P0177','parentage','Figure 3 presents Abdolhossein Khan as a son of Abdollah Sarem al-Dowleh P0028','disputed','active','Prose says Abdollah probably had no male children; retain both assertions.');

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type)
SELECT claim_id,'X0115','supports' FROM claims
WHERE claim_id IN ('C0278','C0279','C0280','C0284','C0285','C0286','C0287','C0288','C0289','C0290');

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type)
SELECT claim_id,'X0116','supports' FROM claims
WHERE claim_id IN ('C0278','C0281','C0282','C0283','C0288','C0290');

-- Old Naser→Mehdi claim was an extraction interpretation, not a genuine
-- unresolved child identity after the Figure 3/prose reconciliation.
UPDATE claims
SET status='superseded',
    notes='Superseded by Figure 3 + explicit later prose. The Chapter 2 military passage is now treated as command succession/ambiguous wording rather than proof that Mehdi was Naser al-Molk''s son.'
WHERE claim_id='C0139';

-- Formal evidence conflicts / omissions for future-source research.
UPDATE evidence_conflicts
SET statement_a='An earlier Chapter 2 regimental reading was interpreted as calling Mehdi Khan a son of Naser al-Molk.',
    statement_b='Figure 3 and explicit later prose place Mehdi Khan as a son of Ahmad Khan Sartip and Negar Khanom, and call Naser al-Molk his brother.',
    resolution_status='resolved',
    notes='Resolved for canonical genealogy in favor of Figure 3 + explicit later prose. Retain the old reading as extraction history.'
WHERE conflict_id='CF001';

INSERT OR REPLACE INTO evidence_conflicts(
  conflict_id,entity_type,entity_id,conflict_topic,statement_a,statement_b,resolution_status,notes
) VALUES
(
  'CF006','person','P0031','parentage in Figure 3 versus prose',
  'Figure 3 visually places Amanollah Khan Baha al-Molk beneath Mahmoud Khan.',
  'Explicit prose identifies Amanollah as a son of Nabi Khan and brother of Mahmoud Khan.',
  'partially_resolved',
  'Canonical genealogy follows the explicit prose: Nabi → Amanollah. Preserve the Figure 3 discrepancy for comparison with future sources.'
),
(
  'CF007','person','P0028','male children',
  'Figure 3 positively shows Mohammad Shafi Khan and Abdolhossein Khan as sons of Abdollah Khan Sarem al-Dowleh.',
  'The prose says Abdollah probably had no male children because the author found no sons in the consulted sources; it explicitly identifies daughter Negar Khanom.',
  'unresolved',
  'Retain Mohammad Shafi and Abdolhossein as disputed Figure-3 children and Negar as prose-confirmed. Future sources may resolve the conflict.'
),
(
  'CF008','person','P0065','parentage wording',
  'A Chapter 2 military passage was previously read as making Abdol Ali Khan the son of Mehdi Khan.',
  'Figure 3 and explicit later prose place Mehdi Khan and Abdol Ali Khan as brothers, sons of Ahmad Sartip and Negar Khanom.',
  'partially_resolved',
  'Canonical genealogy follows Figure 3 + explicit later prose; retain the military wording as a source ambiguity.'
),
(
  'CF009','person','P0023','omitted generation in Figure 3',
  'Figure 3 compresses the Rostam line visually from Ali Khan Nosrat al-Molk toward Zeyn al-Abedin.',
  'Explicit prose inserts Mohammad-Hossein Khan Hesam al-Molk between Ali Khan Nosrat al-Molk and Zeyn al-Abedin.',
  'resolved',
  'Classified as diagram compression/omission rather than contradictory parentage. Canonical genealogy retains the prose-added generation.'
);

-- Research questions for unresolved conflicts.
INSERT OR IGNORE INTO research_questions(question_id,question,status,priority,notes) VALUES
(
  'Q0040',
  'Can another source resolve whether Amanollah Khan Baha al-Molk was shown under Mahmoud only because Figure 3 was visually compressed, or whether the figure asserts different parentage?',
  'open','high','Canonical genealogy follows explicit prose: Amanollah is son of Nabi and brother of Mahmoud.'
),
(
  'Q0041',
  'Can another source confirm or refute Mohammad Shafi Khan and Abdolhossein Khan as sons of Abdollah Khan Sarem al-Dowleh?',
  'open','high','Figure 3 shows both sons; prose says Abdollah probably had no male children.'
);

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary) VALUES
(
  '2026-08-01T09:10:00-07:00','branch','Ashiqloo','reconcile',
  'Completed Figure 3 + prose reconciliation: added eight missing people, corrected/reused existing identities, and preserved source conflicts.'
),
(
  '2026-08-01T09:10:00-07:00','relationship','R0039-R0040','correct',
  'Corrected Mehdi and Abdol Ali parentage beneath Ahmad Khan Sartip while retaining the older wording as evidence history.'
),
(
  '2026-08-01T09:10:00-07:00','evidence_conflict','CF006-CF009','insert',
  'Recorded Amanollah, Abdollah Sarem al-Dowleh, Abdol Ali, and Rostam-line Figure/prose reconciliation issues.'
);

INSERT OR REPLACE INTO metadata(key,value) VALUES('archive_version','2.8.0');
INSERT OR REPLACE INTO metadata(key,value) VALUES(
  'ashiqloo_final_reconciliation',
  'Figure 3 literal reconstruction verified by archive owner and reconciled with prose. Canonical topology updated while preserving source conflicts.'
);
