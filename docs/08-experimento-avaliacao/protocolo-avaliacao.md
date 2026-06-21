---
description: Desenho experimental, bateria de 30 perguntas e critérios de desfecho.
tags:
  - experimento
---

# Protocolo de avaliação experimental

!!! info "Recomendado para leitura prévia"
    - **[Produto e escopo](../01-produto-e-escopo.md)** — definição de erro estrutural.
    - **[Schema massa de teste](../04-arquitetura-dados/schema-massa-teste.md)** — inventário das 92 entidades.
    - **[Runbook de reprodutibilidade](runbook-reprodutibilidade.md)** — passos para repetir uma corrida com evidências.
    - **[Inferência e prompts](llm-inferencia-e-prompts.md)** — configuração LLM e templates de prompt.
    - **[Métricas e fórmulas](metricas-formulas.md)** — fórmulas e schema `metrics.json`.


### Unidade de avaliação

Cada execução da cadeia:

`pergunta -> tools MCP -> SQL(s) (até 5) -> validação -> execução -> registro`

1 pergunta = 1 sessão = 1 corrida. Resposta **agregada** na trilha e no gabarito.

### Orçamento de tool calls

- Limite máximo fixado: **10 chamadas por sessão** (equivalente a 10 por pergunta).
- O consumo efetivo é registrado em `metrics.json` (`toolCalls`) e na trilha `session.jsonl`.
- Exceder o limite classifica a corrida como `budget_exceeded`.
- O catálogo MCP expõe **quinze tools** de descoberta (ver [Contratos MCP v1](../07-contratos-mcp/contracts-v1.md)). A avaliação MVP prioriza as três basais (`catalog.listTables`, `catalog.describeTable`, `catalog.listRelationships`); as doze complementares ficam disponíveis sob o mesmo orçamento.

### Configuração LLM (pré-requisito de cada corrida)

Antes das etapas do protocolo, fixar configuração conforme [Inferência e prompts](llm-inferencia-e-prompts.md):

| Item | Política v1 |
|------|-------------|
| `temperature` | **0** (`gemini-3.5-flash`, baseline); omitido em `gpt-5.4-nano` |
| `maxOutputTokens` | **4096** |
| `topP` | omitido (`null`) |
| Prompts | Templates v1 em [Manifesto de prompts v1](../templates/prompts/prompts-manifest-v1.json) |
| Paridade | Instruções anti-alucinação idênticas em `system-shared-v1.md` |
| Registro | `context.json` conforme [Schema context.json v1](../evidence/context-schema-v1.json) |

### Checklist por corrida (modo MCP)

- [ ] Receber pergunta e inicializar `runId`.
- [ ] Consultar metadados via tools MCP (máximo 10 chamadas).
- [ ] Gerar até cinco SQLs candidatos por pergunta.
- [ ] Validar sintaxe (Calcite/Hive) de cada statement.
- [ ] Validar aderência estrutural contra catálogo canônico.
- [ ] Executar SQLs aprovados no cluster controlado.
- [ ] Registrar trilha (`session.jsonl`), métricas (`metrics.json`) e contexto (`context.json`).

### Etapas do protocolo

1. Receber pergunta e inicializar `runId`.
2. Consultar metadados via tools MCP sob orçamento fixado (máximo de 10 chamadas).
3. Gerar até cinco SQLs candidatos por pergunta.
4. Executar validação sintática (`parse` Calcite, dialeto Hive) de cada statement.
5. Executar validação estrutural contra catálogo canônico (Atlas governa o subconjunto PS, 92 tabelas).
6. Executar SQLs no banco de testes (subconjunto fixo do PS).
7. Classificar desfecho agregado, registrar trilha completa e gravar `metrics.json`.

### Métricas essenciais (modo MCP)

