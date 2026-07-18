-- Archive v2.6.6 — Reconstruct the Nasrollah Khan Korijani branch
--
-- Genealogical evidence:
--   * S0001 Figure 4, printed p. 213
--   * Human-confirmed Persian readings:
--       Nasrollah Khan Korijani -> Gholam Khan -> Noor Ali Khan
--
-- Biographical evidence:
--   * S0001 printed pp. 48-51, 59, 90-91, 99, 103, 113-114
--
-- This migration:
--   * promotes the geographic form "Korijani" into P0073's canonical name;
--   * adds Gholam Khan and Noor Ali Khan;
--   * adds the two diagram-supported parent-child links;
--   * enriches Nasrollah Khan's offices, missions, events, and citations.

INSERT OR IGNORE INTO citations(
  citation_id, source_id, page_printed, page_file, locator_text, quoted_text, notes
) VALUES
(
  'X0098','S0001','213',NULL,
  'Figure 4 — Nasrollah Khan Korijani branch',
  NULL,
  'Figure 4 shows the three-generation chain Nasrollah Khan Korijani -> Gholam Khan -> Noor Ali Khan. The Persian labels and structure were confirmed directly by the archive owner.'
),
(
  'X0099','S0001','48-51',NULL,
  'Chapter 1 — Zand-era military activity of Nasrollah Khan',
  NULL,
  'Associates Nasrollah Khan with the Gharagozloo decision to support Karim Khan Zand, command of Gharagozloo forces, the Yazd mission of 1194 AH, and subsequent Zand-Qajar military activity.'
),
(
  'X0100','S0001','59',NULL,
  'Chapter 2 — Hajilou identity of Nasrollah Khan Korijani',
  NULL,
  'Explicitly identifies Nasrollah Khan Korijani as a member of the Hajilou branch.'
),
(
  'X0101','S0001','90-103',NULL,
  'Chapter 3 — early Qajar military service',
  NULL,
  'Describes service with Qajar forces, guarding Isfahan in 1203 AH, command of one thousand cavalry near Qomsheh, and the western-frontier mission under Mohammad Ali Mirza Dowlatshah on 12 Rajab 1222 AH.'
),
(
  'X0102','S0001','113-114',NULL,
  'Chapter 3 — offices in Fars',
  NULL,
  'Identifies Nasrollah Khan as head of the Gharagozloo forces in Fars, military administrator in 1215 AH, Minister of Fars from 1220 AH until Nowruz 1223 AH, and a man remembered in Shiraz for poetry, good nature, and good character.'
);

INSERT OR IGNORE INTO places(
  place_id, preferred_name_en, preferred_name_fa, place_type, parent_place_id, notes
) VALUES
(
  'L0047','Fars','فارس','province',NULL,
  'Major area of military and administrative service for Nasrollah Khan Korijani.'
),
(
  'L0048','Isfahan','اصفهان','city/province',NULL,
  'Nasrollah Khan was responsible for guarding Isfahan in 1203 AH.'
),
(
  'L0049','Qomsheh (Shahreza)','قمشه (شهرضا)','town','L0048',
  'Area of Nasrollah Khan’s 1203 AH cavalry engagement with Zand forces.'
),
(
  'L0050','Shahrizor','شهرزور','region',NULL,
  'Area associated with the 1222 AH mission against Abd al-Rahman Pasha.'
);

UPDATE persons
SET preferred_name_en='Nasrollah Khan Korijani Gharagozloo',
    preferred_name_fa='نصرالله خان کوریجانی قراگوزلو',
    branch='Hajilou / Korijani',
    summary='Senior Hajilou commander active during the Zand-Qajar transition. He helped advocate Gharagozloo support for Karim Khan Zand, commanded forces in Yazd and central Iran, guarded Isfahan, served on the western frontier, led the Gharagozloo forces in Fars, and became Minister of Fars from 1220 AH until Nowruz 1223 AH. Figure 4 identifies Gholam Khan as his son and Noor Ali Khan as his grandson.',
    verification_status='confirmed',
    updated_at='2026-07-18T06:00:00Z'
WHERE person_id='P0073';

UPDATE person_names
SET is_preferred=0
WHERE person_id='P0073';

UPDATE person_names
SET name_type='canonical', is_preferred=1
WHERE person_id='P0073'
  AND name_text='Nasrollah Khan Korijani Gharagozloo'
  AND language='en';

