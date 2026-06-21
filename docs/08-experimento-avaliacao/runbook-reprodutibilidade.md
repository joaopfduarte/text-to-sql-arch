# Runbook de operação e reprodutibilidade

## Propósito

Padronizar identificação, metadados e artefatos de cada corrida para garantir reprodutibilidade.

## Leitor

Pessoa que executa corridas e arquiva evidências em `evidence/`.

## Pré-requisitos

- [`protocolo-avaliacao.md`](protocolo-avaliacao.md)
- [`llm-inferencia-e-prompts.md`](llm-inferencia-e-prompts.md) (hiperparâmetros, prompts e schema `context.json`)
- [`metricas-formulas.md`](metricas-formulas.md) (schema `metrics.json` e fórmulas)
- [`../07-contratos-mcp/contracts-v1.md`](../07-contratos-mcp/contracts-v1.md) (versão de contrato MCP)

## Conteúdo

### Convenção de identificador

Formato obrigatório:

`run-YYYYMMDD-HHMM-<id-curto>`

Exemplo: `run-20260418-1540-7f3c`.

### Metadados obrigatórios por execução

Registrados em `context.json` (schema: [`../evidence/context-schema-v1.json`](../evidence/context-schema-v1.json)):

**Identificação e campanha**

- `runId`
- `campaignId` (`mcp` ou `baseline-static`)
- `provider` (`google` ou `openai`)
- `modelVersion`
- `seed`
- `commitHash`
- `datasetVersion`
- `contractsVersion`
- `toolBudget` (limite máximo de chamadas por sessão; **10** no MCP, **0** no baseline)

**Inferência e prompts (v1)**

- `promptVersion` (`v1`)
- `inferenceConfigVersion` (`v1`)
- `inferenceConfig` — objeto com `temperature`, `temperatureSupported`, `topP`, `maxOutputTokens`
- `promptArtifacts` — caminhos repo-relative dos templates usados
- `promptArtifactsHash` — SHA-256 dos quatro ficheiros `.md` do manifesto v1

Detalhes e política (`temperature=0` no Gemini): [`llm-inferencia-e-prompts.md`](llm-inferencia-e-prompts.md).

Exemplos: [`../evidence/examples/context-baseline-v1.example.json`](../evidence/examples/context-baseline-v1.example.json),
[`../evidence/examples/context-mcp-v1.example.json`](../evidence/examples/context-mcp-v1.example.json).

### Estrutura de evidência

Pasta por corrida:

`evidence/<runId>/`

Arquivos mínimos:

- `session.jsonl` (trilha completa: pergunta → tools → metadados → SQL(s) → desfechos)
- `metrics.json` (indicadores por corrida; ver schema abaixo)
- `context.json` (metadados de reprodutibilidade)
- `summary.md` (resultado descritivo da corrida)

### Schema mínimo `metrics.json`

**Modo MCP** — campos obrigatórios:

| Campo | Tipo | Descrição |
|-------|------|-----------|
| `runId` | string | Identificador da corrida |
| `campaignId` | string | `mcp` |
| `modelVersion` | string | Ex.: `gpt-5.4-nano`, `gemini-3.5-flash` |
| `outcome` | string | Uma de: `success`, `partial_success`, `syntax_error`, `structural_error`, `execution_error`, `budget_exceeded` |
| `toolCalls` | integer | $k_i$ |
| `latencySec` | number | $L_i$ (segundos) |
| `n_in` | integer | Tokens de entrada |
| `n_out` | integer | Tokens de saída |
| `cost_usd` | number | $C_i$ (fórmula FinOps) |
| `sqlCount` | integer | Número de SQLs gerados ($\leq 5$) |
| `traceComplete` | boolean | Trilha completa conforme protocolo 1:N |

**Modo baseline** — campos obrigatórios:

| Campo | Tipo | Descrição |
|-------|------|-----------|
| `runId` | string | Identificador da corrida |
| `campaignId` | string | `baseline-static` |
| `modelVersion` | string | Modelo do provedor |
| `gabaritoMatch` | boolean | Resposta agregada = gabarito |

