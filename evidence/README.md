---
description: Convenções de corridas, bateria e artefatos experimentais versionados.
tags:
  - experimento
  - evidencia
---

# Evidências experimentais

## Corridas MCP (`evidence/run-.../`)

Cada corrida deve ser registrada em diretório próprio:

- `evidence/run-YYYYMMDD-HHMM-<id-curto>/`

Conteúdo mínimo esperado:

- `session.jsonl`
- `metrics.json`
- `context.json`
- `summary.md`

Schema: [Schema do contexto](context-schema.json). Exemplos em [Exemplo context baseline](examples/context-baseline.example.json).

Não sobrescreva corridas anteriores. Qualquer ajuste gera novo `runId`.

## Artefatos de decisão humana (T11 / T08)

Estes arquivos são **preenchidos pelo autor**, não inferidos por agentes de IA. Ver
`ai-interaction/correcao-metodologia.md` (documentação acadêmica offline; seção «Decisões e execução
exclusivas do autor»).

| Arquivo | Uso |
|----------|-----|
| [Bateria de perguntas](bateria-40-perguntas.csv) | 40 perguntas; 6 cenários; SIMPLES / MÉDIA / COMPLEXA (10 / 10 / 20). Campo `pergunta_nl`: enunciado em linguagem natural para o usuário final, sem nomes de schema; mapeamento técnico em `notas_autor` e no gabarito |
| [Gabarito da bateria](gabarito-bateria.md) | Gabarito $G_i$ por `question_id`; colas SQL de referência — **MySQL 8+**, schema `base_laboratorial` |
| [Matriz de cobertura da bateria](matriz-cobertura-bateria.md) | Cobertura cenário × dificuldade × tabelas (40 perguntas) |
| [Métricas baseline](baseline-metricas.csv) | Métricas da campanha `baseline-static`: 40 perguntas × 2 modelos
(`gemini-3.5-flash`, `gemini-3.1-pro`); mapa $g_i$ em [Auditoria baseline](baseline-auditoria-gabarito.md) |
| [json\_data e data\_source](json_data-data_source-schema-notes.md) | Schema e conteúdo das colunas semiestruturadas usadas em Q31–Q40 |

Esquema estático do comparativo simples: [Schema massa de teste](../arquitetura/dados/schema-massa-teste.md)
e [Pacote experimental](../experimento/pacote-experimental.md).

## Inventário e catálogo de tools MCP (T06)

Artefatos derivados do Swagger do Apache Atlas que sustentam o catálogo fechado de quinze tools MCP.

| Arquivo | Uso |
|----------|-----|
| [Inventário Atlas API](inventario-atlas-api-para-mcp.md) | Triagem das operações de leitura da API REST v2 do Atlas |
| [Matriz de 15 tools MCP](matriz-15-tools-mcp.md) | Decisão final: 3 basais + 12 complementares, com mapeamento Atlas |

Valores agregados ($A_{\mathrm{gab}}$) derivam do CSV baseline preenchido, conforme
[Métricas e fórmulas](../experimento/metricas-formulas.md). A campanha usa
`gemini-3.5-flash` ($A_{\mathrm{gab}} = 47{,}5\%$, 19/40) e `gemini-3.1-pro` ($A_{\mathrm{gab}} = 77{,}5\%$,
31/40), ambos em modo `baseline-static` com $N_{\mathrm{base}} = 40$.
