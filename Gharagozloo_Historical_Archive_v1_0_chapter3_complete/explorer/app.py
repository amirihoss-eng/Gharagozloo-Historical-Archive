from __future__ import annotations

import json
import base64
import binascii
import mimetypes
import os
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
PORT = int(os.environ.get("PORT", "8765"))
HOST = "0.0.0.0" if "PORT" in os.environ else "127.0.0.1"
CURATOR_ENABLED = "PORT" not in os.environ and os.environ.get("CURATOR_MODE", "1") != "0"
PHOTO_DIR = STATIC_DIR / "artifacts" / "photos"
MAX_UPLOAD_BYTES = 15 * 1024 * 1024
ALLOWED_IMAGES = {"image/jpeg": ".jpg", "image/png": ".png", "image/webp": ".webp"}


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


def json_row(con: sqlite3.Connection, query: str, params: tuple) -> dict | None:
    value = con.execute(query, params).fetchone()
    return dict(value) if value else None


def entity_key(*parts: str) -> str:
    return "|".join(parts)


def record_revision(con, action, entity_type, key, before=None, after=None,
                    reverted_revision_id=None, notes=None) -> int:
    cur = con.execute(
        """INSERT INTO edit_revisions
           (changed_at,provenance,action,entity_type,entity_key,before_json,after_json,reverted_revision_id,notes)
           VALUES(datetime('now'),'Manual Edit',?,?,?,?,?,?,?)""",
        (action, entity_type, key,
         json.dumps(before, ensure_ascii=False) if before is not None else None,
         json.dumps(after, ensure_ascii=False) if after is not None else None,
         reverted_revision_id, notes),
    )
    return cur.lastrowid


def mark_manual(con, entity_type, key, revision_id):
    con.execute(
        "INSERT INTO manual_edit_entities(entity_type,entity_key,created_revision_id) VALUES(?,?,?)",
        (entity_type, key, revision_id),
    )


def is_manual(con, entity_type, key) -> bool:
    return con.execute(
        "SELECT 1 FROM manual_edit_entities WHERE entity_type=? AND entity_key=? AND active=1",
        (entity_type, key),
    ).fetchone() is not None


