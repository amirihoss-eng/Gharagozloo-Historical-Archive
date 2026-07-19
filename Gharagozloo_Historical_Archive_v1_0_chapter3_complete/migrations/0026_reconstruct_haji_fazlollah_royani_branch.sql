-- Archive v2.6.8 — Haji Fazlollah Khan Royani branch
--
-- This migration replaces the earlier provisional visual interpretation with
-- the archive owner's row-by-row reconstruction supplied on 2026-07-18.
--
-- User notation:
--   no marker = confidently read
--   ?         = uncertain reading
--   ??        = highly uncertain reading
--
-- The migration does not delete or merge similarly named people elsewhere in
-- the archive. Every person below receives a distinct person ID in the
-- Hajilou / Royani line.

INSERT OR IGNORE INTO sources(
  source_id,short_title,full_title,author,publication_year,source_type,file_name,notes
) VALUES
(
  'S0003',
  'Majmooe Asaar — Haji Abdollah Khan Gharagozloo',
  'Majmooe Asaar-e Haji Abdollah Khan Gharagozloo',
  'Haji Abdollah Khan Gharagozloo; edited collection',
  NULL,
  'family memoir / edited collection',
  'Majmooe Asaar - PDF.pdf',
  'Family-history collection used as a comparison source for the Haji Fazlollah branch.'
);

INSERT OR IGNORE INTO citations(
  citation_id,source_id,page_printed,page_file,locator_text,quoted_text,notes
) VALUES
(
  'X0105','U0001',NULL,NULL,
  'User-supplied Haji Fazlollah branch spreadsheet, 2026-07-18',
  NULL,
  'The archive owner reconstructed the branch row by row and explicitly defined ? as uncertain and ?? as highly uncertain. Source image is preserved in docs/reconciliation/source_images.'
),
(
  'X0106','S0001','213',NULL,
  'Figure 4 — Haji Fazlollah Khan Royani branch',
  NULL,
  'Published genealogy diagram underlying the user-supplied reconstruction.'
),
(
  'X0107','S0003','14-15',NULL,
  'Family-history list of Haji Fazlollah descendants',
  NULL,
  'Comparison source that appears to summarize the branch differently; retained as an unresolved source conflict.'
);

UPDATE persons
SET summary='Early Hajilou/Royani branch head. The branch below this person was reconstructed row by row by the archive owner from S0001 Figure 4. The reconstruction currently contains four immediate children and preserves all uncertain readings exactly through evidence status and research questions.',
    verification_status='confirmed',
    updated_at='2026-07-18T08:00:00Z'
WHERE person_id='P0096';

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0096','Haji Fazl Allah Khan Gharagozloo','en','user_form',0),
('P0096','حاجی فضل‌الله خان قراگوزلو','fa','user_form',0);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0115','Mohammad Hassan Khan Gharagozloo','محمدحسن خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0096. The user marked this name with one question mark.',
  'probable','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0115','Mohammad Hassan Khan Gharagozloo','en','canonical',1),
('P0115','محمدحسن خان قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0115','Mohammad Hassan Khan ?','en','user_transcription_with_uncertainty',0);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0116','Ali Khan Gharagozloo','علی خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0096.',
  'confirmed','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0116','Ali Khan Gharagozloo','en','canonical',1),
('P0116','علی خان قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0117','Hossein Ali Khan Gharagozloo','حسینعلی خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0096. The user marked this name with one question mark.',
  'probable','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0117','Hossein Ali Khan Gharagozloo','en','canonical',1),
('P0117','حسینعلی خان قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0117','Hossein Ali Khan ?','en','user_transcription_with_uncertainty',0);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0118','Abdolhossein Khan Farkhari Gharagozloo','عبدالحسین خان فرخاری قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0096. Farkhari was subsequently accepted by the user as the correct reading.',
  'confirmed','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0118','Abdolhossein Khan Farkhari Gharagozloo','en','canonical',1),
('P0118','عبدالحسین خان فرخاری قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0119','Ali Mohammad Khan Gharagozloo','علی‌محمد خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0115.',
  'confirmed','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0119','Ali Mohammad Khan Gharagozloo','en','canonical',1),
