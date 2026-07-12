#!/usr/bin/env python3
r"""Safely install and apply a Gharagozloo archive patch ZIP.

Run this command from the repository's archive root, the folder containing:
    archive.sqlite
    migrations/
    tools/

Example:
    py tools\apply_patch.py "C:\Users\Hossein\Downloads\Gharagozloo_Foundational_Dossiers_Patch_v1_3.zip"

What the tool does:
1. Validates the repository and patch ZIP.
2. Extracts the patch to a temporary directory.
3. Copies patch files into the repository without silently overwriting conflicts.
4. Applies every new SQL migration in numerical order.
5. Runs archive validation.
6. Regenerates CSV exports.
7. Leaves all changes ready for review in GitHub Desktop.

The tool does not commit or push anything to GitHub.
"""
from __future__ import annotations

import argparse
import filecmp
import shutil
import subprocess
import sys
import tempfile
import zipfile
from pathlib import Path, PurePosixPath

ROOT = Path(__file__).resolve().parents[1]
REQUIRED_REPO_ITEMS = ("archive.sqlite", "migrations", "tools")
COPYABLE_TOP_LEVEL = {
    "migrations",
    "imports",
    "dossiers",
    "docs",
    "sources",
    "research_journal",
    "evidence",
}
IGNORED_TOP_LEVEL_FILES = {
    "README_APPLY_PATCH.md",
    "VERIFICATION.txt",
    "validation_report.json",
}
MIGRATION_PATTERN = "[0-9][0-9][0-9][0-9]_*.sql"


class PatchError(RuntimeError):
    """Raised for a safe, user-facing patch installation failure."""


def run_command(args: list[str], description: str) -> None:
    print(f"\n== {description} ==")
    completed = subprocess.run(args, cwd=ROOT)
    if completed.returncode != 0:
        raise PatchError(f"{description} failed with exit code {completed.returncode}.")


def validate_repo() -> None:
    missing = [name for name in REQUIRED_REPO_ITEMS if not (ROOT / name).exists()]
    if missing:
        raise PatchError(
            "Run this tool from the archive repository root. Missing: "
            + ", ".join(missing)
        )
    required_tools = (
        ROOT / "tools" / "apply_migration.py",
        ROOT / "tools" / "validate_archive.py",
        ROOT / "tools" / "export_csv.py",
    )
    missing_tools = [p.name for p in required_tools if not p.exists()]
    if missing_tools:
        raise PatchError("Required repository tools are missing: " + ", ".join(missing_tools))


def safe_extract(zip_path: Path, destination: Path) -> None:
    with zipfile.ZipFile(zip_path) as archive:
        for info in archive.infolist():
            member = PurePosixPath(info.filename)
            if member.is_absolute() or ".." in member.parts:
                raise PatchError(f"Unsafe path in patch ZIP: {info.filename}")
            target = (destination / Path(*member.parts)).resolve()
            if destination.resolve() not in target.parents and target != destination.resolve():
                raise PatchError(f"Unsafe extraction target: {info.filename}")
        archive.extractall(destination)


def unwrap_single_directory(extracted: Path) -> Path:
    """Allow either a ZIP with files at root or one wrapper directory."""
    entries = [p for p in extracted.iterdir() if p.name != "__MACOSX"]
    if len(entries) == 1 and entries[0].is_dir():
        return entries[0]
    return extracted


def files_identical(source: Path, destination: Path) -> bool:
    return destination.exists() and source.stat().st_size == destination.stat().st_size and filecmp.cmp(
        source, destination, shallow=False
    )


def copy_file_safely(source: Path, destination: Path, copied: list[Path], skipped: list[Path]) -> None:
    destination.parent.mkdir(parents=True, exist_ok=True)
    if destination.exists():
        if files_identical(source, destination):
            skipped.append(destination)
            return
        raise PatchError(
            "Patch conflict: the repository already contains a different file at "
            f"{destination.relative_to(ROOT)}. Nothing was overwritten."
        )
    shutil.copy2(source, destination)
    copied.append(destination)


