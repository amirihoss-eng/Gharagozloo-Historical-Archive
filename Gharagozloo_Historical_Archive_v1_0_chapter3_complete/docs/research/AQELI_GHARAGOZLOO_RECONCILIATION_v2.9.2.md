# Aqeli — Gharagozloo Late-Qajar & Pahlavi Enrichment v2.9.2

## Source

**Bagher Aqeli, _Khandanhaye Hokoomatgar dar Iran_ — Gharagozloo chapter**

Archive file:
`Khandanhaye Hokoomay Gar Dar Iran-OCRed.pdf`

The OCR is imperfect. The migration therefore uses conservative paraphrases and avoids promoting unclear OCR fragments into exact names, dates, or offices unless the passage is recoverable.

## Evidence classification

Aqeli is treated as a **secondary biographical reference**.

This is distinct from:
- Abdollah Khan's primary writings;
- reproduced official decrees;
- Majidi's editorial notes;
- Alvandi's scholarly synthesis.

## Highest-value findings

### Abdollah Khan Amir Nezam — P0004
Aqeli adds:
- candidate birth about 1235 SH;
- statement that he was about 26 at the Astarabad appointment;
- reported consideration for the premiership in 1333 AH;
- contextual sequencing into a short Finance Ministry term.

The birth remains **probable**, not canonical.

### Hossein Qoli Khan Amir Nezam II — evidence preserved on E0400 pending live-ID attachment
Aqeli adds:
- candidate birth about 1260 SH;
- cavalry command by about 1310 AH;
- Sa'ed al-Saltaneh in 1314 AH;
- European education and French/English;
- Kermanshah governorship;
- succession to Amir Nezam;
- inheritance estimated at ~45 villages;
- reported Minister of War service in 1299 SH;
- reported Pahlavi court foreign-protocol leadership through about 1318 SH;
- death in 1332 SH;
- estate-to-waqf transition.

Anecdotal gambling/death material is stored only as attributed, low-confidence evidence.

### Gholamhossein Amiri Gharagozloo
Aqeli reports:
- petroleum/oil-related study in Europe;
- management/directorship in the oil company;
- representation of Hamadan in the Sixteenth Majles;
- supervision of Amir Nezam family waqf;
- a post-1979 imprisonment/Freemasonry allegation.

The final item is explicitly sensitive and remains only an attributed secondary claim pending documentary corroboration.

### Amir Nezam waqf
Aqeli reports:
- original charitable endowment of roughly 45 villages;
- charitable purposes including a hospital and school;
- later reduction to roughly 14 villages plus a Tehran house after disputes;
- Gholamhossein Amiri's involvement in supervision/protection/recovery.

This is a major future documentary-research target.

### Mohtaj Ali Khan Amir Arfa'
Aqeli reports:
- financial/banking orientation;
- European study with Mansur Ali under Farid al-Molk Hamadani;
- about five years abroad;
- sons Gholam Ali and Gholamhossein Amiri.

The genealogy corroborates existing archive structure.

Aqeli's sequencing of Mohtaj Ali's marriage conflicts with **Majmooe Asaar**, which places the marriage in Dhu al-Hijjah 1324 AH before the European journey. The archive retains the earlier canonical date pending stronger evidence.

### Mansur Ali Khan
Aqeli reports:
- Dar al-Funun and European education;
- Kermanshah, Khuzestan/Lorestan and Hamadan governorships;
- government action against Salar al-Dowleh;
- Eleventh Majles representation from Hamadan;
- marriage to a daughter of Vosuq al-Dowleh.

The marriage is independently corroborated by Majmooe Asaar.

### Other branches
Aqeli contains useful later biographies for:
- Amir Afkham / Shervini descendants;
- Baha al-Molk descendants;
- Alireza Khan Baha al-Molk;
- Yahya Khan Etemad al-Dowleh;
- Manouchehr Gharagozloo;
- Gholamhossein Parzhad Gharagozloo.

This migration records the existence and relevance of these clusters without guessing live canonical person IDs.

## Identity guardrail

Aqeli makes it especially important to distinguish:

**Gholamhossein Amiri Gharagozloo**
from
**Gholamhossein Parzhad Gharagozloo**

They are separate people in different branches with different careers.

## Why contextual claims use E0400

The current migration package does not have direct access to the user's live `archive.sqlite`, so it does not guess canonical person IDs for Mohtaj Ali, Mansur Ali, Gholamhossein Amiri, Parzhad, or Baha al-Molk descendants.

Their Aqeli evidence is therefore preserved on **E0400**, a source-reconciliation evidence cluster, until a later identity-attachment pass can bind each claim to the already-existing canonical person record.

This is intentional data hygiene, not a genealogy gap.

## No topology change

Migration 0045 makes **zero canonical genealogy changes**.

## Correction after first apply attempt

The first Migration 0045 build encountered a foreign-key failure in the user's live
archive and was automatically rolled back. To avoid assuming that local person IDs
match remembered/reconstructed IDs, the corrected build keeps all later-generation
person evidence on E0400. A later identity-binding migration should use the user's
actual exported `persons.csv` / `person_names.csv` to attach those claims precisely.
