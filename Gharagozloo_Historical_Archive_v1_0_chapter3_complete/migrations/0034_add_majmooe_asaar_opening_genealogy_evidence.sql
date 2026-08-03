-- Gharagozloo Historical Archive
-- Migration 0034
-- v2.8.1 — Majmooe Asaar Opening Genealogy Evidence Checkpoint
--
-- IMPORTANT POLICY:
--   * Evidence enrichment only.
--   * Canonical genealogy topology is NOT changed by this migration.
--   * No new parent_of relationships are inserted.
--   * Unresolved candidate people remain claim text / research questions rather than
--     canonical person records until a later reconciliation decision.
--
-- Baseline: Archive v2.8.0 Final Hajilou Cleanup and Ashiqloo Reconciliation.

-- ---------------------------------------------------------------------------
-- Release metadata
-- ---------------------------------------------------------------------------
INSERT OR REPLACE INTO metadata(key,value) VALUES('database_version','2.8.1');
INSERT OR REPLACE INTO metadata(key,value) VALUES('last_migration','0034');
INSERT OR REPLACE INTO metadata(key,value) VALUES('updated_at','2026-08-03T00:00:00Z');
INSERT OR REPLACE INTO metadata(key,value) VALUES('historical_enrichment_phase','Majmooe Asaar opening genealogy evidence checkpoint');

-- ---------------------------------------------------------------------------
-- Source catalog
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO sources(
    source_id, short_title, full_title, author, publication_year,
    source_type, file_name, notes
) VALUES(
    'S0200',
    'Majmooe Asaar',
    'Majmooe Asaar-e Haji Abdollah Khan Gharagozloo',
    'Haji Abdollah Khan Gharagozloo (papers); editor/compiler not yet normalized',
    NULL,
    'book',
    'Majmooe Asaar - PDF.pdf',
    'Collected works and reports associated with Haji Abdollah Khan Gharagozloo. The opening genealogy is an older family genealogy preserved among his papers and attributed by the editor to Haji Mohammad Khan. This inherited family genealogy must be distinguished from Haji Abdollah Khan''s own later firsthand reports.'
);

-- ---------------------------------------------------------------------------
-- Citation anchors for the opening genealogy.
-- page_file is intentionally used where the scan page is more reliable than the
-- printed pagination. Quoted text is paraphrased/short rather than transcribed.
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO citations(
    citation_id, source_id, page_printed, page_file, locator_text, quoted_text, notes
) VALUES
('X0500','S0200',NULL,'12','Opening family genealogy: older ancestral chain',
 'The family genealogy traces an older line through Qara Mohammad, Haji Bonyad Khan, Haji Qasem, Haji Jafar Khan and Haji Abdollah Beg.',
 'Family-tradition genealogy preserved in the papers; treat as transmitted genealogy rather than independently verified chronology.'),
('X0501','S0200',NULL,'15','Opening family genealogy: sons of Haji Abdollah Beg and Haji Fathollah branch',
 'The genealogy enumerates Haji Fathollah as a sixth son and names Abbas Beg, Allah-Panah Beg and Heidar Qoli Beg among his children.',
 'Strong explicit genealogical statement in the preserved family genealogy.'),
('X0502','S0200',NULL,'15','Opening family genealogy: Haji Mohammad Khan Jeyhunabadi descendants',
 'The genealogy gives six sons for Haji Mohammad Khan, including Mohammad Baqer, Haji Hamze, Haji Ali Mohammad, Mehdi Khan Sartip, Zolfaghar and Mohammad Qoli.',
 'This list differs from the current canonical v2.8.0 child set; preserve as a source conflict/alternate tradition.'),
('X0503','S0200',NULL,'15','Opening family genealogy: Haji Safar descendants',
 'The genealogy names Mohammad Jafar Khan Majzub Ali Shah, Sadeq Beg, Amin Beg, Rahim Beg and Hossein Ali Beg as children of Haji Safar.',
 'Additive family-genealogy evidence; no canonical edge changes in this migration.'),
