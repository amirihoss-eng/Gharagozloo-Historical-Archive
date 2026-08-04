# Abdollah Khan Explorer / Dossier Enrichment Audit — v2.8.3 → v2.8.4

## Finding

The Explorer screenshot for `P0004 Abdollah Khan Gharagozloo` shows a short legacy summary even though the evidence layer has become substantially richer.

The current architecture intentionally separates the canonical person registry from events, claims, roles, titles, and citations. `persons.summary` is therefore only a curated publication field; detailed historical assertions remain in the evidence chain.

## Why the page looked thin

Migrations 0035 and 0036 primarily enriched:
- events and event participation;
- places;
- atomic claims;
- citations and claim-citation links;
- research questions.

Those additions increased the counts visible in the Explorer, but they did not automatically regenerate `persons.summary`.

## v2.8.4 action

Migration 0037:
1. updates `persons.summary` for `P0004` using only evidence already checkpointed through 0036;
2. points the existing dossier registration, if present, to a new multi-source dossier document;
3. does not alter genealogy topology;
4. does not add the newly mined 1309–1311 AH Fars/Hamadan material yet, because that material has not been checkpointed into the evidence layer.

## Publication rule adopted

Going forward, when a person's evidence reaches a coherent checkpoint, the workflow should include a **publication roll-up**:
- refresh the concise person summary;
- refresh/register the dossier document;
- keep detailed chronology in events;
- keep proof and uncertainty in claims/citations/conflicts.

This prevents the Explorer from lagging behind the research database while preserving evidence-first architecture.
