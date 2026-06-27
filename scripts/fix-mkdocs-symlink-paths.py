#!/usr/bin/env python3
"""Ajusta links relativos para symlinks em docs/ (dados, evidence, templates)."""

from __future__ import annotations

import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DOCS = ROOT / "docs"

REPLACEMENTS: list[tuple[str, str]] = [
    (r"\.\./\.\./\.\./dados/", "../../dados/"),
    (r"\.\./\.\./\.\./evidence/", "../../evidence/"),
    (r"\.\./docs/experimento/", "../experimento/"),
    (r"\.\./docs/arquitetura/", "../arquitetura/"),
    (r"\.\./\.\./docs/arquitetura/", "../../arquitetura/"),
    (r"context-schema-v1\.json", "context-schema.json"),
    (r"Schema context\.json v1", "Schema do contexto"),
    (r"artifact-docs/dados/", "dados/"),
]

DEPTH2_REPLACEMENTS: list[tuple[str, str]] = [
    (r"\.\./\.\./dados/", "../dados/"),
    (r"\.\./\.\./evidence/", "../evidence/"),
]


def fix_file(path: Path) -> bool:
    text = path.read_text(encoding="utf-8")
    original = text
    for old, new in REPLACEMENTS:
        text = re.sub(old, new, text)
    try:
        rel = path.relative_to(DOCS)
        if len(rel.parts) == 2:
            for old, new in DEPTH2_REPLACEMENTS:
                text = re.sub(old, new, text)
    except ValueError:
        pass
    if text != original:
        path.write_text(text, encoding="utf-8")
        return True
    return False


def main() -> None:
    changed = 0
    for base in [DOCS, ROOT / "evidence", ROOT / "dados", ROOT / "templates"]:
        if not base.is_dir():
            continue
        for path in base.rglob("*.md"):
            if fix_file(path):
                print(path.relative_to(ROOT))
                changed += 1
    print(f"updated {changed} files")


if __name__ == "__main__":
    main()