('X0504','S0200',NULL,'15','Opening family genealogy: Haji Mina descendants and branch origins',
 'The genealogy names several Haji Mina descendants and associates Safi Qoli with the Kabudarahang khans, Abolqasem with the Yekleh family and Mohammad Ali with Haji Noor Ali.',
 'Several identities do not yet have safe canonical matches; keep them at evidence level.'),
('X0505','S0200',NULL,'15','Opening family genealogy: Haji Fazlollah and Nasrollah branches',
 'The genealogy gives branch histories, service context and descendant lists for Haji Fazlollah and Nasrollah, including Nasrollah''s seven named children.',
 'Evidence enrichment only; descendant placement remains pending reconciliation.');

-- ---------------------------------------------------------------------------
-- Resolve the existing canonical Hajilou branch heads from the v2.8.0 graph.
-- These TEMP tables let the migration attach claims to existing canonical people
-- without hard-coding IDs that may differ across reconstructed builds.
-- ---------------------------------------------------------------------------
CREATE TEMP TABLE _ma_anchor(key TEXT PRIMARY KEY, person_id TEXT);

INSERT OR REPLACE INTO _ma_anchor(key, person_id) VALUES('root_haji_mohammad_jafar','P0094');

INSERT OR REPLACE INTO _ma_anchor(key, person_id)
SELECT 'haji_abdollah', p.person_id
FROM relationships r
JOIN persons p ON p.person_id=r.person2_id
WHERE r.person1_id='P0094'
  AND r.relationship_type='parent_of'
  AND r.verification_status <> 'superseded'
  AND lower(p.preferred_name_en) LIKE '%abdollah%'
ORDER BY CASE WHEN lower(p.preferred_name_en) LIKE '%haji%' THEN 0 ELSE 1 END, p.person_id
LIMIT 1;

INSERT OR REPLACE INTO _ma_anchor(key, person_id)
SELECT 'haji_fazlollah', p.person_id
FROM _ma_anchor a
JOIN relationships r ON r.person1_id=a.person_id
JOIN persons p ON p.person_id=r.person2_id
WHERE a.key='haji_abdollah'
  AND r.relationship_type='parent_of'
  AND r.verification_status <> 'superseded'
  AND (lower(p.preferred_name_en) LIKE '%fazlollah%' OR lower(p.preferred_name_en) LIKE '%fazl allah%')
ORDER BY p.person_id LIMIT 1;

INSERT OR REPLACE INTO _ma_anchor(key, person_id)
SELECT 'nasrollah', p.person_id
FROM _ma_anchor a
JOIN relationships r ON r.person1_id=a.person_id
JOIN persons p ON p.person_id=r.person2_id
WHERE a.key='haji_abdollah'
  AND r.relationship_type='parent_of'
  AND r.verification_status <> 'superseded'
  AND (lower(p.preferred_name_en) LIKE '%nasr%allah%' OR lower(p.preferred_name_en) LIKE '%nasrollah%')
ORDER BY p.person_id LIMIT 1;

INSERT OR REPLACE INTO _ma_anchor(key, person_id)
SELECT 'haji_safar', p.person_id
FROM _ma_anchor a
JOIN relationships r ON r.person1_id=a.person_id
JOIN persons p ON p.person_id=r.person2_id
WHERE a.key='haji_abdollah'
  AND r.relationship_type='parent_of'
  AND r.verification_status <> 'superseded'
  AND lower(p.preferred_name_en) LIKE '%safar%'
ORDER BY p.person_id LIMIT 1;

INSERT OR REPLACE INTO _ma_anchor(key, person_id)
SELECT 'haji_mina', p.person_id
FROM _ma_anchor a
JOIN relationships r ON r.person1_id=a.person_id
JOIN persons p ON p.person_id=r.person2_id
WHERE a.key='haji_abdollah'
  AND r.relationship_type='parent_of'
  AND r.verification_status <> 'superseded'
  AND lower(p.preferred_name_en) LIKE '%mina%'
