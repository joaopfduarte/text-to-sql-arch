---
description: Inventário das entidades da massa de laboratório MySQL.
tags:
  - dados
---

# Schema e massa de laboratório (MySQL 8+)

!!! info "Recomendado para leitura prévia"
    - **[Pacote experimental](../../experimento/pacote-experimental.md)** — ordem de reprodução
      (schema, bateria, gabarito, baseline).
    - **[Banco laboratorial](banco-laboratorio-dominio.md)** — domínios de negócio e entidades-âncora.
    - **[Carga no cluster](carga-cluster-laboratorio.md)** — pipeline de ingestão no Hive/Atlas.
    - **[Catálogo Atlas](catalogo-atlas.md)** — camada semântica no cluster.


### Decisão

A massa de avaliação corresponde ao schema relacional **`base_laboratorial`**, versionado em
[Dump MySQL base_laboratorial](../../dados/base_laboratorial.sql) (MySQL 8+). O inventário
abaixo é derivado automaticamente desse dump.

### Download e importação

```bash
mysql -u root -p < dados/base_laboratorial.sql
```

Requisitos e convenções: [Instruções de importação MySQL](../../dados/README.md).

### Regras da massa

- O schema é fixado antes das corridas finais e versionado em `datasetVersion`.
- Alteração do schema exposto exige nova versão e ADR.
- Dados sensíveis são mascarados na carga conforme [Carga no cluster](carga-cluster-laboratorio.md).

<!-- INVENTORY:START -->

### Inventário completo (92 entidades)

