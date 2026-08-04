from pathlib import Path
import sqlite3, sys, unicodedata, re

DB = Path.cwd().parent / "archive.sqlite"
OUT = Path.cwd().parent / "migrations" / "0046_bind_aqeli_late_generation_claims.sql"

if not DB.exists():
    raise SystemExit(f"archive.sqlite not found at expected path: {DB}")

con = sqlite3.connect(DB)
con.row_factory = sqlite3.Row

def norm(s):
    s = s or ""
    s = unicodedata.normalize("NFKC", s).lower()
    s = s.replace("’", "'").replace("ʻ", "'").replace("‐", "-").replace("–", "-")
    s = re.sub(r"[\s_\-']+", " ", s)
    return s.strip()

rows = con.execute("""
SELECT p.person_id,
       COALESCE(p.preferred_name_en,'') AS en,
       COALESCE(p.preferred_name_fa,'') AS fa,
       COALESCE(p.branch,'') AS branch,
       COALESCE(p.summary,'') AS summary,
       COALESCE(GROUP_CONCAT(pn.name_text,' | '),'') AS aliases
FROM persons p
LEFT JOIN person_names pn ON pn.person_id=p.person_id
GROUP BY p.person_id
ORDER BY p.person_id
""").fetchall()

people = []
for r in rows:
    blob = " | ".join([r["en"], r["fa"], r["aliases"], r["branch"], r["summary"]])
    people.append((r["person_id"], blob, norm(blob), dict(r)))

def candidates(include_any, include_all=(), exclude=()):
    out = []
    for pid, blob, nb, raw in people:
        if include_all and not all(norm(x) in nb for x in include_all):
            continue
        if include_any and not any(norm(x) in nb for x in include_any):
            continue
        if exclude and any(norm(x) in nb for x in exclude):
            continue
        out.append((pid, raw, blob))
    return out

targets = {
    "hossein_qoli": {
        "known_id": "P0012",
        "claims": [f"C{i}" for i in range(1510, 1522)],
        "citation": "X1501",
        "label": "Hossein Qoli Khan Amir Nezam II"
    },
    "mohtaj_ali": {
        "include_any": ["Mohtaj Ali", "محتاجعلی", "محتاج علی", "Amir Arfa", "امیر ارفع"],
        "include_all": [],
        "exclude": ["Gholamhossein", "غلامحسین"],
        "claims": ["C1537","C1538","C1539","C1540"],
        "citation": "X1505",
        "label": "Mohtaj Ali Khan Amir Arfa"
    },
    "mansur_ali": {
        "known_id": "P0006",
        "claims": ["C1541","C1542","C1543","C1544","C1545"],
        "citation": "X1506",
        "label": "Mansur Ali Khan Sardar Akram"
    },
    "gholamhossein_amiri": {
        "include_any": ["Gholamhossein Amiri", "Gholam Hossein Amiri", "غلامحسین امیری", "غلام حسین امیری"],
        "include_all": [],
        "exclude": ["Parzhad", "پرژاد"],
        "claims": ["C1530","C1531","C1532","C1533","C1534","C1535","C1536"],
        "citation": "X1503",
        "label": "Gholamhossein Amiri Gharagozloo"
    },
}

resolved = {}

for key, t in targets.items():
    if "known_id" in t:
        n = con.execute("SELECT COUNT(*) FROM persons WHERE person_id=?", (t["known_id"],)).fetchone()[0]
        if n != 1:
            raise SystemExit(f"{t['label']}: expected {t['known_id']} but it does not exist.")
        resolved[key] = t["known_id"]
        continue

    cs = candidates(t["include_any"], t["include_all"], t["exclude"])
    print(f"\n=== {t['label']} candidates ===")
    for pid, raw, blob in cs:
        print(pid, "|", raw["en"], "|", raw["fa"], "|", raw["branch"])
    if len(cs) != 1:
        raise SystemExit(
            f"\nCannot safely resolve {t['label']}: found {len(cs)} candidates. "
            "No migration was written. Paste the candidate output to ChatGPT."
        )
    resolved[key] = cs[0][0]

print("\n=== RESOLVED IDS ===")
for key, pid in resolved.items():
    print(f"{targets[key]['label']}: {pid}")

