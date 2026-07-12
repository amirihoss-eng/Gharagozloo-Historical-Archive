CREATE TABLE IF NOT EXISTS organizations (
    organization_id TEXT PRIMARY KEY,
    preferred_name_en TEXT NOT NULL,
    preferred_name_fa TEXT,
    organization_type TEXT NOT NULL CHECK(organization_type IN (
        'tribe','tribal_branch','family_branch','military_unit','government_body','other'
    )),
    parent_organization_id TEXT REFERENCES organizations(organization_id),
    date_text TEXT,
    description TEXT,
    verification_status TEXT NOT NULL DEFAULT 'provisional'
);

CREATE TABLE IF NOT EXISTS organization_names (
    organization_name_id INTEGER PRIMARY KEY AUTOINCREMENT,
    organization_id TEXT NOT NULL REFERENCES organizations(organization_id) ON DELETE CASCADE,
    name_text TEXT NOT NULL,
    language TEXT,
    name_type TEXT NOT NULL DEFAULT 'alias',
    is_preferred INTEGER NOT NULL DEFAULT 0 CHECK(is_preferred IN (0,1)),
    UNIQUE(organization_id,name_text,name_type)
);

CREATE TABLE IF NOT EXISTS organization_memberships (
    membership_id TEXT PRIMARY KEY,
    person_id TEXT NOT NULL REFERENCES persons(person_id),
    organization_id TEXT NOT NULL REFERENCES organizations(organization_id),
    membership_role TEXT,
    date_text TEXT,
    notes TEXT,
    verification_status TEXT NOT NULL DEFAULT 'provisional'
);

CREATE TABLE IF NOT EXISTS military_units (
    military_unit_id TEXT PRIMARY KEY,
    organization_id TEXT NOT NULL UNIQUE REFERENCES organizations(organization_id) ON DELETE CASCADE,
    unit_kind TEXT NOT NULL,
    service_arm TEXT,
    affiliated_branch_id TEXT REFERENCES organizations(organization_id),
    headquarters_place_id TEXT REFERENCES places(place_id),
    notes TEXT
);

CREATE TABLE IF NOT EXISTS roles (
    role_id TEXT PRIMARY KEY,
    preferred_name_en TEXT NOT NULL,
    preferred_name_fa TEXT,
    role_category TEXT NOT NULL CHECK(role_category IN (
        'military_rank','military_office','government_office','estate_office','occupation','social_status','other'
    )),
    description TEXT
);

CREATE TABLE IF NOT EXISTS person_role_assignments (
    assignment_id TEXT PRIMARY KEY,
    person_id TEXT NOT NULL REFERENCES persons(person_id),
    role_id TEXT NOT NULL REFERENCES roles(role_id),
    organization_id TEXT REFERENCES organizations(organization_id),
    place_id TEXT REFERENCES places(place_id),
    date_text TEXT,
    start_date_text TEXT,
    end_date_text TEXT,
    appointing_authority_text TEXT,
    notes TEXT,
    verification_status TEXT NOT NULL DEFAULT 'provisional'
);

CREATE TABLE IF NOT EXISTS military_commands (
    command_id TEXT PRIMARY KEY,
    person_id TEXT NOT NULL REFERENCES persons(person_id),
    military_unit_id TEXT NOT NULL REFERENCES military_units(military_unit_id),
    command_role_id TEXT REFERENCES roles(role_id),
    date_text TEXT,
    start_date_text TEXT,
    end_date_text TEXT,
    predecessor_person_id TEXT REFERENCES persons(person_id),
    successor_person_id TEXT REFERENCES persons(person_id),
    notes TEXT,
    verification_status TEXT NOT NULL DEFAULT 'provisional'
);

CREATE TABLE IF NOT EXISTS estates (
    estate_id TEXT PRIMARY KEY,
    preferred_name_en TEXT NOT NULL,
    preferred_name_fa TEXT,
    place_id TEXT REFERENCES places(place_id),
    estate_type TEXT NOT NULL DEFAULT 'landed_estate',
    description TEXT,
    verification_status TEXT NOT NULL DEFAULT 'provisional'
);

CREATE TABLE IF NOT EXISTS estate_associations (
    estate_association_id TEXT PRIMARY KEY,
    estate_id TEXT NOT NULL REFERENCES estates(estate_id),
    person_id TEXT REFERENCES persons(person_id),
    organization_id TEXT REFERENCES organizations(organization_id),
    association_type TEXT NOT NULL,
    date_text TEXT,
    notes TEXT,
    verification_status TEXT NOT NULL DEFAULT 'provisional',
    CHECK(person_id IS NOT NULL OR organization_id IS NOT NULL)
);

CREATE TABLE IF NOT EXISTS entity_citations (
    entity_citation_id TEXT PRIMARY KEY,
    entity_type TEXT NOT NULL,
    entity_id TEXT NOT NULL,
    citation_id TEXT NOT NULL REFERENCES citations(citation_id) ON DELETE CASCADE,
    support_type TEXT NOT NULL DEFAULT 'supports',
    notes TEXT,
    UNIQUE(entity_type,entity_id,citation_id,support_type)
);

CREATE INDEX IF NOT EXISTS idx_org_parent ON organizations(parent_organization_id);
CREATE INDEX IF NOT EXISTS idx_memberships_person ON organization_memberships(person_id);
CREATE INDEX IF NOT EXISTS idx_role_assignments_person ON person_role_assignments(person_id);
CREATE INDEX IF NOT EXISTS idx_commands_person ON military_commands(person_id);
CREATE INDEX IF NOT EXISTS idx_commands_unit ON military_commands(military_unit_id);
CREATE INDEX IF NOT EXISTS idx_estate_assoc_person ON estate_associations(person_id);
CREATE INDEX IF NOT EXISTS idx_estate_assoc_org ON estate_associations(organization_id);
CREATE INDEX IF NOT EXISTS idx_entity_citations_entity ON entity_citations(entity_type,entity_id);

INSERT OR REPLACE INTO metadata(key,value) VALUES('archive_schema_version','2.0');
INSERT OR REPLACE INTO metadata(key,value) VALUES('schema_design','institutional-economic-military expansion');
