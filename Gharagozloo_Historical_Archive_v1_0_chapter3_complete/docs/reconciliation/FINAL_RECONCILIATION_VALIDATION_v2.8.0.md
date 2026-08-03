# Final Reconciliation Validation — Archive v2.8.0

## Result

**Structural validation:** PASS  
**Errors:** 0  
**Warnings:** 0  
**Hajilou genealogy topology unchanged from v2.7.3:** TRUE  
**Ashiqloo expected canonical edges missing:** 0  
**Known incorrect old edges still canonical:** 0  
**Eight missing Ashiqloo people added:** TRUE  
**Amir Nezam title on P0012:** CONFIRMED IN DATABASE  
**Kazem unnamed-child claim C0272 restored:** TRUE  
**Explorer canonical-graph filtering patched:** TRUE

## New Ashiqloo people
- `P0170` — Gholam Ali Khan Hesam al-Molk Gharagozloo — `confirmed`
- `P0171` — Mehdi Qoli Khan Gharagozloo — `confirmed`
- `P0172` — Yahya Khan Gharagozloo — `confirmed`
- `P0173` — Manouchehr Gharagozloo — `confirmed`
- `P0174` — Fath Ali Khan Gharagozloo — `confirmed`
- `P0175` — Mohammad Shafi Khan Gharagozloo — `disputed`
- `P0176` — Ezzat Allah Saremi — `confirmed`
- `P0177` — Abdolhossein Khan Gharagozloo — `disputed`

## Source conflicts preserved
- `CF006` — parentage in Figure 3 versus prose — `partially_resolved`
- `CF007` — male children — `unresolved`
- `CF008` — parentage wording — `partially_resolved`
- `CF009` — omitted generation in Figure 3 — `resolved`

## Canonical-policy checks

- Mohammad Hossein Khan retains the five verified Ashiqloo sons.
- Rostam line retains Mohammad-Hossein Khan Hesam al-Molk as the prose-added generation.
- Nabi → Amanollah remains canonical.
- Mahmoud → Amanollah is not canonical; Figure 3 disagreement is preserved in `CF006`.
- Ahmad Sartip → Mehdi Khan is canonical.
- Ahmad Sartip → Abdol Ali Khan is canonical.
- Mehdi Khan → Mohammad Ebrahim Khan is canonical.
- Naser al-Molk → Mehdi Khan is no longer canonical.
- Mehdi Khan → Abdol Ali Khan is no longer canonical; old wording remains in `CF008`.
- Abdollah Sarem al-Dowleh → Mohammad Shafi Khan is present as `disputed`.
- Abdollah Sarem al-Dowleh → Abdolhossein Khan is present as `disputed`.
- Negar Khanom remains a confirmed daughter of Abdollah Sarem al-Dowleh.
- Duplicate Mahmoud → Ahmad record `R0028` is retained only as `superseded`.
- `P0074`, `P0075`, and `P0142` remain in SQLite for audit history but are excluded from the canonical graph.
- Hajilou parent-child topology is byte-for-byte equivalent at the edge-set level before and after migrations 0032–0033.

## Conclusion

The test build is ready for installation and visual verification in the Explorer. No unresolved structural database error remains in the approved Figure 3 + prose Ashiqloo reconciliation.
