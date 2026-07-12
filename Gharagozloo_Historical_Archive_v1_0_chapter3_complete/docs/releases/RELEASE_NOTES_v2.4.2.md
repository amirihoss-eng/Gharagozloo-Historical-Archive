# Release Notes — v2.4.2

**Release type:** Documentation and continuity patch  
**Database content:** unchanged from validated v2.4.1  
**Latest database migration:** 0016

## Added

- Repository Audit v2.4.1
- Schema Audit v2.4.1
- Data Dictionary v2.4.1
- Architecture Specification v2.4.1
- Entity Relationship Map in SVG, PNG, and Graphviz DOT formats
- Archive Project State v2.4.1
- Architecture and project documentation indexes

## Updated

- Top-level README now describes the actual archive state.
- `manifest.json` now identifies this package as v2.4.2 and migration 0016.

## Database changes

None. No SQL migration is required for this release.

## Validation

The canonical database remains the validated post-migration-0016 archive. The validator should be rerun after copying this package into the working repository.

## Next planned milestone

Begin Family Explorer v0.1 as a read-only visualization layer over `archive.sqlite`.
