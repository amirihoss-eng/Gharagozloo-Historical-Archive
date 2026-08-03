-- Archive v2.7.4 — Hajilou final reconciliation cleanup
--
-- This migration does NOT alter the verified Hajilou genealogy topology.
-- It performs only metadata/evidence cleanup found during the final audit.

-- Published evidence that Hossein Qoli Khan P0012 used the title Amir Nezam.
INSERT OR IGNORE INTO citations(
  citation_id,source_id,page_printed,page_file,locator_text,quoted_text,notes
) VALUES
(
  'X0113','S0001','67-84',NULL,
  'Military organization / succession of command of the Fadavi regiment',
  NULL,
  'Alvandi explicitly calls Hossein Qoli Khan "Amir Nezam" when describing his succession to command after his father.'
),
(
  'X0114','S0003','15',NULL,
  'Family-history introduction / Hajilou line',
  NULL,
  'The family-history collection identifies Hossein Qoli Khan as later becoming Amir Nezam and elsewhere calls him Amir Nezam II.'
);

INSERT OR IGNORE INTO titles(title_id,title_en,title_fa,meaning_notes)
VALUES(
  'T0031','Amir Nezam','امیرنظام',
  'Qajar military/administrative title. Explicitly attested for Hossein Qoli Khan P0012 in S0001 and corroborated by S0003.'
);

INSERT OR IGNORE INTO person_titles(person_id,title_id,date_text,notes)
SELECT 'P0012','T0031',NULL,
       'Confirmed by Alvandi S0001; independently corroborated by Majmooe Asaar S0003.'
WHERE NOT EXISTS(
  SELECT 1 FROM person_titles WHERE person_id='P0012' AND title_id='T0031'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred)
VALUES
('P0012','Hossein Qoli Khan Amir Nezam','en','title-form',0),
('P0012','حسینقلی خان امیرنظام','fa','title-form',0);

UPDATE persons
SET branch='Hajilou / Amir Nezam Letgahi',
    summary='Son of Abdollah Khan; Ejlal al-Dowleh and Amir Tuman; later titled Sa''ed al-Saltaneh. Published sources also explicitly attest him as Amir Nezam, the title by which he is strongly remembered in family tradition.',
    updated_at='2026-08-01T09:00:00-07:00'
WHERE person_id='P0012';

UPDATE persons
SET branch='Hajilou / Amir Nezam Letgahi',
    updated_at='2026-08-01T09:00:00-07:00'
WHERE person_id IN ('P0168','P0169');

-- Superseded Hasan node remains in SQLite for audit history but is explicitly
-- non-canonical. The Explorer patch accompanying this migration removes
-- superseded / merged_duplicate records from the canonical graph.
UPDATE persons
SET verification_status='superseded',
    summary='Superseded provisional node from an earlier spreadsheet interpretation. The owner-verified PowerPoint contains no separate Hasan child here. Retained only for audit history and excluded from the canonical graph.',
    updated_at='2026-08-01T09:00:00-07:00'
WHERE person_id='P0142';

-- Restore the parentage evidence claim for Kazem Khan's unnamed child. The
-- relationship is confirmed; only the personal name remains unreadable.
INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0272','person','P0165','parentage',
  'Child of Kazem Khan Gharagozloo (P0084)',
  'confirmed','active',
  'Relationship confirmed by the owner-verified Jeyhunabadi reconstruction. The child''s personal name remains unreadable and is tracked separately as an open research question.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type)
VALUES('C0272','X0111','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0272','USER_SUPPLIED','user_supplied','presents',
  'Parent-child relationship confirmed by the archive owner; name remains unknown.'
);

-- Retire stale question wording without erasing the research history.
UPDATE research_questions
SET question='What is the exact reading of the name/title currently transcribed as Soltan Fath Ali?',
    notes='The earlier provisional Hasan descendant was removed by the verified PowerPoint reconstruction. Only the uncertain reading of Soltan Fath Ali remains open.'
WHERE question_id='Q0032';

UPDATE research_questions
SET question='What is the exact reading of the name/title currently transcribed as Zolfaghar Khan in this Figure 4 subbranch?',
    notes='The child is now confirmed as Assad Khan. The remaining uncertainty concerns the father''s exact reading/title.'
WHERE question_id='Q0033';

UPDATE research_questions
SET question='What is the precise historical identity and full title-form of Farid al-Molk Mirza Mohammad Ali Khan Hamadani beneath Mohammad Khan Hajilou?',
    notes='Mohammad Khan Hajilou''s placement is confirmed by the owner-verified PowerPoint. The open issue is the longer descendant identity/title.'
WHERE question_id='Q0035';

-- Add explicit title claim with two published sources.
INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0277','person','P0012','held_title',
  'Amir Nezam (امیرنظام)',
  'confirmed','active',
  'Explicitly attested in S0001 and independently corroborated by S0003. Family oral history also remembers him primarily by this title.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0277','X0113','supports'),
('C0277','X0114','supports');

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary) VALUES
(
  '2026-08-01T09:00:00-07:00','person','P0012','enrich',
  'Added confirmed Amir Nezam title and normalized the Amir Nezam Letgahi branch label.'
),
(
  '2026-08-01T09:00:00-07:00','person','P0142','supersede',
  'Marked obsolete Hasan node superseded; retained only for audit history.'
),
(
  '2026-08-01T09:00:00-07:00','claim','C0272','restore',
  'Restored the missing parentage claim for Kazem Khan''s unnamed child.'
);

INSERT OR REPLACE INTO metadata(key,value) VALUES('archive_version','2.7.4');
INSERT OR REPLACE INTO metadata(key,value) VALUES(
  'hajilou_final_reconciliation',
  'Hajilou genealogy topology verified; final metadata cleanup complete. P0012 Amir Nezam confirmed by published evidence.'
);
