---
description: Passos operacionais para repetir uma corrida com evidências completas.
tags:
  - experimento
  - operacao
---

# Runbook de operação e reprodutibilidade

!!! info "Recomendado para leitura prévia"
    - **[Protocolo de avaliação](protocolo-avaliacao.md)** — desenho experimental, bateria e critérios de desfecho.
    - **[Inferência e prompts](llm-inferencia-e-prompts.md)** — hiperparâmetros, prompts e schema `context.json`.
    - **[Métricas e fórmulas](metricas-formulas.md)** — schema `metrics.json` e fórmulas.
    - **[Contratos MCP v1](../arquitetura/contratos-mcp/contracts-v1.md)** — versão de contrato MCP.


### Convenção de identificador

Formato obrigatório:

`run-YYYYMMDD-HHMM-<id-curto>`

Exemplo: `run-20260418-1540-7f3c`.

### Metadados obrigatórios por execução

Registrados em `context.json` (schema: [Schema context.json v1](../evidence/context-schema-v1.json)):

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
- `promptArtifactsHash` — SHA-256 dos quatro arquivos `.md` do manifesto v1

Detalhes e política (`temperature=0` no Gemini): [Inferência e prompts](llm-inferencia-e-prompts.md).

Exemplos: [Exemplo context baseline v1](../evidence/examples/context-baseline-v1.example.json),
[Exemplo context MCP v1](../evidence/examples/context-mcp-v1.example.json).

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

Exemplos JSON completos: [Métricas e fórmulas](metricas-formulas.md).

### Trilha `session.jsonl` (1:N)

Cada linha ou bloco deve permitir reconstruir:

1. Pergunta original
2. Sequência de tool calls MCP
3. Metadados consultados
4. Lista de SQLs ($n_i \leq 5$)
5. Desfecho por statement e desfecho agregado $o_i$

### Checklist de reprodutibilidade

- [ ] Commit limpo e registrado (`commitHash`).
- [ ] Versão do contrato MCP fixada (`contractsVersion`).
- [ ] Dataset fixo e versionado (massa PS de 92 tabelas; ver `schema-massa-teste.md`).
- [ ] Seed explícita.
- [ ] Modelo, `provider`, `promptVersion` e `inferenceConfig` registrados (`temperature=0` no Gemini).
- [ ] `promptArtifactsHash` calculado e conferido contra templates em [Manifesto de prompts v1](../templates/prompts/prompts-manifest-v1.json).
- [ ] Política de tool budget registrada (`toolBudget`).
- [ ] `metrics.json` preenchido conforme modo (MCP ou baseline).
- [ ] Evidências salvas em pasta da corrida.

### Política de retenção

- Nunca sobrescrever evidências de corrida.
- Correções devem gerar nova corrida com novo `runId`.

### Campanha comparativo simples (`baseline-static`)

Execução manual no ambiente Google (`gemini-3.5-flash`) na campanha v1, **antes** do modo MCP. Sem tools MCP;
esquema via DDL estático.

**Esquema no prompt:** [Schema massa de teste](../arquitetura/dados/schema-massa-teste.md) (92 tabelas MySQL).
Registrar `commitHash` do código-fonte do artefato e hash ou versão do arquivo DDL em `datasetVersion` / notas da campanha.

**Bateria:** [Bateria de 30 perguntas](../evidence/bateria-30-perguntas-v1.csv) +
[Gabarito da bateria](../evidence/gabarito-bateria-v1.md) (`batteryVersion` v1, revisão
aprovada).

#### Checklist pré-voo (`baseline-static`)

- [ ] Auditoria de executabilidade: executar as 30 colas em `gabarito-bateria-v1.md` contra `massa_teste_laboratorio`; registrar em § Auditoria do mesmo arquivo; só prosseguir se 30/30 OK.
- [ ] Bateria e gabarito aprovados (`9985067`).
- [ ] `DDL offline` versionado e anexado ao prompt de cada corrida.
- [ ] `campaignId`: `baseline-static`; `toolBudget`: 0 (sem MCP).
- [ ] `modelVersion` fixo `gemini-3.5-flash`; `provider`: `google`; `seed` explícita por campanha.
- [ ] `inferenceConfig.temperature`: **0**; `maxOutputTokens`: **4096** (ver [Inferência e prompts](llm-inferencia-e-prompts.md)).
- [ ] Templates de prompt v1 congelados; `promptArtifactsHash` registrado em cada `context.json`.
- [ ] 30 perguntas = 30 corridas na campanha v1 (Gemini-only).
- [ ] Gabarito $G_i$ disponível para classificar `gabaritoMatch`.

#### Registro consolidado

Preencher [Métricas baseline v1](../evidence/baseline-metricas-v1.csv) — uma linha por
corrida:

| Coluna | Descrição |
|--------|-----------|
| `run_id` | Identificador único da corrida |
| `question_id` | Q01--Q30 |
| `model_version` | Campanha v1: `gemini-3.5-flash` |
| `provider` | Campanha v1: `google` |
| `gabarito_match` | `true` / `false` |
| `notas_autor` | Observações opcionais |

Agregados ($A_{\mathrm{gab}}$) calculados conforme [Métricas e fórmulas](metricas-formulas.md) e
incorporados ao Cap. 4 após a coleta.

#### Limitação D12

O DDL integral no prompt aumenta o contexto de entrada; declarar como ameaça à validade interna na
metodologia (Cap. 4).

!!! tip "Recomendado para leitura posterior"
    Seguinte: **[Operação](../operacao/index.md)** — ciclo de corrida, incidentes e governança.
