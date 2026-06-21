# Evidências experimentais

## Corridas MCP (`evidence/run-.../`)

Cada corrida deve ser registrada em diretório próprio:

- `evidence/run-YYYYMMDD-HHMM-<id-curto>/`

Conteúdo mínimo esperado:

- `session.jsonl`
- `metrics.json`
- `context.json`
- `summary.md`

Schema v1: [`context-schema-v1.json`](context-schema-v1.json). Exemplos em [`examples/`](examples/).

Não sobrescreva corridas anteriores. Qualquer ajuste gera novo `runId`.

## Artefatos de decisão humana (T11 / T08)

Estes ficheiros são **preenchidos pelo autor**, não inferidos por agentes de IA. Ver
`ai-interaction/correcao-metodologia.md` (pacote académico externo; secção «Decisões e execução
exclusivas do autor»).

| Ficheiro | Uso |
|----------|-----|
| [`bateria-30-perguntas-v1.csv`](bateria-30-perguntas-v1.csv) | 30 perguntas; 6 cenários; SIMPLES / MÉDIA / COMPLEXA — **revisão humana aprovada** (`9985067`) |
| [`gabarito-bateria-v1.md`](gabarito-bateria-v1.md) | Gabarito $G_i$ por `question_id`; inclui auditoria de executabilidade e resultado baseline v1 |
| [`matriz-cobertura-bateria-v1.md`](matriz-cobertura-bateria-v1.md) | Cobertura cenário × dificuldade × tabelas |
| [`baseline-metricas-v1.csv`](baseline-metricas-v1.csv) | Métricas da campanha `baseline-static` v1 (Gemini-only, 30 corridas; `gabarito_match` por pergunta) |

Esquema estático do comparativo simples: [`schema-massa-teste.md`](../04-arquitetura-dados/schema-massa-teste.md).

## Inventário e catálogo de tools MCP (T06)

Artefatos derivados do Swagger do Apache Atlas que sustentam o catálogo fechado de quinze tools MCP.

| Ficheiro | Uso |
|----------|-----|
| [`inventario-atlas-api-para-mcp.md`](inventario-atlas-api-para-mcp.md) | Triagem das operações de leitura da API REST v2 do Atlas |
| [`matriz-15-tools-mcp-v1.md`](matriz-15-tools-mcp-v1.md) | Decisão final: 3 basais + 12 complementares, com mapeamento Atlas |

Valores agregados ($A_{\mathrm{gab}}$) derivam do CSV baseline preenchido, conforme
[`metricas-formulas.md`](../08-experimento-avaliacao/metricas-formulas.md). A campanha v1 usa apenas
`gemini-3.5-flash` ($N_{\mathrm{base}} = 30$); extensão a segundo provedor é opcional e não mistura com esta v1.
