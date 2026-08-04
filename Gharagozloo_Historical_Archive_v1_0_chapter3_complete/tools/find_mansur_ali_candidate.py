from pathlib import Path
import sqlite3

DB = Path.cwd().parent / "archive.sqlite"
if not DB.exists():
    raise SystemExit(f"archive.sqlite not found: {DB}")

con = sqlite3.connect(DB)
con.row_factory = sqlite3.Row

def show_person(pid):
    r = con.execute("""
        SELECT p.person_id,
               COALESCE(p.preferred_name_en,'') AS en,
               COALESCE(p.preferred_name_fa,'') AS fa,
               COALESCE(p.branch,'') AS branch,
               COALESCE(GROUP_CONCAT(pn.name_text,' | '),'') AS aliases
        FROM persons p
        LEFT JOIN person_names pn ON pn.person_id=p.person_id
        WHERE p.person_id=?
        GROUP BY p.person_id
    """, (pid,)).fetchone()
    if r:
        print(f"{r['person_id']} | {r['en']} | {r['fa']} | {r['branch']} | aliases: {r['aliases']}")

print("=== PEOPLE DIRECTLY CONNECTED TO P0004 ===")
rels = con.execute("""
    SELECT person1_id, relationship_type, person2_id
    FROM relationships
    WHERE person1_id='P0004' OR person2_id='P0004'
    ORDER BY relationship_type, person1_id, person2_id
""").fetchall()

seen = set()
for r in rels:
    print(f"{r['person1_id']} --{r['relationship_type']}--> {r['person2_id']}")
    other = r["person2_id"] if r["person1_id"] == "P0004" else r["person1_id"]
    if other not in seen:
        show_person(other)
        seen.add(other)

print("\n=== BROAD NAME/TITLE SEARCH ===")
terms = [
    "Mansur", "Mansour", "Mansoor",
    "منصور", "Sardar Akram", "سردار اکرم",
    "Ali Khan", "علی خان"
]

rows = con.execute("""
    SELECT p.person_id,
           COALESCE(p.preferred_name_en,'') AS en,
           COALESCE(p.preferred_name_fa,'') AS fa,
           COALESCE(p.branch,'') AS branch,
           COALESCE(GROUP_CONCAT(pn.name_text,' | '),'') AS aliases
    FROM persons p
    LEFT JOIN person_names pn ON pn.person_id=p.person_id
    GROUP BY p.person_id
    ORDER BY p.person_id
""").fetchall()

for r in rows:
    blob = " | ".join([r["en"], r["fa"], r["aliases"]]).lower()
    if any(t.lower() in blob for t in terms):
        print(f"{r['person_id']} | {r['en']} | {r['fa']} | {r['branch']} | aliases: {r['aliases']}")

print("\n=== TITLES MATCHING SARDAR AKRAM ===")
try:
    rows = con.execute("""
        SELECT pt.person_id, t.title_id,
               COALESCE(t.title_name_en,'') AS title_en,
               COALESCE(t.title_name_fa,'') AS title_fa
        FROM person_titles pt
        JOIN titles t ON t.title_id=pt.title_id
        WHERE LOWER(COALESCE(t.title_name_en,'')) LIKE '%sardar%'
           OR COALESCE(t.title_name_fa,'') LIKE '%سردار%'
        ORDER BY pt.person_id
    """).fetchall()
    for r in rows:
        print(dict(r))
        show_person(r["person_id"])
except Exception as e:
    print("Could not query title fields with expected names:", e)

con.close()
