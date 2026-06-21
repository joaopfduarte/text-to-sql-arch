---
description: Cobertura cenário × dificuldade × tabelas da bateria v1.
tags:
  - experimento
  - evidencia
---

# Matriz de cobertura da bateria (v1)

## Status

- **batteryVersion:** v1
- **Commit de referência:** `9985067` (rebalanceamento MÉDIA/COMPLEXA e 6 cenários)
- **Revisão humana:** aprovada (11/06/2026)

Fontes: [Bateria de 30 perguntas](bateria-30-perguntas-v1.csv) e
[Gabarito da bateria](gabarito-bateria-v1.md). Tabelas conforme o DDL das 92
([Schema massa de teste](../arquitetura/dados/schema-massa-teste.md)).

A bateria adopta **6 cenários** (remove `Listagem simples` e `Filtro por enum` da taxonomia anterior de 8).
Sincronizada com `documentacao-academica-externa/cap4-metodologia.tex` (Onda 2, T11).

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
| Permissões de usuário (`tbl_54cf92bb`) | Q24, Q26 | 2 (>=2) |
| Jornada vídeo/painel (`tbl_06d78b0c`/render) | Q27, Q28, Q29, Q30 | 4 (>=3) |

## Perguntas com `sql_esperados_max` > 1

| Pergunta | Máximo | Justificativa |
|----------|--------|---------------|
| Q14 | 2 | Um SQL por semestre ou um único com `CASE`. |
| Q19 | 2 | Contagem e soma por tipo de produto. |
| Q23 | 2 | Contagem por raiz mais consulta auxiliar do topo. |
| Q27 | 2 | Um SQL por situação de conta ou um único com `CASE`. |

Total: 4 perguntas (faixa 3-5 atendida).

## Tabela subconjunto laboratorial x frequência

Frequência de uso por tabela na validação estrutural do gabarito (79 referências, 29 tabelas distintas
das 92).

| Tabela | Frequência | Perguntas |
|--------|------------|-----------|
| `tbl_363ae7e9` | 8 | Q03, Q06, Q07, Q11, Q12, Q13, Q16, Q17 |
| `tbl_c066178a` | 6 | Q08, Q14, Q15, Q16, Q18, Q20 |
| `tbl_f193a446` | 6 | Q11, Q15, Q16, Q17, Q18, Q30 |
| `tbl_d58bb5a4` | 5 | Q21, Q22, Q23, Q25, Q26 |
| `tbl_891b1fc9` | 4 | Q02, Q11, Q16, Q19 |
| `tbl_c78eb7ee` | 4 | Q09, Q10, Q15, Q30 |
| `tbl_e019dc9e` | 4 | Q27, Q28, Q29, Q30 |
| `tbl_21eee00c` | 4 | Q27, Q28, Q29, Q30 |
| `tbl_6696932f` | 3 | Q03, Q06, Q13 |
| `tbl_162cf7be` | 3 | Q01, Q04, Q05 |
| `tbl_3a2c56ff` | 3 | Q11, Q16, Q19 |
| `tbl_a6e2174e` | 3 | Q21, Q22, Q23 |
| `tbl_c311310d` | 3 | Q21, Q22, Q23 |
| `tbl_06d78b0c` | 3 | Q27, Q28, Q29 |
| `tbl_ed8b2873` | 2 | Q02, Q19 |
| `tbl_4c8d7ae5` | 2 | Q04, Q05 |
| `tbl_2c1fc4f7` | 2 | Q09, Q10 |
| `tbl_cca22dd2` | 2 | Q25, Q26 |
| `tbl_54cf92bb` | 2 | Q24, Q26 |
| `tbl_973ec6fa` | 1 | Q01 |
| `tbl_8991e9dc` | 1 | Q05 |
| `tbl_0bd88855` | 1 | Q12 |
| `tbl_e9e0d929` | 1 | Q12 |
| `tbl_6b881dfd` | 1 | Q17 |
| `tbl_6cf5e405` | 1 | Q20 |
| `tbl_6cc6cc99` | 1 | Q20 |
| `tbl_d1556a76` | 1 | Q24 |
| `tbl_c127eea9` | 1 | Q26 |
| `tbl_4e5786c9` | 1 | Q28 |

## Domínios cobertos

| Domínio | Tabelas na bateria |
|---------|--------------------|
| domínio comercial principal | `tbl_162cf7be`, `tbl_8991e9dc`, `tbl_4c8d7ae5`, `tbl_973ec6fa` |
| domínio operacional de entregas | `tbl_363ae7e9`, `tbl_3a2c56ff`, `tbl_6696932f`, `tbl_e9e0d929` |
| domínio de catálogo | `tbl_891b1fc9`, `tbl_ed8b2873` |
| domínio financeiro | `tbl_c066178a`, `tbl_6b881dfd` |
| domínio de assinaturas | `tbl_6cf5e405`, `tbl_6cc6cc99` |
| domínio de identidade | `tbl_f193a446` |
| domínio geográfico de referência | `tbl_c78eb7ee`, `tbl_2c1fc4f7` |
| domínio de linha do tempo | `tbl_0bd88855` |
| domínio de mídia | `tbl_a6e2174e`, `tbl_c311310d`, `tbl_d58bb5a4`, `tbl_cca22dd2` |
| domínio de acesso e auditoria | `tbl_54cf92bb`, `tbl_d1556a76`, `tbl_c127eea9` |
| domínio de conteúdo externo | `tbl_06d78b0c`, `tbl_4e5786c9`, `tbl_e019dc9e`, `tbl_21eee00c` |