ORDER BY p.person_id LIMIT 1;

INSERT OR REPLACE INTO _ma_anchor(key, person_id)
SELECT 'jeyhunabadi', p.person_id
FROM _ma_anchor a
JOIN relationships r ON r.person1_id=a.person_id
JOIN persons p ON p.person_id=r.person2_id
WHERE a.key='haji_abdollah'
  AND r.relationship_type='parent_of'
  AND r.verification_status <> 'superseded'
  AND (lower(p.preferred_name_en) LIKE '%jeyhun%' OR lower(p.preferred_name_en) LIKE '%jeihun%')
ORDER BY p.person_id LIMIT 1;

-- ---------------------------------------------------------------------------
-- Atomic claims. These claims state what S0200 says; they do not silently
-- convert the source tradition into canonical topology.
-- ---------------------------------------------------------------------------

-- Older ancestral tradition, attached to the current canonical root for discoverability.
INSERT OR IGNORE INTO claims VALUES(
 'C0500','person','P0094','alternate_ancestral_tradition',
 'Majmooe Asaar preserves an older family genealogy running through Qara Mohammad, Haji Bonyad Khan, Haji Qasem, Haji Jafar Khan and Haji Abdollah Beg before the later Hajilou line.',
 'possible','active',
 'This is a transmitted family-genealogy tradition. Do not assume Majmooe Asaar''s Haji Jafar Khan is identical with P0094 without separate identity reconciliation.'
);
INSERT OR IGNORE INTO claim_citations VALUES('C0500','X0500','supports');

-- Haji Fathollah: explicit but not canonical in v2.8.0.
INSERT OR IGNORE INTO claims
SELECT 'C0501','person',person_id,'child_list',
 'Majmooe Asaar explicitly enumerates Haji Fathollah as a sixth son of Haji Abdollah Beg.',
 'disputed','active',
 'Source-explicit statement preserved as evidence; v2.8.0 canonical topology currently has five branch heads and is intentionally unchanged.'
FROM _ma_anchor WHERE key='haji_abdollah';
INSERT OR IGNORE INTO claim_citations VALUES('C0501','X0501','supports');

INSERT OR IGNORE INTO claims
SELECT 'C0502','person',person_id,'biographical_context',
 'Haji Fathollah is described as not entering government service and as occupying himself with landed/property affairs together with Haji Safar Khan.',
 'confirmed','active',
 'Claim concerns the source''s description of Haji Fathollah, not canonical identity placement.'
FROM _ma_anchor WHERE key='haji_abdollah';
INSERT OR IGNORE INTO claim_citations VALUES('C0502','X0501','supports');

INSERT OR IGNORE INTO claims
SELECT 'C0503','person',person_id,'descendant_list',
 'Majmooe Asaar names Abbas Beg, Allah-Panah Beg and Heidar Qoli Beg as children of Haji Fathollah.',
 'confirmed','active',
 'Names retained as source-derived candidates; no person records or parent_of edges created yet.'
FROM _ma_anchor WHERE key='haji_abdollah';
INSERT OR IGNORE INTO claim_citations VALUES('C0503','X0501','supports');

-- Jeyhunabadi child list.
INSERT OR IGNORE INTO claims
SELECT 'C0504','person',person_id,'alternate_child_list',
 'Majmooe Asaar lists six sons: Mohammad Baqer Khan, Haji Hamze Khan, Haji Ali Mohammad Khan, Mehdi Khan Sartip, Zolfaghar Khan and Mohammad Qoli Khan.',
 'disputed','active',
 'Alternate source list differs from the current canonical v2.8.0 child set. Mohammad Qoli may correspond to Haji Yavar Mohammad Gholi, but that identity is not proven.'
FROM _ma_anchor WHERE key='jeyhunabadi';
INSERT OR IGNORE INTO claim_citations VALUES('C0504','X0502','supports');

