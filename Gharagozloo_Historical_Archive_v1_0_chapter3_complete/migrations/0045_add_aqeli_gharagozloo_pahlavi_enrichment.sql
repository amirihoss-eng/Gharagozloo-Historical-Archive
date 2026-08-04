-- Migration 0045
-- Bagher Aqeli: Khandanhaye Hokoomatgar dar Iran — Gharagozloo chapter enrichment
-- Baseline: v2.9.1 / migration 0044
--
-- Scope:
--   * Late-Qajar and Pahlavi-era biographical enrichment from Aqeli
--   * Amir Nezam / Amir Arfa branch
--   * Hossein Qoli Khan Amir Nezam II
--   * Mohtaj Ali Khan, Mansur Ali Khan, Gholamhossein Amiri Gharagozloo context
--   * Amir Nezam estate / waqf evidence
--   * selected Baha al-Molk / Amir Afkham contextual evidence
--   * explicit chronology conflicts and source-attributed allegations
--
-- IMPORTANT:
--   * Aqeli is treated as a secondary biographical source.
--   * No canonical genealogy changes.
--   * No forced person-ID creation for contextual figures whose canonical IDs
--     are not safely resolved in this migration package.
--   * P0004 = Haji Abdollah Khan Amir Nezam.
--   * To maximize compatibility with the user's live archive, only P0004 is
--     referenced directly in this migration.
--   * Claims concerning Hossein Qoli, Mohtaj Ali, Mansur Ali, Gholamhossein
--     Amiri, and other later figures are stored in a dedicated source-analysis
--     event until their live canonical person IDs are explicitly reconciled.
--   * Allegations, judgments, and anecdotes remain attributed to Aqeli.
--   * Transaction control omitted because apply_migration.py owns it.

UPDATE metadata SET value='2.9.2' WHERE key='database_version';
INSERT OR REPLACE INTO metadata(key,value) VALUES('last_migration','0045');
INSERT OR REPLACE INTO metadata(key,value) VALUES('updated_at','2026-08-04T05:20:00Z');
INSERT OR REPLACE INTO metadata(key,value) VALUES(
    'historical_enrichment_checkpoint',
    'Aqeli Gharagozloo Late Qajar and Pahlavi Biographical Enrichment'
);

INSERT INTO sources(source_id,short_title,full_title,author,publication_year,source_type,file_name,notes)
SELECT 'S0202',
       'Khandanhaye Hokoomatgar dar Iran — Gharagozloo',
       'خاندان‌های حکومتگر در ایران — فصل قراگوزلو',
       'Bagher Aqeli',
       NULL,
       'secondary biographical reference',
       'Khandanhaye Hokoomay Gar Dar Iran-OCRed.pdf',
       'OCRed chapter extract on the Gharagozloo family. OCR is imperfect; claims are preserved conservatively and should be checked against page images when wording is uncertain.'
WHERE NOT EXISTS (SELECT 1 FROM sources WHERE source_id='S0202');

-- ---------------------------------------------------------------------------
-- Source-analysis event used to hold contextual late-generation claims whose
-- live canonical person IDs are intentionally not guessed in this package.
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO events(
    event_id,event_type,title,date_text,place_id,description,verification_status
) VALUES(
    'E0400',
    'source_reconciliation',
    'Aqeli Gharagozloo Late-Qajar and Pahlavi Biographical Evidence Cluster',
    'late Qajar to Pahlavi period',
    NULL,
    'Secondary biographical evidence from Bagher Aqeli concerning later Gharagozloo generations, estates, waqf administration, public offices, marriages, education, and source conflicts. This is an evidence/reconciliation cluster, not a single historical occurrence.',
    'confirmed'
);

-- ---------------------------------------------------------------------------
-- Citations
-- Page-file numbers are retained where securely associated with the OCRed
-- chapter extract; locator text is the primary locator because OCR layout is
-- imperfect and some scan pages contain two book pages.
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO citations(
    citation_id,source_id,page_printed,page_file,locator_text,quoted_text,notes
) VALUES
('X1500','S0202',NULL,NULL,'Abdollah Khan Amir Nezam biography',
 'Aqeli gives a probable birth around 1235 SH, describes the Astarabad appointment at about age twenty-six, and reports that in 1333 AH he was considered for the premiership before later serving as Minister of Finance.',
 'Secondary biographical evidence; birth and premiership episode require independent corroboration.'),
