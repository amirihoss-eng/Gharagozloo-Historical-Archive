-- Migration 0002: reliable migration pipeline infrastructure
-- IMPORTANT: future migration files must not contain BEGIN, COMMIT, or ROLLBACK.
-- tools/apply_migration.py supplies the transaction.

CREATE TABLE IF NOT EXISTS schema_migrations (
    migration_id TEXT PRIMARY KEY,
    filename TEXT NOT NULL UNIQUE,
    sha256 TEXT NOT NULL,
    applied_at TEXT NOT NULL,
    description TEXT
);

CREATE INDEX IF NOT EXISTS idx_claims_subject
    ON claims(subject_type, subject_id);

CREATE INDEX IF NOT EXISTS idx_claim_citations_citation
    ON claim_citations(citation_id);

CREATE INDEX IF NOT EXISTS idx_relationships_person1
    ON relationships(person1_id);

CREATE INDEX IF NOT EXISTS idx_relationships_person2
    ON relationships(person2_id);

CREATE INDEX IF NOT EXISTS idx_event_persons_person
    ON event_persons(person_id);
