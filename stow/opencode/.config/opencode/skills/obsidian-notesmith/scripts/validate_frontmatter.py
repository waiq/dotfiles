#!/usr/bin/env python3
"""Strict frontmatter validator for obsidian-notesmith outputs."""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path


COMMON_KEYS = {"title", "aliases", "tags", "created", "updated"}
TYPE_KEYS = {
    "SRC - ": {"source_type", "source_url", "author", "published", "confidence"},
    "LIT - ": {"sources", "confidence"},
    "EVR-SEEDS - ": {"sources", "confidence"},
    "DIGEST - ": {"confidence"},
}


def note_prefix(name: str) -> str | None:
    for prefix in (
        "MOC - ",
        "SRC - ",
        "LIT - ",
        "EVR-SEEDS - ",
        "DIGEST - ",
        "CONSUME - ",
        "PIPELINE - ",
    ):
        if name.startswith(prefix):
            return prefix
    return None


def frontmatter_keys(text: str) -> set[str] | None:
    if not text.startswith("---\n"):
        return None
    end = text.find("\n---\n", 4)
    if end == -1:
        return None
    block = text[4:end]
    keys: set[str] = set()
    for line in block.splitlines():
        if not line.strip() or line.lstrip().startswith("-"):
            continue
        m = re.match(r"^([A-Za-z_][A-Za-z0-9_-]*)\s*:", line)
        if m:
            keys.add(m.group(1))
    return keys


def validate_file(path: Path) -> list[str]:
    text = path.read_text(encoding="utf-8")
    keys = frontmatter_keys(text)
    errors: list[str] = []
    if keys is None:
        return ["missing_or_invalid_frontmatter"]
    missing_common = sorted(COMMON_KEYS - keys)
    if missing_common:
        errors.append("missing_common:" + ",".join(missing_common))
    prefix = note_prefix(path.name)
    if prefix and prefix in TYPE_KEYS:
        missing_type = sorted(TYPE_KEYS[prefix] - keys)
        if missing_type:
            errors.append("missing_type:" + ",".join(missing_type))
    return errors


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--vault", required=True, help="Vault root path")
    parser.add_argument("--topic", required=True, help="Topic title fragment")
    args = parser.parse_args()

    root = Path(args.vault)
    files = sorted(root.glob(f"**/*{args.topic}*.md"))
    files = [p for p in files if note_prefix(p.name)]
    if not files:
        print(f"No topic notes found for: {args.topic}")
        return 2

    failed = 0
    for path in files:
        errs = validate_file(path)
        if errs:
            failed += 1
            print(f"FAIL {path}")
            for err in errs:
                print(f"  - {err}")
        else:
            print(f"OK   {path}")

    if failed:
        print(f"\nFrontmatter validation failed: {failed}/{len(files)} notes.")
        return 1

    print(f"\nFrontmatter validation passed: {len(files)} notes.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
