-- Archive v2.7.3 — Add two children of Hossein Qoli Khan Amir Nezam
--
-- User-confirmed structure supplied on 2026-07-31:
--
-- Hossein Qoli Khan Amir Nezam (P0012)
-- ├── Mostafa Gharagozloo
-- └── Adel Khan Gharagozloo
--
-- This migration adds only these two children and does not alter existing
-- people or relationships.

INSERT OR IGNORE INTO citations(
  citation_id,source_id,page_printed,page_file,locator_text,quoted_text,notes
) VALUES(
  'X0112','U0001',NULL,NULL,
  'User-confirmed children of Hossein Qoli Khan Amir Nezam, 2026-07-31',
  NULL,
  'The archive owner supplied two children: Mostafa Gharagozloo and Adel Khan Gharagozloo.'
);

INSERT OR IGNORE INTO persons(
  person_id,preferred_name_en,preferred_name_fa,sex,
  birth_date_text,death_date_text,branch,summary,
  verification_status,created_at,updated_at
) VALUES
(
  'P0168','Mostafa Gharagozloo','مصطفی قراگوزلو','M',
  NULL,NULL,'Hajilou / Amir Nezam',
  'Child of Hossein Qoli Khan Amir Nezam, supplied directly by the archive owner.',
  'confirmed','2026-07-31T21:00:00-07:00','2026-07-31T21:00:00-07:00'
),
(
  'P0169','Adel Khan Gharagozloo','عادل خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Amir Nezam',
  'Child of Hossein Qoli Khan Amir Nezam, supplied directly by the archive owner.',
  'confirmed','2026-07-31T21:00:00-07:00','2026-07-31T21:00:00-07:00'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0168','Mostafa Gharagozloo','en','canonical',1),
('P0168','مصطفی قراگوزلو','fa','canonical',1),
('P0169','Adel Khan Gharagozloo','en','canonical',1),
('P0169','عادل خان قراگوزلو','fa','canonical',1);

INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES
(
  'R0145','P0012','parent_of','P0168',
  'User-confirmed child of Hossein Qoli Khan Amir Nezam.',
  'confirmed'
),
(
  'R0146','P0012','parent_of','P0169',
  'User-confirmed child of Hossein Qoli Khan Amir Nezam.',
  'confirmed'
);

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES
(
  'C0275','person','P0168','parentage',
  'Child of Hossein Qoli Khan Amir Nezam (P0012)',
  'confirmed','active','User-confirmed reconstruction.'
),
(
  'C0276','person','P0169','parentage',
  'Child of Hossein Qoli Khan Amir Nezam (P0012)',
  'confirmed','active','User-confirmed reconstruction.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0275','X0112','supports'),
('C0276','X0112','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES
(
  'C0275','USER_SUPPLIED','user_supplied','presents',
  'Relationship supplied directly by the archive owner.'
),
(
  'C0276','USER_SUPPLIED','user_supplied','presents',
  'Relationship supplied directly by the archive owner.'
);

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES
(
  'EC0245','person','P0168','X0112','supports',
  'User-confirmed child of Hossein Qoli Khan Amir Nezam.'
),
(
  'EC0246','person','P0169','X0112','supports',
  'User-confirmed child of Hossein Qoli Khan Amir Nezam.'
);

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary) VALUES
(
  '2026-07-31T21:00:00-07:00','person','P0168-P0169','insert',
  'Added Mostafa Gharagozloo and Adel Khan Gharagozloo as children of Hossein Qoli Khan Amir Nezam (P0012).'
),
(
  '2026-07-31T21:00:00-07:00','relationship','R0145-R0146','insert',
  'Added two parent-child relationships beneath Hossein Qoli Khan Amir Nezam (P0012).'
);

INSERT OR REPLACE INTO metadata(key,value) VALUES('archive_version','2.7.3');
INSERT OR REPLACE INTO metadata(key,value) VALUES(
  'hossein_qoli_amir_nezam_children',
  'Added Mostafa Gharagozloo and Adel Khan Gharagozloo as confirmed children of P0012.'
);