('P0119','علی‌محمد خان قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0120','Shafi Khan Gharagozloo','شفیع خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0115.',
  'confirmed','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0120','Shafi Khan Gharagozloo','en','canonical',1),
('P0120','شفیع خان قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0121','Gholam Ali Khan Gharagozloo','غلامعلی خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0119.',
  'confirmed','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0121','Gholam Ali Khan Gharagozloo','en','canonical',1),
('P0121','غلامعلی خان قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0122','Sadegh Khan Gharagozloo','صادق خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0120.',
  'confirmed','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0122','Sadegh Khan Gharagozloo','en','canonical',1),
('P0122','صادق خان قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0123','Mirza Soltan Gharagozloo','میرزا سلطان قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0117. The user marked this name with one question mark.',
  'probable','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0123','Mirza Soltan Gharagozloo','en','canonical',1),
('P0123','میرزا سلطان قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0123','Mirza Soltan ?','en','user_transcription_with_uncertainty',0);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0124','Najaf Qoli Khan Gharagozloo','نجف‌قلی خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0117.',
  'confirmed','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0124','Najaf Qoli Khan Gharagozloo','en','canonical',1),
('P0124','نجف‌قلی خان قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0125','Abdolrahman Gharagozloo','عبدالرحمان قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0117.',
  'confirmed','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0125','Abdolrahman Gharagozloo','en','canonical',1),
('P0125','عبدالرحمان قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0126','Heydar Qoli Khan Gharagozloo','حیدرقلی خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0117.',
  'confirmed','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0126','Heydar Qoli Khan Gharagozloo','en','canonical',1),
('P0126','حیدرقلی خان قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0127','Mohammad Morad Beg Gharagozloo','محمدمراد بیگ قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0117.',
  'confirmed','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0127','Mohammad Morad Beg Gharagozloo','en','canonical',1),
('P0127','محمدمراد بیگ قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0128','Fath Ali Beg Gharagozloo','فتحعلی بیگ قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0117.',
  'confirmed','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0128','Fath Ali Beg Gharagozloo','en','canonical',1),
('P0128','فتحعلی بیگ قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0129','Mohammad Vali Beg Gharagozloo','محمدولی بیگ قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0117.',
  'confirmed','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0129','Mohammad Vali Beg Gharagozloo','en','canonical',1),
('P0129','محمدولی بیگ قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0130','Ali Khan Gharagozloo','علی خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0124.',
  'confirmed','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0130','Ali Khan Gharagozloo','en','canonical',1),
('P0130','علی خان قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0131','Mohammad Zahir Fath al-Dowleh Gharagozloo','محمدظاهر فتح‌الدوله قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0124. Both the personal-name reading and the title were marked uncertain by the user.',
  'probable','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0131','Mohammad Zahir Fath al-Dowleh Gharagozloo','en','canonical',1),
('P0131','محمدظاهر فتح‌الدوله قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0131','Mohammad Zaher ? Fath Dolleh ?','en','user_transcription_with_uncertainty',0);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0132','Khair Allah Khan Gharagozloo','خیرالله خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0130.',
  'confirmed','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0132','Khair Allah Khan Gharagozloo','en','canonical',1),
('P0132','خیرالله خان قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0133','Abdollah Khan Gharagozloo','عبدالله خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0130.',
  'confirmed','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0133','Abdollah Khan Gharagozloo','en','canonical',1),
('P0133','عبدالله خان قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0134','Aman Allah Khan Gharagozloo','امان‌الله خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0130.',
  'confirmed','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0134','Aman Allah Khan Gharagozloo','en','canonical',1),
('P0134','امان‌الله خان قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0135','Karim Khan Gharagozloo','کریم خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0126.',
  'confirmed','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0135','Karim Khan Gharagozloo','en','canonical',1),
('P0135','کریم خان قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0136','Mahmoud Khan Gharagozloo','محمود خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0127.',
  'confirmed','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0136','Mahmoud Khan Gharagozloo','en','canonical',1),
('P0136','محمود خان قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0137','Enayat Allah Khan Gharagozloo','عنایت‌الله خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0127.',
  'confirmed','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0137','Enayat Allah Khan Gharagozloo','en','canonical',1),
