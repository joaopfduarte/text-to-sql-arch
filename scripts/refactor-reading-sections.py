#!/usr/bin/env python3
"""Remove Propósito/Leitor/Pré-requisitos; adiciona admonitions Material para leitura prévia/posterior."""

from __future__ import annotations

import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DOCS = ROOT / "docs"

# (título curto, descrição para o leitor)
PAGE_BLURBS: dict[str, tuple[str, str]] = {
    "guias/leitura-rapida.md": ("Leitura rápida", "visão geral do sistema em até 30 minutos"),
    "produto/escopo.md": ("Produto e escopo", "artefato, recorte metodológico e decisões de ambiente"),
    "arquitetura/negocio.md": ("Arquitetura de negócio", "atores, blocos e contratos macro"),
    "arquitetura/aplicacao/visao-logica.md": ("Visão lógica", "camadas, fluxo operacional e zonas de rede"),
    "arquitetura/aplicacao/camadas-mcp.md": ("Camadas MCP", "mapeamento tool → porta → contrato → erro"),
    "arquitetura/aplicacao/modelo-dominio.md": ("Modelo de domínio", "bounded contexts e agregados"),
    "arquitetura/dados/banco-laboratorio-dominio.md": (
        "Banco laboratorial",
        "domínios genéricos, entidades-âncora e FKs",
    ),
    "arquitetura/dados/schema-massa-teste.md": (
        "Schema massa de teste",
        "inventário das 92 entidades",
    ),
    "arquitetura/dados/catalogo-atlas.md": (
        "Catálogo Atlas",
        "camada semântica e metadados no cluster",
    ),
    "arquitetura/dados/carga-cluster-laboratorio.md": (
        "Carga no cluster",
        "pipeline de ingestão da massa `massa_teste_laboratorio`",
    ),
    "infraestrutura/visao-aws.md": ("Visão AWS", "topologia de rede e componentes na nuvem"),
    "infraestrutura/cluster-hadoop.md": ("Cluster Hadoop", "serviços ODP, sizing e operação"),
    "infraestrutura/delta-oci-para-aws.md": (
        "Delta legado para AWS",
        "comparativo ambiente subdimensionado vs alvo x86",
    ),
    "infraestrutura/vdf-odp-x86.md": ("VDF ODP x86", "stack canônica ODP 1.3.1.0 para o cluster"),
    "implementacao/modulos-spring.md": ("Módulos Spring", "estrutura de projetos e dependências"),
    "implementacao/ports-adapters.md": ("Ports e adapters", "portas hexagonais e adaptadores"),
    "arquitetura/contratos-mcp/contracts-v1.md": ("Contratos MCP v1", "envelope JSON, tools e taxonomia de erro"),
    "experimento/protocolo-avaliacao.md": (
        "Protocolo de avaliação",
        "desenho experimental, bateria e critérios de desfecho",
    ),
    "experimento/llm-inferencia-e-prompts.md": (
        "Inferência e prompts",
        "hiperparâmetros, templates e schema `context.json`",
    ),
    "experimento/metricas-formulas.md": (
        "Métricas e fórmulas",
        "indicadores, fórmulas e schema `metrics.json`",
    ),
    "experimento/runbook-reprodutibilidade.md": (
        "Runbook de reprodutibilidade",
        "passos para repetir uma corrida com evidências",
    ),
    "operacao/index.md": ("Operação", "ciclo de corrida, incidentes e governança"),
    "pesquisa/rastreabilidade-academica.md": (
        "Rastreabilidade acadêmica",
        "relação com a documentação acadêmica externa",
    ),
    "pesquisa/roadmap.md": ("Roadmap", "marcos até a apresentação em novembro de 2026"),
    "adr/README.md": ("Índice de ADRs", "decisões arquiteturais registradas"),
    "adr/ADR-0001-fundacao-arquitetural.md": (
        "ADR-0001 Fundação arquitetural",
        "hexagonal, MCP versionado e evidência por `runId`",
    ),
    "adr/ADR-0002-topologia-aws-cluster-minimo.md": (
        "ADR-0002 Topologia AWS",
        "cluster ODP mínimo, sizing e massa fixa",
    ),
    "adr/ADR-0003-inferencia-llm-deterministica.md": (
        "ADR-0003 Inferência LLM",
        "determinismo, seeds e configuração de prompts",
    ),
    "evidence/gabarito-bateria-v1.md": (
        "Gabarito da bateria",
        "colas SQL de referência por pergunta",
    ),
    "evidence/matriz-cobertura-bateria-v1.md": (
        "Matriz de cobertura",
        "cenários, dificuldade e tabelas por pergunta",
    ),
    "evidence/matriz-15-tools-mcp-v1.md": (
        "Matriz de 15 tools MCP",
        "seleção das tools do catálogo fechado",
    ),
    "evidence/inventario-atlas-api-para-mcp.md": (
        "Inventário Atlas API",
        "operações de leitura triadas para o MCP",
    ),
    "evidence/context-schema-v1.json": ("Schema `context.json`", "campos obrigatórios por corrida"),
    "templates/prompts/prompts-manifest-v1.json": (
        "Manifesto de prompts v1",
        "versões dos artefatos de prompt",
    ),
    "assets/scripts/ODP-VDF.xml": ("VDF ODP x86", "definição canônica da stack alvo"),
}

