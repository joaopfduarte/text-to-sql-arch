---
description: Mapa g_i da campanha baseline-static (40 perguntas, dois modelos).
tags:
  - experimento
  - evidencia
---

# Auditoria de aderência ao gabarito — baseline-static

Fonte canônica de $g_i$: [Métricas baseline](baseline-metricas.csv).

Gabarito: [Gabarito da bateria](gabarito-bateria.md).

## Convenção

- $g_i=1$ (`gabarito_match=true`): resposta aderente a $G_i$, incluindo **parciais estruturais** dentro da
  tolerância do gabarito.
- $N=40$ por `modelVersion`.
- Modo: `baseline-static` (DDL no prompt, 0 tool calls).

## Agregados

| modelVersion | Acertos | Erros | $A_{\mathrm{gab}}$ |
|--------------|---------|-------|-------------------|
| `gemini-3.5-flash` | 19 | 21 | **47,5%** |
| `gemini-3.1-pro` | 31 | 9 | **77,5%** |

Subconjunto histórico Flash Q01--Q30 (jun/2026): 19/30 (63,3%).

## gemini-3.5-flash — mapa $g_i$

| Q | $g_i$ | Notas |
|---|-------|-------|
| Q01--Q07 | 1 | campanha jun/2026 |
| Q08 | 0 | divergiu de $G_i$ |
| Q09--Q11 | 1 | |
| Q12 | 0 | divergiu de $G_i$ |
| Q13 | 1 | |
| Q14--Q18 | 0 | divergiu de $G_i$ |
| Q19 | 1 | |
| Q20 | 0 | divergiu de $G_i$ |
| Q21 | 1 | |
| Q22 | 0 | divergiu de $G_i$ |
| Q23--Q26 | 1 | |
| Q27--Q28 | 0 | divergiu de $G_i$ |
| Q29--Q30 | 1 | |
| Q31--Q40 | 0 | auditoria vs gabarito jun/2026 |

## gemini-3.1-pro — mapa $g_i$

| Q | $g_i$ | Notas |
|---|-------|-------|
| Q01--Q20 | 1 | SIMPLES/MÉDIA — campanha assumida OK |
| Q21--Q25 | 1 | COMPLEXA corretas |
| Q26 | 1 | parcial — junta user_authority |
| Q27 | 0 | ERROR execução |
| Q28 | 0 | person_id vs owner_id; falta publications |
| Q29 | 1 | parcial — falta joins render |
| Q30 | 1 | parcial — falta join project_render |
| Q31 | 0 | telefone e DATEDIFF |
| Q32 | 1 | parcial — falta JSON_VALID |
| Q33 | 0 | ERROR execução |
| Q34 | 0 | chave $.company e joins pagamento |
| Q35 | 0 | owner_id e $.name |
| Q36 | 0 | composição e publications |
| Q37 | 1 | parcial — person_owner_id |
| Q38 | 0 | $.loanValue |
| Q39 | 1 | parcial — company_type |
| Q40 | 0 | filtro JSON espúrio sponsor |

## gemini-3.5-flash Q31--Q40 (resumo de divergências)

Todas $g_i=0$: confusão `data_source`/`json_data`, `origin` vs UF, joins inventados (`user`,
`subscriptions`), `owner_id` vs `person_id`, paths JSON em português ou inexistentes.
