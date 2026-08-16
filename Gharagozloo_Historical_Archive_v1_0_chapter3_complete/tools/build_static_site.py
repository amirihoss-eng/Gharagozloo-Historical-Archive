#!/usr/bin/env python3
"""Build the read-only Cloudflare Pages edition from the canonical archive."""

from __future__ import annotations

import json
import os
import shutil
import socket
try:
    import sqlite3
except ModuleNotFoundError:  # Cloudflare's Python image omits the optional module.
    import pysqlite3 as sqlite3
import subprocess
import sys
import time
from datetime import datetime, timezone
from pathlib import Path
from urllib.parse import quote
from urllib.request import urlopen

ROOT = Path(__file__).resolve().parents[1]
DB = ROOT / "archive.sqlite"
STATIC = ROOT / "explorer" / "static"
DIST = ROOT / "cloudflare_dist"


def write_json(relative: str, data) -> None:
    target = DIST / "data" / relative
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(
        json.dumps(data, ensure_ascii=False, separators=(",", ":")),
        encoding="utf-8",
    )


def free_port() -> int:
    with socket.socket() as sock:
        sock.bind(("127.0.0.1", 0))
        return sock.getsockname()[1]


def fetch(base: str, path: str):
    with urlopen(base + path, timeout=30) as response:
        return json.load(response)


def search_index() -> list[dict]:
    con = sqlite3.connect(DB)
    con.row_factory = sqlite3.Row
    output = []
    people = con.execute(
        """SELECT p.person_id AS id,p.preferred_name_en AS title,
                  p.preferred_name_fa AS subtitle,
                  GROUP_CONCAT(DISTINCT pn.name_text) AS aliases,
                  p.summary,p.branch
           FROM persons p LEFT JOIN person_names pn ON pn.person_id=p.person_id
           GROUP BY p.person_id"""
    )
    for row in people:
        item = dict(row)
        output.append({
            "id": item["id"], "title": item["title"],
            "subtitle": item["subtitle"], "kind": "person",
            "search_text": " ".join(str(item.get(k) or "") for k in ("title", "subtitle", "aliases", "summary", "branch")),
        })
    for table, id_column, kind, extra in (
        ("estates", "estate_id", "estate", "description"),
        ("organizations", "organization_id", "organization", "description"),
    ):
        for row in con.execute(f"SELECT {id_column} AS id,preferred_name_en AS title,preferred_name_fa AS subtitle,{extra} AS extra FROM {table}"):
            item = dict(row)
            output.append({"id": item["id"], "title": item["title"], "subtitle": item["subtitle"], "kind": kind,
                           "search_text": " ".join(str(item.get(k) or "") for k in ("title", "subtitle", "extra"))})
    for row in con.execute("SELECT event_id AS id,title,date_text AS subtitle,description FROM events"):
        item = dict(row)
        output.append({"id": item["id"], "title": item["title"], "subtitle": item["subtitle"], "kind": "timeline",
                       "search_text": " ".join(str(item.get(k) or "") for k in ("title", "subtitle", "description"))})
    con.close()
    return output


def validate_database() -> None:
    con = sqlite3.connect(DB)
    integrity = con.execute("PRAGMA integrity_check").fetchone()[0]
    foreign_keys = con.execute("PRAGMA foreign_key_check").fetchall()
    con.close()
    if integrity != "ok" or foreign_keys:
        raise RuntimeError(f"Database validation failed: integrity={integrity}, foreign_keys={len(foreign_keys)}")


def main() -> int:
    validate_database()
    if DIST.exists():
        shutil.rmtree(DIST)
    shutil.copytree(STATIC, DIST / "static")
    shutil.copy2(STATIC / "index.html", DIST / "index.html")
    shutil.copy2(STATIC / "index.html", DIST / "404.html")
    (DIST / "static" / "archive-mode.js").write_text("window.ARCHIVE_STATIC_DATA=true;\n", encoding="utf-8")

    port = free_port()
    env = os.environ.copy()
    env["PORT"] = str(port)
    process = subprocess.Popen(
        [sys.executable, str(ROOT / "explorer" / "app.py")],
        cwd=ROOT, env=env, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE,
        text=True,
    )
    base = f"http://127.0.0.1:{port}"
    try:
        for _ in range(100):
            try:
                fetch(base, "/api/health")
                break
            except Exception:
                if process.poll() is not None:
                    details = process.stderr.read().strip() if process.stderr else ""
                    raise RuntimeError(
                        "The temporary export server stopped unexpectedly"
                        + (f":\n{details}" if details else "")
                    )
                time.sleep(0.1)
        else:
            raise RuntimeError("Timed out starting the temporary export server")

        endpoints = {
            "dashboard.json": "/api/dashboard",
            "graph_core.json": "/api/graph/core",
            "timeline.json": "/api/timeline",
            "gallery.json": "/api/gallery",
            "people.json": "/api/people?limit=500",
            "estates.json": "/api/estates",
            "organizations.json": "/api/organizations",
            "titles.json": "/api/titles",
            "research.json": "/api/research",
        }
        exported = {}
        for filename, endpoint in endpoints.items():
            exported[filename] = fetch(base, endpoint)
            write_json(filename, exported[filename])

        for person in exported["people.json"]:
            pid = person["person_id"]
            write_json(f"person/{pid}.json", fetch(base, f"/api/person/{quote(pid)}"))
            write_json(f"person_graph/{pid}.json", fetch(base, f"/api/person/{quote(pid)}/graph?depth=3"))
        for estate in exported["estates.json"]:
            eid = estate["estate_id"]
            write_json(f"estate/{eid}.json", fetch(base, f"/api/estate/{quote(eid)}"))
        for organization in exported["organizations.json"]:
            oid = organization["organization_id"]
            write_json(f"organization/{oid}.json", fetch(base, f"/api/organization/{quote(oid)}"))
        for title in exported["titles.json"]:
            tid = title["title_id"]
            write_json(f"title/{tid}.json", fetch(base, f"/api/title/{quote(tid)}"))
    finally:
        process.terminate()
        try:
            process.wait(timeout=5)
        except subprocess.TimeoutExpired:
            process.kill()

    write_json("search_index.json", search_index())
    write_json("build.json", {
        "generated_at": datetime.now(timezone.utc).isoformat(),
        "people": len(exported["people.json"]),
        "events": len(exported["timeline.json"]["events"]),
        "gallery": len(exported["gallery.json"]),
    })
    (DIST / "_headers").write_text(
        "/\n  Cache-Control: no-cache\n/data/*\n  Cache-Control: public, max-age=300\n/static/*\n  Cache-Control: public, max-age=3600\n",
        encoding="utf-8",
    )
    print(f"Static archive built at {DIST}")
    print(f"People: {len(exported['people.json'])} | Events: {len(exported['timeline.json']['events'])} | Gallery: {len(exported['gallery.json'])}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
