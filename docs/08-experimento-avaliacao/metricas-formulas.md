---
description: Indicadores, fórmulas e schema metrics.json do experimento.
tags:
  - experimento
---

# Especificação de métricas e fórmulas

!!! info "Recomendado para leitura prévia"
    - **[Protocolo de avaliação](protocolo-avaliacao.md)** — desenho experimental, bateria e critérios de desfecho.
    - **[Runbook de reprodutibilidade](runbook-reprodutibilidade.md)** — passos para repetir uma corrida com evidências.
    - **[Gabarito da bateria](../evidence/gabarito-bateria-v1.md)** — quando publicado.
    - **Tarifas GPT-5.4 Nano** — referência de custo do provedor (documentação externa ao repositório).
    - **Tarifas Gemini 3.5 Flash** — referência de custo do provedor (documentação externa ao repositório).

## Unidade experimental

1 pergunta = 1 sessão = 1 corrida. FinOps **por sessão** = **por corrida** ($C_i$).


## Inventário de métricas

### A. Modo MCP (essenciais)

| Símbolo | Nome | Unidade | Agregação |
|---------|------|---------|-----------|
| $o_i$ | Desfecho da corrida $c_i$ | enum (6 classes) | distribuição |
| $A_{\mathrm{est}}$ | Aderência estrutural | [0,1] | média sobre $\mathcal{C}$ |
| $A_{\mathrm{exec}}$ | Executabilidade | [0,1] | média |
| $A_{\mathrm{part}}$ | Sucesso parcial | [0,1] | média |
| $T$ | Rastreabilidade | [0,1] | média |
| $k_i$ | Tool calls consumidas | inteiro ≥ 0 | — |
| $\bar{k}$ | Média de tool calls | adimensional | média |
| $R_{\mathrm{budget}}$ | Respeito ao orçamento (≤10) | [0,1] | média |
| $L_i$ | Latência ponta a ponta | s | — |
| $L_{p50}$, $L_{p95}$ | Percentis de latência | s | sobre $\{L_i\}$ |
| $n_{\mathrm{in},i}$, $n_{\mathrm{out},i}$ | Tokens entrada/saída | tokens | — |
| $C_i$ | Custo FinOps LLM | USD | — |
| $\bar{C}$, $C_{\mathrm{total}}$ | Custo médio / total campanha | USD | agregados |

### B. Modo MCP (taxas de erro complementares)

| Símbolo | Fórmula |
|---------|---------|
| $A_{\mathrm{syn}}$ | $\|\{c_i: o_i=\texttt{syntax\_error}\}\|/N$ |
| $A_{\mathrm{struct}}$ | $\|\{c_i: o_i=\texttt{structural\_error}\}\|/N$ |
| $A_{\mathrm{execErr}}$ | $\|\{c_i: o_i=\texttt{execution\_error}\}\|/N$ |
| $A_{\mathrm{budget}}$ | $\|\{c_i: o_i=\texttt{budget\_exceeded}\}\|/N$ |

### C. Modo baseline

| Símbolo | Nome |
|---------|------|
| $g_i$ | Gabarito atendido (booleano) |
| $A_{\mathrm{gab}}$ | Fração de respostas corretas vs gabarito |

### D. Infraestrutura (separada)

| Símbolo | Nome |
|---------|------|
| $C_{\mathrm{infra}}$ | Estimativa custo cluster AWS (período da campanha) |

**Não entra** em $C_i$. Latência, tokens e FinOps aplicam-se apenas ao modo MCP.


## Algoritmo de desfecho $o_i$

Seja $S_i = \{s_{i,1},\ldots,s_{i,n_i}\}$ com $n_i \leq 5$ SQLs válidos e $G_i$ o gabarito da pergunta.
Avaliar pipeline MCP (parse Calcite → estrutural → execução Hive) e match com $G_i$ na **resposta agregada**.

Ordem de precedência (primeira condição verdadeira define $o_i$):

1. `budget_exceeded` — $k_i > 10$
2. `syntax_error` — falha de parse Calcite em algum SQL
3. `structural_error` — referência inválida ao catálogo canônico
4. `execution_error` — falha Hive ou **nenhum** SQL bate gabarito
5. `partial_success` — parte dos SQLs válidos bate gabarito, não todos
6. `success` — pipeline OK e **todos** os SQLs exigidos batem gabarito


## Fórmulas — modo MCP

Conjunto de corridas: $\mathcal{C}=\{c_1,\ldots,c_N\}$, $|\mathcal{C}|=N$.

$$A_{\mathrm{est}} = \frac{1}{N}\sum_{i=1}^{N} \mathbb{1}[o_i \neq \texttt{structural\_error}]$$

$$A_{\mathrm{exec}} = \frac{1}{N}\sum_{i=1}^{N} \mathbb{1}[o_i = \texttt{success}]$$

$$A_{\mathrm{part}} = \frac{1}{N}\sum_{i=1}^{N} \mathbb{1}[o_i = \texttt{partial\_success}]$$

