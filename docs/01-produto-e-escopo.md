# Produto e escopo metodológico

## Propósito

Apresentar o artefato Text-to-SQL do TCC, congelar o recorte metodológico e tornar explícitas as decisões de ambiente que sustentam a reprodutibilidade.

## Leitor

Pessoa que precisa entender, em até 15 minutos, o que é o artefato, o que está dentro do escopo do TCC e o que ficou fora.

## Pré-requisitos

- Nenhum. Este é o primeiro documento operacional.

## Conteúdo

### O produto em uma frase

Um pipeline Text-to-SQL em que um agente LLM consulta a camada semântica e de metadados via servidor MCP antes de gerar SQL, valida a aderência estrutural contra o catálogo canônico e executa o SQL sob ambiente controlado, registrando trilha completa por corrida. O catálogo canônico é implementado com Apache Atlas (escolha arquitetural; ver [`04-arquitetura-dados/catalogo-atlas.md`](04-arquitetura-dados/catalogo-atlas.md)).

### Cadeia funcional

`pergunta em linguagem natural -> consultas de metadados via MCP -> síntese de SQL -> validação sintática e estrutural -> execução controlada -> registro de métricas e evidências`

### Recorte científico

- Tipo de pesquisa: aplicada e experimental.
- Objeto: artefato único `Text-to-SQL` com grounding na camada semântica e de metadados via `MCP`.
- Horizonte: janela de 5 a 6 meses até a apresentação no fim de novembro de 2026.
- Ambiente: laboratório AWS reprodutível, operado em conta de estudo, com infraestrutura como código e cluster mínimo (sem dependência de tenant corporativo, mas com cluster real provisionado).

### Definição operacional de erro estrutural

Um SQL contém erro estrutural quando:

1. referencia tabela, visão ou coluna ausente do catálogo canônico;
2. usa `schema` incompatível com o catálogo canônico;
3. cria junções não suportadas por relacionamentos recuperados dos metadados.

### Escopo MVP

- Cluster AWS mínimo (subset ODP) com ZooKeeper, HDFS, YARN mínimo e Apache Atlas. Ver [`05-infraestrutura/cluster-hadoop.md`](05-infraestrutura/cluster-hadoop.md) e [`adr/ADR-0002-topologia-aws-cluster-minimo.md`](adr/ADR-0002-topologia-aws-cluster-minimo.md).
- Subconjunto fixo do banco PS (92 tabelas) como massa relacional de avaliação. Ver [`04-arquitetura-dados/banco-putz-dominio.md`](04-arquitetura-dados/banco-putz-dominio.md) e [`04-arquitetura-dados/schema-massa-teste.md`](04-arquitetura-dados/schema-massa-teste.md).
- Aplicação Java 25 + Spring Boot + Spring AI com servidor MCP, adaptador Atlas, validador sintático Apache
  Calcite (dialeto Hive), executor SQL em Hive e harness com logs estruturados.
- Métricas essenciais: aderência estrutural, executabilidade, rastreabilidade da trilha pergunta-tool calls-SQL, orçamento de tool calls.

### Fora do escopo MVP (pós-MVP opcional)

- Mock fiel de contingência ao Atlas.
- Estudos de sensibilidade de prompt.
- Observabilidade ampliada (tracing distribuído, dashboards).
- Pipeline de CI/CD multi-ambiente.

### Decisões já registradas

| Tema | Decisão | Documento |
|------|---------|-----------|
| Fundação arquitetural | Hexagonal por contexto, MCP versionado, evidência por `runId` | [`adr/ADR-0001-fundacao-arquitetural.md`](adr/ADR-0001-fundacao-arquitetural.md) |
| Topologia AWS | Cluster ODP em AWS x86_64 com Ubuntu 24.04 (ODP 1.3.1.0), Atlas no cluster e sizing robusto (1 master + 3 workers). | [`adr/ADR-0002-topologia-aws-cluster-minimo.md`](adr/ADR-0002-topologia-aws-cluster-minimo.md) |
| Massa de teste | Subconjunto PS (92 tabelas) fixo substitui exemplos sintéticos | [`04-arquitetura-dados/schema-massa-teste.md`](04-arquitetura-dados/schema-massa-teste.md) |
| Validador sintático SQL | Apache Calcite (dialeto Hive) | Cap.~4 + [`06-implementacao-java/ports-adapters.md`](06-implementacao-java/ports-adapters.md) |

## Próximo passo

[`02-arquitetura-negocio.md`](02-arquitetura-negocio.md)
