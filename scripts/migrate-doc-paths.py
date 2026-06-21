#!/usr/bin/env python3
"""Migra links internos da documentacao para a arvore por dominio (FSD).

Reescreve links Markdown e atributos HTML (href/src) apontando para arquivos
movidos, recalculando o caminho relativo a partir da NOVA localizacao do arquivo
de origem. Deve rodar com os arquivos ainda nas localizacoes ANTIGAS (antes do
git mv); apos rodar, os links ja estarao corretos para o novo layout.

Uso:
    python3 scripts/migrate-doc-paths.py            # aplica
    python3 scripts/migrate-doc-paths.py --dry-run  # apenas relatorio
"""

from __future__ import annotations

import os
import posixpath
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DOCS = ROOT / "docs"

# Arquivos na raiz de docs/ que mudam de path.
ROOT_FILE_MAP: dict[str, str] = {
    "00-glossario-anonimizacao.md": "guias/glossario-anonimizacao.md",
    "00-leitura-rapida.md": "guias/leitura-rapida.md",
    "01-produto-e-escopo.md": "produto/escopo.md",
    "02-arquitetura-negocio.md": "arquitetura/negocio.md",
    "09-operacao.md": "operacao/index.md",
    "10-rastreabilidade-academica.md": "pesquisa/rastreabilidade-academica.md",
    "roadmap-5a6-meses.md": "pesquisa/roadmap.md",
}

# Diretorios que mudam de prefixo.
DIR_MAP: dict[str, str] = {
    "03-arquitetura-aplicacao": "arquitetura/aplicacao",
    "04-arquitetura-dados": "arquitetura/dados",
    "05-infraestrutura": "infraestrutura",
    "06-implementacao-java": "implementacao",
    "07-contratos-mcp": "arquitetura/contratos-mcp",
    "08-experimento-avaliacao": "experimento",
}

MD_LINK_RE = re.compile(r"(\]\()([^)]+)(\))")
HTML_ATTR_RE = re.compile(r'\b(href|src)=(")([^"]+)(")')


def map_docs_rel(old_rel: str) -> str:
    """Mapeia um path docs-relativo antigo para o novo (inalterado se nao movido)."""
    old_rel = old_rel.strip("/") if old_rel != "/" else old_rel
    if old_rel in ROOT_FILE_MAP:
        return ROOT_FILE_MAP[old_rel]
    if old_rel in DIR_MAP:
        return DIR_MAP[old_rel]
    head, sep, tail = old_rel.partition("/")
    if sep and head in DIR_MAP:
        return f"{DIR_MAP[head]}/{tail}"
    return old_rel


def split_suffix(href: str) -> tuple[str, str]:
    for ch in ("#", "?"):
        idx = href.find(ch)
        if idx != -1:
            return href[:idx], href[idx:]
    return href, ""


def is_external(path_part: str) -> bool:
    return (
        path_part == ""
        or path_part.startswith(("http://", "https://", "mailto:", "/", "data:", "tel:"))
    )


def rewrite_href(href: str, old_src_dir: str, new_src_dir: str) -> str:
    path_part, suffix = split_suffix(href)
    if is_external(path_part):
        return href
    had_trailing = path_part.endswith("/")
    old_target = posixpath.normpath(posixpath.join(old_src_dir, path_part))
    if old_target == ".":
        return href
    base = posixpath.basename(old_target)
    is_page_url = had_trailing or "." not in base

    if is_page_url:
        # Link em estilo URL de diretorio (MkDocs use_directory_urls): sem .md.
        as_md = f"{old_target}.md"
        mapped = map_docs_rel(as_md)
        if mapped == as_md:
            new_target_for_rel = old_target
        elif mapped.endswith("/index.md"):
            new_target_for_rel = mapped[: -len("/index.md")]
        else:
            new_target_for_rel = mapped[:-3]
        new_path = posixpath.relpath(new_target_for_rel, new_src_dir or ".")
        if not new_path.endswith("/"):
            new_path += "/"
        return new_path + suffix

    new_target = map_docs_rel(old_target)
    new_path = posixpath.relpath(new_target, new_src_dir or ".")
    return new_path + suffix