UPDATE person_names
SET name_type='canonical', is_preferred=1
WHERE person_id='P0073'
  AND name_text='نصرالله خان کوریجانی قراگوزلو'
  AND language='fa';

INSERT INTO person_names(person_id,name_text,language,name_type,is_preferred)
SELECT 'P0073','Nasrollah Khan Korijani Gharagozloo','en','canonical',1
WHERE NOT EXISTS (
  SELECT 1 FROM person_names
  WHERE person_id='P0073'
    AND name_text='Nasrollah Khan Korijani Gharagozloo'
    AND language='en'
);

INSERT INTO person_names(person_id,name_text,language,name_type,is_preferred)
SELECT 'P0073','نصرالله خان کوریجانی قراگوزلو','fa','canonical',1
WHERE NOT EXISTS (
  SELECT 1 FROM person_names
  WHERE person_id='P0073'
    AND name_text='نصرالله خان کوریجانی قراگوزلو'
    AND language='fa'
);

INSERT INTO person_names(person_id,name_text,language,name_type,is_preferred)
SELECT 'P0073','Nasrollah Khan Gharagozloo','en','short_form',0
WHERE NOT EXISTS (
  SELECT 1 FROM person_names
  WHERE person_id='P0073'
    AND name_text='Nasrollah Khan Gharagozloo'
    AND language='en'
);

INSERT INTO person_names(person_id,name_text,language,name_type,is_preferred)
SELECT 'P0073','نصرالله خان قراگوزلو','fa','short_form',0
WHERE NOT EXISTS (
  SELECT 1 FROM person_names
  WHERE person_id='P0073'
    AND name_text='نصرالله خان قراگوزلو'
    AND language='fa'
);

INSERT OR IGNORE INTO persons(
  person_id, preferred_name_en, preferred_name_fa, sex,
  birth_date_text, death_date_text, branch, summary,
  verification_status, created_at, updated_at
) VALUES
(
  'P0105','Gholam Khan Gharagozloo','غلام خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Korijani',
  'Son of Nasrollah Khan Korijani and father of Noor Ali Khan in S0001 Figure 4.',
  'probable','2026-07-18T06:00:00Z','2026-07-18T06:00:00Z'
),
(
  'P0106','Noor Ali Khan Gharagozloo','نورعلی خان قراگوزلو','M',
  NULL,NULL,'Hajilou / Korijani',
  'Son of Gholam Khan and grandson of Nasrollah Khan Korijani in S0001 Figure 4.',
  'probable','2026-07-18T06:00:00Z','2026-07-18T06:00:00Z'
);

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0105','Gholam Khan Gharagozloo','en','canonical',1),
('P0105','غلام خان قراگوزلو','fa','canonical',1),
('P0106','Noor Ali Khan Gharagozloo','en','canonical',1),
('P0106','نورعلی خان قراگوزلو','fa','canonical',1);

INSERT OR IGNORE INTO relationships(
  relationship_id,person1_id,relationship_type,person2_id,notes,verification_status
) VALUES
(
  'R0082','P0073','parent_of','P0105',
  'Figure 4 shows Gholam Khan as the child of Nasrollah Khan Korijani.',
  'probable'
),
(
  'R0083','P0105','parent_of','P0106',
  'Figure 4 shows Noor Ali Khan as the child of Gholam Khan.',
  'probable'
);

INSERT OR IGNORE INTO roles(
  role_id,preferred_name_en,preferred_name_fa,role_category,description
) VALUES
(
  'ROLE0013','Head of Gharagozloo forces in Fars',
  'سرکرده قراگوزلویان فارس','military_office',
  'Command responsibility for the Gharagozloo forces serving in Fars.'
),
(
  'ROLE0014','Military administrator of the army in Fars',
  'ناظم نظام لشکر در فارس','military_office',
  'Military administrative office reported for Nasrollah Khan in 1215 AH.'
),
(
  'ROLE0015','Minister of Fars',
  'وزیر فارس','government_office',
  'Senior provincial ministerial office in Fars.'
);

