# Matriz de cobertura da bateria (v1)

## Status

- **batteryVersion:** v1
- **Commit de referência:** `9985067` (rebalanceamento MÉDIA/COMPLEXA e 6 cenários)
- **Revisão humana:** aprovada (11/06/2026)

Fontes: [`bateria-30-perguntas-v1.csv`](bateria-30-perguntas-v1.csv) e
[`gabarito-bateria-v1.md`](gabarito-bateria-v1.md). Tabelas conforme o DDL das 92
([`putz_db.sql`](../db-reference/putz_db.sql)).

A bateria adopta **6 cenários** (remove `Listagem simples` e `Filtro por enum` da taxonomia anterior de 8).
Sincronizada com `content/cap4-metodologia.tex` (Onda 2, T11).

## Cenário x perguntas

| Cenário | Perguntas | Total |
|---------|-----------|-------|
| Junção 1:N | Q01, Q02, Q03, Q04 | 4 |
| Junção em cadeia | Q05, Q11, Q12, Q21, Q22 | 5 |
| Agregação | Q06, Q07, Q13, Q23, Q24 | 5 |
| Filtro temporal | Q08, Q14, Q29 | 3 |
| Junção geográfica | Q09, Q10, Q15, Q30 | 4 |
| Junção cross-domínio | Q16, Q17, Q18, Q19, Q20, Q25, Q26, Q27, Q28 | 9 |
| **Total** | — | **30** |

São 6 cenários; cada um com pelo menos 3 perguntas (mínimo I3).

## Dificuldade x contagem

| Dificuldade | Perguntas | Total |
|-------------|-----------|-------|
| SIMPLES | Q01, Q02, Q03, Q04, Q05, Q06, Q07, Q08, Q09, Q10 | 10 |
| MÉDIA | Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19, Q20 | 10 |
| COMPLEXA | Q21, Q22, Q23, Q24, Q25, Q26, Q27, Q28, Q29, Q30 | 10 |
| **Total** | — | **30** |

## Cenário x dificuldade

| Cenário | SIMPLES | MÉDIA | COMPLEXA |
|---------|---------|-------|----------|
| Junção 1:N | 4 | 0 | 0 |
| Junção em cadeia | 1 | 2 | 2 |
| Agregação | 2 | 1 | 2 |
| Filtro temporal | 1 | 1 | 1 |
| Junção geográfica | 2 | 1 | 1 |
| Junção cross-domínio | 0 | 5 | 4 |

## Cobertura temática obrigatória das COMPLEXA

| Tema | Perguntas | Total |
|------|-----------|-------|
| Categorias de ativos | Q21, Q22, Q23, Q25, Q26 | 5 (>=4) |
| Permissões de usuário (`putz_user_authority`) | Q24, Q26 | 2 (>=2) |
| Jornada vídeo/painel (`publications_user`/render) | Q27, Q28, Q29, Q30 | 4 (>=3) |

## Perguntas com `sql_esperados_max` > 1

| Pergunta | Máximo | Justificativa |
|----------|--------|---------------|
| Q14 | 2 | Um SQL por semestre ou um único com `CASE`. |
| Q19 | 2 | Contagem e soma por tipo de produto. |
| Q23 | 2 | Contagem por raiz mais consulta auxiliar do topo. |
| Q27 | 2 | Um SQL por situação de conta ou um único com `CASE`. |

Total: 4 perguntas (faixa 3-5 atendida).

## Tabela PS x frequência

Frequência de uso por tabela na validação estrutural do gabarito (79 referências, 29 tabelas distintas
das 92).

| Tabela | Frequência | Perguntas |
|--------|------------|-----------|
| `project` | 8 | Q03, Q06, Q07, Q11, Q12, Q13, Q16, Q17 |
| `transaction` | 6 | Q08, Q14, Q15, Q16, Q18, Q20 |
| `person` | 6 | Q11, Q15, Q16, Q17, Q18, Q30 |
| `asset_category` | 5 | Q21, Q22, Q23, Q25, Q26 |
| `product` | 4 | Q02, Q11, Q16, Q19 |
| `ibge__uf` | 4 | Q09, Q10, Q15, Q30 |
| `project_render_item` | 4 | Q27, Q28, Q29, Q30 |
| `project_render` | 4 | Q27, Q28, Q29, Q30 |
| `project_payment` | 3 | Q03, Q06, Q13 |
| `franquias` | 3 | Q01, Q04, Q05 |
| `project_item` | 3 | Q11, Q16, Q19 |
| `asset_item` | 3 | Q21, Q22, Q23 |
| `asset_item__categories` | 3 | Q21, Q22, Q23 |
| `publications_user` | 3 | Q27, Q28, Q29 |
| `product_type` | 2 | Q02, Q19 |
| `franquias__redes_franquia` | 2 | Q04, Q05 |
| `ibge__city` | 2 | Q09, Q10 |
| `asset_category__users` | 2 | Q25, Q26 |
| `putz_user_authority` | 2 | Q24, Q26 |
| `franquias__unidades` | 1 | Q01 |
| `franquias__segmentos` | 1 | Q05 |
| `timeline_event` | 1 | Q12 |
| `project_step` | 1 | Q12 |
| `transaction_coupon` | 1 | Q17 |
| `subscriptions` | 1 | Q20 |
| `subscription_plans` | 1 | Q20 |
| `putz_authority` | 1 | Q24 |
| `putz_user` | 1 | Q26 |
| `publications` | 1 | Q28 |

## Domínios cobertos

| Domínio | Tabelas na bateria |
|---------|--------------------|
| Franquias | `franquias`, `franquias__segmentos`, `franquias__redes_franquia`, `franquias__unidades` |
| Projetos | `project`, `project_item`, `project_payment`, `project_step` |
| Produtos | `product`, `product_type` |
| Transações/cupons | `transaction`, `transaction_coupon` |
| Assinaturas | `subscriptions`, `subscription_plans` |
| Pessoas | `person` |
| Geografia | `ibge__uf`, `ibge__city` |
| Timeline | `timeline_event` |
| Ativos | `asset_item`, `asset_item__categories`, `asset_category`, `asset_category__users` |
| Permissões | `putz_user_authority`, `putz_authority`, `putz_user` |
| Publicações/render | `publications_user`, `publications`, `project_render_item`, `project_render` |