def process_text(text: str, old_src_dir: str, new_src_dir: str) -> tuple[str, int]:
    count = 0
    in_fence = False
    out_lines: list[str] = []
    for line in text.splitlines(keepends=False):
        if line.lstrip().startswith("```"):
            in_fence = not in_fence
            out_lines.append(line)
            continue
        if in_fence:
            out_lines.append(line)
            continue

        def md_sub(m: re.Match[str]) -> str:
            nonlocal count
            new = rewrite_href(m.group(2), old_src_dir, new_src_dir)
            if new != m.group(2):
                count += 1
            return f"{m.group(1)}{new}{m.group(3)}"

        def html_sub(m: re.Match[str]) -> str:
            nonlocal count
            new = rewrite_href(m.group(3), old_src_dir, new_src_dir)
            if new != m.group(3):
                count += 1
            return f"{m.group(1)}={m.group(2)}{new}{m.group(4)}"

        line = MD_LINK_RE.sub(md_sub, line)
        line = HTML_ATTR_RE.sub(html_sub, line)
        out_lines.append(line)
    result = "\n".join(out_lines)
    if text.endswith("\n"):
        result += "\n"
    return result, count


def iter_targets() -> list[tuple[Path, str, str]]:
    """Retorna (caminho_atual, old_src_dir, new_src_dir) por arquivo.

    old_src_dir / new_src_dir sao dirs docs-relativos ('' para raiz de docs).
    README.md usa prefixo 'docs/' nos links, tratado separadamente.
    """
    out: list[tuple[Path, str, str]] = []
    seen: set[Path] = set()
    for path in sorted(DOCS.rglob("*.md")):
        resolved = path.resolve()
        if resolved in seen:
            continue
        seen.add(resolved)
        old_rel = path.relative_to(DOCS).as_posix()
        new_rel = map_docs_rel(old_rel)
        out.append((path, posixpath.dirname(old_rel), posixpath.dirname(new_rel)))

    # Arvores fora de docs/ expostas via symlink (docs/evidence, docs/templates).
    # Nao mudam de local, mas seus links para docs/ precisam ser recalculados.
    for base, prefix in ((ROOT / "evidence", "evidence"), (ROOT / "templates", "templates")):
        if not base.is_dir():
            continue
        for path in sorted(base.rglob("*.md")):
            resolved = path.resolve()
            if resolved in seen:
                continue
            seen.add(resolved)
            rel = f"{prefix}/{path.relative_to(base).as_posix()}"
            d = posixpath.dirname(rel)
            out.append((path, d, d))
    return out


def process_readme(dry: bool) -> int:
    readme = ROOT / "README.md"
    if not readme.exists():
        return 0
    text = readme.read_text(encoding="utf-8")
    # README fica na raiz do repo; links internos comecam com 'docs/'.
    count = 0

    def rewrite_readme_href(href: str) -> str:
        nonlocal count
        path_part, suffix = split_suffix(href)
        if not path_part.startswith("docs/"):
            return href
        old_docs_rel = posixpath.normpath(path_part[len("docs/"):])
        new_docs_rel = map_docs_rel(old_docs_rel)
        new = f"docs/{new_docs_rel}{suffix}"
        if new != href:
            count += 1
        return new

    def md_sub(m: re.Match[str]) -> str:
        return f"{m.group(1)}{rewrite_readme_href(m.group(2))}{m.group(3)}"

    in_fence = False
    out_lines: list[str] = []
    for line in text.splitlines():
        if line.lstrip().startswith("```"):
            in_fence = not in_fence
            out_lines.append(line)
            continue
        out_lines.append(line if in_fence else MD_LINK_RE.sub(md_sub, line))
    new_text = "\n".join(out_lines)
    if text.endswith("\n"):
        new_text += "\n"
    if count and not dry:
        readme.write_text(new_text, encoding="utf-8")
    if count:
        print(f"README.md: {count} links")
    return count


def main() -> None:
    dry = "--dry-run" in sys.argv
    total = 0
    for path, old_dir, new_dir in iter_targets():
        text = path.read_text(encoding="utf-8")
        new_text, count = process_text(text, old_dir, new_dir)
        if count:
            total += count
            print(f"{path.relative_to(ROOT)}: {count} links")
            if not dry:
                path.write_text(new_text, encoding="utf-8")
    total += process_readme(dry)
    print(f"{'(dry-run) ' if dry else ''}total: {total} links reescritos")


if __name__ == "__main__":
    main()