INSERT OR IGNORE INTO person_role_assignments(
  assignment_id,person_id,role_id,organization_id,place_id,date_text,
  start_date_text,end_date_text,appointing_authority_text,notes,verification_status
) VALUES
(
  'PRA0008','P0073','ROLE0013',NULL,'L0047',
  'early Qajar period',NULL,NULL,NULL,
  'S0001 describes Nasrollah Khan as head of the Gharagozloo forces in Fars.',
  'confirmed'
),
(
  'PRA0009','P0073','ROLE0014',NULL,'L0047',
  '1215 AH','1215 AH',NULL,NULL,
  'Sir John Malcolm is cited by S0001 as identifying him as military administrator of the army in Fars.',
  'confirmed'
),
(
  'PRA0010','P0073','ROLE0015',NULL,'L0047',
  '1220 AH - Nowruz 1223 AH','1220 AH','Nowruz 1223 AH','Fath-Ali Shah Qajar',
  'Appointed Minister of Fars in 1220 AH and replaced by Mohammad Nabi Khan at Nowruz 1223 AH.',
  'confirmed'
);

INSERT OR IGNORE INTO events(
  event_id,event_type,title,date_text,place_id,description,verification_status
) VALUES
(
  'E0076','military engagement',
  'Nasrollah Khan defends Isfahan and fights near Qomsheh',
  '1203 AH','L0049',
  'While responsible for guarding Isfahan, Nasrollah Khan warned Ali Qoli Khan Qajar of a renewed Zand attack and engaged the Zand force with one thousand cavalry near Qomsheh. His force was defeated. A report that he was captured is treated by S0001 as uncertain.',
  'confirmed'
),
(
  'E0077','military mission',
  'Nasrollah Khan joins the mission against Abd al-Rahman Pasha',
  '12 Rajab 1222 AH','L0050',
  'Nasrollah Khan and his retainers served with Mohammad Ali Mirza Dowlatshah in the mission against Abd al-Rahman Pasha in Shahrizor.',
  'confirmed'
),
(
  'E0078','appointment',
  'Nasrollah Khan appointed Minister of Fars',
  '1220 AH','L0047',
  'Fath-Ali Shah appointed Nasrollah Khan Minister of Fars after complaints against the prior minister.',
  'confirmed'
),
(
  'E0079','dismissal',
  'Nasrollah Khan replaced as Minister of Fars',
  'Nowruz 1223 AH','L0047',
  'Nasrollah Khan’s three-year ministry ended and Mohammad Nabi Khan, known as the Great Ambassador, replaced him.',
  'confirmed'
);

INSERT OR IGNORE INTO event_persons(event_id,person_id,role) VALUES
('E0076','P0073','commander'),
('E0077','P0073','commander/participant'),
('E0078','P0073','appointee'),
('E0079','P0073','outgoing minister');

INSERT OR IGNORE INTO claims(
  claim_id,subject_type,subject_id,predicate,object_text,
  confidence,status,notes
) VALUES
(
  'C0199','person','P0105','parentage',
  'Son of Nasrollah Khan Korijani Gharagozloo (P0073)',
  'probable','active','Figure 4 genealogy.'
),
(
  'C0200','person','P0106','parentage',
  'Son of Gholam Khan Gharagozloo (P0105)',
  'probable','active','Figure 4 genealogy.'
),
(
  'C0201','person','P0073','branch affiliation',
  'Hajilou, Korijani line',
  'confirmed','active','Explicitly identified as Hajilou in the narrative.'
),
(
  'C0202','person','P0073','political-military alliance',
  'Helped advocate Gharagozloo support for Karim Khan Zand',
  'confirmed','active','Narrative account in S0001.'
),
(
  'C0203','person','P0073','military command',
  'Commanded Gharagozloo forces sent toward Yazd in 1194 AH',
  'confirmed','active','Already represented by event E0073 and enriched here.'
),
(
  'C0204','person','P0073','military service',
  'Guarded Isfahan and commanded one thousand cavalry near Qomsheh in 1203 AH',
  'confirmed','active','S0001 narrative; possible capture is not asserted.'
),
(
  'C0205','person','P0073','military service',
  'Served in the 1222 AH mission against Abd al-Rahman Pasha',
  'confirmed','active','S0001 narrative.'
),
(
  'C0206','person','P0073','held office',
  'Military administrator of the army in Fars in 1215 AH',
  'confirmed','active','S0001 cites Sir John Malcolm.'
),
(
  'C0207','person','P0073','held office',
  'Minister of Fars from 1220 AH until Nowruz 1223 AH',
  'confirmed','active','S0001 narrative.'
),
(
  'C0208','person','P0073','personal reputation',
  'Known in Shiraz for poetic ability, good nature, and good character',
  'confirmed','active','Authorial summary in S0001.'
);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0199','X0098','supports'),
('C0200','X0098','supports'),
('C0201','X0100','supports'),
('C0202','X0099','supports'),
('C0203','X0099','supports'),
('C0204','X0101','supports'),
('C0205','X0101','supports'),
('C0206','X0102','supports'),
('C0207','X0102','supports'),
('C0208','X0102','supports');

