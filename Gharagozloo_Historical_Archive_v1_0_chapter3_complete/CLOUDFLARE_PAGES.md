# Cloudflare Pages public archive

The public Cloudflare edition is a read-only export of `archive.sqlite`. Local Curator Mode and the Render/Python application remain unchanged.

## Cloudflare build settings

- Production branch: `research/hajilou-figure4-reconstruction`
- Root directory: `Gharagozloo_Historical_Archive_v1_0_chapter3_complete`
- Build command: `python tools/build_static_site.py`
- Build output directory: `cloudflare_dist`

The build starts the existing Python application only inside the build environment, exports all public API responses as JSON, and then stops it. The deployed website contains no writable API and exposes no Curator Mode.

## Local preview

Run the build script, then serve `cloudflare_dist` with any static HTTP server. Do not open `index.html` directly as a file because browser data requests require HTTP.
