# Leitura rápida (até 30 min)

## Pré-requisitos

Nenhum. Este é o ponto de partida.

## Conteúdo

### O que estamos fazendo (1 min)

Um pipeline Text-to-SQL onde o agente LLM **consulta a camada semântica e de metadados via MCP antes de gerar SQL**. No experimento, essa camada materializa-se como catálogo canônico (Apache Atlas). O objetivo é medir aderência estrutural, executabilidade e rastreabilidade contra um banco real (subconjunto laboratorial, 92 tabelas) em cluster AWS mínimo.

### Onde olhar para entender o sistema (em ordem, 25 min)

| Etapa | Documento | Tempo |
|-------|-----------|-------|
| 1 | [`01-produto-e-escopo.md`](01-produto-e-escopo.md) — o que é, o que está fora do escopo | 3 min |
| 2 | [`02-arquitetura-negocio.md`](02-arquitetura-negocio.md) — blocos de negócio e contratos macro | 3 min |
| 3 | [`diagrams/diagrama-mestre.puml`](diagrams/diagrama-mestre.puml) — fluxo lógico ponta a ponta | 2 min |
| 4 | [`03-arquitetura-aplicacao/visao-logica.md`](03-arquitetura-aplicacao/visao-logica.md) — camadas e fluxo operacional | 4 min |
| 5 | [`03-arquitetura-aplicacao/camadas-mcp.md`](03-arquitetura-aplicacao/camadas-mcp.md) — tabela tool → porta → contrato → erro | 4 min |
| 6 | [`04-arquitetura-dados/banco-laboratorio-dominio.md`](04-arquitetura-dados/banco-laboratorio-dominio.md) — onde estão os dados | 3 min |
| 7 | [`05-infraestrutura/visao-aws.md`](05-infraestrutura/visao-aws.md) — topologia AWS | 3 min |
| 8 | [`diagrams/cluster-topologia-aws.puml`](diagrams/cluster-topologia-aws.puml) — diagrama de deployment | 3 min |

Se você chegou aqui, já consegue localizar o agente, o cluster, a camada semântica e a massa.

### O que ler em seguida, conforme o seu papel

| Papel | Leitura seguinte |
|-------|------------------|
| Dev Java | [`06-implementacao-java/modulos-spring.md`](06-implementacao-java/modulos-spring.md), [`06-implementacao-java/ports-adapters.md`](06-implementacao-java/ports-adapters.md), [`07-contratos-mcp/contracts-v1.md`](07-contratos-mcp/contracts-v1.md) |
| Engenheiro de infra/dados | [`05-infraestrutura/cluster-hadoop.md`](05-infraestrutura/cluster-hadoop.md), [`05-infraestrutura/delta-oci-para-aws.md`](05-infraestrutura/delta-oci-para-aws.md), [`05-infraestrutura/vdf-odp-x86.md`](05-infraestrutura/vdf-odp-x86.md), [`04-arquitetura-dados/carga-cluster-laboratorio.md`](04-arquitetura-dados/carga-cluster-laboratorio.md) |
| Operador de corridas | [`08-experimento-avaliacao/protocolo-avaliacao.md`](08-experimento-avaliacao/protocolo-avaliacao.md), [`08-experimento-avaliacao/llm-inferencia-e-prompts.md`](08-experimento-avaliacao/llm-inferencia-e-prompts.md), [`08-experimento-avaliacao/runbook-reprodutibilidade.md`](08-experimento-avaliacao/runbook-reprodutibilidade.md), [`09-operacao.md`](09-operacao.md) |
| Pessoa que escreve o TCC | [`10-rastreabilidade-academica.md`](10-rastreabilidade-academica.md) |
| Pessoa que governa decisões | [`adr/README.md`](adr/README.md) (ADR-0001, ADR-0002 e ADR-0003) |

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

## Próximo passo

[`01-produto-e-escopo.md`](01-produto-e-escopo.md)
