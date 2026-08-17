-- Migration 0055: refine Qara Mohammad identity
-- Do not add BEGIN, COMMIT, or ROLLBACK.
-- Use explicit column lists in every INSERT.

UPDATE persons
SET preferred_name_en = 'Qara Mohammad',
    preferred_name_fa = 'قرا محمد',
    branch = 'Hajilou ancestral tradition',
    summary = 'Earliest named ancestor in the Hajilou family tradition preserved by Majmooe Asaar. The source calls him Qara Mohammad and describes him as a remote ancestor (jad-e a’la) of the later Hajilou Gharagozloo branch; it does not establish that he personally used Gharagozloo as a surname or was himself called Hajilou. The transmitted account says he was from the nobility of Turkestan, migrated to Iran amid internal conflict around the early Safavid period and the end of Timurid rule, reached the area later called Tasaran, married the daughter of the local chief Ajam Beg, and remained there. The exact intermediate genealogy connecting him to the later documented Hajilou trunk remains unresolved.',
    updated_at = '2026-08-17T00:00:00Z'
WHERE person_id = 'P0179';

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0179','Qara Mohammad Gharagozloo','en','superseded_archive_form',0),
('P0179','قرا محمد قراگزلو','fa','superseded_archive_form',0);

INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary) VALUES
('2026-08-17T00:00:00Z','person','P0179','revise','Changed the preferred name to the source-attested Qara Mohammad, retained the former expanded Gharagozloo forms as searchable historical archive aliases, and relabeled the branch Hajilou ancestral tradition to distinguish ancestral affiliation from a proven personal branch name. Provisional status and the non-parental ancestry hypothesis remain unchanged.');
