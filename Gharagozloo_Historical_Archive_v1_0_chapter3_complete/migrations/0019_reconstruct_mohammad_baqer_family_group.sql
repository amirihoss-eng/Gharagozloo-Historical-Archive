-- Archive v2.6.1 — Figure 4 Hajilou reconstruction, Wave 1
--
-- Scope:
--   Reconstruct the family group of Sartip Mohammad-Baqer Khan Gharagozloo
--   (P0002) from S0001 Figure 4, while preserving the already corroborated
--   direct line through Mostafa-Qoli Khan E'temad al-Saltaneh (P0003).
--
-- Evidence policy:
--   The prose independently confirms P0001 -> P0002 -> P0003 -> P0004.
--   The collateral sons and the Mahmoud -> Ali-Akbar -> Mehdi chain are shown
--   in Figure 4 but are not independently narrated in the book text currently
--   available. They are therefore recorded as probable, diagram-supported
--   relationships rather than confirmed prose-supported relationships.

INSERT OR IGNORE INTO citations(
  citation_id, source_id, page_printed, page_file,
  locator_text, quoted_text, notes
) VALUES
(
  'X0090','S0001','213',NULL,
  'Figure 4 — Hajilou genealogy; family group of Sartip Mohammad-Baqer Khan',
  NULL,
  'Diagram shows Mohammad-Baqer Khan as a son of Haji Mohammad Khan Jeyhunabadi and depicts four sons under Mohammad-Baqer: Alireza Khan, Kazem Khan, Mostafa-Qoli Khan E''temad al-Saltaneh, and Mahmoud Khan. Diagram evidence is treated as probable pending prose or independent corroboration.'
),
(
  'X0091','S0001','61',NULL,
  'Chapter 2 — Amir Nezam Letgahi lineage statement',
  NULL,
  'Prose identifies Abdollah Khan as son of Mostafa-Qoli Khan, son of Mohammad-Baqer Khan, son of Haji Mohammad Khan Jeyhunabadi, and classifies the family as Hajilou.'
);

-- Add collateral sons visible in Figure 4. Generic English names are used where
-- an additional small-print epithet in the chart cannot yet be transcribed with
-- sufficient certainty.
INSERT OR IGNORE INTO persons(
  person_id, preferred_name_en, preferred_name_fa, sex,
  birth_date_text, death_date_text, branch, summary,
  verification_status, created_at, updated_at
) VALUES
(
  'P0083','Alireza Khan Gharagozloo','علیرضا خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Jeyhunabadi',
  'Son of Sartip Mohammad-Baqer Khan Gharagozloo in S0001 Figure 4. The chart appears to include an additional descriptor after his name, but the scan does not permit a reliable transcription; identity remains provisional.',
  'provisional','2026-07-18T00:00:00Z','2026-07-18T00:00:00Z'
),
(
  'P0084','Kazem Khan Gharagozloo','کاظم خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Jeyhunabadi',
  'Son of Sartip Mohammad-Baqer Khan Gharagozloo in S0001 Figure 4. No descendants are securely transcribed from the figure in this wave.',
  'provisional','2026-07-18T00:00:00Z','2026-07-18T00:00:00Z'
),
(
  'P0085','Mahmoud Khan Gharagozloo','محمود خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Jeyhunabadi',
  'Son of Sartip Mohammad-Baqer Khan Gharagozloo in S0001 Figure 4; distinct from Mahmoud Khan Naser al-Molk of the Ashiqloo/Bahari line (P0014).',
  'provisional','2026-07-18T00:00:00Z','2026-07-18T00:00:00Z'
),
(
  'P0086','Ali Akbar Khan Gharagozloo','علی‌اکبر خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Jeyhunabadi',
  'Shown in S0001 Figure 4 as son of Mahmoud Khan of the Mohammad-Baqer Khan Hajilou family group.',
  'provisional','2026-07-18T00:00:00Z','2026-07-18T00:00:00Z'
),
(
  'P0087','Mehdi Khan Gharagozloo','مهدی خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Jeyhunabadi',
  'Shown in S0001 Figure 4 as son of Ali-Akbar Khan and grandson of Mahmoud Khan in the Mohammad-Baqer Khan Hajilou family group.',
  'provisional','2026-07-18T00:00:00Z','2026-07-18T00:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0083','Alireza Khan Gharagozloo','en','canonical',1),
('P0083','علیرضا خان قراگوزلو','fa','canonical',1),
('P0084','Kazem Khan Gharagozloo','en','canonical',1),
('P0084','کاظم خان قراگوزلو','fa','canonical',1),
('P0085','Mahmoud Khan Gharagozloo','en','canonical',1),
('P0085','محمود خان قراگوزلو','fa','canonical',1),
('P0086','Ali Akbar Khan Gharagozloo','en','canonical',1),
('P0086','علی‌اکبر خان قراگوزلو','fa','canonical',1),
('P0087','Mehdi Khan Gharagozloo','en','canonical',1),
('P0087','مهدی خان قراگوزلو','fa','canonical',1);