INSERT OR IGNORE INTO claims
SELECT 'C0505','person',person_id,'candidate_child',
 'Haji Ali Mohammad Khan is named by Majmooe Asaar as a son of Haji Mohammad Khan Jeyhunabadi.',
 'possible','active','Pending identity and placement reconciliation.'
FROM _ma_anchor WHERE key='jeyhunabadi';
INSERT OR IGNORE INTO claim_citations VALUES('C0505','X0502','supports');

INSERT OR IGNORE INTO claims
SELECT 'C0506','person',person_id,'candidate_child',
 'Mehdi Khan Sartip is named by Majmooe Asaar as a son of Haji Mohammad Khan Jeyhunabadi.',
 'possible','active','Pending identity and placement reconciliation.'
FROM _ma_anchor WHERE key='jeyhunabadi';
INSERT OR IGNORE INTO claim_citations VALUES('C0506','X0502','supports');

INSERT OR IGNORE INTO claims
SELECT 'C0507','person',person_id,'identity_hypothesis',
 'Majmooe Asaar''s Mohammad Qoli Khan may be the same person as the canonical Haji Yavar Mohammad Gholi, but the identification is not yet demonstrated.',
 'possible','active','Keep as hypothesis only; do not merge or alter canonical genealogy.'
FROM _ma_anchor WHERE key='jeyhunabadi';
INSERT OR IGNORE INTO claim_citations VALUES('C0507','X0502','supports');

-- Haji Safar branch.
INSERT OR IGNORE INTO claims
SELECT 'C0508','person',person_id,'descendant_list',
 'Majmooe Asaar names Mohammad Jafar Khan Majzub Ali Shah, Sadeq Beg, Amin Beg, Rahim Beg and Hossein Ali Beg as children of Haji Safar.',
 'probable','active','Additive source tradition; canonical topology is not changed in this checkpoint.'
FROM _ma_anchor WHERE key='haji_safar';
INSERT OR IGNORE INTO claim_citations VALUES('C0508','X0503','supports');

INSERT OR IGNORE INTO claims
SELECT 'C0509','person',person_id,'biographical_context',
 'Haji Safar is described as dervish-minded/independent, avoiding government service and attending to agricultural and landed affairs.',
 'confirmed','active',NULL
FROM _ma_anchor WHERE key='haji_safar';
INSERT OR IGNORE INTO claim_citations VALUES('C0509','X0503','supports');

-- Haji Mina branch and existing parentage conflict support.
INSERT OR IGNORE INTO claims
SELECT 'C0510','person',person_id,'descendant_tradition',
 'Majmooe Asaar names Haji Mirza Safi Qoli Khan, Haji Abolqasem Khan, Haji Morteza Qoli Khan, Mohammad Ali Khan, Hossein Ali Beg and Mehdi Qoli Beg in the Haji Mina branch.',
 'probable','active','Several names do not yet have safe canonical identity matches.'
FROM _ma_anchor WHERE key='haji_mina';
INSERT OR IGNORE INTO claim_citations VALUES('C0510','X0504','supports');

INSERT OR IGNORE INTO claims
SELECT 'C0511','person',person_id,'branch_origin',
 'Majmooe Asaar associates Haji Mirza Safi Qoli Khan with the ancestry of the Kabudarahang khans.',
 'probable','active','Source-derived branch-origin statement; identity placement pending.'
FROM _ma_anchor WHERE key='haji_mina';
INSERT OR IGNORE INTO claim_citations VALUES('C0511','X0504','supports');

INSERT OR IGNORE INTO claims
SELECT 'C0512','person',person_id,'branch_origin',
 'Majmooe Asaar associates Haji Abolqasem Khan with the ancestry of the Yekleh family.',
 'probable','active','Source-derived branch-origin statement; identity placement pending.'
FROM _ma_anchor WHERE key='haji_mina';
INSERT OR IGNORE INTO claim_citations VALUES('C0512','X0504','supports');