('P0137','عنایت‌الله خان قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0138','Habib Allah Khan Gharagozloo','حبیب‌الله خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0127.',
  'confirmed','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0138','Habib Allah Khan Gharagozloo','en','canonical',1),
('P0138','حبیب‌الله خان قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0139','Noor Allah Khan Gharagozloo','نورالله خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0137.',
  'confirmed','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0139','Noor Allah Khan Gharagozloo','en','canonical',1),
('P0139','نورالله خان قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0140','Nasr Allah Khan Gharagozloo','نصرالله خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0138.',
  'confirmed','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0140','Nasr Allah Khan Gharagozloo','en','canonical',1),
('P0140','نصرالله خان قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0141','Soltan Fath Ali Gharagozloo','سلطان فتحعلی قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0129. The user marked this name with one question mark.',
  'probable','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0141','Soltan Fath Ali Gharagozloo','en','canonical',1),
('P0141','سلطان فتحعلی قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0141','Soltan Fath Ali ?','en','user_transcription_with_uncertainty',0);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0142','Hasan Gharagozloo','حسن قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0141. The user marked this name with two question marks.',
  'provisional','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0142','Hasan Gharagozloo','en','canonical',1),
('P0142','حسن قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0142','Hassan ??','en','user_transcription_with_uncertainty',0);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0143','Shir Ali Beg Gharagozloo','شیرعلی بیگ قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0118.',
  'confirmed','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0143','Shir Ali Beg Gharagozloo','en','canonical',1),
('P0143','شیرعلی بیگ قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0144','Zolfaghar Khan Gharagozloo','ذوالفقار خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0143. The user marked this name with two question marks.',
  'provisional','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0144','Zolfaghar Khan Gharagozloo','en','canonical',1),
('P0144','ذوالفقار خان قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0144','Zolfaghar Khan ??','en','user_transcription_with_uncertainty',0);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0145','Hasan Gharagozloo','حسن قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0144. The user marked this name with two question marks.',
  'provisional','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0145','Hasan Gharagozloo','en','canonical',1),
('P0145','حسن قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0145','Hassan ??','en','user_transcription_with_uncertainty',0);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0146','Fath Ali Khan Gharagozloo','فتحعلی خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0144.',
  'confirmed','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0146','Fath Ali Khan Gharagozloo','en','canonical',1),
('P0146','فتحعلی خان قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0147','Ghasem Khan Gharagozloo','قاسم خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0118.',
  'confirmed','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0147','Ghasem Khan Gharagozloo','en','canonical',1),
('P0147','قاسم خان قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0148','Nasr Allah Khan Gharagozloo','نصرالله خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0147.',
  'confirmed','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0148','Nasr Allah Khan Gharagozloo','en','canonical',1),
('P0148','نصرالله خان قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0149','Hossein Ali Khan Gharagozloo','حسینعلی خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0147. The user marked this name with one question mark.',
  'probable','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0149','Hossein Ali Khan Gharagozloo','en','canonical',1),
('P0149','حسینعلی خان قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0149','Hossein Ali Khan ?','en','user_transcription_with_uncertainty',0);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0150','Aziz Khan Gharagozloo','عزیز خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0147. The user marked part of this name with one question mark.',
  'probable','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0150','Aziz Khan Gharagozloo','en','canonical',1),
('P0150','عزیز خان قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0150','Aziz ? Khan','en','user_transcription_with_uncertainty',0);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0151','Fazl Allah Khan Gharagozloo','فضل‌الله خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0147.',
  'confirmed','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0151','Fazl Allah Khan Gharagozloo','en','canonical',1),
('P0151','فضل‌الله خان قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0152','Moosa Khan Gharagozloo','موسی خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0118.',
  'confirmed','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0152','Moosa Khan Gharagozloo','en','canonical',1),
('P0152','موسی خان قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0153','Mohammad Khan Hajilou Gharagozloo','محمد خان حاجیلو قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0118. The user marked the Hajilou reading with two question marks.',
  'provisional','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0153','Mohammad Khan Hajilou Gharagozloo','en','canonical',1),
