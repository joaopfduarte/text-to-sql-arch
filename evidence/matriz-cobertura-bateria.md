---
description: Cobertura cenário × dificuldade × tabelas da bateria.
tags:
  - experimento
  - evidencia
---

# Matriz de cobertura da bateria

## Status

- **Commit de referência:** `9985067` (rebalanceamento MÉDIA/COMPLEXA e 6 cenários)
- **Revisão humana:** aprovada (11/06/2026)
- **Expansão Q31–Q40:** +10 COMPLEXA (27/06/2026); total 40 perguntas, distribuição 10 / 10 / 20.
  Q31–Q40 usam identificadores reais MySQL e exploram `json_data`/`data_source` — ver § Cobertura Q31–Q40.

Fontes: [Bateria de perguntas](bateria-40-perguntas.csv) (40 linhas) e
[Gabarito da bateria](gabarito-bateria.md). Tabelas conforme o DDL das 92
([Schema massa de teste](../arquitetura/dados/schema-massa-teste.md)).

A bateria adopta **6 cenários** (remove `Listagem simples` e `Filtro por enum` da taxonomia anterior de 8).
Sincronizada com `documentacao-academica-externa/cap4-metodologia.tex` (Onda 2, T11).

## Cenário x perguntas

| Cenário | Perguntas | Total |
|---------|-----------|-------|
| Junção 1:N | Q01, Q02, Q03, Q04 | 4 |
| Junção em cadeia | Q05, Q11, Q12, Q21, Q22, Q39 | 6 |
| Agregação | Q06, Q07, Q13, Q23, Q24, Q33, Q34, Q37 | 8 |
| Filtro temporal | Q08, Q14, Q29, Q40 | 4 |
| Junção geográfica | Q09, Q10, Q15, Q30, Q31, Q32 | 6 |
| Junção cross-domínio | Q16, Q17, Q18, Q19, Q20, Q25, Q26, Q27, Q28, Q35, Q36, Q38 | 12 |
| **Total** | — | **40** |

São 6 cenários; cada um com pelo menos 3 perguntas (mínimo I3).

## Dificuldade x contagem

| Dificuldade | Perguntas | Total |
|-------------|-----------|-------|
| SIMPLES | Q01, Q02, Q03, Q04, Q05, Q06, Q07, Q08, Q09, Q10 | 10 |
| MÉDIA | Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19, Q20 | 10 |
| COMPLEXA | Q21–Q30, Q31, Q32, Q33, Q34, Q35, Q36, Q37, Q38, Q39, Q40 | 20 |
| **Total** | — | **40** |

## Cenário x dificuldade

| Cenário | SIMPLES | MÉDIA | COMPLEXA |
|---------|---------|-------|----------|
| Junção 1:N | 4 | 0 | 0 |
| Junção em cadeia | 1 | 2 | 3 |
| Agregação | 2 | 1 | 5 |
| Filtro temporal | 1 | 1 | 2 |
| Junção geográfica | 2 | 1 | 3 |
| Junção cross-domínio | 0 | 5 | 7 |

## Cobertura temática obrigatória das COMPLEXA

| Tema | Perguntas | Total |
|------|-----------|-------|
| Categorias de ativos | Q21, Q22, Q23, Q25, Q26 | 5 (>=4) |
| Permissões de usuário (`user_authority`, `authority`) | Q24, Q26 | 2 (>=2) |
| Jornada vídeo/painel (`publications_user` / `project_render_item`) | Q27, Q28, Q29, Q30 | 4 (>=3) |

## Perguntas com `sql_esperados_max` > 1

| Pergunta | Máximo | Justificativa |
|----------|--------|---------------|
| Q14 | 2 | Um SQL por semestre ou um único com `CASE`. |
| Q19 | 2 | Contagem e soma por tipo de produto. |
| Q23 | 2 | Contagem por raiz mais consulta auxiliar do topo. |
| Q27 | 2 | Um SQL por situação de conta ou um único com `CASE`. |

Total: 4 perguntas (faixa 3-5 atendida).

## Tabela subconjunto laboratorial x frequência

Frequência de uso por tabela na validação estrutural do gabarito (104 referências, 29 tabelas distintas
do inventário MySQL).

