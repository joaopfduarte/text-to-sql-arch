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

Schema v1: [Schema context.json v1](context-schema-v1.json). Exemplos em [Exemplo context baseline v1](examples/context-baseline-v1.example.json).

Não sobrescreva corridas anteriores. Qualquer ajuste gera novo `runId`.

## Artefatos de decisão humana (T11 / T08)

Estes arquivos são **preenchidos pelo autor**, não inferidos por agentes de IA. Ver
`ai-interaction/correcao-metodologia.md` (documentação acadêmica offline; seção «Decisões e execução
exclusivas do autor»).

| Arquivo | Uso |
|----------|-----|
| [Bateria de 30 perguntas](bateria-30-perguntas-v1.csv) | 30 perguntas; 6 cenários; SIMPLES / MÉDIA / COMPLEXA — **revisão humana aprovada** (`9985067`) |
| [Gabarito da bateria](gabarito-bateria-v1.md) | Gabarito $G_i$ por `question_id`; inclui auditoria de executabilidade e resultado baseline v1 |
| [Matriz de cobertura da bateria](matriz-cobertura-bateria-v1.md) | Cobertura cenário × dificuldade × tabelas |
| [Métricas baseline v1](baseline-metricas-v1.csv) | Métricas da campanha `baseline-static` v1 (Gemini-only, 30 corridas; `gabarito_match` por pergunta) |

Esquema estático do comparativo simples: [Schema massa de teste](../04-arquitetura-dados/schema-massa-teste.md).

## Inventário e catálogo de tools MCP (T06)

Artefatos derivados do Swagger do Apache Atlas que sustentam o catálogo fechado de quinze tools MCP.

| Arquivo | Uso |
|----------|-----|
| [Inventário Atlas API](inventario-atlas-api-para-mcp.md) | Triagem das operações de leitura da API REST v2 do Atlas |
| [Matriz de 15 tools MCP](matriz-15-tools-mcp-v1.md) | Decisão final: 3 basais + 12 complementares, com mapeamento Atlas |

Valores agregados ($A_{\mathrm{gab}}$) derivam do CSV baseline preenchido, conforme
[Métricas e fórmulas](../08-experimento-avaliacao/metricas-formulas.md). A campanha v1 usa apenas
`gemini-3.5-flash` ($N_{\mathrm{base}} = 30$); extensão a segundo provedor é opcional e não mistura com esta v1.
