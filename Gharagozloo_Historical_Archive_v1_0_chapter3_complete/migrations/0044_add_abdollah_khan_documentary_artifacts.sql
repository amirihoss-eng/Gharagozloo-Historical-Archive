-- Migration 0044
-- Majmooe Asaar: Abdollah Khan Decrees, Appointments & Documentary Artifacts
-- Baseline: v2.9.0 / migration 0043
--
-- Scope:
--   * Catalog the reproduced official-document pages in the documentary appendix
--   * Treat them as PRIMARY DOCUMENTARY ARTIFACTS distinct from:
--       - Abdollah Khan's authored reports/travelogues
--       - Majidi's editorial commentary
--   * Link each artifact to P0004
--   * Preserve exact handwriting as transcription_pending
--   * Add research questions for document-level paleographic reconciliation
--
-- IMPORTANT:
--   * No genealogy changes.
--   * No duplicate historical events are created.
--   * No exact dates, issuing authorities, offices, ranks, salaries, or jurisdictions
--     are inferred from uncertain handwriting.
--   * Existing events should later receive documentary support only after each
--     decree/order is securely transcribed and matched.
--   * Transaction control omitted because apply_migration.py owns it.

UPDATE metadata SET value='2.9.1' WHERE key='database_version';
INSERT OR REPLACE INTO metadata(key,value) VALUES('last_migration','0044');
INSERT OR REPLACE INTO metadata(key,value) VALUES('updated_at','2026-08-04T04:15:00Z');
INSERT OR REPLACE INTO metadata(key,value) VALUES(
    'historical_enrichment_checkpoint',
    'Abdollah Khan Decrees Appointments and Documentary Artifacts'
);

-- Source S0200 is the Majmooe Asaar collection already introduced in earlier migrations.

-- ---------------------------------------------------------------------------
-- Documentary artifacts: PDF pages 43–51
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO artifacts(
    artifact_id,source_id,printed_page,artifact_type,title,caption_fa,description,
    transcription_status,confidence,file_reference,notes
) VALUES
('A0201','S0200',NULL,'official_document_scan',
 'Abdollah Khan documentary appendix — PDF page 43',
 NULL,
 'Reproduced handwritten Qajar-era decree/order/appointment document in the documentary appendix concerning Haji Abdollah Khan Gharagozloo. Exact transcription and document-to-event reconciliation remain pending.',
 'transcription_pending','provisional',
 'Majmooe Asaar - PDF.pdf#pdf_page=43',
 'Cataloged conservatively from the reproduced documentary appendix. Do not infer exact date, issuing authority, title, office, salary, or jurisdiction until the handwriting is securely transcribed.'),
('A0202','S0200',NULL,'official_document_scan',
 'Abdollah Khan documentary appendix — PDF page 44',
 NULL,
 'Reproduced handwritten Qajar-era decree/order/appointment document in the documentary appendix concerning Haji Abdollah Khan Gharagozloo. Exact transcription and document-to-event reconciliation remain pending.',
 'transcription_pending','provisional',
 'Majmooe Asaar - PDF.pdf#pdf_page=44',
 'Cataloged conservatively from the reproduced documentary appendix. Do not infer exact date, issuing authority, title, office, salary, or jurisdiction until the handwriting is securely transcribed.'),
('A0203','S0200',NULL,'official_document_scan',
 'Abdollah Khan documentary appendix — PDF page 45',
 NULL,
 'Reproduced handwritten Qajar-era decree/order/appointment document in the documentary appendix concerning Haji Abdollah Khan Gharagozloo. Exact transcription and document-to-event reconciliation remain pending.',
 'transcription_pending','provisional',
 'Majmooe Asaar - PDF.pdf#pdf_page=45',
 'Cataloged conservatively from the reproduced documentary appendix. Do not infer exact date, issuing authority, title, office, salary, or jurisdiction until the handwriting is securely transcribed.'),
