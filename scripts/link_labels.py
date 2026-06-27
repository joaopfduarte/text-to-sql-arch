"""Mapa canônico de rótulos para links internos da documentação."""

from __future__ import annotations

from pathlib import Path

# título curto para [texto](url)
PAGE_TITLES: dict[str, str] = {
    "guias/leitura-rapida.md": "Leitura rápida",
    "produto/escopo.md": "Produto e escopo",
    "arquitetura/negocio.md": "Arquitetura de negócio",
    "arquitetura/aplicacao/visao-logica.md": "Visão lógica",
    "arquitetura/aplicacao/camadas-mcp.md": "Camadas MCP",
    "arquitetura/aplicacao/modelo-dominio.md": "Modelo de domínio",
    "arquitetura/dados/banco-laboratorio-dominio.md": "Banco laboratorial",
    "arquitetura/dados/schema-massa-teste.md": "Schema massa de teste",
    "arquitetura/dados/catalogo-atlas.md": "Catálogo Atlas",
    "arquitetura/dados/carga-cluster-laboratorio.md": "Carga no cluster",
    "infraestrutura/visao-aws.md": "Visão AWS",
    "infraestrutura/cluster-hadoop.md": "Cluster Hadoop",
    "infraestrutura/vdf-odp-x86.md": "VDF ODP x86",
    "implementacao/modulos-spring.md": "Módulos Spring",
    "implementacao/ports-adapters.md": "Ports e adapters",
    "arquitetura/contratos-mcp/contracts-v1.md": "Contratos MCP v1",
    "experimento/protocolo-avaliacao.md": "Protocolo de avaliação",
    "experimento/llm-inferencia-e-prompts.md": "Inferência e prompts",
    "experimento/metricas-formulas.md": "Métricas e fórmulas",
    "experimento/runbook-reprodutibilidade.md": "Runbook de reprodutibilidade",
    "experimento/pacote-experimental.md": "Pacote experimental",
    "operacao/index.md": "Operação",
    "pesquisa/rastreabilidade-academica.md": "Rastreabilidade acadêmica",
    "pesquisa/roadmap.md": "Roadmap",
    "pesquisa/migracao-diagramas-tikz-plantuml.md": "Migração diagramas TikZ/PlantUML",
    "adr/README.md": "Índice de ADRs",
    "adr/ADR-0001-fundacao-arquitetural.md": "ADR-0001 Fundação arquitetural",
    "adr/ADR-0002-topologia-aws-cluster-minimo.md": "ADR-0002 Topologia AWS",
    "adr/ADR-0003-inferencia-llm-deterministica.md": "ADR-0003 Inferência LLM",
    "adr/ADR-0004-politica-select-only-passo5.md": "ADR-0004 SELECT-only passo 5",
    "adr/ADR-0005-convencao-maven-pacotes-producao.md": "ADR-0005 Maven produção",
    "evidence/README.md": "Evidências experimentais",
    "evidence/gabarito-bateria.md": "Gabarito da bateria",
    "evidence/bateria-40-perguntas.csv": "Bateria de 40 perguntas",
    "evidence/baseline-metricas.csv": "Métricas baseline",
    "evidence/baseline-auditoria-gabarito.md": "Auditoria baseline",
    "evidence/matriz-cobertura-bateria.md": "Matriz de cobertura da bateria",
    "evidence/matriz-15-tools-mcp.md": "Matriz de 15 tools MCP",
    "evidence/inventario-atlas-api-para-mcp.md": "Inventário Atlas API",
    "evidence/context-schema.json": "Schema do contexto",
    "evidence/json_data-data_source-schema-notes.md": "Notas json_data e data_source",
    "evidence/examples/context-baseline.example.json": "Exemplo context baseline",
    "evidence/examples/context-mcp.example.json": "Exemplo context MCP",
    "dados/README.md": "Instruções de importação MySQL",
    "dados/base_laboratorial.sql": "Dump MySQL base_laboratorial",
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
    "arquitetura/": "Arquitetura",
    "arquitetura/aplicacao/": "Arquitetura de aplicação",
    "arquitetura/dados/": "Arquitetura de dados",
    "arquitetura/contratos-mcp/": "Contratos MCP",
    "infraestrutura/": "Infraestrutura",
    "implementacao/": "Implementação Java",
    "experimento/": "Experimento e avaliação",
    "guias/": "Guias",
    "produto/": "Produto e escopo",
    "operacao/": "Operação",
    "pesquisa/": "Pesquisa",
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