def next_artifact_id(con) -> str:
    # Include retired Manual Edit IDs so an audit identity is never reused.
    maximum = con.execute(
        """SELECT MAX(number) FROM (
               SELECT CAST(SUBSTR(artifact_id,2) AS INTEGER) AS number
                 FROM artifacts WHERE artifact_id GLOB 'A[0-9]*'
               UNION ALL
               SELECT CAST(SUBSTR(entity_key,2) AS INTEGER) AS number
                 FROM manual_edit_entities
                WHERE entity_type='artifact' AND entity_key GLOB 'A[0-9]*'
           )"""
    ).fetchone()[0] or 0
    return f"A{maximum + 1:04d}"


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
    p["gallery"] = rows(
        """SELECT a.artifact_id,a.title,a.description,a.file_reference,a.notes,
                  a.printed_page,a.confidence,s.source_id,s.short_title,s.full_title,
                  ap.role,agm.verification_class,agm.display_status,
                  (SELECT GROUP_CONCAT(linked.preferred_name_en, ', ')
                     FROM artifact_persons ap2
                     JOIN persons linked ON linked.person_id=ap2.person_id
                    WHERE ap2.artifact_id=a.artifact_id) AS person_names,
                  CASE WHEN ppp.artifact_id IS NOT NULL THEN 1 ELSE 0 END AS is_primary
           FROM artifact_persons ap
           JOIN artifacts a ON a.artifact_id=ap.artifact_id
           JOIN sources s ON s.source_id=a.source_id
           LEFT JOIN artifact_gallery_metadata agm ON agm.artifact_id=a.artifact_id
           LEFT JOIN person_primary_portraits ppp
                  ON ppp.person_id=ap.person_id AND ppp.artifact_id=a.artifact_id
           WHERE ap.person_id=? AND a.artifact_type IN ('photograph','portrait','image')
           ORDER BY is_primary DESC, a.artifact_id""",
        (person_id,),
    ) if row("SELECT name FROM sqlite_master WHERE type='table' AND name='artifact_gallery_metadata'") else []
    p["primary_portrait"] = next((x for x in p["gallery"] if x.get("is_primary")), None)
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

    def read_json(self):
        length = int(self.headers.get("Content-Length", "0"))
        if length <= 0 or length > MAX_UPLOAD_BYTES * 2:
            raise ValueError("Request body is empty or too large")
        return json.loads(self.rfile.read(length).decode("utf-8"))

    def require_curator(self):
        if not CURATOR_ENABLED:
            self.send_json({"error": "Not found"}, 404)
            return False
        if not row("SELECT name FROM sqlite_master WHERE type='table' AND name='edit_revisions'"):
            self.send_json({"error": "Curator audit migration 0053 has not been applied"}, 503)
            return False
        return True

    def do_GET(self):
        try:
            parsed = urlparse(self.path)
            path = parsed.path
            qs = parse_qs(parsed.query)
            if path == "/api/health":
                return self.send_json({"ok": True, "database": str(DB_PATH), "version": "0.6.11-family-graph-edge-filter"})
            if path == "/api/capabilities":
                return self.send_json({"curator_mode": CURATOR_ENABLED})
            if path == "/api/curator/photos":
                if not self.require_curator(): return
                data = rows(
                    """SELECT a.artifact_id,a.title,a.description,a.file_reference,a.notes,a.source_id,
                              agm.verification_class,agm.display_status,
                              GROUP_CONCAT(DISTINCT p.person_id) person_ids,
                              GROUP_CONCAT(DISTINCT p.preferred_name_en) person_names,
                              CASE WHEN mee.entity_key IS NULL THEN 0 ELSE 1 END manual_artifact
                       FROM artifacts a
                       JOIN artifact_gallery_metadata agm ON agm.artifact_id=a.artifact_id
                       LEFT JOIN artifact_persons ap ON ap.artifact_id=a.artifact_id
                       LEFT JOIN persons p ON p.person_id=ap.person_id
                       LEFT JOIN manual_edit_entities mee ON mee.entity_type='artifact'
                            AND mee.entity_key=a.artifact_id AND mee.active=1
                       WHERE a.artifact_type IN ('photograph','portrait','image')
                       GROUP BY a.artifact_id ORDER BY a.artifact_id DESC"""
                )
                for photo in data:
                    photo["links"] = rows(
                        """SELECT ap.person_id,p.preferred_name_en,ap.role,ap.notes,
                                  CASE WHEN mee.entity_key IS NULL THEN 0 ELSE 1 END manual_link,
                                  CASE WHEN ppp.artifact_id IS NULL THEN 0 ELSE 1 END is_primary
                           FROM artifact_persons ap JOIN persons p ON p.person_id=ap.person_id
                           LEFT JOIN manual_edit_entities mee ON mee.entity_type='artifact_person'
                                AND mee.entity_key=(ap.artifact_id||'|'||ap.person_id||'|'||ap.role) AND mee.active=1
                           LEFT JOIN person_primary_portraits ppp ON ppp.person_id=ap.person_id AND ppp.artifact_id=ap.artifact_id
                           WHERE ap.artifact_id=? ORDER BY p.preferred_name_en""", (photo["artifact_id"],))
                return self.send_json({"photos": data, "people": rows(
                    "SELECT person_id,preferred_name_en,preferred_name_fa FROM persons WHERE verification_status NOT IN ('merged_duplicate','superseded') ORDER BY preferred_name_en"
                ), "sources": rows("SELECT source_id,short_title FROM sources ORDER BY short_title")})
            if path == "/api/curator/revisions":
                if not self.require_curator(): return
                return self.send_json(rows(
                    """SELECT r.* FROM edit_revisions r
                       WHERE r.provenance='Manual Edit' AND r.action='remove'
                         AND NOT EXISTS (SELECT 1 FROM edit_revisions x WHERE x.reverted_revision_id=r.revision_id)
                       ORDER BY r.revision_id DESC LIMIT 50"""))
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
                                        COALESCE(pr.dossier_level,'') AS dossier_level,
                                        pp.artifact_id AS primary_artifact_id,
                                        a.file_reference AS primary_file_reference
                                 FROM persons p
                                 LEFT JOIN person_reconciliation pr ON pr.person_id=p.person_id
                                 LEFT JOIN person_primary_portraits pp ON pp.person_id=p.person_id
                                 LEFT JOIN artifacts a ON a.artifact_id=pp.artifact_id
                                 WHERE p.verification_status NOT IN ('merged_duplicate','superseded')
                                 ORDER BY p.preferred_name_en""")
                rels = rows("""SELECT relationship_id,person1_id,person2_id,relationship_type,
                                      verification_status,notes
                               FROM relationships
                               WHERE verification_status NOT IN ('superseded')
                                 AND relationship_type IN (
                                     'parent_of','father_of','spouse_of',
                                     'ancestral_hypothesis'
                                 )
                               ORDER BY relationship_id""")

                # UI-only historical context node. This is intentionally NOT a person record
                # and does not assert a fictional common ancestor.
                people.append({
                    "person_id": "CTX_GHARAGOZLOO",
                    "preferred_name_en": "Gharagozloo — common tribal ancestry",
                    "preferred_name_fa": "قراگوزلو — نیای مشترک ایلی",
                    "branch": "Historical context",
                    "birth_date_text": None,
                    "death_date_text": None,
                    "summary": (
                        "Hajilou and Ashiqloo are documented as Gharagozloo branches, "
                        "but the specific named common ancestor linking the two trunks "
                        "is not established in the sources currently held by the archive."
                    ),
                    "verification_status": "context",
                    "dossier_level": "",
                    "node_type": "context",
                })
                rels.extend([
                    {
                        "relationship_id": "CTX001",
                        "person1_id": "CTX_GHARAGOZLOO",
                        "person2_id": "P0179",
                        "relationship_type": "ancestral_context",
                        "verification_status": "context",
                        "notes": "Visual context connection to the Hajilou family-tradition origin node; not a parent-child assertion."
                    },
                    {
                        "relationship_id": "CTX002",
                        "person1_id": "CTX_GHARAGOZLOO",
                        "person2_id": "P0070",
                        "relationship_type": "ancestral_context",
                        "verification_status": "context",
                        "notes": "Visual context connection to the extended Ashiqloo historical hypothesis path; not a parent-child assertion."
                    },
                ])

                branches = rows("""SELECT COALESCE(branch,'Unclassified') AS branch,COUNT(*) AS count
                                   FROM persons
                                   WHERE verification_status NOT IN ('merged_duplicate','superseded')
                                   GROUP BY COALESCE(branch,'Unclassified')
                                   ORDER BY count DESC,branch""")
                lineage_roots = [
                    {"person_id": "CTX_GHARAGOZLOO", "label": "Gharagozloo — combined historical ancestry", "branch": "Historical context"},
                    {"person_id": "P0179", "label": "Hajilou — Qara Mohammad family-tradition origin", "branch": "Hajilou"},
                    {"person_id": "P0070", "label": "Ashiqloo — historical trunk", "branch": "Ashiqloo"},
                ]
                return self.send_json({"nodes": people, "edges": rels, "branches": branches,
                                       "default_root": "CTX_GHARAGOZLOO", "lineage_roots": lineage_roots})

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
            if path == "/api/gallery":
                has_meta = row("SELECT name FROM sqlite_master WHERE type='table' AND name='artifact_gallery_metadata'")
                if not has_meta:
                    return self.send_json([])
                data = rows(
                    """SELECT a.artifact_id,a.title,a.description,a.file_reference,a.notes,
                              a.printed_page,a.confidence,s.source_id,s.short_title,s.full_title,
                              agm.verification_class,agm.display_status,
                              GROUP_CONCAT(DISTINCT p.person_id) AS person_ids,
                              GROUP_CONCAT(DISTINCT p.preferred_name_en) AS person_names
                       FROM artifacts a
                       JOIN sources s ON s.source_id=a.source_id
                       JOIN artifact_gallery_metadata agm ON agm.artifact_id=a.artifact_id
                       LEFT JOIN artifact_persons ap ON ap.artifact_id=a.artifact_id
                       LEFT JOIN persons p ON p.person_id=ap.person_id
                       WHERE a.artifact_type IN ('photograph','portrait','image')
                         AND COALESCE(agm.display_status,'visible')='visible'
                       GROUP BY a.artifact_id
                       ORDER BY a.artifact_id DESC"""
                )
                return self.send_json(data)

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

    def do_POST(self):
        try:
            path = urlparse(self.path).path
            if not path.startswith("/api/curator/"):
                return self.send_json({"error": "Not found"}, 404)
            if not self.require_curator():
                return
            payload = self.read_json()
            if path == "/api/curator/photos/upload":
                return self.curator_upload(payload)
            if path == "/api/curator/photos/link":
                return self.curator_link(payload)
            if path == "/api/curator/photos/metadata":
                return self.curator_metadata(payload)
            if path == "/api/curator/photos/primary":
                return self.curator_primary(payload)
            if path == "/api/curator/photos/remove-link":
                return self.curator_remove_link(payload)
            if path == "/api/curator/photos/remove-artifact":
                return self.curator_remove_artifact(payload)
            if path == "/api/curator/revert":
                return self.curator_revert(payload)
            return self.send_json({"error": "Not found"}, 404)
        except (ValueError, KeyError, json.JSONDecodeError, binascii.Error) as exc:
            self.send_json({"error": str(exc)}, 400)
        except sqlite3.IntegrityError as exc:
            self.send_json({"error": f"Database constraint rejected the edit: {exc}"}, 409)
        except Exception as exc:
            self.send_json({"error": str(exc)}, 500)

    def curator_upload(self, p):
        mime = p.get("mime_type", "")
        if mime not in ALLOWED_IMAGES: raise ValueError("Only JPEG, PNG, and WebP images are accepted")
        raw = base64.b64decode(p["data_base64"], validate=True)
        if not raw or len(raw) > MAX_UPLOAD_BYTES: raise ValueError("Image must be between 1 byte and 15 MB")
        title = str(p.get("title", "")).strip()
        if not title: raise ValueError("A title or caption is required")
        people = list(dict.fromkeys(p.get("person_ids") or []))
        with db() as con:
            aid = next_artifact_id(con)
            source_id = p.get("source_id") or "U0001"
            if not con.execute("SELECT 1 FROM sources WHERE source_id=?", (source_id,)).fetchone():
                raise ValueError("Selected source does not exist")
            for pid in people:
                if not con.execute("SELECT 1 FROM persons WHERE person_id=?", (pid,)).fetchone():
                    raise ValueError(f"Person does not exist: {pid}")
            filename = aid + ALLOWED_IMAGES[mime]
            artifact = {"artifact_id": aid, "source_id": source_id, "artifact_type": "photograph",
                        "title": title, "description": str(p.get("description", "")).strip() or None,
                        "transcription_status": "not_applicable", "confidence": "confirmed",
                        "file_reference": filename, "notes": str(p.get("notes", "")).strip() or None}
            con.execute("""INSERT INTO artifacts(artifact_id,source_id,artifact_type,title,description,
                         transcription_status,confidence,file_reference,notes) VALUES
                         (:artifact_id,:source_id,:artifact_type,:title,:description,:transcription_status,
                          :confidence,:file_reference,:notes)""", artifact)
            verification = p.get("verification_class", "unresolved")
            con.execute("INSERT INTO artifact_gallery_metadata VALUES(?,?,?,?)",
                        (aid, verification, "visible", "Added through Local Curator Mode"))
            rid = record_revision(con, "create", "artifact", aid, after=artifact)
            mark_manual(con, "artifact", aid, rid)
            for pid in people:
                link = {"artifact_id": aid, "person_id": pid, "role": "subject", "notes": "Linked through Local Curator Mode"}
                con.execute("INSERT INTO artifact_persons VALUES(:artifact_id,:person_id,:role,:notes)", link)
                lrid = record_revision(con, "create", "artifact_person", entity_key(aid,pid,"subject"), after=link)
                mark_manual(con, "artifact_person", entity_key(aid,pid,"subject"), lrid)
            primary = p.get("primary_person_id")
            if primary:
                if primary not in people: raise ValueError("Primary portrait person must also be linked")
                self.set_primary(con, primary, aid)
            PHOTO_DIR.mkdir(parents=True, exist_ok=True)
            (PHOTO_DIR / filename).write_bytes(raw)
        return self.send_json({"ok": True, "artifact_id": aid}, 201)

    def curator_link(self, p):
        aid, pid = p["artifact_id"], p["person_id"]
        role = p.get("role") or "subject"; key = entity_key(aid,pid,role)
        link = {"artifact_id":aid,"person_id":pid,"role":role,"notes":str(p.get("notes","")).strip() or None}
        with db() as con:
            con.execute("INSERT INTO artifact_persons VALUES(:artifact_id,:person_id,:role,:notes)", link)
            rid=record_revision(con,"create","artifact_person",key,after=link); mark_manual(con,"artifact_person",key,rid)
        return self.send_json({"ok":True})

    def curator_metadata(self, p):
        aid=p["artifact_id"]
        allowed=("title","description","notes","source_id")
        with db() as con:
            before=json_row(con,"SELECT artifact_id,title,description,notes,source_id FROM artifacts WHERE artifact_id=?",(aid,))
            if not before: raise ValueError("Photo does not exist")
            after={**before, **{k:(str(p[k]).strip() or None) for k in allowed if k in p}}
            if not after.get("title"): raise ValueError("Title cannot be empty")
            if not after.get("source_id") or not con.execute("SELECT 1 FROM sources WHERE source_id=?",(after["source_id"],)).fetchone():
                raise ValueError("Selected source does not exist")
            con.execute("UPDATE artifacts SET title=?,description=?,notes=?,source_id=? WHERE artifact_id=?",
                        (after["title"],after["description"],after["notes"],after["source_id"],aid))
            record_revision(con,"update","artifact_metadata",aid,before,after)
        return self.send_json({"ok":True})

    def set_primary(self, con, pid, aid):
        if not con.execute("SELECT 1 FROM artifact_persons WHERE artifact_id=? AND person_id=?",(aid,pid)).fetchone():
            raise ValueError("The photo must be linked to the person before it can be primary")
        before=json_row(con,"SELECT * FROM person_primary_portraits WHERE person_id=?",(pid,))
        after={"person_id":pid,"artifact_id":aid,"selection_basis":"Selected through Local Curator Mode",
               "selected_by":"Manual Edit","notes":None}
        con.execute("""INSERT INTO person_primary_portraits VALUES(:person_id,:artifact_id,:selection_basis,:selected_by,:notes)
                     ON CONFLICT(person_id) DO UPDATE SET artifact_id=excluded.artifact_id,
                     selection_basis=excluded.selection_basis,selected_by=excluded.selected_by,notes=excluded.notes""",after)
        record_revision(con,"update","primary_portrait",pid,before,after)

    def curator_primary(self,p):
        with db() as con: self.set_primary(con,p["person_id"],p["artifact_id"])
        return self.send_json({"ok":True})

    def curator_remove_link(self,p):
        aid,pid,role=p["artifact_id"],p["person_id"],p.get("role") or "subject"; key=entity_key(aid,pid,role)
        with db() as con:
            if not is_manual(con,"artifact_person",key): raise ValueError("Only links created by Manual Edit may be removed")
            before=json_row(con,"SELECT * FROM artifact_persons WHERE artifact_id=? AND person_id=? AND role=?",(aid,pid,role))
            if not before: raise ValueError("Link does not exist")
            if con.execute("SELECT 1 FROM person_primary_portraits WHERE person_id=? AND artifact_id=?",(pid,aid)).fetchone():
                raise ValueError("Choose another primary portrait before removing this link")
            con.execute("DELETE FROM artifact_persons WHERE artifact_id=? AND person_id=? AND role=?",(aid,pid,role))
            record_revision(con,"remove","artifact_person",key,before=before)
            con.execute("UPDATE manual_edit_entities SET active=0 WHERE entity_type='artifact_person' AND entity_key=?",(key,))
        return self.send_json({"ok":True})

    def curator_remove_artifact(self,p):
        aid=p["artifact_id"]
        with db() as con:
            if not is_manual(con,"artifact",aid): raise ValueError("Only artifacts created by Manual Edit may be removed")
            artifact=json_row(con,"SELECT * FROM artifacts WHERE artifact_id=?",(aid,))
            if not artifact: raise ValueError("Photo does not exist")
            if con.execute("SELECT 1 FROM person_primary_portraits WHERE artifact_id=?",(aid,)).fetchone():
                raise ValueError("Choose another primary portrait before removing this artifact")
            snapshot={"artifact":artifact,"gallery":json_row(con,"SELECT * FROM artifact_gallery_metadata WHERE artifact_id=?",(aid,)),
                      "links":[dict(x) for x in con.execute("SELECT * FROM artifact_persons WHERE artifact_id=?",(aid,))],
                      "primary":[dict(x) for x in con.execute("SELECT * FROM person_primary_portraits WHERE artifact_id=?",(aid,))]}
            con.execute("DELETE FROM person_primary_portraits WHERE artifact_id=?",(aid,))
            con.execute("DELETE FROM artifacts WHERE artifact_id=?",(aid,))
            record_revision(con,"remove","artifact",aid,before=snapshot)
            con.execute("UPDATE manual_edit_entities SET active=0 WHERE entity_type='artifact' AND entity_key=?",(aid,))
            con.execute("UPDATE manual_edit_entities SET active=0 WHERE entity_type='artifact_person' AND entity_key LIKE ?",(aid+"|%",))
        return self.send_json({"ok":True,"revert_available":True})

    def curator_revert(self,p):
        revision_id=int(p["revision_id"])
        with db() as con:
            rev=json_row(con,"SELECT * FROM edit_revisions WHERE revision_id=?",(revision_id,))
            if not rev or rev["provenance"]!="Manual Edit" or rev["action"]!="remove":
                raise ValueError("Only a Manual Edit removal revision can be reverted here")
            if con.execute("SELECT 1 FROM edit_revisions WHERE reverted_revision_id=?",(revision_id,)).fetchone():
                raise ValueError("This revision has already been reverted")
            before=json.loads(rev["before_json"])
            if rev["entity_type"]=="artifact_person":
                con.execute("INSERT INTO artifact_persons VALUES(:artifact_id,:person_id,:role,:notes)",before)
                con.execute("UPDATE manual_edit_entities SET active=1 WHERE entity_type='artifact_person' AND entity_key=?",(rev["entity_key"],))
            elif rev["entity_type"]=="artifact":
                a=before["artifact"]
                cols=",".join(a); binds=",".join(":"+x for x in a)
                con.execute(f"INSERT INTO artifacts({cols}) VALUES({binds})",a)
                g=before.get("gallery")
                if g: con.execute("INSERT INTO artifact_gallery_metadata VALUES(:artifact_id,:verification_class,:display_status,:selection_notes)",g)
                for link in before.get("links",[]): con.execute("INSERT INTO artifact_persons VALUES(:artifact_id,:person_id,:role,:notes)",link)
                for primary in before.get("primary",[]): con.execute("INSERT INTO person_primary_portraits VALUES(:person_id,:artifact_id,:selection_basis,:selected_by,:notes)",primary)
                con.execute("UPDATE manual_edit_entities SET active=1 WHERE entity_type='artifact' AND entity_key=?",(rev["entity_key"],))
                con.execute("UPDATE manual_edit_entities SET active=1 WHERE entity_type='artifact_person' AND entity_key LIKE ?",(rev["entity_key"]+"|%",))
            else: raise ValueError("Unsupported removal revision")
            record_revision(con,"revert",rev["entity_type"],rev["entity_key"],after=before,reverted_revision_id=revision_id)
        return self.send_json({"ok":True})

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
    if "PORT" not in os.environ:
        threading.Timer(0.8, lambda: webbrowser.open(url)).start()
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        pass
    finally:
        server.server_close()


if __name__ == "__main__":
    main()