('A0204','S0200',NULL,'official_document_scan',
 'Abdollah Khan documentary appendix — PDF page 46',
 NULL,
 'Reproduced handwritten Qajar-era decree/order/appointment document in the documentary appendix concerning Haji Abdollah Khan Gharagozloo. Exact transcription and document-to-event reconciliation remain pending.',
 'transcription_pending','provisional',
 'Majmooe Asaar - PDF.pdf#pdf_page=46',
 'Cataloged conservatively from the reproduced documentary appendix. Do not infer exact date, issuing authority, title, office, salary, or jurisdiction until the handwriting is securely transcribed.'),
('A0205','S0200',NULL,'official_document_scan',
 'Abdollah Khan documentary appendix — PDF page 47',
 NULL,
 'Reproduced handwritten Qajar-era decree/order/appointment document in the documentary appendix concerning Haji Abdollah Khan Gharagozloo. Exact transcription and document-to-event reconciliation remain pending.',
 'transcription_pending','provisional',
 'Majmooe Asaar - PDF.pdf#pdf_page=47',
 'Cataloged conservatively from the reproduced documentary appendix. Do not infer exact date, issuing authority, title, office, salary, or jurisdiction until the handwriting is securely transcribed.'),
('A0206','S0200',NULL,'official_document_scan',
 'Abdollah Khan documentary appendix — PDF page 48',
 NULL,
 'Reproduced handwritten Qajar-era decree/order/appointment document in the documentary appendix concerning Haji Abdollah Khan Gharagozloo. Exact transcription and document-to-event reconciliation remain pending.',
 'transcription_pending','provisional',
 'Majmooe Asaar - PDF.pdf#pdf_page=48',
 'Cataloged conservatively from the reproduced documentary appendix. Do not infer exact date, issuing authority, title, office, salary, or jurisdiction until the handwriting is securely transcribed.'),
('A0207','S0200',NULL,'official_document_scan',
 'Abdollah Khan documentary appendix — PDF page 49',
 NULL,
 'Reproduced handwritten Qajar-era decree/order/appointment document in the documentary appendix concerning Haji Abdollah Khan Gharagozloo. Exact transcription and document-to-event reconciliation remain pending.',
 'transcription_pending','provisional',
 'Majmooe Asaar - PDF.pdf#pdf_page=49',
 'Cataloged conservatively from the reproduced documentary appendix. Do not infer exact date, issuing authority, title, office, salary, or jurisdiction until the handwriting is securely transcribed.'),
('A0208','S0200',NULL,'official_document_scan',
 'Abdollah Khan documentary appendix — PDF page 50',
 NULL,
 'Reproduced handwritten Qajar-era decree/order/appointment document in the documentary appendix concerning Haji Abdollah Khan Gharagozloo. Exact transcription and document-to-event reconciliation remain pending.',
 'transcription_pending','provisional',
 'Majmooe Asaar - PDF.pdf#pdf_page=50',
 'Cataloged conservatively from the reproduced documentary appendix. Do not infer exact date, issuing authority, title, office, salary, or jurisdiction until the handwriting is securely transcribed.'),
