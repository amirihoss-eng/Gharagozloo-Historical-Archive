-- Archive v2.4.1 — Wave 3 validation hotfix
-- Resolves the 14 warnings reported after migrations 0014 and 0015:
--   * adds citations to claims C0140-C0151;
--   * removes two redundant English alias rows that duplicate canonical names.
-- No historical claim, relationship, event, or person record is deleted.

INSERT OR IGNORE INTO citations(
    citation_id,source_id,page_printed,page_file,locator_text,quoted_text,notes
) VALUES
('X0082','S0001','59-61',NULL,
 'Chapter 2 family branches and the five sons of Mohammad-Hossein Khan',
 NULL,'Supports family identities and succession in the first Ashiqloo generation.'),
('X0083','S0001','67-84',NULL,
 'Chapter 2 military organization, commands, and regimental succession',
 NULL,'Supports ranks, commands, and hereditary military succession.'),
('X0084','S0001','96-166',NULL,
 'Chapter 3 political, military, estate, and provincial narrative',
 NULL,'Supports campaigns, offices, landholding, and political activity.'),
('X0085','S0001','199-203',NULL,
 'Documentary portrait captions for the Hesam al-Molk / Amir Afkham line',
 NULL,'Supports portrait identities and family relationships.'),
('X0086','S0001','167-186',NULL,
 'Chapter 4 Naser al-Molk narrative and family information',
 NULL,'Used for conflict comparison and related contextual evidence.');

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0140','X0082','supports'),
('C0141','X0083','supports'),
('C0141','X0084','supports'),
('C0142','X0083','supports'),
('C0142','X0084','supports'),
('C0143','X0082','supports'),
('C0143','X0083','supports'),
('C0144','X0082','supports'),
('C0144','X0083','supports'),
('C0145','X0083','supports'),
('C0145','X0084','supports'),
('C0146','X0083','supports'),
('C0146','X0084','supports'),
('C0147','X0082','supports'),
('C0147','X0083','supports'),
('C0148','X0082','supports'),
('C0149','X0083','supports'),
('C0149','X0084','supports'),
('C0150','X0084','supports'),
('C0150','X0085','supports'),
('C0151','X0084','supports'),
('C0151','X0085','supports');

-- These aliases are byte-for-byte equivalent to the canonical preferred names
-- after normalization and therefore trigger duplicate-name validation warnings.
DELETE FROM person_names
WHERE person_id='P0018'
  AND language='en'
  AND name_text='Rustam Khan Gharagozloo';

DELETE FROM person_names
WHERE person_id='P0020'
  AND language='en'
  AND name_text='Ali Naqi Khan Gharagozloo';

INSERT OR REPLACE INTO metadata(key,value) VALUES('archive_version','2.4.1');
INSERT OR REPLACE INTO metadata(key,value) VALUES(
    'wave3_validation_hotfix',
    'Resolved 12 uncited-claim warnings and 2 duplicate-name warnings after migrations 0014-0015.'
);