| Tabela | Frequência | Perguntas |
|--------|------------|-----------|
| `project_render_item` | 14 | Q27–Q40 |
| `person` | 12 | Q11, Q15–Q18, Q30–Q32, Q34, Q37, Q39, Q40 |
| `project` | 8 | Q03, Q06, Q07, Q11–Q13, Q16, Q17 |
| `transaction` | 6 | Q08, Q14–Q16, Q18, Q20 |
| `ibge__uf` | 6 | Q09, Q10, Q15, Q30–Q32 |
| `project_render` | 6 | Q27–Q30, Q33, Q34 |
| `asset_category` | 5 | Q21–Q23, Q25, Q26 |
| `publications_user` | 5 | Q27–Q29, Q35, Q36 |
| `product` | 4 | Q02, Q11, Q16, Q19 |
| `franquias` | 3 | Q01, Q04, Q05 |
| `project_payment` | 3 | Q03, Q06, Q13 |
| `project_item` | 3 | Q11, Q16, Q19 |
| `transaction_coupon` | 3 | Q17, Q37, Q38 |
| `asset_item` | 3 | Q21–Q23 |
| `asset_item__categories` | 3 | Q21–Q23 |
| `product_type` | 2 | Q02, Q19 |
| `franquias__redes_franquia` | 2 | Q04, Q05 |
| `ibge__city` | 2 | Q09, Q10 |
| `user_authority` | 2 | Q24, Q26 |
| `asset_category__users` | 2 | Q25, Q26 |
| `publications` | 2 | Q28, Q36 |
| `franquias__unidades` | 1 | Q01 |
| `franquias__segmentos` | 1 | Q05 |
| `project_step` | 1 | Q12 |
| `timeline_event` | 1 | Q12 |
| `subscription_plans` | 1 | Q20 |
| `subscriptions` | 1 | Q20 |
| `authority` | 1 | Q24 |
| `user` | 1 | Q26 |

## Domínios cobertos

| Domínio | Tabelas na bateria |
|---------|--------------------|
| domínio comercial principal | `franquias`, `franquias__segmentos`, `franquias__redes_franquia`, `franquias__unidades` |
| domínio operacional de entregas | `project`, `project_item`, `project_payment`, `project_render`, `project_render_item`, `timeline_event`, `project_step` |
| domínio de catálogo | `product`, `product_type` |
| domínio financeiro | `transaction`, `transaction_coupon`, `subscriptions`, `subscription_plans` |
| domínio de identidade | `person` |
| domínio geográfico de referência | `ibge__uf`, `ibge__city` |
| domínio de mídia | `asset_item`, `asset_item__categories`, `asset_category`, `asset_category__users` |
| domínio de acesso e auditoria | `authority`, `user`, `user_authority` |
| domínio de conteúdo externo | `publications_user`, `publications` |

## Cobertura Q31–Q40 (perspectivas, JSON e project\_render\_item)

As dez perguntas COMPLEXA Q31–Q40 usam identificadores reais MySQL e todas (i) fazem junção a
`project_render_item` e (ii) exploram `json_data` e/ou `data_source`.

### Perspectiva de usuário (papéis reais)

| Perspectiva | Perguntas | Total |
|-------------|-----------|-------|
| admin | Q31, Q32, Q33, Q34 | 4 |
| publisher | Q35, Q36 | 2 |
| affiliate | Q37, Q38 | 2 |
| sponsor | Q39, Q40 | 2 |

Os quatro itens admin são analíticos (cohort temporal, região, qualidade de JSON, base pagante).

### Exploração de colunas semiestruturadas

| Coluna JSON | Perguntas | Total |
|-------------|-----------|-------|
| `data_source` | Q31, Q32, Q34, Q35, Q37, Q38, Q39, Q40 | 8 |
| `json_data` | Q33, Q36, Q39 | 3 |

### Tabelas reais usadas em Q31–Q40

| Tabela | Perguntas |
|--------|-----------|
| `project_render_item` | Q31–Q40 (todas) |
| `person` | Q31, Q32, Q34, Q37, Q39, Q40 |
| `project_render` | Q33, Q34 |
| `ibge__uf` | Q31, Q32 |
| `publications_user` | Q35, Q36 |
| `publications` | Q36 |
| `transaction_coupon` | Q37, Q38 |

Cobertura de `project_render_item`: 10/10 (100%). Toda Q31–Q40 contém ao menos uma função JSON
(`JSON_EXTRACT`, `JSON_UNQUOTE`, `JSON_VALID`, `JSON_CONTAINS_PATH`).
