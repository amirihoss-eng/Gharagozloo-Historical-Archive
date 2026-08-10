-- Phase 1 Local Curator Mode: reversible Manual Edit provenance.
CREATE TABLE edit_revisions (
    revision_id INTEGER PRIMARY KEY AUTOINCREMENT,
    changed_at TEXT NOT NULL,
    provenance TEXT NOT NULL CHECK (provenance IN ('Manual Edit','Research / Migration Update')),
    action TEXT NOT NULL,
    entity_type TEXT NOT NULL,
    entity_key TEXT NOT NULL,
    before_json TEXT,
    after_json TEXT,
    reverted_revision_id INTEGER REFERENCES edit_revisions(revision_id),
    notes TEXT
);

CREATE TABLE manual_edit_entities (
    entity_type TEXT NOT NULL,
    entity_key TEXT NOT NULL,
    created_revision_id INTEGER NOT NULL REFERENCES edit_revisions(revision_id),
    active INTEGER NOT NULL DEFAULT 1 CHECK (active IN (0,1)),
    PRIMARY KEY (entity_type, entity_key)
);

CREATE INDEX idx_edit_revisions_entity
    ON edit_revisions(entity_type, entity_key, revision_id DESC);