('A0209','S0200',NULL,'official_document_scan',
 'Abdollah Khan documentary appendix — PDF page 51',
 NULL,
 'Reproduced handwritten Qajar-era decree/order/appointment document in the documentary appendix concerning Haji Abdollah Khan Gharagozloo. Exact transcription and document-to-event reconciliation remain pending.',
 'transcription_pending','provisional',
 'Majmooe Asaar - PDF.pdf#pdf_page=51',
 'Cataloged conservatively from the reproduced documentary appendix. Do not infer exact date, issuing authority, title, office, salary, or jurisdiction until the handwriting is securely transcribed.');

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0201','P0004','associated_person','Document appears in the appendix explicitly devoted to decrees, orders and appointments of Haji Abdollah Khan Gharagozloo; exact role within each document awaits transcription.'),
('A0202','P0004','associated_person','Document appears in the appendix explicitly devoted to decrees, orders and appointments of Haji Abdollah Khan Gharagozloo; exact role within each document awaits transcription.'),
('A0203','P0004','associated_person','Document appears in the appendix explicitly devoted to decrees, orders and appointments of Haji Abdollah Khan Gharagozloo; exact role within each document awaits transcription.'),
('A0204','P0004','associated_person','Document appears in the appendix explicitly devoted to decrees, orders and appointments of Haji Abdollah Khan Gharagozloo; exact role within each document awaits transcription.'),
('A0205','P0004','associated_person','Document appears in the appendix explicitly devoted to decrees, orders and appointments of Haji Abdollah Khan Gharagozloo; exact role within each document awaits transcription.'),
('A0206','P0004','associated_person','Document appears in the appendix explicitly devoted to decrees, orders and appointments of Haji Abdollah Khan Gharagozloo; exact role within each document awaits transcription.'),
('A0207','P0004','associated_person','Document appears in the appendix explicitly devoted to decrees, orders and appointments of Haji Abdollah Khan Gharagozloo; exact role within each document awaits transcription.'),
('A0208','P0004','associated_person','Document appears in the appendix explicitly devoted to decrees, orders and appointments of Haji Abdollah Khan Gharagozloo; exact role within each document awaits transcription.'),
('A0209','P0004','associated_person','Document appears in the appendix explicitly devoted to decrees, orders and appointments of Haji Abdollah Khan Gharagozloo; exact role within each document awaits transcription.');

-- ---------------------------------------------------------------------------
-- Page-level citations for later document-to-event reconciliation
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO citations(
    citation_id,source_id,page_printed,page_file,locator_text,quoted_text,notes
) VALUES
('X1400','S0200',NULL,'43', 'Documentary appendix reproduced document — PDF page 43',
 'Reproduced handwritten official document associated by the volume with Haji Abdollah Khan Gharagozloo.',
 'Primary documentary artifact; exact paleographic transcription pending.'),
('X1401','S0200',NULL,'44', 'Documentary appendix reproduced document — PDF page 44',
 'Reproduced handwritten official document associated by the volume with Haji Abdollah Khan Gharagozloo.',
 'Primary documentary artifact; exact paleographic transcription pending.'),
('X1402','S0200',NULL,'45', 'Documentary appendix reproduced document — PDF page 45',
 'Reproduced handwritten official document associated by the volume with Haji Abdollah Khan Gharagozloo.',
 'Primary documentary artifact; exact paleographic transcription pending.'),
('X1403','S0200',NULL,'46', 'Documentary appendix reproduced document — PDF page 46',
 'Reproduced handwritten official document associated by the volume with Haji Abdollah Khan Gharagozloo.',
 'Primary documentary artifact; exact paleographic transcription pending.'),
('X1404','S0200',NULL,'47', 'Documentary appendix reproduced document — PDF page 47',
 'Reproduced handwritten official document associated by the volume with Haji Abdollah Khan Gharagozloo.',
 'Primary documentary artifact; exact paleographic transcription pending.'),
('X1405','S0200',NULL,'48', 'Documentary appendix reproduced document — PDF page 48',
 'Reproduced handwritten official document associated by the volume with Haji Abdollah Khan Gharagozloo.',
 'Primary documentary artifact; exact paleographic transcription pending.'),
('X1406','S0200',NULL,'49', 'Documentary appendix reproduced document — PDF page 49',
 'Reproduced handwritten official document associated by the volume with Haji Abdollah Khan Gharagozloo.',
 'Primary documentary artifact; exact paleographic transcription pending.'),
('X1407','S0200',NULL,'50', 'Documentary appendix reproduced document — PDF page 50',
 'Reproduced handwritten official document associated by the volume with Haji Abdollah Khan Gharagozloo.',
 'Primary documentary artifact; exact paleographic transcription pending.'),
('X1408','S0200',NULL,'51', 'Documentary appendix reproduced document — PDF page 51',
 'Reproduced handwritten official document associated by the volume with Haji Abdollah Khan Gharagozloo.',
 'Primary documentary artifact; exact paleographic transcription pending.');

