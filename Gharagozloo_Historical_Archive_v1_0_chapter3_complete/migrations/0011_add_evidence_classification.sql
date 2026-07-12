-- Archive v2.1 evidence classification enhancement.
-- Adds an explicit source-critical profile for claims without altering existing claims.

CREATE TABLE IF NOT EXISTS evidence_types (
    evidence_type_code TEXT PRIMARY KEY,
    preferred_name_en TEXT NOT NULL,
    preferred_name_fa TEXT,
    description TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS claim_evidence_profiles (
    claim_id TEXT PRIMARY KEY REFERENCES claims(claim_id) ON DELETE CASCADE,
    evidence_type_code TEXT NOT NULL REFERENCES evidence_types(evidence_type_code),
    assertion_scope TEXT NOT NULL DEFAULT 'author_statement'
        CHECK(assertion_scope IN (
            'primary_source_report',
            'author_statement',
            'author_inference',
            'scholarly_opinion',
            'documentary_caption',
            'genealogical_diagram',
            'user_supplied',
            'archive_synthesis'
        )),
    source_position TEXT NOT NULL DEFAULT 'neutral'
        CHECK(source_position IN (
            'supports',
            'presents',
            'prefers',
            'questions',
            'rejects',
            'unresolved'
        )),
    assessment_notes TEXT
);

CREATE INDEX IF NOT EXISTS idx_claim_evidence_type
ON claim_evidence_profiles(evidence_type_code);

INSERT OR IGNORE INTO evidence_types(
    evidence_type_code, preferred_name_en, preferred_name_fa, description
) VALUES
('PRIMARY_REPORT','Primary historical report','گزارش تاریخی دست اول',
 'A report attributed to a contemporary or near-contemporary historical source.'),
('NARRATIVE_FACT','Narrative factual statement','گزارش روایی',
 'A factual statement made in the book narrative and supported by cited sources.'),
('AUTHOR_SYNTHESIS','Author synthesis','جمع‌بندی نویسنده',
 'The author combines multiple sources into an interpretive historical conclusion.'),
('AUTHOR_INFERENCE','Author inference','استنباط نویسنده',
 'The author explicitly proposes a probable or possible reconstruction.'),
('SCHOLARLY_OPINION','Scholarly opinion','نظر پژوهشی',
 'An interpretation attributed to a named scholar or earlier author.'),
('REJECTED_HYPOTHESIS','Rejected hypothesis','فرضیه ردشده',
 'A hypothesis presented for discussion but rejected or substantially questioned by the author.'),
('DOCUMENTARY_CAPTION','Documentary caption','شرح تصویر یا سند',
 'A statement contained in a printed caption for a photograph, map, document, or artifact.'),
('GENEALOGICAL_DIAGRAM','Genealogical diagram','نمودار تبارشناختی',
 'A relationship or identity represented in a genealogy diagram.'),
('USER_SUPPLIED','User-supplied evidence','اطلاعات ارائه‌شده توسط خانواده',
 'Information supplied directly by the archive owner or another identified family informant.'),
('ARCHIVE_SYNTHESIS','Archive synthesis','جمع‌بندی آرشیو',
 'A statement synthesized by the archive from multiple structured records.');

INSERT OR REPLACE INTO metadata(key,value)
VALUES('evidence_classification_version','1.0');