('P0153','محمد خان حاجیلو قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0153','Mohammad Khan Hajilou ??','en','user_transcription_with_uncertainty',0);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0154','Taghi Khan Gharagozloo','تقی خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0153.',
  'confirmed','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0154','Taghi Khan Gharagozloo','en','canonical',1),
('P0154','تقی خان قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0155','Mohammad Hassan Khan Gharagozloo','محمدحسن خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0153.',
  'confirmed','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0155','Mohammad Hassan Khan Gharagozloo','en','canonical',1),
('P0155','محمدحسن خان قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES(
  'P0156','Farid al-Molk Mirza Mohammad Ali Khan Hamadani Gharagozloo','فریدالملک میرزا محمدعلی خان همدانی قراگوزلو','M',
  NULL,NULL,'Hajilou / Royani',
  'Descendant in the Haji Fazlollah Khan Royani branch reconstructed by the archive owner from S0001 Figure 4. Parent in this reconstruction: P0153.',
  'confirmed','2026-07-18T08:00:00Z','2026-07-18T08:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0156','Farid al-Molk Mirza Mohammad Ali Khan Hamadani Gharagozloo','en','canonical',1),
('P0156','فریدالملک میرزا محمدعلی خان همدانی قراگوزلو','fa','canonical',1);


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0092','P0096','parent_of','P0115','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4. The relationship is retained, while uncertainty applies to the child''s name reading.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0221','person','P0115','parentage',
  'Child of Haji Fazlollah Khan Royani Gharagozloo (P0096)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0221','X0105','supports'),
('C0221','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0221','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0190','person','P0115','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0115','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0093','P0096','parent_of','P0116','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0222','person','P0116','parentage',
  'Child of Haji Fazlollah Khan Royani Gharagozloo (P0096)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0222','X0105','supports'),
('C0222','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0222','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0191','person','P0116','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0116','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0094','P0096','parent_of','P0117','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4. The relationship is retained, while uncertainty applies to the child''s name reading.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0223','person','P0117','parentage',
  'Child of Haji Fazlollah Khan Royani Gharagozloo (P0096)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0223','X0105','supports'),
('C0223','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0223','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0192','person','P0117','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0117','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0095','P0096','parent_of','P0118','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4. The relationship is retained, while uncertainty applies to the child''s name reading.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0224','person','P0118','parentage',
  'Child of Haji Fazlollah Khan Royani Gharagozloo (P0096)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0224','X0105','supports'),
('C0224','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0224','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0193','person','P0118','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0118','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0096','P0115','parent_of','P0119','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0225','person','P0119','parentage',
  'Child of Mohammad Hassan Khan Gharagozloo (P0115)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0225','X0105','supports'),
('C0225','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0225','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0194','person','P0119','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0119','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0097','P0115','parent_of','P0120','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0226','person','P0120','parentage',
  'Child of Mohammad Hassan Khan Gharagozloo (P0115)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0226','X0105','supports'),
('C0226','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0226','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0195','person','P0120','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0120','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0098','P0119','parent_of','P0121','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0227','person','P0121','parentage',
  'Child of Ali Mohammad Khan Gharagozloo (P0119)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0227','X0105','supports'),
('C0227','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0227','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0196','person','P0121','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0121','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0099','P0120','parent_of','P0122','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0228','person','P0122','parentage',
  'Child of Shafi Khan Gharagozloo (P0120)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0228','X0105','supports'),
('C0228','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0228','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0197','person','P0122','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0122','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0100','P0117','parent_of','P0123','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4. The relationship is retained, while uncertainty applies to the child''s name reading.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0229','person','P0123','parentage',
  'Child of Hossein Ali Khan Gharagozloo (P0117)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0229','X0105','supports'),
('C0229','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0229','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0198','person','P0123','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0123','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0101','P0117','parent_of','P0124','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0230','person','P0124','parentage',
  'Child of Hossein Ali Khan Gharagozloo (P0117)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0230','X0105','supports'),
('C0230','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0230','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0199','person','P0124','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0124','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0102','P0117','parent_of','P0125','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0231','person','P0125','parentage',
  'Child of Hossein Ali Khan Gharagozloo (P0117)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0231','X0105','supports'),