('X1501','S0202',NULL,NULL,'Hossein Qoli Khan Amir Nezam II biography',
 'Aqeli gives a birth around 1260 SH, military service under his father, Sa''ed al-Saltaneh in 1314 AH, European study, later governorship, Amir Nezam title succession, Pahlavi court service, and death in 1332 SH.',
 'Secondary biography; some dates/offices require independent corroboration.'),
('X1502','S0202',NULL,NULL,'Hossein Qoli Khan estate and waqf',
 'Aqeli associates Hossein Qoli Khan with an inheritance of roughly forty-five villages and later charitable endowment of much of the estate.',
 'Secondary estate/waqf evidence.'),
('X1503','S0202',NULL,NULL,'Gholamhossein Amiri Gharagozloo biography',
 'Aqeli says Gholamhossein Amiri Gharagozloo studied petroleum-related subjects in Europe, became a manager/director in the oil company, represented Hamadan in the Sixteenth Majles, and later supervised family waqf property.',
 'Secondary biography; exact institutional titles and dates should be independently verified.'),
('X1504','S0202',NULL,NULL,'Gholamhossein Amiri waqf statement',
 'Aqeli reports that Hossein Qoli Khan had endowed about forty-five villages for charitable purposes including a hospital and school, while later disputes reduced the surviving waqf to about fourteen villages plus a Tehran house; Gholamhossein was involved in supervision and recovery efforts.',
 'Secondary report apparently drawing on a statement attributed to Gholamhossein Amiri Gharagozloo.'),
('X1505','S0202',NULL,NULL,'Mohtaj Ali Khan biography and marriage sequencing',
 'Aqeli describes Mohtaj Ali Khan as involved in financial/banking matters, educated in Europe with Mansur Ali, and places his marriage to a daughter of Fazlollah Khan Entesar al-Molk after his return.',
 'Secondary chronology conflicts with Majmooe Asaar marriage date of Dhu al-Hijjah 1324 AH.'),
('X1506','S0202',NULL,NULL,'Mansur Ali Khan Sardar Akram II biography',
 'Aqeli gives education at Dar al-Funun and in Europe, later governorships, action against Salar al-Dowleh, Hamadan representation in the Eleventh Majles, and marriage to a daughter of Vosuq al-Dowleh.',
 'Secondary biography; marriage is independently corroborated by Majmooe Asaar.'),
('X1507','S0202',NULL,NULL,'Gholamhossein Amiri post-1979 allegation',
 'Aqeli reports that Gholamhossein Amiri Gharagozloo was briefly imprisoned after the Revolution in connection with an allegation of Freemasonry membership.',
 'Sensitive/contested biographical allegation; preserve only as attributed secondary-source claim pending independent evidence.'),
('X1508','S0202',NULL,NULL,'Hossein Qoli Khan anecdotal death account',
 'Aqeli preserves an anecdotal account that Hossein Qoli Khan was fond of gambling and died after a seizure in a bath at his Victoria residence.',
 'Anecdotal and attributed; do not treat cause or circumstances of death as independently established.'),
('X1509','S0202',NULL,NULL,'Amir Afkham and Shervini branch characterizations',
 'Aqeli provides late-Qajar/early-Pahlavi biographical detail for Amir Afkham and related figures but also uses strongly judgmental language about their conduct.',
 'Biographical details may corroborate; moral judgments remain attributed.'),
('X1510','S0202',NULL,NULL,'Baha al-Molk branch late-Pahlavi biographies',
 'Aqeli provides later biographies for Alireza Khan Baha al-Molk, Yahya Khan Etemad al-Dowleh, Manouchehr Gharagozloo, and related descendants.',
 'Contextual branch enrichment; canonical IDs should be reconciled before person-level insertion.'),
('X1511','S0202',NULL,NULL,'Gholamhossein Parzhad distinction',
 'Aqeli describes Gholamhossein Parzhad Gharagozloo as a separate person from Gholamhossein Amiri Gharagozloo, with a different parentage and parliamentary career.',
 'Important identity distinction to prevent conflation of two same-name later-generation figures.');

