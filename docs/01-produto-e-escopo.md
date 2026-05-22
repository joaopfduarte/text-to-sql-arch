# Produto e escopo metodológico

## Propósito

Apresentar o artefato Text-to-SQL do TCC, congelar o recorte metodológico e tornar explícitas as decisões de ambiente que sustentam a reprodutibilidade.

## Leitor

Pessoa que precisa entender, em até 15 minutos, o que é o artefato, o que está dentro do escopo do TCC e o que ficou fora.

## Pré-requisitos

- Nenhum. Este é o primeiro documento operacional.

## Conteúdo

### O produto em uma frase

Um pipeline Text-to-SQL em que um agente LLM consulta metadados de catálogo via servidor MCP antes de gerar SQL, valida a aderência estrutural contra o catálogo canônico (Apache Atlas) e executa o SQL sob ambiente controlado, registrando trilha completa por corrida.

### Cadeia funcional

`pergunta em linguagem natural -> consultas de metadados via MCP -> síntese de SQL -> validação sintática e estrutural -> execução controlada -> registro de métricas e evidências`

### Recorte científico

- Tipo de pesquisa: aplicada e experimental.
- Objeto: artefato único `Text-to-SQL` com grounding em metadados via `MCP`.
- Horizonte: janela de 5 a 6 meses até a apresentação no fim de novembro de 2026.
- Ambiente: laboratório AWS reprodutível, operado em conta de estudo, com infraestrutura como código e cluster mínimo (sem dependência de tenant corporativo, mas com cluster real provisionado).

### Definição operacional de erro estrutural

Um SQL contém erro estrutural quando:

1. referencia tabela, visão ou coluna ausente do catálogo canônico;
2. usa `schema` incompatível com o catálogo canônico;
3. cria junções não suportadas por relacionamentos recuperados dos metadados.

### Escopo MVP

- Cluster AWS mínimo (subset ODP) com ZooKeeper, HDFS, YARN mínimo e Apache Atlas. Ver [`05-infraestrutura/cluster-hadoop.md`](05-infraestrutura/cluster-hadoop.md) e [`adr/ADR-0002-topologia-aws-cluster-minimo.md`](adr/ADR-0002-topologia-aws-cluster-minimo.md).
- Subconjunto congelado do banco XPTO como massa relacional de avaliação. Ver [`04-arquitetura-dados/banco-xpto-dominio.md`](04-arquitetura-dados/banco-xpto-dominio.md) e [`04-arquitetura-dados/schema-massa-teste.md`](04-arquitetura-dados/schema-massa-teste.md).
- Aplicação Java 25 + Spring Boot + Spring AI com servidor MCP, adaptador Atlas, validador/executor SQL e harness com logs estruturados.
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
| Massa de teste | Subconjunto XPTO congelado substitui exemplos sintéticos | [`04-arquitetura-dados/schema-massa-teste.md`](04-arquitetura-dados/schema-massa-teste.md) |

## Próximo passo

[`02-arquitetura-negocio.md`](02-arquitetura-negocio.md)