required = {
    "sources": [("source_id","S0202")],
    "events": [("event_id","E0400")],
    "citations": [("citation_id", x) for x in ["X1501","X1503","X1504","X1505","X1506"]],
    "claims": [("claim_id", c) for t in targets.values() for c in t["claims"]],
}
for table, pairs in required.items():
    for col, val in pairs:
        n = con.execute(f"SELECT COUNT(*) FROM {table} WHERE {col}=?", (val,)).fetchone()[0]
        if n != 1:
            raise SystemExit(f"Required 0045 record missing or duplicated: {table}.{col}={val} count={n}")

lines = []
lines.append("-- Migration 0046")
lines.append("-- Bind Aqeli late-generation claims from E0400 to canonical person IDs")
lines.append("-- Generated from the user's live v2.9.2 archive by prepare_0046_identity_binding.py")
lines.append("-- No genealogy topology changes.")
lines.append("")
lines.append("UPDATE metadata SET value='2.9.3' WHERE key='database_version';")
lines.append("INSERT OR REPLACE INTO metadata(key,value) VALUES('last_migration','0046');")
lines.append("INSERT OR REPLACE INTO metadata(key,value) VALUES('updated_at','2026-08-04T02:50:00Z');")
lines.append("")

for key, pid in resolved.items():
    t = targets[key]
    claim_list = ",".join("'" + c + "'" for c in t["claims"])
    lines.append(f"-- {t['label']} -> {pid}")
    lines.append(
        f"UPDATE claims SET subject_type='person', subject_id='{pid}' "
        f"WHERE claim_id IN ({claim_list}) AND subject_type='event' AND subject_id='E0400';"
    )
    lines.append("")

ecs = [
    ("EC1510", resolved["hossein_qoli"], "X1501", "Aqeli biography attached to canonical Hossein Qoli Khan Amir Nezam II."),
    ("EC1511", resolved["mohtaj_ali"], "X1505", "Aqeli biography attached to canonical Mohtaj Ali Khan Amir Arfa."),
    ("EC1512", resolved["mansur_ali"], "X1506", "Aqeli biography attached to canonical Mansur Ali Khan Sardar Akram."),
    ("EC1513", resolved["gholamhossein_amiri"], "X1503", "Aqeli biography attached to canonical Gholamhossein Amiri Gharagozloo."),
    ("EC1514", resolved["gholamhossein_amiri"], "X1504", "Aqeli waqf evidence attached to canonical Gholamhossein Amiri Gharagozloo."),
]
for ecid, pid, xid, note in ecs:
    safe_note = note.replace("'", "''")
    lines.append(
        "INSERT OR IGNORE INTO entity_citations("
        "entity_citation_id,entity_type,entity_id,citation_id,support_type,notes) VALUES("
        f"'{ecid}','person','{pid}','{xid}','supports','{safe_note}');"
    )

lines.append("")
lines.append("""
UPDATE research_questions
SET status='resolved',
    notes=COALESCE(notes,'') || ' Resolved in migration 0046 by matching against the live canonical persons/person_names tables.'
WHERE question_id='Q0161';
""".strip())

lines.append("")
for key, pid in resolved.items():
    label = targets[key]["label"].replace("'", "''")
    lines.append(
        "INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary) VALUES("
        f"'2026-08-04T02:50:00Z','person','{pid}','aqeli_identity_binding',"
        f"'Bound reviewed Aqeli claims from E0400 to canonical person: {label}.');"
    )

lines.append("""
INSERT INTO change_log(changed_at,entity_type,entity_id,action,summary)
VALUES('2026-08-04T02:50:00Z','migration','0046','apply',
       'Bound reviewed Aqeli late-generation claims from reconciliation event E0400 to exact canonical person records; genealogy unchanged.');
""".strip())

OUT.write_text("\n".join(lines) + "\n", encoding="utf-8")
con.close()

print(f"\nWrote migration: {OUT}")
print("\nNext run:")
print(r"  py .\diagnose_0045_fk.py ..\migrations\0046_bind_aqeli_late_generation_claims.sql")
print(r"  py .\apply_migration.py ..\migrations\0046_bind_aqeli_late_generation_claims.sql")
print(r"  py .\validate_archive.py")
print(r"  py .\export_csv.py")