-- ---------------------------------------------------------------------------
-- Conservative claims: artifact cluster existence, not unverified document content
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO claims(
    claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES
('C1400','person','P0004','documentary_appendix_cluster',
 'Majmooe Asaar reproduces a documentary appendix of handwritten decrees, orders, and appointment-related documents associated with Haji Abdollah Khan Gharagozloo.',
 'confirmed','active',
 'Primary documentary-artifact cluster. Exact item-level transcription remains pending.'),
('C1401','person','P0004','documentary_evidence_layer',
 'The reproduced decree/order pages constitute a primary documentary evidence layer distinct from Abdollah Khan''s authored narratives and Majidi''s editorial commentary.',
 'confirmed','active',
 'Archive evidence-layer classification.'),
('C1402','person','P0004','documentary_reconciliation_policy',
 'Each reproduced official document should be matched to an existing appointment, title, rank, command, or governorship event only after secure transcription; duplicate events should not be created merely because a document corroborates an existing event.',
 'confirmed','active',
 'Archive reconciliation policy for documentary artifacts.');

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C1400','X1400','supports'),
('C1400','X1401','supports'),
('C1400','X1402','supports'),
('C1400','X1403','supports'),
('C1400','X1404','supports'),
('C1400','X1405','supports'),
('C1400','X1406','supports'),
('C1400','X1407','supports'),
('C1400','X1408','supports'),
('C1401','X1400','supports'),
('C1402','X1400','supports');

-- ---------------------------------------------------------------------------
-- Research questions
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO research_questions(question_id,question,status,priority,notes) VALUES
('Q0140','Can each reproduced decree/order in Majmooe Asaar PDF pages 43–51 be transcribed paleographically from the original scan or a higher-resolution manuscript image?','open','high','Do not rely on OCR for the handwritten Qajar administrative script unless no better option exists.'),
('Q0141','Which reproduced document corresponds to Abdollah Khan''s Astarabad governorship appointment of 24 Jumada II 1298 AH?','open','high','Match only after secure reading of date, office and issuing authority.'),
('Q0142','Which reproduced document or documents correspond to Abdollah Khan''s promotions through Sarhang, Mirpanj, Sartip/Amir Toman, Sa''ed al-Saltaneh, Sardar Akram and Amir Nezam?','open','high','Use title/rank language in the documents and compare with existing timeline/title records.'),
('Q0143','Is the 1314 AH Khuzestan governorship / Sardar Akram appointment represented among the reproduced documents, and does it include the related title transfers to Hossein Qoli Khan and Mohtaj Ali Khan?','open','high','Cross-check against existing primary/secondary evidence rather than assuming the match.'),
('Q0144','Is the post-coup farman granting Abdollah Khan the title Amir Nezam represented among these reproduced documents?','open','high','If identified, attach the document as corroborating evidence to the existing event rather than creating a duplicate.'),
('Q0145','Can seals, marginal endorsements, scribal notes, and issuing-office marks on each reproduced document be identified independently?','open','medium','Useful for dating, provenance, issuing authority and authenticity assessment.'),
('Q0146','Are the reproduced pages nine separate documents or do any adjacent pages belong to one multi-page document?','open','high','Artifact records are presently page-level pending document-boundary reconciliation.');

-- ---------------------------------------------------------------------------
-- Change log
-- ---------------------------------------------------------------------------
INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-04T04:15:00Z','migration','0044','apply',
       'Cataloged Abdollah Khan documentary appendix as primary documentary artifacts; exact transcription remains pending.');

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-04T04:15:00Z','artifact','A0201-A0209','insert',
       'Added nine page-level official-document artifact records from Majmooe Asaar PDF pages 43–51 and linked them to P0004.');

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-04T04:15:00Z','database','archive','release',
       'Prepared v2.9.1 Abdollah Khan Decrees, Appointments and Documentary Artifacts checkpoint.');