INSERT OR IGNORE INTO claims
SELECT 'C0513','person',person_id,'lineage_detail',
 'Majmooe Asaar states that Haji Morteza Qoli Khan was the father of Mohammad Mirza Khan.',
 'probable','active','Potentially important corrective detail if the current chart visually flattens the generations; no topology change in this migration.'
FROM _ma_anchor WHERE key='haji_mina';
INSERT OR IGNORE INTO claim_citations VALUES('C0513','X0504','supports');

INSERT OR IGNORE INTO claims
SELECT 'C0514','person',person_id,'branch_origin',
 'Majmooe Asaar associates Mohammad Ali Khan with the ancestry of Haji Noor Ali Khan.',
 'probable','active','Identity placement pending.'
FROM _ma_anchor WHERE key='haji_mina';
INSERT OR IGNORE INTO claim_citations VALUES('C0514','X0504','supports');

INSERT OR IGNORE INTO claims
SELECT 'C0515','person',person_id,'parentage_support',
 'Majmooe Asaar independently places Haji Mina in the Haji Abdollah line.',
 'probable','active','This strengthens the side of the existing Haji Mina parentage conflict followed by the canonical graph; it does not erase the conflicting Alvandi wording.'
FROM _ma_anchor WHERE key='haji_mina';
INSERT OR IGNORE INTO claim_citations VALUES('C0515','X0504','supports');

-- Haji Fazlollah branch.
INSERT OR IGNORE INTO claims
SELECT 'C0516','person',person_id,'government_service',
 'Majmooe Asaar says Haji Fazlollah governed Khamseh, Qazvin and Garrus for years.',
 'confirmed','active','Service-context claim from the family genealogy.'
FROM _ma_anchor WHERE key='haji_fazlollah';
INSERT OR IGNORE INTO claim_citations VALUES('C0516','X0505','supports');

INSERT OR IGNORE INTO claims
SELECT 'C0517','person',person_id,'descendant_tradition',
 'Majmooe Asaar identifies Abdolhossein Khan, Hossein Ali Khan and Haji Mohammad Hossein as principal descendants/branch figures under Haji Fazlollah.',
 'probable','active','Preserve as source genealogy; individual canonical placements remain governed by existing reconciled topology.'
FROM _ma_anchor WHERE key='haji_fazlollah';
INSERT OR IGNORE INTO claim_citations VALUES('C0517','X0505','supports');

INSERT OR IGNORE INTO claims
SELECT 'C0518','person',person_id,'maternal_ancestry',
 'Majmooe Asaar states that Hossein Ali Khan was a maternal ancestor of the late Haji Amir Nezam.',
 'probable','active','The intermediate maternal links are not supplied here; do not invent direct mother/daughter edges.'
FROM _ma_anchor WHERE key='haji_fazlollah';
INSERT OR IGNORE INTO claim_citations VALUES('C0518','X0505','supports');

INSERT OR IGNORE INTO claims
SELECT 'C0519','person',person_id,'branch_origin',
 'Majmooe Asaar associates Abdolhossein Khan with the ancestry of the Qarakhlu/Qarkhlu khans and Hossein Ali Khan with the Hosseinabad khans.',
 'probable','active','Transliteration of the Qarakhlu/Qarkhlu branch name should remain provisional until visual normalization.'
FROM _ma_anchor WHERE key='haji_fazlollah';
INSERT OR IGNORE INTO claim_citations VALUES('C0519','X0505','supports');

-- Nasrollah branch.
INSERT OR IGNORE INTO claims
SELECT 'C0520','person',person_id,'military_role',
 'Majmooe Asaar describes Nasrollah Khan as commander of the Hajilou cavalry.',
 'confirmed','active',NULL
FROM _ma_anchor WHERE key='nasrollah';
INSERT OR IGNORE INTO claim_citations VALUES('C0520','X0505','supports');

INSERT OR IGNORE INTO claims
SELECT 'C0521','person',person_id,'service_context',
 'Majmooe Asaar says Nasrollah Khan often served in Shiraz under Hasan Ali Mirza Farmanfarma.',
 'confirmed','active',NULL
