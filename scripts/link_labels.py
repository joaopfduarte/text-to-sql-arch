"""Mapa canónico de rótulos para links internos da documentação."""

from __future__ import annotations

from pathlib import Path

# título curto para [texto](url)
PAGE_TITLES: dict[str, str] = {
    "00-leitura-rapida.md": "Leitura rápida",
    "01-produto-e-escopo.md": "Produto e escopo",
    "02-arquitetura-negocio.md": "Arquitetura de negócio",
    "03-arquitetura-aplicacao/visao-logica.md": "Visão lógica",
    "03-arquitetura-aplicacao/camadas-mcp.md": "Camadas MCP",
    "03-arquitetura-aplicacao/modelo-dominio.md": "Modelo de domínio",
    "04-arquitetura-dados/banco-laboratorio-dominio.md": "Banco laboratorial",
    "04-arquitetura-dados/schema-massa-teste.md": "Schema massa de teste",
    "04-arquitetura-dados/catalogo-atlas.md": "Catálogo Atlas",
    "04-arquitetura-dados/carga-cluster-laboratorio.md": "Carga no cluster",
    "05-infraestrutura/visao-aws.md": "Visão AWS",
    "05-infraestrutura/cluster-hadoop.md": "Cluster Hadoop",
    "05-infraestrutura/delta-oci-para-aws.md": "Delta legado para AWS",
    "05-infraestrutura/vdf-odp-x86.md": "VDF ODP x86",
    "06-implementacao-java/modulos-spring.md": "Módulos Spring",
    "06-implementacao-java/ports-adapters.md": "Ports e adapters",
    "07-contratos-mcp/contracts-v1.md": "Contratos MCP v1",
    "08-experimento-avaliacao/protocolo-avaliacao.md": "Protocolo de avaliação",
    "08-experimento-avaliacao/llm-inferencia-e-prompts.md": "Inferência e prompts",
    "08-experimento-avaliacao/metricas-formulas.md": "Métricas e fórmulas",
    "08-experimento-avaliacao/runbook-reprodutibilidade.md": "Runbook de reprodutibilidade",
    "09-operacao.md": "Operação",
    "10-rastreabilidade-academica.md": "Rastreabilidade académica",
    "11-migracao-diagramas-tikz-plantuml.md": "Migração de diagramas TikZ/PlantUML",
    "roadmap-5a6-meses.md": "Roadmap",
    "adr/README.md": "Índice de ADRs",
    "adr/ADR-0001-fundacao-arquitetural.md": "ADR-0001 Fundação arquitetural",
    "adr/ADR-0002-topologia-aws-cluster-minimo.md": "ADR-0002 Topologia AWS",
    "adr/ADR-0003-inferencia-llm-deterministica.md": "ADR-0003 Inferência LLM",
    "evidence/README.md": "Evidências experimentais",
    "evidence/gabarito-bateria-v1.md": "Gabarito da bateria",
    "evidence/bateria-30-perguntas-v1.csv": "Bateria de 30 perguntas",
    "evidence/baseline-metricas-v1.csv": "Métricas baseline v1",
    "evidence/matriz-cobertura-bateria-v1.md": "Matriz de cobertura da bateria",
    "evidence/matriz-15-tools-mcp-v1.md": "Matriz de 15 tools MCP",
    "evidence/inventario-atlas-api-para-mcp.md": "Inventário Atlas API",
    "evidence/context-schema-v1.json": "Schema context.json v1",
    "evidence/examples/context-baseline-v1.example.json": "Exemplo context baseline v1",
    "evidence/examples/context-mcp-v1.example.json": "Exemplo context MCP v1",
    "templates/prompts/prompts-manifest-v1.json": "Manifesto de prompts v1",
    "templates/prompts/system-shared-v1.md": "System prompt compartilhado v1",
    "templates/prompts/system-baseline-v1.md": "System prompt baseline v1",
    "templates/prompts/system-mcp-v1.md": "System prompt MCP v1",
    "templates/prompts/user-template-v1.md": "Template de mensagem do usuário v1",
    "templates/run-report-template.md": "Template de relatório de corrida",
    "templates/incident-template.md": "Template de incidente",
    "templates/review-metodologico-template.md": "Template de revisão metodológica",
    "templates/adr-template.md": "Template de ADR",
    "assets/scripts/ODP-VDF.xml": "VDF ODP x86",
    "assets/figures/README.md": "Inventário de figuras LaTeX",
}

DIAGRAM_TITLES: dict[str, str] = {
    "diagrama-mestre.puml": "Diagrama mestre — fluxo lógico",
    "diagrama-mestre.svg": "Diagrama mestre — fluxo lógico",
    "camadas-mcp.puml": "Diagrama de camadas MCP",
    "camadas-mcp.svg": "Diagrama de camadas MCP",
    "rede-implantacao.puml": "Diagrama de rede lógica",
    "rede-implantacao.svg": "Diagrama de rede lógica",
    "visao-aws-logica.puml": "Diagrama lógico AWS",
    "visao-aws-logica.svg": "Diagrama lógico AWS",
    "cluster-topologia-aws.puml": "Topologia do cluster AWS",
    "cluster-topologia-aws.svg": "Topologia do cluster AWS",
    "rede-aws.puml": "Diagrama de rede AWS",
    "rede-aws.svg": "Diagrama de rede AWS",
    "ingestao-laboratorio.puml": "Pipeline de ingestão laboratorial",
    "ingestao-laboratorio.svg": "Pipeline de ingestão laboratorial",
}

DIR_TITLES: dict[str, str] = {
    "03-arquitetura-aplicacao/": "Arquitetura de aplicação",
    "04-arquitetura-dados/": "Arquitetura de dados",
    "05-infraestrutura/": "Infraestrutura",
    "07-contratos-mcp/": "Contratos MCP",
    "08-experimento-avaliacao/": "Experimento e avaliação",
    "evidence/": "Evidências experimentais",
    "templates/prompts/": "Templates de prompts",
    "diagrams/": "Diagramas",
}

for _path, _title in list(PAGE_TITLES.items()):
    PAGE_TITLES.setdefault(Path(_path).name, _title)


def parse_mkdocs_nav(nav_lines: list[str]) -> None:
    for line in nav_lines:
        if not line.strip() or line.strip().startswith("#"):
            continue
        stripped = line.lstrip()
        if ":" not in stripped:
            continue
        title, _, path = stripped.partition(":")
        title = title.strip().strip('"').strip("'")
        path = path.strip().strip('"').strip("'")
        if not path.endswith(".md"):
            continue
        PAGE_TITLES.setdefault(path, title)
        PAGE_TITLES.setdefault(Path(path).name, title)


def load_titles_from_mkdocs(mkdocs_path: Path) -> None:
    in_nav = False
    nav_lines: list[str] = []
    for line in mkdocs_path.read_text(encoding="utf-8").splitlines():
        if line.startswith("nav:"):
            in_nav = True
            continue
        if in_nav:
            if line and not line.startswith(" ") and not line.startswith("\t"):
                break
            nav_lines.append(line)
    parse_mkdocs_nav(nav_lines)
