# Leitura rápida (até 30 min)


### O que estamos fazendo (1 min)

Um pipeline Text-to-SQL onde o agente LLM **consulta a camada semântica e de metadados via MCP antes de gerar SQL**. No experimento, essa camada materializa-se como catálogo canônico (Apache Atlas). O objetivo é medir aderência estrutural, executabilidade e rastreabilidade contra um banco real (subconjunto laboratorial, 92 tabelas) em cluster AWS mínimo.

### Onde olhar para entender o sistema (em ordem, 25 min)

| Etapa | Documento | Tempo |
|-------|-----------|-------|
| 1 | [Produto e escopo](01-produto-e-escopo.md) — o que é, o que está fora do escopo | 3 min |
| 2 | [Arquitetura de negócio](02-arquitetura-negocio.md) — blocos de negócio e contratos macro | 3 min |
| 3 | [Diagrama mestre — fluxo lógico](diagrams/diagrama-mestre.svg) — fluxo lógico ponta a ponta | 2 min |
| 4 | [Visão lógica](03-arquitetura-aplicacao/visao-logica.md) — camadas e fluxo operacional | 4 min |
| 5 | [Camadas MCP](03-arquitetura-aplicacao/camadas-mcp.md) — tabela tool → porta → contrato → erro | 4 min |
| 6 | [Banco laboratorial](04-arquitetura-dados/banco-laboratorio-dominio.md) — onde estão os dados | 3 min |
| 7 | [Visão AWS](05-infraestrutura/visao-aws.md) — topologia AWS | 3 min |
| 8 | [Topologia do cluster AWS](diagrams/cluster-topologia-aws.svg) — diagrama de deployment | 3 min |

Se você chegou aqui, já consegue localizar o agente, o cluster, a camada semântica e a massa.

### O que ler em seguida, conforme o seu papel

| Papel | Leitura seguinte |
|-------|------------------|
| Dev Java | [Módulos Spring](06-implementacao-java/modulos-spring.md), [Ports e adapters](06-implementacao-java/ports-adapters.md), [Contratos MCP v1](07-contratos-mcp/contracts-v1.md) |
| Engenheiro de infra/dados | [Cluster Hadoop](05-infraestrutura/cluster-hadoop.md), [Delta legado para AWS](05-infraestrutura/delta-oci-para-aws.md), [VDF ODP x86](05-infraestrutura/vdf-odp-x86.md), [Carga no cluster](04-arquitetura-dados/carga-cluster-laboratorio.md) |
| Operador de corridas | [Protocolo de avaliação](08-experimento-avaliacao/protocolo-avaliacao.md), [Inferência e prompts](08-experimento-avaliacao/llm-inferencia-e-prompts.md), [Runbook de reprodutibilidade](08-experimento-avaliacao/runbook-reprodutibilidade.md), [Operação](09-operacao.md) |
| Pessoa que escreve o TCC | [Rastreabilidade académica](10-rastreabilidade-academica.md) |
| Pessoa que governa decisões | [Índice de ADRs](adr/README.md) (ADR-0001, ADR-0002 e ADR-0003) |

### Vocabulário mínimo

| Termo | Significado |
|-------|-------------|
| MCP | Model Context Protocol; protocolo que o agente usa para falar com tools. |
| Camada semântica e de metadados | Componente que expõe inventário estruturado de esquema ao agente via MCP. |
| Catálogo canônico | Instanciação experimental da camada semântica; fonte única de metadados na corrida. |
| Apache Atlas | Produto escolhido que implementa o catálogo canônico no cluster. |
| subconjunto laboratorial | Schema relacional de 92 tabelas; subconjunto fixo é a massa de avaliação. |
| `runId` | Identificador único por corrida, no formato `run-YYYYMMDD-HHMM-<id-curto>`. |
| Erro estrutural | SQL que cita tabela/coluna/junção ausente do catálogo canônico. |
| Aderência estrutural | Proporção de SQLs gerados sem erro estrutural. |

!!! tip "Recomendado para leitura posterior"
    Seguinte: **[Produto e escopo](01-produto-e-escopo.md)** — artefato, recorte metodológico e decisões de ambiente.