FROM _ma_anchor WHERE key='nasrollah';
INSERT OR IGNORE INTO claim_citations VALUES('C0521','X0505','supports');

INSERT OR IGNORE INTO claims
SELECT 'C0522','person',person_id,'descendant_list',
 'Majmooe Asaar names seven children of Nasrollah Khan: Ghaffar Khan, Mirza Hashem Khan, Mohammad Hossein Khan, Qasem Khan, Hassan Khan, Abdollah Khan and Nasir Beg.',
 'confirmed','active','Source-explicit child list; no canonical child nodes or edges are added in this evidence checkpoint.'
FROM _ma_anchor WHERE key='nasrollah';
INSERT OR IGNORE INTO claim_citations VALUES('C0522','X0505','supports');

-- ---------------------------------------------------------------------------
-- Evidence conflicts / alternate genealogical traditions.
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO evidence_conflicts(
 conflict_id, entity_type, entity_id, conflict_topic,
 statement_a, statement_b, resolution_status, notes
)
SELECT
 'CF010','person',person_id,'number_and_identity_of_Haji_Abdollah_branch_heads',
 'Canonical v2.8.0 genealogy currently represents five branch heads under Haji Abdollah: Haji Fazlollah, Nasrollah, Haji Safar, Haji Mina and Haji Mohammad Khan Jeyhunabadi.',
 'Majmooe Asaar explicitly enumerates Haji Fathollah as a sixth son of Haji Abdollah Beg and gives three named children for him.',
 'unresolved',
 'Preserve both. No canonical topology change in migration 0034. Haji Fathollah is strong source evidence and should be reconsidered in a later topology reconciliation.'
FROM _ma_anchor WHERE key='haji_abdollah';

INSERT OR IGNORE INTO evidence_conflicts(
 conflict_id, entity_type, entity_id, conflict_topic,
 statement_a, statement_b, resolution_status, notes
)
SELECT
 'CF011','person',person_id,'Haji_Mohammad_Khan_Jeyhunabadi_child_list',
 'Canonical v2.8.0 represents five direct children: Mohammad Baqer, Zolfaghar, Haji Yavar Mohammad Gholi, Haji Hamze and Kazem.',
 'Majmooe Asaar lists six sons: Mohammad Baqer, Haji Hamze, Haji Ali Mohammad, Mehdi Khan Sartip, Zolfaghar and Mohammad Qoli.',
 'unresolved',
 'Possible overlap exists between Mohammad Qoli and Haji Yavar Mohammad Gholi, but it is not proven. Kazem may simply be omitted from the source list. Preserve as an alternate family tradition pending person-by-person reconciliation.'
FROM _ma_anchor WHERE key='jeyhunabadi';

-- Strengthen, but do not resolve, the already-existing Haji Mina parentage conflict if CF004 exists.
UPDATE evidence_conflicts
SET notes = COALESCE(notes,'') ||
    CASE WHEN COALESCE(notes,'')='' THEN '' ELSE ' ' END ||
    'Majmooe Asaar (S0200) independently supports placement of Haji Mina in the Haji Abdollah line; this is new corroborating evidence for the current canonical placement, while the conflicting wording remains preserved.'
WHERE conflict_id='CF004'
  AND instr(COALESCE(notes,''),'Majmooe Asaar (S0200) independently supports')=0;

-- ---------------------------------------------------------------------------
-- Research questions generated by the opening-genealogy reconciliation.
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO research_questions VALUES(
 'Q0050',
 'Is the Haji Jafar Khan in Majmooe Asaar''s older ancestral chain identical with canonical P0094 Haji Mohammad Jafar Khan Gharagozloo, or does the source preserve a different generation/person?',
 'open','high',
 'Do not merge by name alone. Compare chronology, descendants, titles and the full manuscript wording.'
);

INSERT OR IGNORE INTO research_questions VALUES(
 'Q0051',
 'Should Haji Fathollah, explicitly described by Majmooe Asaar as the sixth son of Haji Abdollah Beg, eventually be added as a sixth canonical Hajilou branch head?',
 'open','high',
 'Before topology change, seek corroboration and determine whether later charts omitted the branch because its members avoided government service.'
);