def install_patch_files(patch_root: Path) -> tuple[list[Path], list[Path]]:
    copied: list[Path] = []
    skipped: list[Path] = []

    recognized = False
    for name in sorted(COPYABLE_TOP_LEVEL):
        source_root = patch_root / name
        if not source_root.exists():
            continue
        recognized = True
        if not source_root.is_dir():
            raise PatchError(f"Expected a directory in patch: {name}")
        for source in source_root.rglob("*"):
            if source.is_file():
                relative = source.relative_to(patch_root)
                copy_file_safely(source, ROOT / relative, copied, skipped)

    # Permit patch-level documentation, storing it under imports/patch_notes
    notes_dir = ROOT / "imports" / "patch_notes"
    for source in patch_root.iterdir():
        if source.is_file() and source.name in IGNORED_TOP_LEVEL_FILES:
            recognized = True
            copy_file_safely(source, notes_dir / source.name, copied, skipped)

    if not recognized:
        visible = ", ".join(sorted(p.name for p in patch_root.iterdir()))
        raise PatchError(
            "This does not look like a supported archive patch. "
            f"Top-level items found: {visible or '(none)'}"
        )

    return copied, skipped


def ensure_gitignore() -> bool:
    gitignore = ROOT.parent / ".gitignore"
    # If archive root itself is repository root, use that .gitignore instead.
    if (ROOT / ".git").exists() or not gitignore.exists():
        gitignore = ROOT / ".gitignore"

    line = "backups/"
    existing = gitignore.read_text(encoding="utf-8") if gitignore.exists() else ""
    normalized = {item.strip() for item in existing.splitlines()}
    if line in normalized:
        return False

    prefix = "" if not existing or existing.endswith("\n") else "\n"
    gitignore.write_text(existing + prefix + "\n# Local SQLite migration backups\nbackups/\n", encoding="utf-8")
    print(f"Updated {gitignore.relative_to(ROOT.parent if gitignore.parent == ROOT.parent else ROOT)} to ignore backups/.")
    return True


def find_new_migrations(copied: list[Path]) -> list[Path]:
    migrations = [
        p for p in copied
        if p.parent == ROOT / "migrations" and p.match(MIGRATION_PATTERN)
    ]
    return sorted(migrations, key=lambda p: p.name)


def main() -> int:
    parser = argparse.ArgumentParser(description="Install and apply a Gharagozloo archive patch ZIP.")
    parser.add_argument("patch_zip", type=Path, help="Path to the patch ZIP file.")
    parser.add_argument(
        "--keep-temp",
        action="store_true",
        help="Keep the temporary extracted patch folder for troubleshooting.",
    )
    args = parser.parse_args()

    try:
        validate_repo()
        patch_zip = args.patch_zip.expanduser().resolve()
        if not patch_zip.exists() or not patch_zip.is_file():
            raise PatchError(f"Patch ZIP not found: {patch_zip}")
        if not zipfile.is_zipfile(patch_zip):
            raise PatchError(f"Not a valid ZIP file: {patch_zip}")

        temp_context = tempfile.TemporaryDirectory(prefix="gharagozloo_patch_")
        temp_dir = Path(temp_context.name)
        print(f"Reading patch: {patch_zip.name}")
        safe_extract(patch_zip, temp_dir)
        patch_root = unwrap_single_directory(temp_dir)

        copied, skipped = install_patch_files(patch_root)
        ensure_gitignore()

        print("\n== Patch files installed ==")
        for path in copied:
            print(f"  + {path.relative_to(ROOT)}")
        for path in skipped:
            print(f"  = {path.relative_to(ROOT)} (already identical)")

        migrations = find_new_migrations(copied)
        if not migrations:
            print("\nNo new SQL migration was included. File installation is complete.")
        else:
            for migration in migrations:
                run_command(
                    [sys.executable, str(ROOT / "tools" / "apply_migration.py"), str(migration)],
                    f"Apply {migration.name}",
                )

        run_command(
            [sys.executable, str(ROOT / "tools" / "validate_archive.py")],
            "Validate archive",
        )
        run_command(
            [sys.executable, str(ROOT / "tools" / "export_csv.py")],
            "Regenerate CSV exports",
        )

        print("\nSUCCESS")
        print("The patch was installed, migrations were applied, validation passed, and exports were regenerated.")
        print("Open GitHub Desktop, review the changed files, commit them, and push origin.")

        if args.keep_temp:
            kept = ROOT / "patch_temp_last_run"
            if kept.exists():
                shutil.rmtree(kept)
            shutil.copytree(temp_dir, kept)
            print(f"Temporary extraction retained at: {kept}")
        temp_context.cleanup()
        return 0

    except PatchError as exc:
        print(f"\nERROR: {exc}", file=sys.stderr)
        print("No conflicting repository file was overwritten.", file=sys.stderr)
        return 1
    except Exception as exc:
        print(f"\nUNEXPECTED ERROR: {exc}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
