from __future__ import annotations

import json
import mimetypes
import sqlite3
import sys
import threading
import webbrowser
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from urllib.parse import parse_qs, urlparse

APP_DIR = Path(__file__).resolve().parent
REPO_ROOT = APP_DIR.parent
DB_PATH = REPO_ROOT / "archive.sqlite"
STATIC_DIR = APP_DIR / "static"
HOST = "127.0.0.1"
PORT = 8765


def db() -> sqlite3.Connection:
    if not DB_PATH.exists():
        raise FileNotFoundError(f"Archive database not found: {DB_PATH}")
    con = sqlite3.connect(DB_PATH)
    con.row_factory = sqlite3.Row
    con.execute("PRAGMA foreign_keys = ON")
    return con


def rows(query: str, params: tuple = ()) -> list[dict]:
    with db() as con:
        return [dict(r) for r in con.execute(query, params).fetchall()]


def row(query: str, params: tuple = ()) -> dict | None:
    with db() as con:
        r = con.execute(query, params).fetchone()
        return dict(r) if r else None


def counts() -> dict:
    names = [
        "persons", "events", "places", "organizations", "sources", "claims",
        "citations", "relationships", "estates", "military_units",
        "person_dossiers", "research_questions"
    ]
    with db() as con:
        return {name: con.execute(f'SELECT COUNT(*) FROM "{name}"').fetchone()[0] for name in names}


def person_summary(person_id: str) -> dict | None:
    p = row("SELECT * FROM persons WHERE person_id = ?", (person_id,))
    if not p:
        return None

    p["aliases"] = rows(
        "SELECT name_text, language, name_type, is_preferred FROM person_names WHERE person_id=? ORDER BY is_preferred DESC, name_text",
        (person_id,),
    )
    p["titles"] = rows(
        """SELECT t.title_en, t.title_fa, t.meaning_notes, pt.date_text, pt.notes
           FROM person_titles pt JOIN titles t ON t.title_id=pt.title_id
           WHERE pt.person_id=? ORDER BY COALESCE(pt.date_text,''), t.title_en""",
        (person_id,),
    )
    p["roles"] = rows(
        """SELECT r.preferred_name_en AS role_en, r.preferred_name_fa AS role_fa,
                  r.role_category, o.preferred_name_en AS organization,
                  pl.preferred_name_en AS place, pra.date_text, pra.start_date_text,
                  pra.end_date_text, pra.appointing_authority_text, pra.notes,
                  pra.verification_status
           FROM person_role_assignments pra
           JOIN roles r ON r.role_id=pra.role_id
           LEFT JOIN organizations o ON o.organization_id=pra.organization_id
           LEFT JOIN places pl ON pl.place_id=pra.place_id
           WHERE pra.person_id=? ORDER BY COALESCE(pra.start_date_text,pra.date_text,'')""",
        (person_id,),
    )
    p["events"] = rows(
        """SELECT e.event_id, e.title, e.event_type, e.date_text, e.description,
                  ep.role, pl.preferred_name_en AS place
           FROM event_persons ep JOIN events e ON e.event_id=ep.event_id
           LEFT JOIN places pl ON pl.place_id=e.place_id
           WHERE ep.person_id=? ORDER BY COALESCE(e.date_text,''), e.title""",
        (person_id,),
    )
    p["relationships"] = rows(
        """SELECT r.relationship_id, r.relationship_type, r.verification_status, r.notes,
                  CASE WHEN r.person1_id=? THEN r.person2_id ELSE r.person1_id END AS related_person_id,
                  CASE WHEN r.person1_id=? THEN p2.preferred_name_en ELSE p1.preferred_name_en END AS related_name_en,
                  CASE WHEN r.person1_id=? THEN p2.preferred_name_fa ELSE p1.preferred_name_fa END AS related_name_fa,
                  CASE WHEN r.person1_id=? THEN 'outgoing' ELSE 'incoming' END AS direction
           FROM relationships r
           JOIN persons p1 ON p1.person_id=r.person1_id
           JOIN persons p2 ON p2.person_id=r.person2_id
           WHERE r.person1_id=? OR r.person2_id=?
           ORDER BY r.relationship_type, related_name_en""",
        (person_id, person_id, person_id, person_id, person_id, person_id),
    )
    p["claims"] = rows(
        """SELECT c.claim_id, c.predicate, c.object_text, c.confidence, c.status, c.notes,
                  cep.evidence_type_code, cep.assertion_scope, cep.source_position,
                  cep.assessment_notes
           FROM claims c
           LEFT JOIN claim_evidence_profiles cep ON cep.claim_id=c.claim_id
           WHERE c.subject_type='person' AND c.subject_id=?
           ORDER BY c.predicate, c.claim_id""",
        (person_id,),
    )
    for claim in p["claims"]:
        claim["citations"] = rows(
            """SELECT ci.citation_id, ci.page_printed, ci.page_file, ci.locator_text,
                      ci.quoted_text, ci.notes, cc.support_type,
                      s.source_id, s.short_title, s.full_title, s.author, s.publication_year
               FROM claim_citations cc
               JOIN citations ci ON ci.citation_id=cc.citation_id
               JOIN sources s ON s.source_id=ci.source_id
               WHERE cc.claim_id=? ORDER BY s.short_title, ci.page_printed""",
            (claim["claim_id"],),
        )
    p["reconciliation"] = row(
        "SELECT * FROM person_reconciliation WHERE person_id=?", (person_id,)
    )
    p["dossier"] = row(
        "SELECT * FROM person_dossiers WHERE person_id=? ORDER BY sequence_no LIMIT 1", (person_id,)
    )
    return p