INSERT OR IGNORE INTO claim_evidence_profiles(
  claim_id,evidence_type_code,assertion_scope,source_position,assessment_notes
) VALUES
('C0199','GENEALOGICAL_DIAGRAM','genealogical_diagram','presents','Parentage reconstructed from Figure 4 and human-confirmed reading.'),
('C0200','GENEALOGICAL_DIAGRAM','genealogical_diagram','presents','Parentage reconstructed from Figure 4 and human-confirmed reading.'),
('C0201','NARRATIVE_FACT','author_statement','supports','Direct branch identification in the prose.'),
('C0202','NARRATIVE_FACT','author_statement','supports','Narrative political-military account.'),
('C0203','NARRATIVE_FACT','author_statement','supports','Narrative military mission account.'),
('C0204','NARRATIVE_FACT','author_statement','supports','Narrative military account; uncertain capture excluded from the claim.'),
('C0205','NARRATIVE_FACT','author_statement','supports','Narrative western-frontier mission account.'),
('C0206','NARRATIVE_FACT','author_statement','supports','Office reported by S0001 through Malcolm.'),
('C0207','NARRATIVE_FACT','author_statement','supports','Direct narrative appointment and dismissal dates.'),
('C0208','NARRATIVE_FACT','author_statement','supports','Authorial biographical assessment.');

INSERT OR IGNORE INTO entity_citations(
  entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES
('EC0168','person','P0073','X0098','supports','Figure 4 branch genealogy.'),
('EC0169','person','P0073','X0099','supports','Zand-era military activity.'),
('EC0170','person','P0073','X0100','supports','Hajilou/Korijani identity.'),
('EC0171','person','P0073','X0101','supports','Early Qajar military service.'),
('EC0172','person','P0073','X0102','supports','Fars offices and reputation.'),
('EC0173','person','P0105','X0098','supports','Figure 4 child label and relationship.'),
('EC0174','person','P0106','X0098','supports','Figure 4 grandchild label and relationship.'),
('EC0175','event','E0076','X0101','supports','1203 AH Isfahan/Qomsheh engagement.'),
('EC0176','event','E0077','X0101','supports','1222 AH western-frontier mission.'),
('EC0177','event','E0078','X0102','supports','Appointment as Minister of Fars.'),
('EC0178','event','E0079','X0102','supports','End of ministry in Nowruz 1223 AH.');

INSERT OR IGNORE INTO artifact_persons(artifact_id,person_id,role,notes) VALUES
('A0015','P0105','mentioned','Figure 4 son of Nasrollah Khan Korijani.'),
('A0015','P0106','mentioned','Figure 4 grandson of Nasrollah Khan Korijani.');

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary) VALUES
(
  '2026-07-18T06:00:00Z','person','P0073','update',
  'Promoted Korijani into Nasrollah Khan’s canonical name and added offices, missions, and biographical evidence.'
),
(
  '2026-07-18T06:00:00Z','person','P0105-P0106','insert',
  'Added Gholam Khan and Noor Ali Khan from S0001 Figure 4.'
),
(
  '2026-07-18T06:00:00Z','relationship','R0082-R0083','insert',
  'Added Nasrollah Khan -> Gholam Khan -> Noor Ali Khan genealogy.'
);

INSERT OR REPLACE INTO metadata(key,value) VALUES('archive_version','2.6.6');
INSERT OR REPLACE INTO metadata(key,value) VALUES(
  'nasrollah_korijani_branch',
  'Reconstructed P0073 Nasrollah Khan Korijani -> P0105 Gholam Khan -> P0106 Noor Ali Khan and enriched Nasrollah Khan’s Zand-Qajar military and Fars administrative biography.'
);
