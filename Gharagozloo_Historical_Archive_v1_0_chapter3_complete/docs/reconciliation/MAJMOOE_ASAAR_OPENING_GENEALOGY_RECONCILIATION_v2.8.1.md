# Majmooe Asaar Opening Genealogy Reconciliation — v2.8.1

**Baseline:** Gharagozloo Archive v2.8.0 — Final Hajilou Cleanup and Ashiqloo Reconciliation  
**Migration:** 0034  
**Mode:** Evidence enrichment only  
**Canonical genealogy topology:** UNCHANGED

## Purpose

This checkpoint introduces **Majmooe Asaar-e Haji Abdollah Khan Gharagozloo** as a second major historical source and preserves the opening family genealogy as queryable archive evidence before deeper biographical mining begins.

The archive distinguishes three provenance layers:

1. the modern editor/compiler's introduction;
2. an **older family genealogy preserved among Haji Abdollah Khan's papers**, attributed by the editor to Haji Mohammad Khan;
3. Haji Abdollah Khan's own later first-person reports and administrative writings.

Migration 0034 concerns only the **opening genealogy/reconciliation layer**. It does not yet ingest the later Sarakhs, Khorasan, Khuzestan, Fars, Astarabad or other first-person reports.

## Canonical-policy decision

The v2.8.0 tree remains the current publication/canonical genealogy. Majmooe Asaar is added through the source → citation → claim → conflict/research-question evidence chain.

No new canonical `parent_of` relationships are created in 0034. Unresolved people are not inserted as graph-active person nodes merely because one source names them. This prevents a source discrepancy from silently rewriting the verified tree while preserving the historical evidence in full.

## Findings preserved

### 1. Older ancestral family tradition

Majmooe Asaar preserves an older ancestral chain beginning with **Qara Mohammad**, continuing through **Haji Bonyad Khan, Haji Qasem, Haji Jafar Khan and Haji Abdollah Beg**, and then into the later Hajilou line.

This is preserved as **family-tradition genealogy**, not independently verified chronology. A major identity question remains: the manuscript's Haji Jafar Khan must not automatically be equated with canonical `P0094 Haji Mohammad Jafar Khan Gharagozloo` merely because the names are similar.

### 2. Haji Fathollah — major new source discrepancy

Majmooe Asaar explicitly calls **Haji Fathollah the sixth son of Haji Abdollah Beg**. It further states that he did not enter government service and occupied himself with landed/property affairs together with Haji Safar Khan.

The source names three children:

- Abbas Beg
- Allah-Panah Beg
- Heidar Qoli Beg

The canonical v2.8.0 Hajilou graph currently has five branch heads under Haji Abdollah. Therefore 0034 records this as **CF010 — unresolved**, with no topology change.

This is not treated as an OCR accident. It is a strong source-explicit alternate genealogical tradition.

### 3. Haji Mohammad Khan Jeyhunabadi child-list discrepancy

Majmooe Asaar gives six sons:

- Mohammad Baqer Khan
- Haji Hamze Khan
- Haji Ali Mohammad Khan
- Mehdi Khan Sartip
- Zolfaghar Khan
- Mohammad Qoli Khan

The current canonical v2.8.0 child set is:

- Mohammad Baqer
- Zolfaghar
- Haji Yavar Mohammad Gholi
- Haji Hamze
- Kazem

The overlap is substantial but not complete. **Mohammad Qoli Khan may be identical with Haji Yavar Mohammad Gholi**, but that hypothesis is not proven. Kazem's absence from the Majmooe Asaar list is treated as a possible omission rather than proof against Kazem.

This discrepancy is preserved as **CF011 — unresolved**.

### 4. Haji Safar branch enrichment

Majmooe Asaar names five children of Haji Safar:

- Mohammad Jafar Khan Majzub Ali Shah
- Sadeq Beg
- Amin Beg
- Rahim Beg
- Hossein Ali Beg

The source also describes Haji Safar as independent/dervish-minded, avoiding government service and attending to agricultural and landed affairs.

These statements are preserved as additive evidence. Existing later descendants are not removed.

### 5. Haji Mina branch enrichment

Majmooe Asaar names or associates the following with the Haji Mina branch:

- Haji Mirza Safi Qoli Khan — associated with ancestry of the Kabudarahang khans
- Haji Abolqasem Khan — associated with ancestry of the Yekleh family
- Haji Morteza Qoli Khan — stated to be father of Mohammad Mirza Khan
- Mohammad Ali Khan — associated with ancestry of Haji Noor Ali Khan
- Hossein Ali Beg
- Mehdi Qoli Beg

Several names do not yet have safe canonical matches. No forced aliasing is performed.

Importantly, Majmooe Asaar independently supports **Haji Mina's placement in the Haji Abdollah line**. This new corroboration is appended to the existing Haji Mina parentage conflict rather than deleting the contrary evidence.

### 6. Haji Fazlollah branch enrichment

Majmooe Asaar says Haji Fazlollah governed **Khamseh, Qazvin and Garrus for years**.

It identifies branch figures including:

- Abdolhossein Khan — associated with the Qarakhlu/Qarkhlu khans
- Hossein Ali Khan — associated with the Hosseinabad khans and described as a **maternal ancestor of Haji Amir Nezam**
- Haji Mohammad Hossein — ancestor of a further branch whose exact name still requires visual normalization

The maternal-ancestry statement is preserved as a claim. No intermediate maternal generations are invented.

### 7. Nasrollah branch enrichment

Majmooe Asaar describes Nasrollah Khan as:

- commander of the Hajilou cavalry;
- frequently serving in Shiraz under Hasan Ali Mirza Farmanfarma.

It names seven children:

- Ghaffar Khan
- Mirza Hashem Khan
- Mohammad Hossein Khan
- Qasem Khan
- Hassan Khan
- Abdollah Khan
- Nasir Beg

The current canonical Nasrollah/Korijani subtree is much smaller. The seven-person list is therefore stored as source evidence pending later identity-by-identity reconciliation.

## Research questions opened

Migration 0034 opens targeted questions for:

- identity of the older Haji Jafar Khan;
- whether Haji Fathollah should eventually become a sixth canonical branch head;
- Mohammad Qoli Khan versus Haji Yavar Mohammad Gholi;
- placement of Haji Ali Mohammad Khan and Mehdi Khan Sartip;
- reconciliation of the additional Haji Safar children;
- reconciliation of additional Haji Mina identities;
- missing maternal links from Hossein Ali Khan to Haji Amir Nezam;
- placement of Nasrollah's seven children;
- visual transcription of the difficult village/property list before estate modeling.

## Explorer implications

No new evidence UI is required. The existing Explorer **Evidence snapshot / Inspect claims and citations** pathway should surface these additions once the database-backed evidence endpoint reads the new claims, citations and conflicts.

The intended model remains:

**canonical tree = current best-supported genealogy**  
**evidence layer = everything the sources actually say, including contradictions and alternate traditions**

## Next historical-enrichment step

After v2.8.1 is installed, validated and committed, begin chronological mining of Haji Abdollah Khan's own material, starting with the **Sarakhs/Khorasan mission and related travel/report material**. Those first-person records should be treated separately from the inherited opening genealogy.