('C0231','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0231','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0200','person','P0125','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0125','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0103','P0117','parent_of','P0126','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0232','person','P0126','parentage',
  'Child of Hossein Ali Khan Gharagozloo (P0117)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0232','X0105','supports'),
('C0232','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0232','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0201','person','P0126','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0126','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0104','P0117','parent_of','P0127','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0233','person','P0127','parentage',
  'Child of Hossein Ali Khan Gharagozloo (P0117)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0233','X0105','supports'),
('C0233','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0233','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0202','person','P0127','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0127','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0105','P0117','parent_of','P0128','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0234','person','P0128','parentage',
  'Child of Hossein Ali Khan Gharagozloo (P0117)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0234','X0105','supports'),
('C0234','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0234','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0203','person','P0128','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0128','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0106','P0117','parent_of','P0129','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0235','person','P0129','parentage',
  'Child of Hossein Ali Khan Gharagozloo (P0117)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0235','X0105','supports'),
('C0235','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0235','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0204','person','P0129','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0129','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0107','P0124','parent_of','P0130','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0236','person','P0130','parentage',
  'Child of Najaf Qoli Khan Gharagozloo (P0124)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0236','X0105','supports'),
('C0236','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0236','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0205','person','P0130','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0130','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0108','P0124','parent_of','P0131','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4. The relationship is retained, while uncertainty applies to the child''s name reading.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0237','person','P0131','parentage',
  'Child of Najaf Qoli Khan Gharagozloo (P0124)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0237','X0105','supports'),
('C0237','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0237','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0206','person','P0131','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0131','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0109','P0130','parent_of','P0132','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0238','person','P0132','parentage',
  'Child of Ali Khan Gharagozloo (P0130)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0238','X0105','supports'),
('C0238','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0238','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0207','person','P0132','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0132','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0110','P0130','parent_of','P0133','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0239','person','P0133','parentage',
  'Child of Ali Khan Gharagozloo (P0130)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0239','X0105','supports'),
('C0239','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0239','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0208','person','P0133','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0133','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0111','P0130','parent_of','P0134','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0240','person','P0134','parentage',
  'Child of Ali Khan Gharagozloo (P0130)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0240','X0105','supports'),
('C0240','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0240','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0209','person','P0134','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0134','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0112','P0126','parent_of','P0135','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0241','person','P0135','parentage',
  'Child of Heydar Qoli Khan Gharagozloo (P0126)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0241','X0105','supports'),
('C0241','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0241','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0210','person','P0135','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0135','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0113','P0127','parent_of','P0136','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0242','person','P0136','parentage',
  'Child of Mohammad Morad Beg Gharagozloo (P0127)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0242','X0105','supports'),
('C0242','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0242','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0211','person','P0136','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0136','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0114','P0127','parent_of','P0137','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0243','person','P0137','parentage',
  'Child of Mohammad Morad Beg Gharagozloo (P0127)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0243','X0105','supports'),
('C0243','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0243','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0212','person','P0137','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0137','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0115','P0127','parent_of','P0138','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0244','person','P0138','parentage',
  'Child of Mohammad Morad Beg Gharagozloo (P0127)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0244','X0105','supports'),
('C0244','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0244','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0213','person','P0138','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0138','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0116','P0137','parent_of','P0139','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0245','person','P0139','parentage',
  'Child of Enayat Allah Khan Gharagozloo (P0137)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0245','X0105','supports'),
('C0245','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0245','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0214','person','P0139','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0139','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0117','P0138','parent_of','P0140','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0246','person','P0140','parentage',
  'Child of Habib Allah Khan Gharagozloo (P0138)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0246','X0105','supports'),
('C0246','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0246','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0215','person','P0140','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0140','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0118','P0129','parent_of','P0141','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4. The relationship is retained, while uncertainty applies to the child''s name reading.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0247','person','P0141','parentage',
  'Child of Mohammad Vali Beg Gharagozloo (P0129)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0247','X0105','supports'),
('C0247','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0247','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0216','person','P0141','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0141','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0119','P0141','parent_of','P0142','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4. The relationship is retained, while uncertainty applies to the child''s name reading.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0248','person','P0142','parentage',
  'Child of Soltan Fath Ali Gharagozloo (P0141)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0248','X0105','supports'),