# Atalhos por basename (links relativos na mesma pasta)
for _path, _pair in list(PAGE_BLURBS.items()):
    PAGE_BLURBS.setdefault(Path(_path).name, _pair)

EXTRA_BLURBS: dict[str, tuple[str, str]] = {
    "GPT54NanoModelDocs.md": ("Tarifas GPT-5.4 Nano", "referência de custo do provedor"),
    "Gemini35FlashModelDocs.md": ("Tarifas Gemini 3.5 Flash", "referência de custo do provedor"),
}

REMOVE_SECTIONS = {"Propósito", "Leitor", "Pré-requisitos"}
LINK_RE = re.compile(r"\[`?([^`\]]+)`?\]\(([^)]+)\)")
HINT_RE = re.compile(r"\s*[—–-]\s*(.+)$|\s*\(([^)]+)\)\s*$")


def norm_key(path: str) -> str:
    p = path.split("#")[0].split("?")[0]
    p = p.removeprefix("../").removeprefix("./")
    if p.startswith("docs/"):
        p = p[5:]
    return p


def lookup_blurb(href: str, link_text: str, hint: str | None, current: Path | None = None) -> tuple[str, str]:
    candidates: list[str] = []
    key = norm_key(href)
    candidates.append(key)
    candidates.append(Path(key).name)
    if current and not href.startswith(("http://", "https://", "/")):
        try:
            resolved = (current.parent / href.split("#")[0]).resolve()
            rel = resolved.relative_to(DOCS)
            candidates.insert(0, rel.as_posix())
            candidates.insert(1, rel.name)
        except ValueError:
            try:
                resolved = (ROOT / href.split("#")[0]).resolve()
                rel = resolved.relative_to(ROOT)
                candidates.insert(0, rel.as_posix())
            except ValueError:
                pass
    for candidate in candidates:
        if candidate in PAGE_BLURBS:
            title, desc = PAGE_BLURBS[candidate]
            if hint:
                desc = hint.strip("() ")
            return title, desc
    for name, pair in EXTRA_BLURBS.items():
        if key.endswith(name) or href.endswith(name):
            return pair
    if link_text != href and not link_text.endswith((".md", ".json", ".xml")):
        title = link_text
    else:
        title = Path(key).stem.replace("-", " ").replace("_", " ").title()
    desc = hint.strip("() ") if hint else "contexto necessário para esta página"
    return title, desc


def parse_link_line(line: str, current: Path) -> tuple[str, str, str] | None:
    line = line.strip()
    if not line.startswith("- "):
        return None
    body = line[2:].strip()
    if body.lower().startswith("nenhum"):
        return None
    m = LINK_RE.search(body)
    if not m:
        if body.lower().startswith("gabarito:"):
            m = LINK_RE.search(body.split(":", 1)[1])
            prefix = "Gabarito"
        elif body.lower().startswith("tarifas llm:"):
            return None  # handled as plain paths below
        else:
            return None
    else:
        prefix = None
    link_text, href = m.group(1), m.group(2)
    tail = body[m.end() :].strip()
    hint = None
    hm = HINT_RE.search(tail)
    if hm:
        hint = hm.group(1) or hm.group(2)
    title, desc = lookup_blurb(href, link_text, hint, current)
    if prefix:
        title = prefix
    return href, title, desc


def parse_plain_path_line(line: str) -> list[tuple[str, str, str]]:
    line = line.strip()
    if not line.startswith("- "):
        return []
    body = line[2:]
    if LINK_RE.search(body):
        return []
    paths = re.findall(r"`([^`]+)`", body)
    out: list[tuple[str, str, str]] = []
    for href in paths:
        key = Path(href).name
        if key in EXTRA_BLURBS:
            title, desc = EXTRA_BLURBS[key]
            out.append((href, title, desc))
    return out


def format_prev_item(href: str, title: str, desc: str) -> str:
    return f"    - **[{title}]({href})** — {desc}."