| Métrica | Unidade | Fórmula resumida | Modo |
|---------|---------|------------------|------|
| Desfecho $o_i$ | enum (6 classes) | algoritmo em `metricas-formulas.md` | MCP |
| Aderência estrutural $A_{\mathrm{est}}$ | [0,1] | fração sem `structural_error` | MCP |
| Executabilidade $A_{\mathrm{exec}}$ | [0,1] | fração `success` | MCP |
| Sucesso parcial $A_{\mathrm{part}}$ | [0,1] | fração `partial_success` | MCP |
| Rastreabilidade $T$ | [0,1] | fração com trilha completa (1:N) | MCP |
| Orçamento $\bar{k}$, $R_{\mathrm{budget}}$ | adimensional / [0,1] | média e fração $k_i \leq 10$ | MCP |
| Latência $L_{p50}$, $L_{p95}$ | s | percentis sobre $\{L_i\}$ | MCP |
| Tokens $n_{\mathrm{in},i}$, $n_{\mathrm{out},i}$ | tokens | reportados pela API | MCP |
| FinOps $C_i$, $\bar{C}$ | USD | $n_{\mathrm{in}} p_{\mathrm{in}} + n_{\mathrm{out}} p_{\mathrm{out}}$ | MCP |

### Métricas essenciais (modo baseline)

| Métrica | Unidade | Fórmula resumida | Modo |
|---------|---------|------------------|------|
| Aderência ao gabarito $A_{\mathrm{gab}}$ | [0,1] | fração resposta = gabarito | baseline |

Taxonomia MCP (`success`, `partial_success`, erros estruturais, rastreabilidade Atlas, orçamento) **não
se aplica** ao baseline. Latência, tokens e FinOps **não** são métricas do modo baseline.

### Protocolo do comparativo simples (`baseline-static`)

0. Auditar executabilidade das colas $G_i$ (§ Auditoria em
   [Gabarito da bateria](../evidence/gabarito-bateria-v1.md)).
1. Anexar [Schema massa de teste](../04-arquitetura-dados/schema-massa-teste.md) ao prompt (injecção estática; 0 tool calls).
2. Submeter cada pergunta de [Bateria de 30 perguntas](../evidence/bateria-30-perguntas-v1.csv)
   com `modelVersion` `gemini-3.5-flash` (campanha v1, um único provedor).
3. Comparar resposta agregada final com $G_i$ em [Gabarito da bateria](../evidence/gabarito-bateria-v1.md).
4. Registrar métricas em [Métricas baseline v1](../evidence/baseline-metricas-v1.csv) (30 corridas).

Detalhes operacionais: [Runbook de reprodutibilidade](runbook-reprodutibilidade.md) (secção `baseline-static`).

### Infraestrutura (separada)

- $C_{\mathrm{infra}}$: estimativa de custo cluster AWS no período da campanha.
- **Não** entra em $C_i$ nem em comparativos FinOps.

### Classificação de desfecho (6 classes, modo MCP)

Ordem de precedência:

1. `budget_exceeded` — $k_i > 10$
2. `syntax_error`
3. `structural_error`
4. `execution_error` — falha Hive ou nenhum SQL bate gabarito
5. `partial_success` — parte dos SQLs bate gabarito
6. `success` — todos os SQLs exigidos batem gabarito

### Tarifas FinOps (referência)

| modelVersion | Input (USD / 1M tokens) | Output (USD / 1M tokens) |
|--------------|-------------------------|--------------------------|
| `gpt-5.4-nano` | 0,20 | 1,25 |
| `gemini-3.5-flash` | 1,50 | 9,00 |

Fontes: documentação Spring AI para integração OpenAI e Google (Gemini).

### Ameaças à validade

- sobreajuste de prompt à massa fixa do PS;
- variação temporal de comportamento da API de LLM;
- simplificações do laboratório AWS frente a cenário corporativo real;
- viés de domínio do PS (domínios comerciais e operacionais) frente a outros domínios.

### Evidência mínima por corrida

- `runId`, `campaignId` (`mcp` ou `baseline-static`)
- pergunta original
- chamadas de tool e payloads resumidos (MCP)
- snapshot de metadados usados (MCP)
- lista de SQLs (até 5) e desfechos por statement (MCP)
- resultado de parse e execução
- `metrics.json` conforme [Métricas e fórmulas](metricas-formulas.md)
- `context.json` conforme [Schema context.json v1](../evidence/context-schema-v1.json)
- `seed`, `modelVersion`, `promptVersion`, `commitHash`

!!! tip "Recomendado para leitura posterior"
    Seguinte: **[Runbook de reprodutibilidade](runbook-reprodutibilidade.md)** — passos para repetir uma corrida com evidências.