def graph_for(person_id: str, depth: int = 2) -> dict:
    depth = max(1, min(depth, 4))
    seen = {person_id}
    frontier = {person_id}
    edges: list[dict] = []
    with db() as con:
        for _ in range(depth):
            if not frontier:
                break
            placeholders = ",".join("?" for _ in frontier)
            q = f"""SELECT * FROM relationships
                    WHERE person1_id IN ({placeholders}) OR person2_id IN ({placeholders})"""
            params = tuple(frontier) + tuple(frontier)
            batch = [dict(r) for r in con.execute(q, params)]
            next_frontier = set()
            for e in batch:
                key = e["relationship_id"]
                if not any(x["relationship_id"] == key for x in edges):
                    edges.append(e)
                for pid in (e["person1_id"], e["person2_id"]):
                    if pid not in seen:
                        seen.add(pid)
                        next_frontier.add(pid)
            frontier = next_frontier
        placeholders = ",".join("?" for _ in seen)
        people = [dict(r) for r in con.execute(
            f"SELECT person_id, preferred_name_en, preferred_name_fa, branch, verification_status FROM persons WHERE person_id IN ({placeholders})",
            tuple(seen),
        )]
    return {"center": person_id, "nodes": people, "edges": edges}


class Handler(BaseHTTPRequestHandler):
    server_version = "GharagozlooExplorer/0.6.4-expandable-generation-cards"

    def send_json(self, payload, status=200):
        data = json.dumps(payload, ensure_ascii=False).encode("utf-8")
        self.send_response(status)
        self.send_header("Content-Type", "application/json; charset=utf-8")
        self.send_header("Content-Length", str(len(data)))
        self.send_header("Cache-Control", "no-store")
        self.end_headers()
        self.wfile.write(data)

    def send_file(self, path: Path):
        if not path.exists() or not path.is_file():
            self.send_error(404)
            return
        data = path.read_bytes()
        ctype = mimetypes.guess_type(path.name)[0] or "application/octet-stream"
        self.send_response(200)
        self.send_header("Content-Type", ctype + ("; charset=utf-8" if ctype.startswith("text/") else ""))
        self.send_header("Content-Length", str(len(data)))
        self.end_headers()
        self.wfile.write(data)

    def do_GET(self):
        try:
            parsed = urlparse(self.path)
            path = parsed.path
            qs = parse_qs(parsed.query)
            if path == "/api/health":
                return self.send_json({"ok": True, "database": str(DB_PATH), "version": "0.6.9-lineage-selector"})
            if path == "/api/dashboard":
                featured = rows(
                    """SELECT p.person_id,p.preferred_name_en,p.preferred_name_fa,p.branch,p.summary,
                              p.verification_status, pr.dossier_level
                       FROM persons p LEFT JOIN person_reconciliation pr ON pr.person_id=p.person_id
                       ORDER BY CASE WHEN pr.dossier_level='silver' THEN 0 ELSE 1 END,
                                CASE WHEN p.summary IS NOT NULL THEN 0 ELSE 1 END,
                                p.preferred_name_en LIMIT 12"""
                )
                branches = rows("SELECT COALESCE(branch,'Unclassified') AS branch, COUNT(*) AS count FROM persons GROUP BY COALESCE(branch,'Unclassified') ORDER BY count DESC, branch")
                return self.send_json({"counts": counts(), "featured": featured, "branches": branches})

            if path == "/api/graph/core":
                people = rows("""SELECT p.person_id,p.preferred_name_en,p.preferred_name_fa,p.branch,
                                        p.birth_date_text,p.death_date_text,p.summary,p.verification_status,
                                        COALESCE(pr.dossier_level,'') AS dossier_level
                                 FROM persons p LEFT JOIN person_reconciliation pr ON pr.person_id=p.person_id
                                 ORDER BY p.preferred_name_en""")
                rels = rows("""SELECT relationship_id,person1_id,person2_id,relationship_type,
                                      verification_status,notes
                               FROM relationships ORDER BY relationship_id""")
                branches = rows("""SELECT COALESCE(branch,'Unclassified') AS branch,COUNT(*) AS count
                                   FROM persons GROUP BY COALESCE(branch,'Unclassified')
                                   ORDER BY count DESC,branch""")
                lineage_roots = [
                    {"person_id": "P0001", "label": "Hajilou — Amir Nezam / Amiri line", "branch": "Hajilou"},
                    {"person_id": "P0011", "label": "Ashiqloo historical line", "branch": "Ashiqloo"},
                ]
                return self.send_json({"nodes": people, "edges": rels, "branches": branches,
                                       "default_root": "P0001", "lineage_roots": lineage_roots})

            if path == "/api/timeline":
                event_type = (qs.get("type", [""])[0] or "").strip()
                place = (qs.get("place", [""])[0] or "").strip()
                sql = """SELECT e.event_id,e.event_type,e.title,e.date_text,e.description,e.verification_status,
                                p.place_id,p.preferred_name_en AS place_en,p.preferred_name_fa AS place_fa,
                                COUNT(DISTINCT ep.person_id) AS people_count
                         FROM events e
                         LEFT JOIN places p ON p.place_id=e.place_id
                         LEFT JOIN event_persons ep ON ep.event_id=e.event_id
                         WHERE 1=1"""
                params=[]
                if event_type:
                    sql += " AND e.event_type=?"; params.append(event_type)
                if place:
                    sql += " AND e.place_id=?"; params.append(place)
                sql += " GROUP BY e.event_id ORDER BY COALESCE(e.date_text,''), e.title"
                return self.send_json({
                    "events": rows(sql, tuple(params)),
                    "types": rows("SELECT event_type,COUNT(*) AS count FROM events GROUP BY event_type ORDER BY count DESC,event_type"),
                    "places": rows("SELECT p.place_id,p.preferred_name_en,COUNT(e.event_id) AS count FROM places p JOIN events e ON e.place_id=p.place_id GROUP BY p.place_id ORDER BY count DESC,p.preferred_name_en")
                })
            if path == "/api/estates":
                data=rows("""SELECT e.*,p.preferred_name_en AS place_en,p.preferred_name_fa AS place_fa,
                                    COUNT(DISTINCT ea.estate_association_id) AS association_count
                             FROM estates e LEFT JOIN places p ON p.place_id=e.place_id
                             LEFT JOIN estate_associations ea ON ea.estate_id=e.estate_id
                             GROUP BY e.estate_id ORDER BY e.preferred_name_en""")
                return self.send_json(data)
            if path.startswith("/api/estate/"):
                eid=path.split("/")[3]
                estate=row("""SELECT e.*,p.preferred_name_en AS place_en,p.preferred_name_fa AS place_fa
                              FROM estates e LEFT JOIN places p ON p.place_id=e.place_id WHERE e.estate_id=?""",(eid,))
                if not estate: return self.send_json({"error":"Estate not found"},404)
                estate["associations"]=rows("""SELECT ea.*,pe.preferred_name_en AS person_en,pe.preferred_name_fa AS person_fa,
                                                       o.preferred_name_en AS organization_en
                                                FROM estate_associations ea
                                                LEFT JOIN persons pe ON pe.person_id=ea.person_id
                                                LEFT JOIN organizations o ON o.organization_id=ea.organization_id
                                                WHERE ea.estate_id=? ORDER BY COALESCE(ea.date_text,''),ea.association_type""",(eid,))
                return self.send_json(estate)
            if path == "/api/organizations":
                data=rows("""SELECT o.*,po.preferred_name_en AS parent_name,COUNT(DISTINCT om.membership_id) AS member_count,
                                    COUNT(DISTINCT pra.assignment_id) AS role_count
                             FROM organizations o LEFT JOIN organizations po ON po.organization_id=o.parent_organization_id
                             LEFT JOIN organization_memberships om ON om.organization_id=o.organization_id
                             LEFT JOIN person_role_assignments pra ON pra.organization_id=o.organization_id
                             GROUP BY o.organization_id ORDER BY o.organization_type,o.preferred_name_en""")
                return self.send_json(data)
            if path.startswith("/api/organization/"):
                oid=path.split("/")[3]
                org=row("SELECT * FROM organizations WHERE organization_id=?",(oid,))
                if not org: return self.send_json({"error":"Organization not found"},404)
                org["members"]=rows("""SELECT om.*,p.preferred_name_en,p.preferred_name_fa FROM organization_memberships om
                                        JOIN persons p ON p.person_id=om.person_id WHERE om.organization_id=?
                                        ORDER BY COALESCE(om.date_text,''),p.preferred_name_en""",(oid,))
                org["roles"]=rows("""SELECT pra.*,p.preferred_name_en,p.preferred_name_fa,r.preferred_name_en AS role_en
                                      FROM person_role_assignments pra JOIN persons p ON p.person_id=pra.person_id
                                      JOIN roles r ON r.role_id=pra.role_id WHERE pra.organization_id=?
                                      ORDER BY COALESCE(pra.start_date_text,pra.date_text,''),p.preferred_name_en""",(oid,))
                return self.send_json(org)
            if path == "/api/titles":
                return self.send_json(rows("""SELECT t.*,COUNT(pt.person_title_id) AS holder_count FROM titles t
                                              LEFT JOIN person_titles pt ON pt.title_id=t.title_id
                                              GROUP BY t.title_id ORDER BY holder_count DESC,t.title_en"""))
            if path.startswith("/api/title/"):
                tid=path.split("/")[3]
                title=row("SELECT * FROM titles WHERE title_id=?",(tid,))
                if not title: return self.send_json({"error":"Title not found"},404)
                title["holders"]=rows("""SELECT pt.*,p.preferred_name_en,p.preferred_name_fa FROM person_titles pt
                                          JOIN persons p ON p.person_id=pt.person_id WHERE pt.title_id=?
                                          ORDER BY COALESCE(pt.date_text,''),p.preferred_name_en""",(tid,))
                return self.send_json(title)
            if path == "/api/research":
                return self.send_json(rows("SELECT * FROM research_questions ORDER BY CASE priority WHEN 'high' THEN 0 WHEN 'medium' THEN 1 ELSE 2 END,status,question_id"))
            if path == "/api/search":
                q=(qs.get("q",[""])[0] or "").strip()
                if not q: return self.send_json([])
                like=f"%{q}%"
                result=[]
                for r in rows("""SELECT DISTINCT p.person_id AS id,p.preferred_name_en AS title,p.preferred_name_fa AS subtitle,'person' AS kind
                                 FROM persons p LEFT JOIN person_names pn ON pn.person_id=p.person_id
                                 WHERE p.preferred_name_en LIKE ? OR p.preferred_name_fa LIKE ? OR pn.name_text LIKE ? LIMIT 30""",(like,like,like)):
                    result.append(r)
                for r in rows("SELECT estate_id AS id,preferred_name_en AS title,preferred_name_fa AS subtitle,'estate' AS kind FROM estates WHERE preferred_name_en LIKE ? OR preferred_name_fa LIKE ? LIMIT 15",(like,like)):
                    result.append(r)
                for r in rows("SELECT organization_id AS id,preferred_name_en AS title,preferred_name_fa AS subtitle,'organization' AS kind FROM organizations WHERE preferred_name_en LIKE ? OR preferred_name_fa LIKE ? LIMIT 15",(like,like)):
                    result.append(r)
                for r in rows("SELECT event_id AS id,title,date_text AS subtitle,'event' AS kind FROM events WHERE title LIKE ? OR description LIKE ? LIMIT 15",(like,like)):
                    result.append(r)
                return self.send_json(result[:60])
            if path == "/api/people":
                q = (qs.get("q", [""])[0] or "").strip()
                branch = (qs.get("branch", [""])[0] or "").strip()
                limit = min(int(qs.get("limit", ["200"])[0]), 500)
                sql = """SELECT p.person_id,p.preferred_name_en,p.preferred_name_fa,p.sex,p.birth_date_text,p.death_date_text,
                                p.branch,p.summary,p.verification_status,pr.dossier_level,pr.reconciliation_status,
                                GROUP_CONCAT(DISTINCT pn.name_text) AS aliases
                         FROM persons p
                         LEFT JOIN person_names pn ON pn.person_id=p.person_id
                         LEFT JOIN person_reconciliation pr ON pr.person_id=p.person_id
                         WHERE 1=1"""
                params = []
                if q:
                    like = f"%{q}%"
                    sql += " AND (p.preferred_name_en LIKE ? OR p.preferred_name_fa LIKE ? OR pn.name_text LIKE ? OR p.summary LIKE ? OR p.branch LIKE ?)"
                    params += [like] * 5
                if branch:
                    sql += " AND COALESCE(p.branch,'Unclassified')=?"
                    params.append(branch)
                sql += " GROUP BY p.person_id ORDER BY p.preferred_name_en LIMIT ?"
                params.append(limit)
                return self.send_json(rows(sql, tuple(params)))
            if path.startswith("/api/person/") and path.endswith("/graph"):
                pid = path.split("/")[3]
                depth = int(qs.get("depth", ["2"])[0])
                return self.send_json(graph_for(pid, depth))
            if path.startswith("/api/person/"):
                pid = path.split("/")[3]
                payload = person_summary(pid)
                return self.send_json(payload or {"error": "Person not found"}, 200 if payload else 404)
            if path == "/":
                return self.send_file(STATIC_DIR / "index.html")
            if path.startswith("/static/"):
                rel = Path(path.removeprefix("/static/"))
                if ".." in rel.parts:
                    return self.send_error(403)
                return self.send_file(STATIC_DIR / rel)
            return self.send_file(STATIC_DIR / "index.html")
        except Exception as exc:
            self.send_json({"error": str(exc)}, 500)

    def log_message(self, fmt, *args):
        print(f"[Explorer] {self.address_string()} - {fmt % args}")


def main():
    if not DB_PATH.exists():
        print("\nERROR: archive.sqlite was not found next to the explorer folder.")
        print(f"Expected: {DB_PATH}\n")
        input("Press Enter to close...")
        raise SystemExit(1)
    server = ThreadingHTTPServer((HOST, PORT), Handler)
    url = f"http://{HOST}:{PORT}"
    print("\nGharagozloo Historical Archive Explorer v0.2")
    print(f"Database: {DB_PATH}")
    print(f"Open: {url}")
    print("Press Ctrl+C to stop.\n")
    threading.Timer(0.8, lambda: webbrowser.open(url)).start()
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        pass
    finally:
        server.server_close()


if __name__ == "__main__":
    main()
