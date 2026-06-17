#!/usr/bin/env python3
"""Ajusta links Markdown para alvos dentro de docs/ (MkDocs --strict)."""
from __future__ import annotations

import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
DOCS = ROOT / "docs"

DOC_CHILDREN = (
    "diagrams",
    "evidence",
    "templates",
    "db-reference",
    "adr",
    "legacy-infra",
    "assets",
)


def monografia_href(depth: int) -> str:
    return ("../" * depth) + "monografia.md"


def child_prefix(depth: int, child: str) -> str:
    return ("../" * depth) + child + "/"


def fix_file(path: Path) -> bool:
    rel = path.relative_to(DOCS)
    depth = len(rel.parts) - 1
    text = path.read_text(encoding="utf-8")
    original = text
    mono = monografia_href(depth)

    text = re.sub(r"\]\((?:\.\./)+content/[^)]*\)", f"]({mono})", text)

    text = re.sub(
        r"\[`([^`]+)`\]\((?:\.\./)+guide-docs/[^)]+\)",
        r"`\1`",
        text,
    )

    for child in DOC_CHILDREN:
        for extra in range(1, 5):
            wrong = "../" * (depth + extra) + child + "/"
            right = child_prefix(depth, child)
            if wrong != right:
                text = text.replace(wrong, right)

    text = text.replace("](../../assets/", "](../assets/")
    text = text.replace("](../docs/", "](../")
    text = text.replace("(../docs/", "(../")
    text = text.replace("](adr/)", "](adr/README.md)")

    text = re.sub(
        r"\[`[^`]*atlas-api-swagger\.json`\]\([^)]+\)",
        "`assets/scripts/atlas-api-swagger.json`",
        text,
    )
    text = re.sub(
        r"\[`[^`]*Atlas REST API-documentation\.html`\]\([^)]+\)",
        "`assets/scripts/Atlas REST API-documentation.html`",
        text,
    )
    text = re.sub(
        r"\[`[^`]+`\]\([^)]*ai-interaction/[^)]+\)",
        "`ai-interaction/correcao-metodologia.md`",
        text,
    )

    if depth == 0:
        for child in DOC_CHILDREN:
            text = text.replace(f"../{child}/", f"{child}/")

    text = text.replace("putz_db.pdf", "putz_db.md")
    text = text.replace("](../adr/)", "](adr/README.md)")

    text = re.sub(
        r"\]\((?:\.\./)+legacy-infra/\)",
        f"]({child_prefix(depth, 'legacy-infra')}index.md)",
        text,
    )
    text = re.sub(
        r"\]\((?:\.\./)+templates/prompts/\)",
        f"]({child_prefix(depth, 'templates')}prompts/)",
        text,
    )

    if path.name == "11-migracao-diagramas-tikz-plantuml.md":
        text = text.replace(
            "](../../assets/figures/README.md)",
            "](assets/figures/README.md)",
        )

    if text != original:
        path.write_text(text, encoding="utf-8")
        return True
    return False


def main() -> None:
    changed = 0
    for md in sorted(DOCS.rglob("*.md")):
        if fix_file(md):
            changed += 1
            print(f"fixed: {md.relative_to(ROOT)}")
    print(f"done ({changed} files)")


if __name__ == "__main__":
    main()