('C0248','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0248','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0217','person','P0142','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0142','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0120','P0118','parent_of','P0143','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0249','person','P0143','parentage',
  'Child of Abdolhossein Khan Farkhari Gharagozloo (P0118)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0249','X0105','supports'),
('C0249','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0249','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0218','person','P0143','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0143','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0121','P0143','parent_of','P0144','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4. The relationship is retained, while uncertainty applies to the child''s name reading.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0250','person','P0144','parentage',
  'Child of Shir Ali Beg Gharagozloo (P0143)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0250','X0105','supports'),
('C0250','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0250','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0219','person','P0144','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0144','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0122','P0144','parent_of','P0145','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4. The relationship is retained, while uncertainty applies to the child''s name reading.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0251','person','P0145','parentage',
  'Child of Zolfaghar Khan Gharagozloo (P0144)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0251','X0105','supports'),
('C0251','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0251','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0220','person','P0145','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0145','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0123','P0144','parent_of','P0146','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0252','person','P0146','parentage',
  'Child of Zolfaghar Khan Gharagozloo (P0144)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0252','X0105','supports'),
('C0252','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0252','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0221','person','P0146','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0146','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0124','P0118','parent_of','P0147','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0253','person','P0147','parentage',
  'Child of Abdolhossein Khan Farkhari Gharagozloo (P0118)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0253','X0105','supports'),
('C0253','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0253','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0222','person','P0147','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0147','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0125','P0147','parent_of','P0148','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0254','person','P0148','parentage',
  'Child of Ghasem Khan Gharagozloo (P0147)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0254','X0105','supports'),
('C0254','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0254','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0223','person','P0148','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0148','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0126','P0147','parent_of','P0149','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4. The relationship is retained, while uncertainty applies to the child''s name reading.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0255','person','P0149','parentage',
  'Child of Ghasem Khan Gharagozloo (P0147)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0255','X0105','supports'),
('C0255','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0255','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0224','person','P0149','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0149','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0127','P0147','parent_of','P0150','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4. The relationship is retained, while uncertainty applies to the child''s name reading.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0256','person','P0150','parentage',
  'Child of Ghasem Khan Gharagozloo (P0147)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0256','X0105','supports'),
('C0256','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0256','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0225','person','P0150','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0150','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0128','P0147','parent_of','P0151','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0257','person','P0151','parentage',
  'Child of Ghasem Khan Gharagozloo (P0147)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0257','X0105','supports'),
('C0257','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0257','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0226','person','P0151','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0151','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0129','P0118','parent_of','P0152','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0258','person','P0152','parentage',
  'Child of Abdolhossein Khan Farkhari Gharagozloo (P0118)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0258','X0105','supports'),
('C0258','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0258','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0227','person','P0152','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0152','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0130','P0118','parent_of','P0153','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4. The relationship is retained, while uncertainty applies to the child''s name reading.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0259','person','P0153','parentage',
  'Child of Abdolhossein Khan Farkhari Gharagozloo (P0118)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0259','X0105','supports'),
('C0259','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0259','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0228','person','P0153','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0153','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0131','P0153','parent_of','P0154','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0260','person','P0154','parentage',
  'Child of Mohammad Khan Hajilou Gharagozloo (P0153)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0260','X0105','supports'),
('C0260','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0260','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0229','person','P0154','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0154','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0132','P0153','parent_of','P0155','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0261','person','P0155','parentage',
  'Child of Mohammad Khan Hajilou Gharagozloo (P0153)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0261','X0105','supports'),