| # | Entidade | Domínio |
|---|----------|---------|
| 1 | `asset_category` | domínio de mídia |
| 2 | `asset_category__users` | domínio de mídia |
| 3 | `asset_item` | domínio de mídia |
| 4 | `asset_item__categories` | domínio de mídia |
| 5 | `asset_item__voice_overs` | domínio de mídia |
| 6 | `asset_retail_product` | domínio de mídia |
| 7 | `asset_retail_product__categories` | domínio de mídia |
| 8 | `asset_retail_product__voice_overs` | domínio de mídia |
| 9 | `asset_retail_supplier` | domínio de mídia |
| 10 | `asset_retail_unit` | domínio de mídia |
| 11 | `asset_startup` | domínio de mídia |
| 12 | `asset_voice_speaker` | domínio de mídia |
| 13 | `asset_voice_voiceover` | domínio de mídia |
| 14 | `competence` | domínio de catálogo |
| 15 | `competence_guide` | domínio de catálogo |
| 16 | `config_params` | apoio operacional |
| 17 | `DATABASECHANGELOG` | controle de migração |
| 18 | `DATABASECHANGELOGLOCK` | controle de migração |
| 19 | `franquias` | domínio comercial principal |
| 20 | `franquias__expansao_interesse` | domínio comercial principal |
| 21 | `franquias__investimentos_franquia` | domínio comercial principal |
| 22 | `franquias__premiacoes` | domínio comercial principal |
| 23 | `franquias__redes_franquia` | domínio comercial principal |
| 24 | `franquias__redes_sociais` | domínio comercial principal |
| 25 | `franquias__requisitos_franquia` | domínio comercial principal |
| 26 | `franquias__segmentos` | domínio comercial principal |
| 27 | `franquias__sub_segmentos` | domínio comercial principal |
| 28 | `franquias__taxas_franquia` | domínio comercial principal |
| 29 | `franquias__unidades` | domínio comercial principal |
| 30 | `ibge_names_and_frequency` | domínio geográfico de referência |
| 31 | `ibge_name_group_sum` | domínio geográfico de referência |
| 32 | `ibge__city` | domínio geográfico de referência |
| 33 | `ibge__name` | domínio geográfico de referência |
| 34 | `ibge__name_frequency` | domínio geográfico de referência |
| 35 | `ibge__name_group` | domínio geográfico de referência |
| 36 | `ibge__name_render` | domínio geográfico de referência |
| 37 | `ibge__uf` | domínio geográfico de referência |
| 38 | `notification_whatsapp` | domínio de conectores |
| 39 | `openai_assistants` | domínio de conectores |
| 40 | `openai_conclusions` | domínio de conectores |
| 41 | `page_faq` | apoio operacional |
| 42 | `person` | domínio de identidade |
| 43 | `person_references` | domínio de identidade |
| 44 | `portfolio` | domínio de catálogo |
| 45 | `portfolio__tags` | domínio de catálogo |
| 46 | `product` | domínio de catálogo |
| 47 | `product_competence` | domínio de catálogo |
| 48 | `product_group` | domínio de catálogo |
| 49 | `product_type` | domínio de catálogo |
| 50 | `project` | domínio operacional de entregas |
| 51 | `project_calc` | domínio operacional de entregas |
| 52 | `project_case` | domínio operacional de entregas |
| 53 | `project_item` | domínio operacional de entregas |
| 54 | `project_item_request` | domínio operacional de entregas |
| 55 | `project_payment` | domínio operacional de entregas |
| 56 | `project_render` | domínio operacional de entregas |
| 57 | `project_render_group_name` | domínio operacional de entregas |
| 58 | `project_render_item` | domínio operacional de entregas |
| 59 | `project_render_log` | domínio operacional de entregas |
| 60 | `project_render_user` | domínio operacional de entregas |
| 61 | `project_step` | domínio operacional de entregas |
| 62 | `project__tags` | domínio operacional de entregas |
| 63 | `publications` | domínio de conteúdo externo |
| 64 | `publications_complete` | domínio de conteúdo externo |
| 65 | `publications_source` | domínio de conteúdo externo |
| 66 | `publications_source__tags` | domínio de conteúdo externo |
| 67 | `publications_source__type_users` | domínio de conteúdo externo |
| 68 | `publications_user` | domínio de conteúdo externo |
| 69 | `publication_task` | domínio de conteúdo externo |
| 70 | `authority` | domínio de acesso e auditoria |
| 71 | `persistent_audit_event` | domínio de acesso e auditoria |
| 72 | `persistent_audit_evt_data` | domínio de acesso e auditoria |
| 73 | `user` | domínio de acesso e auditoria |
| 74 | `user_authority` | domínio de acesso e auditoria |
| 75 | `question` | apoio operacional |
| 76 | `rel_product_type__groups` | domínio de catálogo |
| 77 | `rel_product_type__tags` | domínio de catálogo |
| 78 | `render_item_resume` | apoio operacional |
| 79 | `satisfaction_survey` | apoio operacional |
| 80 | `schedule` | apoio operacional |
| 81 | `schedule_step` | apoio operacional |
| 82 | `smart_websummit_rio` | apoio operacional |
| 83 | `subscriptions` | domínio financeiro |
| 84 | `subscription_plans` | domínio financeiro |
| 85 | `tag` | tags e classificação |
| 86 | `timeline_attachment` | apoio operacional |
| 87 | `timeline_comment` | apoio operacional |
| 88 | `timeline_event` | apoio operacional |
| 89 | `transaction` | domínio financeiro |
| 90 | `transaction_coupon` | domínio financeiro |
| 91 | `transaction_coupon_remover` | domínio financeiro |
| 92 | `transaction_remover` | domínio financeiro |

#### Resumo por domínio

| Domínio | Quantidade |
|---------|------------|
| domínio de mídia | 13 |
| domínio operacional de entregas | 13 |
| apoio operacional | 11 |
| domínio comercial principal | 11 |
| domínio de catálogo | 10 |
| domínio geográfico de referência | 8 |
| domínio de conteúdo externo | 7 |
| domínio financeiro | 6 |
| domínio de acesso e auditoria | 5 |
| domínio de conectores | 3 |
| controle de migração | 2 |
| domínio de identidade | 2 |
| tags e classificação | 1 |
| **Total** | **92** |

<!-- INVENTORY:END -->

### Relacionamentos (FK lógicas)

As chaves estrangeiras estão definidas no dump MySQL
[Dump MySQL base_laboratorial](../../dados/base_laboratorial.sql). Para junções usadas na
bateria, ver [Gabarito da bateria](../../evidence/gabarito-bateria.md) e
[Matriz de cobertura](../../evidence/matriz-cobertura-bateria.md).

### Artefatos esperados

- Dump MySQL: [Dump MySQL base_laboratorial](../../dados/base_laboratorial.sql).
- Script de carga cluster: [Carga no cluster](carga-cluster-laboratorio.md).
- Bateria e gabarito: [Pacote experimental](../../experimento/pacote-experimental.md).

!!! tip "Recomendado para leitura posterior"
    Seguinte: **[Catálogo Atlas](catalogo-atlas.md)** — camada semântica e metadados no cluster.
