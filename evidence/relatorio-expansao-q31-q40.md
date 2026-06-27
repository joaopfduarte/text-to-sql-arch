---
description: Relatório compacto da expansão da bateria para 40 perguntas.
tags:
  - experimento
  - evidencia
  - relatorio
---

# Relatório: expansão da bateria Q31–Q40

## Sumário

A bateria experimental foi estendida para **40 perguntas** com dez itens COMPLEXA adicionais (Q31–Q40).
Todas exploram `project_render_item` e colunas semiestruturadas (`json_data`, `data_source`) sob quatro
perspectivas de usuário. As colas estão unificadas em **MySQL 8+** com schema **`base_laboratorial`**
e identificadores reais, alinhadas ao dump versionado em [Dump MySQL base_laboratorial](../dados/base_laboratorial.sql).

## Entrega consolidada

| Artefato | Conteúdo |
|----------|----------|
| [Pacote experimental](../experimento/pacote-experimental.md) | Ordem de reprodução |
| [Gabarito](gabarito-bateria.md) | Colas $G_i$ Q01–Q40 |
| [Matriz de cobertura](matriz-cobertura-bateria.md) | Cenário × dificuldade × tabelas |
| [Métricas baseline](baseline-metricas.csv) | 40 × 2 modelos |

## Matriz Q31–Q40 (resumo)

| ID | Perspectiva | JSON | Tabelas principais |
|----|-------------|------|-------------------|
| Q31–Q34 | admin | data_source / json_data | `project_render_item`, `person`, `ibge__uf`, `project_render` |
| Q35–Q36 | publisher | ambos | `publications_user`, `project_render_item`, `publications` |
| Q37–Q38 | affiliate | data_source | `transaction_coupon`, `project_render_item`, `person` |
| Q39–Q40 | sponsor | ambos / data_source | `person` (hierarquia), `project_render_item` |

Validação estrutural e sintática concluída; valores numéricos dependem da massa e são conferidos na
execução local contra `base_laboratorial`.