def format_next_item(href: str, title: str, desc: str) -> str:
    return f"    Seguinte: **[{title}]({href})** — {desc}."


def split_sections(text: str) -> tuple[str, dict[str, str]]:
    parts = re.split(r"(?m)^## ", text)
    head = parts[0]
    sections: dict[str, str] = {}
    for part in parts[1:]:
        name, _, body = part.partition("\n")
        sections[name.strip()] = body
    return head, sections


def rebuild(head: str, sections: dict[str, str], order: list[str]) -> str:
    out = head.rstrip() + "\n"
    for name in order:
        if name in sections:
            out += f"\n## {name}\n\n{sections[name].lstrip()}"
    return out.rstrip() + "\n"


def transform_doc(path: Path, text: str) -> str:
    if not any(f"## {name}" in text for name in REMOVE_SECTIONS | {"Pré-requisitos", "Próximo passo"}):
        return text
    head, sections = split_sections(text)
    prereq_body = sections.pop("Pré-requisitos", None)
    for rm in REMOVE_SECTIONS:
        sections.pop(rm, None)

    prev_items: list[str] = []
    if prereq_body:
        for line in prereq_body.splitlines():
            parsed = parse_link_line(line, path)
            if parsed:
                href, title, desc = parsed
                prev_items.append(format_prev_item(href, title, desc))
            else:
                for href, title, desc in parse_plain_path_line(line):
                    prev_items.append(format_prev_item(href, title, desc))

    next_admon = None
    if "Próximo passo" in sections:
        next_body = sections.pop("Próximo passo").strip()
        m = LINK_RE.search(next_body)
        if m:
            href = m.group(2)
            title, desc = lookup_blurb(href, m.group(1), None, path)
            next_admon = (
                '!!! tip "Recomendado para leitura posterior"\n'
                + format_next_item(href, title, desc)
            )

    # Insert admonitions after H1 block
    head_lines = head.splitlines()
    if head_lines and head_lines[0].startswith("# "):
        h1_end = 1
        while h1_end < len(head_lines) and head_lines[h1_end].strip() == "":
            h1_end += 1
        prefix = "\n".join(head_lines[:h1_end])
        suffix = "\n".join(head_lines[h1_end:]).strip()
        head = prefix
        if suffix:
            head += "\n\n" + suffix
    else:
        head = head.rstrip()

    blocks: list[str] = []
    if prev_items:
        blocks.append('!!! info "Recomendado para leitura prévia"\n' + "\n".join(prev_items))
    if blocks:
        head = head.rstrip() + "\n\n" + "\n\n".join(blocks) + "\n"

    order = [k for k in re.split(r"(?m)^## ", text) if k and k.split("\n", 1)[0].strip() not in REMOVE_SECTIONS]
    # preserve original order from text
    orig_order: list[str] = []
    for part in re.split(r"(?m)^## ", text)[1:]:
        name = part.split("\n", 1)[0].strip()
        if name not in REMOVE_SECTIONS and name not in orig_order:
            orig_order.append(name)
    if "Próximo passo" in orig_order:
        orig_order.remove("Próximo passo")

    result = rebuild(head, sections, orig_order)
    if next_admon:
        result = result.rstrip() + "\n\n" + next_admon + "\n"
    return result


def transform_evidence(path: Path, text: str) -> str:
    head, sections = split_sections(text)
    sections.pop("Propósito", None)
    sections.pop("Leitor", None)
    sections.pop("Pré-requisitos", None)
    orig_order = [part.split("\n", 1)[0].strip() for part in re.split(r"(?m)^## ", text)[1:]]
    orig_order = [n for n in orig_order if n not in REMOVE_SECTIONS]
    return rebuild(head, sections, orig_order)


def main() -> None:
    changed = 0
    for path in sorted(DOCS.rglob("*.md")):
        new = transform_doc(path, path.read_text(encoding="utf-8"))
        if new != path.read_text(encoding="utf-8"):
            path.write_text(new, encoding="utf-8")
            changed += 1
            print("docs:", path.relative_to(ROOT))

    evidence = ROOT / "evidence"
    for path in sorted(evidence.rglob("*.md")):
        text = path.read_text(encoding="utf-8")
        if "## Propósito" not in text and "## Leitor" not in text and "## Pré-requisitos" not in text:
            continue
        new = transform_evidence(path, text)
        if new != text:
            path.write_text(new, encoding="utf-8")
            changed += 1
            print("evidence:", path.relative_to(ROOT))

    print(f"updated {changed} files")


if __name__ == "__main__":
    main()
