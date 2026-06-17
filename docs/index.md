# Arquitetura e engenharia do produto TCC

Pacote operacional para a engenharia do artefato Text-to-SQL com MCP e Apache Atlas. Complementa a [Monografia](monografia.md) com documentação técnica orientada a execução, reprodutibilidade experimental e governança arquitetural.

## Por onde começar

| Papel | Leitura inicial |
|-------|-----------------|
| Qualquer pessoa nova no projeto | [Leitura rápida](00-leitura-rapida.md) |
| Dev Java | [Visão lógica](03-arquitetura-aplicacao/visao-logica.md) → [Módulos Spring](06-implementacao-java/modulos-spring.md) → [Contratos MCP](07-contratos-mcp/contracts-v1.md) |
| Engenheiro de infra/dados | [Visão AWS](05-infraestrutura/visao-aws.md) → [Cluster Hadoop](05-infraestrutura/cluster-hadoop.md) → [Carga no cluster](04-arquitetura-dados/carga-cluster-xpto.md) |
| Operador de corridas | [Runbook](08-experimento-avaliacao/runbook-reprodutibilidade.md) → [Operação](09-operacao.md) |
| Pessoa que escreve o TCC | [Rastreabilidade acadêmica](10-rastreabilidade-academica.md) |

## Estrutura do site

- **00–10:** documentação operacional do artefato (produto, arquitetura, dados, infra, Java, MCP, experimento, operação).
- **ADRs:** decisões arquiteturais registadas em `docs/adr/`.
- **Diagramas:** fontes Mermaid em `docs/diagrams/` (embutidos nas páginas).
- **Monografia:** PDF académico em [monografia.md](monografia.md).

## Princípios de manutenção

- Fonte única da verdade para arquitetura e protocolo experimental.
- Mudança de design relevante exige ADR e atualização do diagrama correspondente.
- Evidência experimental precisa de `runId`, `seed`, `modelVersion`, `commitHash`, `datasetVersion` e `contractsVersion`.
- Contratos MCP versionados em [contracts-v1.md](07-contratos-mcp/contracts-v1.md).
- Detalhes de cluster, VDF e massa de dados completos: [Monografia](monografia.md) (não publicados neste site).

## Desenvolvimento local

```bash
pip install -r requirements.txt
bash scripts/prepare-docs.sh
mkdocs serve
```

Build de produção: `bash scripts/prepare-docs.sh && mkdocs build --strict --site-dir public`.

Diagramas UML (PlantUML): fontes em `diagrams/*.puml`; SVG gerados por `scripts/render-diagrams.sh` (invocado automaticamente pelo `prepare-docs.sh`). Requer `plantuml`, `graphviz` e Java (ex.: `apt-get install -y plantuml graphviz default-jre-headless`).