-- ---------------------------------------------------------------------------
-- Direct claims on established core person P0004; later-generation claims remain on E0400
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO claims(
    claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES
('C1500','person','P0004','aqeli_candidate_birth',
 'Aqeli gives Abdollah Khan Amir Nezam a probable birth around 1235 SH (approximately 1856–1857 CE).',
 'probable','active',
 'Do not set canonical birth date yet; internally plausible with 1298 AH Astarabad appointment but needs independent evidence.'),
('C1501','person','P0004','aqeli_astarabad_age',
 'Aqeli reports that Abdollah Khan was about twenty-six years old when appointed governor of Astarabad.',
 'probable','active',
 'Secondary age estimate; useful as a consistency check on candidate birth year.'),
('C1502','person','P0004','aqeli_premiership_consideration_1333',
 'Aqeli reports that in 1333 AH Ain al-Dowleh considered Abdollah Khan for the premiership, but the appointment did not materialize.',
 'probable','active',
 'New secondary biographical claim; requires corroboration.'),
('C1503','person','P0004','aqeli_finance_ministry_context',
 'Aqeli associates the unrealized premiership consideration with a subsequent short term as Minister of Finance.',
 'probable','active',
 'Finance service is already known; this claim preserves Aqeli''s sequencing/context.'),

('C1510','event','E0400','hossein_qoli_aqeli_candidate_birth',
 'Aqeli gives Hossein Qoli Khan Amir Nezam II a probable birth around 1260 SH.',
 'probable','active',
 'Secondary estimate; do not overwrite canonical birth fields without corroboration.'),
('C1511','event','E0400','hossein_qoli_aqeli_cavalry_command_1310',
 'Aqeli reports that by about 1310 AH Hossein Qoli Khan commanded cavalry associated with his father''s military establishment.',
 'probable','active',
 'Secondary military-career enrichment.'),
('C1512','event','E0400','hossein_qoli_aqeli_saed_al_saltaneh_1314',
 'Aqeli states that Hossein Qoli Khan received the title Sa''ed al-Saltaneh in 1314 AH.',
 'confirmed','active',
 'Corroborates existing title-transfer evidence.'),
('C1513','event','E0400','hossein_qoli_aqeli_european_education',
 'Aqeli reports that Hossein Qoli Khan studied in Europe and returned able to speak and write French and English well.',
 'probable','active',
 'Field/institution not securely established in Aqeli passage.'),
('C1514','event','E0400','hossein_qoli_aqeli_kermanshah_governorship',
 'Aqeli reports that Hossein Qoli Khan later served as governor of Kermanshah.',
 'probable','active',
 'Late-Qajar career enrichment; exact dates require reconciliation.'),
('C1515','event','E0400','hossein_qoli_aqeli_amir_nezam_title_succession',
 'Aqeli states that after Abdollah Khan''s death Hossein Qoli Khan inherited the title Amir Nezam.',
 'confirmed','active',
 'Corroborates existing title succession.'),
('C1516','event','E0400','hossein_qoli_aqeli_estate_inheritance',
 'Aqeli associates Hossein Qoli Khan with an inheritance of approximately forty-five villages.',
 'probable','active',
 'Secondary estimate; requires property-by-property reconstruction.'),
('C1517','event','E0400','hossein_qoli_aqeli_minister_of_war_1299_sh',
 'Aqeli reports that Hossein Qoli Khan briefly served as Minister of War in 1299 SH in a cabinet of Fathollah Khan Sepahdar Rashti.',
 'probable','active',
 'New Pahlavi-transition career claim; verify against cabinet records.'),
('C1518','event','E0400','hossein_qoli_aqeli_pahlavi_foreign_protocol',
 'Aqeli reports that under Reza Shah Hossein Qoli Khan became head of foreign protocol at the Pahlavi court and remained in that role until about 1318 SH.',
 'probable','active',
 'New Pahlavi-era career claim; exact title/dates need official corroboration.'),
('C1519','event','E0400','hossein_qoli_aqeli_death_1332_sh',
 'Aqeli gives Hossein Qoli Khan''s death year as 1332 SH.',
 'probable','active',
 'Secondary death-year evidence.'),
('C1520','event','E0400','hossein_qoli_aqeli_waqf_estate',
 'Aqeli reports that a substantial part of Hossein Qoli Khan''s approximately forty-five-village estate was later endowed for charitable purposes.',
 'probable','active',
 'Secondary waqf evidence; overlaps with separate Gholamhossein-attributed statement.'),
('C1521','event','E0400','hossein_qoli_aqeli_anecdotal_death_account',
 'Aqeli preserves an anecdotal account that Hossein Qoli Khan died after a seizure in a bath at his Victoria residence.',
 'confirmed','active',
 'Confirmed only as a claim reported by Aqeli; the anecdote is not independently established and is not canonical cause of death.');

-- ---------------------------------------------------------------------------
-- Contextual claims stored on reconciliation event E0400
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO claims(
    claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes
) VALUES
('C1530','event','E0400','gholamhossein_amiri_oil_studies',
 'Aqeli says Gholamhossein Amiri Gharagozloo studied petroleum/oil-related subjects in Europe.',
 'probable','active',
 'Attach to canonical Gholamhossein Amiri person after live ID reconciliation.'),
('C1531','event','E0400','gholamhossein_amiri_oil_company',
 'Aqeli says Gholamhossein Amiri Gharagozloo became one of the managers/directors of the oil company.',
 'probable','active',
 'Exact company and title require verification.'),
('C1532','event','E0400','gholamhossein_amiri_majles_16',
 'Aqeli says Gholamhossein Amiri Gharagozloo represented Hamadan in the Sixteenth Majles.',
 'probable','active',
 'High-value claim; verify against Majles rosters and then attach to canonical person/event.'),
('C1533','event','E0400','gholamhossein_amiri_waqf_supervision',
 'Aqeli reports that Gholamhossein Amiri Gharagozloo supervised remaining Amir Nezam family waqf property and pursued efforts to protect or recover endowed assets.',
 'probable','active',
 'Potentially based on Gholamhossein''s own statement as mediated by Aqeli.'),
('C1534','event','E0400','waqf_original_scale',
 'Aqeli reports that approximately forty-five villages were endowed for charitable purposes including a hospital and school.',
 'probable','active',
 'Secondary estate/waqf scale; exact property list unresolved.'),
('C1535','event','E0400','waqf_reduced_scale',
 'Aqeli reports that later disputes and competing claims reduced the surviving waqf to approximately fourteen villages plus a Tehran house.',
 'probable','active',
 'Secondary report; requires waqf/deed/court documentation.'),
('C1536','event','E0400','gholamhossein_amiri_post_revolution_imprisonment',
 'Aqeli reports that Gholamhossein Amiri Gharagozloo was briefly imprisoned after the 1979 Revolution in connection with an allegation of Freemasonry membership.',
 'confirmed','active',
 'Confirmed only as a claim reported by Aqeli; the underlying allegation is not independently established.'),
('C1537','event','E0400','mohtaj_ali_financial_career',
 'Aqeli characterizes Mohtaj Ali Khan Amir Arfa'' as especially involved in banking and financial affairs.',
 'probable','active',
 'Attach after canonical person-ID reconciliation.'),
('C1538','event','E0400','mohtaj_and_mansur_europe',
 'Aqeli reports that Mohtaj Ali Khan and Mansur Ali Khan were sent to Europe under Farid al-Molk Hamadani''s guidance and remained abroad for roughly five years learning foreign languages.',
 'probable','active',
 'Secondary education/travel claim.'),
('C1539','event','E0400','mohtaj_marriage_conflict',
 'Aqeli sequences Mohtaj Ali Khan''s marriage to a daughter of Fazlollah Khan Mirpanj Entesar al-Molk after his return from Europe, conflicting with Majmooe Asaar''s Dhu al-Hijjah 1324 AH marriage date before the European journey.',
 'confirmed','active',
 'Explicit chronology conflict; retain existing canonical 1324 AH date pending stronger evidence.'),
('C1540','event','E0400','mohtaj_children_corroboration',
 'Aqeli identifies Mohtaj Ali Khan''s sons as Gholam Ali Khan and Gholamhossein Amiri Gharagozloo.',
 'confirmed','active',
 'Corroborates existing genealogy; no topology change.'),
('C1541','event','E0400','mansur_ali_education',
 'Aqeli reports that Mansur Ali Khan studied at Dar al-Funun and later continued education in Europe.',
 'probable','active',
 'Late-Qajar biographical enrichment.'),
('C1542','event','E0400','mansur_ali_governorships',
 'Aqeli reports later governorships for Mansur Ali Khan including Kermanshah, Khuzestan/Lorestan, and Hamadan.',
 'probable','active',
 'Exact dates require reconciliation.'),
('C1543','event','E0400','mansur_ali_salar_al_dowleh',
 'Aqeli reports that Mansur Ali Khan was assigned by the government to oppose Salar al-Dowleh.',
 'probable','active',
 'Historical event candidate.'),
('C1544','event','E0400','mansur_ali_majles_11',
 'Aqeli reports that Mansur Ali Khan represented Hamadan in the Eleventh Majles.',
 'probable','active',
 'Verify against parliamentary rosters.'),
('C1545','event','E0400','mansur_ali_vosuq_marriage',
 'Aqeli states that Mansur Ali Khan married a daughter of Vosuq al-Dowleh.',
 'confirmed','active',
 'Corroborated by Majmooe Asaar.'),
('C1546','event','E0400','baha_al_molk_branch_late_careers',
 'Aqeli provides late-Qajar/Pahlavi biographies for Alireza Khan Baha al-Molk, Yahya Khan Etemad al-Dowleh, Manouchehr Gharagozloo, and related descendants.',
 'confirmed','active',
 'Contextual cluster; promote to person-level records only after live ID reconciliation.'),
('C1547','event','E0400','amir_afkham_secondary_detail',
 'Aqeli provides additional biographical detail on Amir Afkham and the Shervini branch while also using strongly judgmental language about some figures.',
 'confirmed','active',
 'Separate factual biographical details from the author''s moral judgments.'),
('C1548','event','E0400','parzhad_identity_distinction',
 'Aqeli distinguishes Gholamhossein Parzhad Gharagozloo from Gholamhossein Amiri Gharagozloo as separate individuals with different parentage and careers.',
 'confirmed','active',
 'Important identity guardrail against same-name conflation.');

-- ---------------------------------------------------------------------------
-- Claim-citation links
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C1500','X1500','supports'),
('C1501','X1500','supports'),
('C1502','X1500','supports'),
('C1503','X1500','supports'),
('C1510','X1501','supports'),
('C1511','X1501','supports'),
('C1512','X1501','supports'),
('C1513','X1501','supports'),
('C1514','X1501','supports'),
('C1515','X1501','supports'),
('C1516','X1501','supports'),
('C1517','X1501','supports'),
('C1518','X1501','supports'),
('C1519','X1501','supports'),
('C1520','X1502','supports'),
('C1521','X1508','supports'),
('C1530','X1503','supports'),
('C1531','X1503','supports'),
('C1532','X1503','supports'),
('C1533','X1504','supports'),
('C1534','X1504','supports'),
('C1535','X1504','supports'),
('C1536','X1507','supports'),
('C1537','X1505','supports'),
('C1538','X1505','supports'),
('C1539','X1505','supports'),
('C1540','X1505','supports'),
('C1541','X1506','supports'),
('C1542','X1506','supports'),
('C1543','X1506','supports'),
('C1544','X1506','supports'),
('C1545','X1506','supports'),
('C1546','X1510','supports'),
('C1547','X1509','supports'),
('C1548','X1511','supports');

-- ---------------------------------------------------------------------------
-- Direct/entity citations: P0004 direct; later-generation evidence remains on E0400
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO entity_citations(
    entity_citation_id,entity_type,entity_id,citation_id,support_type,notes
) VALUES
('EC1500','person','P0004','X1500','supports','Aqeli secondary biography of Abdollah Khan Amir Nezam.'),
('EC1501','event','E0400','X1501','supports','Aqeli Hossein Qoli Khan biography preserved in reconciliation cluster pending explicit live-ID attachment.'),
('EC1502','event','E0400','X1502','supports','Aqeli Hossein Qoli Khan estate/waqf evidence preserved in reconciliation cluster pending explicit live-ID attachment.');

-- ---------------------------------------------------------------------------
-- Research questions / reconciliation targets
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO research_questions(question_id,question,status,priority,notes) VALUES
('Q0150','Can Abdollah Khan Amir Nezam''s Aqeli birth estimate of about 1235 SH be independently corroborated by a primary birth, marriage, appointment-age, or family record?','open','high','Do not populate canonical birth date until corroborated.'),
('Q0151','Can Aqeli''s claim that Ain al-Dowleh considered Abdollah Khan for the premiership in 1333 AH be verified in cabinet papers, diaries, newspapers, or parliamentary records?','open','medium','Potentially important new late-career episode.'),
('Q0152','Can Hossein Qoli Khan Amir Nezam II''s reported 1299 SH service as Minister of War be verified from cabinet rosters and official gazettes?','open','high','New Pahlavi-transition office claim.'),
('Q0153','Can Hossein Qoli Khan''s Pahlavi court role as head of foreign protocol, approximately through 1318 SH, be verified and normalized to the exact institutional title?','open','high','Check court directories, memoirs, official gazettes, and Foreign Ministry records.'),
('Q0154','Can the Amir Nezam waqf be reconstructed property-by-property, including the reported original forty-five villages, surviving fourteen villages, and Tehran house?','open','high','Search waqf deeds, Endowments Organization records, court files, cadastral records, and family papers.'),
('Q0155','What hospital and school were intended beneficiaries of the Amir Nezam waqf, and did either institution operate or receive income from the endowment?','open','high','Aqeli reports charitable purpose but details remain unresolved.'),
('Q0156','Can Gholamhossein Amiri Gharagozloo''s European petroleum studies, oil-company management role, and Sixteenth Majles representation be independently documented?','open','high','Priority direct-branch enrichment.'),
('Q0157','What exact oil company and managerial title does Aqeli mean in the biography of Gholamhossein Amiri Gharagozloo?','open','high','Avoid normalizing employer/title until verified.'),
('Q0158','Can Gholamhossein Amiri Gharagozloo''s role supervising the Amir Nezam waqf be corroborated from waqf administration or court records?','open','high','Potential direct family-authored/mediated evidence.'),
('Q0159','Can Aqeli''s report of post-1979 imprisonment and the associated Freemasonry allegation concerning Gholamhossein Amiri Gharagozloo be independently verified?','open','medium','Sensitive contested claim; keep attributed unless documentary evidence emerges.'),
('Q0160','Resolve the chronology conflict between Aqeli and Majmooe Asaar concerning Mohtaj Ali Khan''s marriage to the daughter of Fazlollah Khan Entesar al-Molk.','open','high','Current canonical preference remains Majmooe Asaar: Dhu al-Hijjah 1324 AH.'),
('Q0161','Reconcile the live canonical archive IDs for Mohtaj Ali Khan, Mansur Ali Khan, Gholamhossein Amiri Gharagozloo, Gholamhossein Parzhad Gharagozloo, and selected Baha al-Molk descendants before attaching Aqeli claims person-by-person.','open','high','This migration intentionally avoids guessing IDs.'),
('Q0162','Can Mansur Ali Khan''s Eleventh Majles representation and later governorships be verified from parliamentary and government records?','open','medium','Secondary Aqeli claims.'),
('Q0163','Can the later Pahlavi careers of Alireza Baha al-Molk, Yahya Etemad al-Dowleh, and Manouchehr Gharagozloo be independently verified before person-level enrichment?','open','medium','Potential future Aqeli follow-up migration.');

-- ---------------------------------------------------------------------------
-- Change log
-- ---------------------------------------------------------------------------
INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-04T05:20:00Z','migration','0045','apply',
       'Added Aqeli Gharagozloo late-Qajar/Pahlavi biographical, estate, waqf, and conflict evidence; canonical genealogy unchanged.');

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-04T05:20:00Z','source','S0202','insert',
       'Added Bagher Aqeli Gharagozloo chapter as a secondary biographical source.');

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-04T05:20:00Z','event','E0400','insert',
       'Added Aqeli late-generation source-reconciliation evidence cluster for contextual figures whose live person IDs were not guessed.');

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-04T05:20:00Z','database','archive','release',
       'Prepared v2.9.2 Aqeli Gharagozloo Late-Qajar and Pahlavi Biographical Enrichment checkpoint.');
