#!/usr/bin/env python3
"""Normaliza rótulos de links Markdown: [texto descritivo](url), nunca path como texto."""

from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DOCS = ROOT / "docs"
EVIDENCE = ROOT / "evidence"

sys.path.insert(0, str(ROOT / "scripts"))
from link_labels import (  # noqa: E402
    DIAGRAM_TITLES,
    DIR_TITLES,
    PAGE_TITLES,
    load_titles_from_mkdocs,
)

load_titles_from_mkdocs(ROOT / "mkdocs.yml")

LINK_RE = re.compile(r"\[(\*\*)?(`?)([^\]`*]+?)(`?)(\*\*)?\]\(([^)]+)\)")
CODE_FENCE = re.compile(r"^```")

PATH_SUFFIXES = {".md", ".puml", ".svg", ".xml", ".json", ".csv", ".html", ".pdf", ".mmd"}


def norm_href(href: str) -> str:
    return href.split("#")[0].split("?")[0]


def resolve_target(href: str, current: Path) -> str | None:
    h = norm_href(href)
    if not h or h.startswith(("http://", "https://", "mailto:")):
        return None
    if h.startswith("/"):
        target = DOCS / h.lstrip("/")
    else:
        target = (current.parent / h).resolve()
    try:
        if target.is_relative_to(DOCS):
            return target.relative_to(DOCS).as_posix()
        if target.is_relative_to(ROOT):
            return target.relative_to(ROOT).as_posix()
    except ValueError:
        pass
    return h


def href_to_keys(href: str, current: Path) -> list[str]:
    h = norm_href(href)
    keys: list[str] = [h, Path(h).name]
    rel = resolve_target(href, current)
    if rel:
        keys.extend([rel, Path(rel).name])
    if h.startswith("../"):
        tail = h.removeprefix("../")
        keys.extend([tail, Path(tail).name])
    return keys


def title_for_href(href: str, current: Path) -> str | None:
    h = norm_href(href)
    base = Path(h).name

    if h.endswith("/") or (base == "" and h):
        for key, title in DIR_TITLES.items():
            if h.endswith(key) or h == key.rstrip("/"):
                return title
        return "Documentação relacionada"

    for key in href_to_keys(href, current):
        if key in PAGE_TITLES:
            return PAGE_TITLES[key]
        if key in DIAGRAM_TITLES:
            return DIAGRAM_TITLES[key]

    if base in DIAGRAM_TITLES:
        return DIAGRAM_TITLES[base]

    if base.endswith(".md"):
        return Path(base).stem.replace("-", " ").replace("_", " ").title()
    return None


def is_path_like(text: str, href: str) -> bool:
    t = text.strip("`").strip()
    h = norm_href(href)
    base = Path(h).name

    if t == h or t == base:
        return True
    if t.endswith("/") and not " " in t:
        return True
    if any(t.endswith(s) for s in PATH_SUFFIXES):
        return True
    if "/" in t and (t in h or h.endswith(t) or t.endswith(base)):
        return True
    if t.startswith("../") or t.startswith("./"):
        return True
    if "`" in text and any(ext in t for ext in PATH_SUFFIXES):
        return True
    return False


def maybe_svg_href(href: str) -> str:
    if norm_href(href).endswith(".puml"):
        return href.replace(".puml", ".svg")
    return href


def process_markdown(text: str, current: Path) -> str:
    lines = text.splitlines(keepends=True)
    out: list[str] = []
    in_fence = False

    for line in lines:
        if CODE_FENCE.match(line.strip()):
            in_fence = not in_fence
            out.append(line)
            continue
        if in_fence:
            out.append(line)
            continue

        def repl(m: re.Match[str]) -> str:
            bold_pre, _bt1, label, _bt2, bold_post, href = m.groups()
            if bold_pre and not bold_post:
                return m.group(0)

            new_href = maybe_svg_href(href)
            if not is_path_like(label, href):
                if new_href != href:
                    return f"[{label}]({new_href})"
                return m.group(0)

            title = title_for_href(href, current)
            if not title:
                return m.group(0)

            prefix = bold_pre or ""
            suffix = bold_post or ""
            return f"{prefix}[{title}]({new_href}){suffix}"

        out.append(LINK_RE.sub(repl, line))

    return "".join(out)


def iter_markdown_files() -> list[Path]:
    files = sorted(DOCS.rglob("*.md")) + sorted(EVIDENCE.rglob("*.md"))
    templates = ROOT / "templates"
    if templates.is_dir():
        files.extend(sorted(templates.rglob("*.md")))
    readme = ROOT / "README.md"
    if readme.is_file():
        files.append(readme)
    return files


def context_for(path: Path) -> Path:
    if path.is_relative_to(DOCS):
        return path
    if path.is_relative_to(ROOT / "templates"):
        return DOCS / "experimento/llm-inferencia-e-prompts.md"
    return DOCS / "index.md"


def main() -> None:
    changed = 0
    for path in iter_markdown_files():
        original = path.read_text(encoding="utf-8")
        updated = process_markdown(original, context_for(path))
        if updated != original:
            path.write_text(updated, encoding="utf-8")
            print(path.relative_to(ROOT))
            changed += 1
    print(f"updated {changed} files")


if __name__ == "__main__":
    main()