-- Figure 4-supported sibling group. The existing P0002 -> P0003 edge is retained.
INSERT OR IGNORE INTO relationships(
  relationship_id, person1_id, relationship_type, person2_id,
  notes, verification_status
) VALUES
(
  'R0059','P0002','parent_of','P0083',
  'Figure 4 depicts Alireza Khan as a son of Sartip Mohammad-Baqer Khan. Diagram-only in this reconstruction wave.',
  'probable'
),
(
  'R0060','P0002','parent_of','P0084',
  'Figure 4 depicts Kazem Khan as a son of Sartip Mohammad-Baqer Khan. Diagram-only in this reconstruction wave.',
  'probable'
),
(
  'R0061','P0002','parent_of','P0085',
  'Figure 4 depicts Mahmoud Khan as a son of Sartip Mohammad-Baqer Khan. Diagram-only in this reconstruction wave.',
  'probable'
),
(
  'R0062','P0085','parent_of','P0086',
  'Figure 4 shows the sequence Mahmoud Khan -> Ali-Akbar Khan.',
  'probable'
),
(
  'R0063','P0086','parent_of','P0087',
  'Figure 4 shows the sequence Ali-Akbar Khan -> Mehdi Khan.',
  'probable'
);

INSERT OR IGNORE INTO claims(
  claim_id, subject_type, subject_id, predicate, object_text,
  confidence, status, notes
) VALUES
(
  'C0163','person','P0002','sons shown in Figure 4',
  'Alireza Khan, Kazem Khan, Mostafa-Qoli Khan E''temad al-Saltaneh, and Mahmoud Khan',
  'probable','active',
  'The four-son grouping is read from the printed genealogy. Mostafa-Qoli is independently corroborated by prose; the collateral sons await further corroboration.'
),
(
  'C0164','person','P0083','is child of','Sartip Mohammad-Baqer Khan Gharagozloo',
  'probable','active','Diagram-supported relationship in S0001 Figure 4.'
),
(
  'C0165','person','P0084','is child of','Sartip Mohammad-Baqer Khan Gharagozloo',
  'probable','active','Diagram-supported relationship in S0001 Figure 4.'
),
(
  'C0166','person','P0085','is child of','Sartip Mohammad-Baqer Khan Gharagozloo',
  'probable','active','Diagram-supported relationship in S0001 Figure 4.'
),
(
  'C0167','person','P0086','is child of','Mahmoud Khan Gharagozloo of the Hajilou/Jeyhunabadi line',
  'probable','active','Diagram-supported relationship in S0001 Figure 4.'
),
(
  'C0168','person','P0087','is child of','Ali-Akbar Khan Gharagozloo',
  'probable','active','Diagram-supported relationship in S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0163','X0090','supports'),
('C0163','X0091','supports'),
('C0164','X0090','supports'),
('C0165','X0090','supports'),
('C0166','X0090','supports'),
('C0167','X0090','supports'),
('C0168','X0090','supports');

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id, entity_type, entity_id, citation_id, support_type, notes
) VALUES
('EC0123','person','P0083','X0090','supports','Figure 4 identification; additional descriptor remains unresolved.'),
('EC0124','person','P0084','X0090','supports','Figure 4 identification.'),
('EC0125','person','P0085','X0090','supports','Figure 4 identification; distinct from P0014.'),
('EC0126','person','P0086','X0090','supports','Figure 4 identification.'),
('EC0127','person','P0087','X0090','supports','Figure 4 identification.'),
('EC0128','relationship','R0059','X0090','supports','Diagram-supported parent-child edge.'),
('EC0129','relationship','R0060','X0090','supports','Diagram-supported parent-child edge.'),
('EC0130','relationship','R0061','X0090','supports','Diagram-supported parent-child edge.'),
('EC0131','relationship','R0062','X0090','supports','Diagram-supported parent-child edge.'),
('EC0132','relationship','R0063','X0090','supports','Diagram-supported parent-child edge.');

-- Record exact remaining transcription work instead of silently guessing.
INSERT OR IGNORE INTO research_questions(question_id,question,status,priority,notes) VALUES
(
  'Q0020',
  'What is the exact additional descriptor printed after Alireza Khan in the Mohammad-Baqer Khan family group of S0001 Figure 4?',
  'open','high',
  'The scan supports the personal name Alireza Khan but the following small-print descriptor is not sufficiently legible for canonical transcription.'
),
(
  'Q0021',
  'Can the collateral descendants shown under Alireza Khan in S0001 Figure 4 be transcribed and corroborated without using the withheld handwritten family tree?',
  'open','high',
  'Continue the book-only reconstruction from a higher-resolution image or independent prose references.'
),
(
  'Q0022',
  'Do prose or documentary sources in S0001 independently corroborate Kazem Khan, Mahmoud Khan, Ali-Akbar Khan, and Mehdi Khan in the Jeyhunabadi Hajilou line?',
  'open','medium',
  'Current canonical inclusion is diagram-supported and therefore marked probable.'
);

INSERT OR REPLACE INTO metadata(key,value) VALUES('archive_version','2.6.1');
INSERT OR REPLACE INTO metadata(key,value) VALUES(
  'hajilou_figure4_wave1',
  'Added the complete currently legible son group of Sartip Mohammad-Baqer Khan and the Mahmoud-to-Ali-Akbar-to-Mehdi collateral chain from S0001 Figure 4, with diagram-only links marked probable.'
);