INSERT OR IGNORE INTO research_questions VALUES(
 'Q0052',
 'Are Majmooe Asaar''s Mohammad Qoli Khan and canonical Haji Yavar Mohammad Gholi the same person?',
 'open','high',
 'Check titles, descendants, especially the statement that Mohammad Qoli was father of Mokarram al-Molk, and independent sources.'
);

INSERT OR IGNORE INTO research_questions VALUES(
 'Q0053',
 'Can Haji Ali Mohammad Khan and Mehdi Khan Sartip, listed by Majmooe Asaar as sons of Haji Mohammad Khan Jeyhunabadi, be identified with existing archive people or independently corroborated?',
 'open','high','No person or parent_of records added in migration 0034.'
);

INSERT OR IGNORE INTO research_questions VALUES(
 'Q0054',
 'Can Sadeq Beg, Amin Beg, Rahim Beg and Hossein Ali Beg in Majmooe Asaar''s Haji Safar child list be reconciled with the existing Haji Safar / Majzub Ali Shah subtree?',
 'open','medium','Treat the current chart and the source list as potentially different levels of genealogical compression until reconciled.'
);

INSERT OR IGNORE INTO research_questions VALUES(
 'Q0055',
 'Can the additional Haji Mina branch names in Majmooe Asaar be matched safely to existing canonical people, especially Haji Mirza Safi Qoli Khan, Haji Abolqasem Khan, Mohammad Ali Khan, Hossein Ali Beg and Mehdi Qoli Beg?',
 'open','high','Do not force aliases from name similarity alone.'
);

INSERT OR IGNORE INTO research_questions VALUES(
 'Q0056',
 'What are the missing intermediate maternal links connecting Hossein Ali Khan in the Haji Fazlollah branch to Haji Abdollah Khan Amir Nezam?',
 'open','high','Majmooe Asaar calls Hossein Ali Khan a maternal ancestor, but does not supply the intermediate women/generations in the extracted passage.'
);

INSERT OR IGNORE INTO research_questions VALUES(
 'Q0057',
 'Can the seven children of Nasrollah Khan listed in Majmooe Asaar be independently identified and placed in the canonical Korijani/Nasrollah subtree?',
 'open','medium','Current canonical subtree is much smaller; preserve source list first, reconcile later.'
);

INSERT OR IGNORE INTO research_questions VALUES(
 'Q0058',
 'Visually transcribe and normalize the difficult opening-genealogy village/property list before creating estate or place records from it.',
 'open','medium','Avoid bulk estate insertion from unreliable OCR.'
);

-- ---------------------------------------------------------------------------
-- Audit trail
-- ---------------------------------------------------------------------------
INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-03T00:00:00Z','migration','0034','apply',
 'Added Majmooe Asaar opening-genealogy evidence checkpoint on top of v2.8.0 without changing canonical genealogy topology.');

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-03T00:00:00Z','source','S0200','insert',
 'Cataloged Majmooe Asaar and documented provenance distinction between the inherited family genealogy and Haji Abdollah Khan''s own firsthand reports.');

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-03T00:00:00Z','claim','C0500-C0522','insert',
 'Added evidence-level claims from the opening genealogy for ancestral tradition, Haji Fathollah, Jeyhunabadi, Haji Safar, Haji Mina, Haji Fazlollah and Nasrollah branches.');

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-03T00:00:00Z','evidence_conflict','CF010-CF011','insert',
 'Preserved Haji Fathollah sixth-son discrepancy and Jeyhunabadi child-list discrepancy as unresolved evidence conflicts.');

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-03T00:00:00Z','database','archive','release',
 'Prepared Archive v2.8.1 — Majmooe Asaar Opening Genealogy Evidence Checkpoint; canonical genealogy unchanged.');

DROP TABLE _ma_anchor;
