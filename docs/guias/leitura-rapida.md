# Leitura rápida (até 30 min)


### O que estamos fazendo (1 min)

Um pipeline Text-to-SQL onde o agente LLM **consulta a camada semântica e de metadados via MCP antes de gerar SQL**. No experimento, essa camada materializa-se como catálogo canônico (Apache Atlas). O objetivo é medir aderência estrutural, executabilidade e rastreabilidade contra um banco real (subconjunto laboratorial, 92 tabelas) em cluster AWS mínimo.

### Onde olhar para entender o sistema (em ordem, 25 min)

| Etapa | Documento | Tempo |
|-------|-----------|-------|
| 1 | [Produto e escopo](../produto/escopo.md) — o que é, o que está fora do escopo | 3 min |
| 2 | [Arquitetura de negócio](../arquitetura/negocio.md) — blocos de negócio e contratos macro | 3 min |
| 3 | [Diagrama mestre — fluxo lógico](../diagrams/diagrama-mestre.svg) — fluxo lógico ponta a ponta | 2 min |
| 4 | [Visão lógica](../arquitetura/aplicacao/visao-logica.md) — camadas e fluxo operacional | 4 min |
| 5 | [Camadas MCP](../arquitetura/aplicacao/camadas-mcp.md) — tabela tool → porta → contrato → erro | 4 min |
| 6 | [Banco laboratorial](../arquitetura/dados/banco-laboratorio-dominio.md) — onde estão os dados | 3 min |
| 7 | [Visão AWS](../infraestrutura/visao-aws.md) — topologia AWS | 3 min |
| 8 | [Topologia do cluster AWS](../diagrams/cluster-topologia-aws.svg) — diagrama de deployment | 3 min |

Se você chegou aqui, já consegue localizar o agente, o cluster, a camada semântica e a massa.

### O que ler em seguida, conforme o seu papel

| Papel | Leitura seguinte |
|-------|------------------|
| Dev Java | [Módulos Spring](../implementacao/modulos-spring.md), [Ports e adapters](../implementacao/ports-adapters.md), [Contratos MCP v1](../arquitetura/contratos-mcp/contracts-v1.md) |
| Engenheiro de infra/dados | [Cluster Hadoop](../infraestrutura/cluster-hadoop.md), [VDF ODP x86](../infraestrutura/vdf-odp-x86.md), [Carga no cluster](../arquitetura/dados/carga-cluster-laboratorio.md) |
| Operador de corridas | [Protocolo de avaliação](../experimento/protocolo-avaliacao.md), [Inferência e prompts](../experimento/llm-inferencia-e-prompts.md), [Runbook de reprodutibilidade](../experimento/runbook-reprodutibilidade.md), [Operação](../operacao/index.md) |
| Autor da pesquisa | [Rastreabilidade acadêmica](../pesquisa/rastreabilidade-academica.md) |
| Pessoa que governa decisões | [Índice de ADRs](../adr/README.md) (ADR-0001, ADR-0002 e ADR-0003) |

### Vocabulário mínimo

| Termo | Significado |
|-------|-------------|
| MCP | Model Context Protocol; protocolo que o agente usa para falar com tools. |
| Camada semântica e de metadados | Componente que expõe inventário estruturado de esquema ao agente via MCP. |
| Catálogo canônico | Instanciação experimental da camada semântica; fonte única de metadados na corrida. |
| Apache Atlas | Produto escolhido que implementa o catálogo canônico no cluster. |
| subconjunto laboratorial | Schema relacional **`base_laboratorial`** (MySQL 8+); massa versionada em `dados/` |
| `runId` | Identificador único por corrida, no formato `run-YYYYMMDD-HHMM-<id-curto>`. |
| Erro estrutural | SQL que cita tabela/coluna/junção ausente do catálogo canônico. |
| Aderência estrutural | Proporção de SQLs gerados sem erro estrutural. |

!!! tip "Recomendado para leitura posterior"
    Seguinte: **[Produto e escopo](../produto/escopo.md)** — artefato, recorte metodológico e decisões de ambiente.