$\text{trilha}(c_i)$ completa sse `session.jsonl` cobre: pergunta → tool calls → metadados → todos os SQLs
→ desfechos por statement.

$$T = \frac{1}{N}\sum_{i=1}^{N} \mathbb{1}[\text{trilha}(c_i)\ \text{completa}]$$

$$\bar{k} = \frac{1}{N}\sum_{i=1}^{N} k_i, \quad R_{\mathrm{budget}} = \frac{1}{N}\sum_{i=1}^{N} \mathbb{1}[k_i \leq 10]$$

Ordenar $\{L_i\}$: $L_{p50} = L_{(\lceil 0{,}5\,N \rceil)}$, $L_{p95} = L_{(\lceil 0{,}95\,N \rceil)}$.

### FinOps por corrida

Tarifas por `modelVersion` $m$ (USD por token):

| Modelo | $p_{\mathrm{in},m}$ | $p_{\mathrm{out},m}$ |
|--------|---------------------|----------------------|
| `gpt-5.4-nano` | $0{,}20 / 10^6$ | $1{,}25 / 10^6$ |
| `gemini-3.5-flash` | $1{,}50 / 10^6$ | $9{,}00 / 10^6$ |

$$C_i = n_{\mathrm{in},i}\, p_{\mathrm{in},m(i)} + n_{\mathrm{out},i}\, p_{\mathrm{out},m(i)}$$

$$\bar{C} = \frac{1}{N}\sum_{i=1}^{N} C_i, \quad C_{\mathrm{total}} = \sum_{i=1}^{N} C_i$$

MVP: sem custo monetário de tool calls Atlas em FinOps; $k_i$ é métrica de controle.


## Fórmulas — modo baseline

Sem MCP: $k_i = 0$; não calcular $A_{\mathrm{est}}$, $T$, $R_{\mathrm{budget}}$.

$$g_i = \mathbb{1}[\text{resposta agregada}_i = G_i]$$

$$A_{\mathrm{gab}} = \frac{1}{N_{\mathrm{base}}}\sum_{i=1}^{N_{\mathrm{base}}} g_i$$

Na campanha `baseline-static` v1, $N_{\mathrm{base}} = 30$ com um único `modelVersion` (`gemini-3.5-flash`).
Extensão futura a segundo provedor é opcional e não se mistura com esta v1. A executabilidade das colas $G_i$
no MySQL é pré-requisito documentado no gabarito e **não** entra em $A_{\mathrm{gab}}$.


## Schema `metrics.json`

Campos obrigatórios por corrida (modo MCP):

```json
{
  "runId": "run-20260609-1430-a1b2",
  "campaignId": "mcp",
  "modelVersion": "gpt-5.4-nano",
  "outcome": "partial_success",
  "toolCalls": 7,
  "latencySec": 4.2,
  "n_in": 12000,
  "n_out": 800,
  "cost_usd": 0.0034,
  "sqlCount": 3,
  "traceComplete": true
}
```

Campos obrigatórios (modo baseline):

```json
{
  "runId": "run-20260609-1500-c3d4",
  "campaignId": "baseline-static",
  "modelVersion": "gemini-3.5-flash",
  "gabaritoMatch": true
}
```

| Campo | Tipo | Descrição |
|-------|------|-----------|
| `runId` | string | Identificador da corrida |
| `campaignId` | string | `mcp` ou `baseline-static` |
| `modelVersion` | string | Modelo fixado na corrida |
| `outcome` | string | Uma das 6 classes (só MCP) |
| `toolCalls` | integer | $k_i$ (0 no baseline) |
| `latencySec` | number | $L_i$ em segundos (só MCP) |
| `n_in`, `n_out` | integer | Tokens reportados pela API (só MCP) |
| `cost_usd` | number | $C_i$ calculado pela fórmula FinOps (só MCP) |
| `gabaritoMatch` | boolean | $g_i$ (baseline) |
| `sqlCount` | integer | $n_i \leq 5$ (MCP) |
| `traceComplete` | boolean | Trilha completa (MCP) |

Metadados de reprodutibilidade permanecem em `context.json` (ver runbook).


## Exemplo numérico

Corrida $c_i$, `gpt-5.4-nano`: $n_{\mathrm{in}}=12\,000$, $n_{\mathrm{out}}=800$, $k_i=7$, $L_i=4{,}2\,\mathrm{s}$,
$o_i=\texttt{partial\_success}$.

$$C_i = 12000 \times \frac{0{,}20}{10^6} + 800 \times \frac{1{,}25}{10^6} \approx 0{,}0024 + 0{,}0010 = 0{,}0034\ \text{USD}$$

Campanha $N=60$: agregar $A_{\mathrm{est}}$, $\bar{k}$, $L_{p50}$, $\bar{C}$ sobre o conjunto de corridas.

!!! tip "Recomendado para leitura posterior"
    Seguinte: **[Runbook de reprodutibilidade](runbook-reprodutibilidade.md)** — passos para repetir uma corrida com evidências.
