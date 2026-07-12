# Gharagozloo Historical Archive Explorer v0.1

A local, read-only browser application for exploring `archive.sqlite`.

## Windows launch

1. Confirm the `explorer` folder is in the repository root, beside `archive.sqlite`.
2. Double-click `explorer\launch_explorer.bat`.
3. Your default browser opens at `http://127.0.0.1:8765`.
4. Leave the command window open while using the Explorer.
5. Close it or press `Ctrl+C` to stop the application.

No external Python packages are required. The application uses Python's standard library and does not modify the database.

## Included in v0.1

- professional archive dashboard;
- live archive statistics;
- searchable and branch-filtered people index;
- comprehensive person pages;
- names, titles, roles and offices;
- family and social relationships;
- event and role timeline;
- interactive relationship graph;
- person-level claims, citations and evidence profiles.

## Architecture

The application reads the canonical database directly from:

```text
repository root/archive.sqlite
```

The Explorer is intentionally read-only. Historical changes remain migration-driven.