Exemplos JSON completos: [`metricas-formulas.md`](metricas-formulas.md).

### Trilha `session.jsonl` (1:N)

Cada linha ou bloco deve permitir reconstruir:

1. Pergunta original
2. Sequência de tool calls MCP
3. Metadados consultados
4. Lista de SQLs ($n_i \leq 5$)
5. Desfecho por statement e desfecho agregado $o_i$

### Checklist de reprodutibilidade

1. Commit limpo e registrado (`commitHash`).
2. Versão do contrato MCP fixada (`contractsVersion`).
3. Dataset fixo e versionado (massa PS de 92 tabelas; ver `schema-massa-teste.md`).
4. Seed explícita.
5. Modelo, `provider`, `promptVersion` e `inferenceConfig` registrados (`temperature=0` no Gemini).
6. `promptArtifactsHash` calculado e conferido contra templates em [`../templates/prompts/`](../templates/prompts/).
7. Política de tool budget registrada (`toolBudget`).
8. `metrics.json` preenchido conforme modo (MCP ou baseline).
9. Evidências salvas em pasta da corrida.

### Política de retenção

- Nunca sobrescrever evidências de corrida.
- Correções devem gerar nova corrida com novo `runId`.

### Campanha comparativo simples (`baseline-static`)

Execução manual no ambiente Google (`gemini-3.5-flash`) na campanha v1, **antes** do modo MCP. Sem tools MCP;
esquema via DDL estático.

**Esquema no prompt:** [`../04-arquitetura-dados/schema-massa-teste.md`](../04-arquitetura-dados/schema-massa-teste.md) (92 tabelas MySQL).
Registar `commitHash` do repositório e hash ou versão do ficheiro DDL em `datasetVersion` / notas da campanha.

**Bateria:** [`../evidence/bateria-30-perguntas-v1.csv`](../evidence/bateria-30-perguntas-v1.csv) +
[`../evidence/gabarito-bateria-v1.md`](../evidence/gabarito-bateria-v1.md) (`batteryVersion` v1, revisão
aprovada).

#### Checklist pré-voo (`baseline-static`)

0. Auditoria de executabilidade: executar as 30 colas em `gabarito-bateria-v1.md` contra `massa_teste_laboratorio`; registar
   em § Auditoria do mesmo ficheiro; só prosseguir se 30/30 OK.
1. Bateria e gabarito aprovados (`9985067`).
2. `DDL anonimizado offline` versionado e anexado ao prompt de cada corrida.
3. `campaignId`: `baseline-static`; `toolBudget`: 0 (sem MCP).
4. `modelVersion` fixo `gemini-3.5-flash`; `provider`: `google`; `seed` explícita por campanha.
5. `inferenceConfig.temperature`: **0**; `maxOutputTokens`: **4096** (ver [`llm-inferencia-e-prompts.md`](llm-inferencia-e-prompts.md)).
6. Templates de prompt v1 congelados; `promptArtifactsHash` registrado em cada `context.json`.
7. 30 perguntas = 30 corridas na campanha v1 (Gemini-only).
8. Gabarito $G_i$ disponível para classificar `gabaritoMatch`.

#### Registro consolidado

Preencher [`../evidence/baseline-metricas-v1.csv`](../evidence/baseline-metricas-v1.csv) — uma linha por
corrida:

| Coluna | Descrição |
|--------|-----------|
| `run_id` | Identificador único da corrida |
| `question_id` | Q01--Q30 |
| `model_version` | Campanha v1: `gemini-3.5-flash` |
| `provider` | Campanha v1: `google` |
| `gabarito_match` | `true` / `false` |
| `notas_autor` | Observações opcionais |

Agregados ($A_{\mathrm{gab}}$) calculados conforme [`metricas-formulas.md`](metricas-formulas.md) e
incorporados ao Cap. 4 após a coleta.

#### Limitação D12

O DDL integral no prompt aumenta o contexto de entrada; declarar como ameaça à validade interna na
metodologia (Cap. 4).

## Próximo passo

[`../09-operacao.md`](../09-operacao.md)