('C0261','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0261','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0230','person','P0155','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0155','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES(
  'R0133','P0153','parent_of','P0156','Parent-child placement follows the archive owner''s 2026-07-18 spreadsheet reconstruction of S0001 Figure 4.','probable'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES(
  'C0262','person','P0156','parentage',
  'Child of Mohammad Khan Hajilou Gharagozloo (P0153)',
  'probable','active',
  'User-supplied branch reconstruction aligned to S0001 Figure 4.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0262','X0105','supports'),
('C0262','X0106','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES(
  'C0262','USER_SUPPLIED','user_supplied','presents',
  'The archive owner supplied the structure and marked uncertain readings explicitly.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES(
  'EC0231','person','P0156','X0105','supports',
  'Person and placement transcribed from the user-supplied branch sheet.'
);

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0156','mentioned','Haji Fazlollah/Royani descendant in the corrected Figure 4 reconstruction.');


INSERT OR IGNORE INTO evidence_conflicts(
  conflict_id,entity_type,entity_id,conflict_topic,
  statement_a,statement_b,resolution_status,notes
) VALUES(
  'CF005','person','P0096','immediate children of Haji Fazlollah Khan',
  'The user-supplied reconstruction of Figure 4 shows four immediate children: Mohammad Hassan Khan, Ali Khan, Hossein Ali Khan, and Abdolhossein Khan Farkhari.',
  'The family-history summary in Majmooe Asaar appears to name three sons and uses a different formulation, including Haji Mohammad Hossein.',
  'unresolved',
  'The canonical graph follows the archive owner’s row-by-row Figure 4 reconstruction. The comparison-source discrepancy remains open and must not be silently merged.'
);

INSERT OR IGNORE INTO research_questions(
  question_id,question,status,priority,notes
) VALUES
(
  'Q0028',
  'Is the first immediate child of Haji Fazlollah Khan correctly read as Mohammad Hassan Khan, and does he correspond to Haji Mohammad Hossein in the comparison family memoir?',
  'open','high',
  'The user marked Mohammad Hassan Khan with one question mark. The comparison family memoir uses Haji Mohammad Hossein.'
),
(
  'Q0029',
  'Is the second uncertain immediate-child reading under Haji Fazlollah Khan exactly Hossein Ali Khan?',
  'open','medium',
  'The user marked the name with one question mark.'
),
(
  'Q0030',
  'What is the exact name represented provisionally as Mirza Soltan in the Hossein Ali branch?',
  'open','medium',
  'The user marked this reading with one question mark.'
),
(
  'Q0031',
  'What is the exact personal name and title of the Najaf Qoli descendant provisionally entered as Mohammad Zahir Fath al-Dowleh?',
  'open','high',
  'Both elements were marked uncertain in the user transcription.'
),
(
  'Q0032',
  'What are the exact readings of Soltan Fath Ali and his descendant currently entered as Hasan?',
  'open','high',
  'The first name was marked ? and the descendant was marked ??.'
),
(
  'Q0033',
  'What are the exact readings of Zolfaghar Khan and his descendant currently entered as Hasan?',
  'open','high',
  'Both were marked ?? in the user reconstruction.'
),
(
  'Q0034',
  'What are the exact readings of Hossein Ali Khan and Aziz Khan in the Ghasem Khan sub-branch?',
  'open','medium',
  'Each contains a user-marked uncertain element.'
),
(
  'Q0035',
  'Is Mohammad Khan Hajilou the correct reading, and what is the precise identity of the Farid al-Molk Mirza Mohammad Ali Khan Hamadani descendant?',
  'open','high',
  'The parent label was marked ??; the longer descendant name should be checked against the original diagram and prose.'
);

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary) VALUES
(
  '2026-07-18T08:00:00Z','person','P0096','update',
  'Rebuilt the Haji Fazlollah Khan Royani node from the archive owner’s corrected row-by-row reconstruction.'
),
(
  '2026-07-18T08:00:00Z','person','P0115-P0156','insert',
  'Added 42 distinct descendants from the user-supplied Haji Fazlollah branch sheet, preserving ? and ?? uncertainty.'
),
(
  '2026-07-18T08:00:00Z','relationship','R0092-R0133','insert',
  'Added 42 parent-child edges for the corrected Haji Fazlollah/Royani branch.'
),
(
  '2026-07-18T08:00:00Z','conflict','CF005','insert',
  'Preserved the conflict between the Figure 4 reconstruction and the three-son formulation in the comparison family memoir.'
);

INSERT OR REPLACE INTO metadata(key,value) VALUES('archive_version','2.6.8');
INSERT OR REPLACE INTO metadata(key,value) VALUES(
  'haji_fazlollah_royani_branch',
  'Corrected user-supplied reconstruction added under P0096. Contains P0115-P0156 and R0092-R0133. Question marks are preserved through verification status, alternate transcriptions, and Q0028-Q0035.'
);
