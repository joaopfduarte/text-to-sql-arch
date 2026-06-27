---
description: Domínios de negócio, entidades-âncora e FKs do schema base_laboratorial.
tags:
  - dados
---

# Banco de domínio laboratório (MySQL 8+)

!!! info "Recomendado para leitura prévia"
    - **[Schema massa de teste](schema-massa-teste.md)** — inventário completo derivado do dump MySQL.
    - **[Pacote experimental](../../experimento/pacote-experimental.md)** — reprodução local do experimento.


### Identificador canônico

| Item | Valor |
|------|-------|
| SGBD reprodutível | MySQL **8+** |
| Schema | **`base_laboratorial`** |
| Dump versionado | [Dump MySQL base_laboratorial](../../dados/base_laboratorial.sql) |
| Entidades no inventário | ver [Schema massa de teste](schema-massa-teste.md) |

A carga Hive/Atlas no cluster laboratorial consome a mesma massa; o artefacto copiável para replicação
local é o arquivo MySQL em [Instruções de importação MySQL](../../dados/README.md).

### Domínios identificados

| Domínio | Entidades representativas | Uso na pesquisa |
|---------|---------------------------|-----------------|
| domínio comercial principal | `franquias`, `franquias__unidades`, `franquias__segmentos`, `franquias__redes_franquia`, … | Franquias, redes, segmentos (Q01–Q05) |
| domínio de catálogo | `product`, `product_type`, `product_group`, `portfolio`, `competence`, … | Produtos e tipos (Q02, Q11, Q19) |
| domínio operacional de entregas | `project`, `project_item`, `project_payment`, `project_render`, `project_render_item`, `timeline_event`, … | Projetos, renders, timeline (Q03–Q07, Q11–Q13, Q27–Q40) |
| domínio financeiro | `transaction`, `transaction_coupon`, `subscriptions`, `subscription_plans` | Pagamentos e assinaturas (Q08, Q14–Q18, Q20, Q37–Q38) |
| domínio geográfico de referência | `ibge__uf`, `ibge__city`, `ibge__name`, … | UF, cidades, regiões (Q09–Q10, Q15, Q30–Q32) |
| domínio de mídia | `asset_category`, `asset_item`, `asset_voice_voiceover`, … | Ativos e categorias (Q21–Q23) |
| domínio de identidade | `person`, `person_references` | Clientes, freelancers, patrocinadores (Q11, Q15–Q18, Q31–Q40) |
| domínio de acesso e auditoria | `user`, `authority`, `user_authority`, `persistent_audit_event`, … | Permissões (Q24–Q26) |
| domínio de conteúdo externo | `publications`, `publications_user`, `publications_source`, … | Publicações e solicitações (Q27–Q29, Q35–Q36) |
| domínio de conectores | `openai_assistants`, `openai_conclusions`, `notification_whatsapp` | Integrações externas |
| controle de migração | `DATABASECHANGELOG`, `DATABASECHANGELOGLOCK` | Liquibase |
| apoio operacional | `config_params`, `page_faq`, `schedule`, `question`, … | Configuração e auxiliares |
| tags e classificação | `tag`, `rel_product_type__tags` | Classificação transversal |

### FKs confirmadas (amostra da bateria)

| Origem | Destino | Uso |
|--------|---------|-----|
| `franquias.segmento_id` | `franquias__segmentos.id` | Q05 |
| `franquias.rede_id` | `franquias__redes_franquia.id` | Q04, Q05 |
| `franquias__unidades.franquia_id` | `franquias.id` | Q01 |
| `product.product_type_id` | `product_type.id` | Q02, Q19 |
| `project_payment.project_id` | `project.id` | Q03, Q06, Q13 |
| `project_item.project_id` | `project.id` | Q11, Q16, Q19 |
| `transaction.person_id` | `person.id` | Q15, Q18 |
| `project_render_item.render_project_id` | `project_render.id` | Q27–Q40 |
| `publications_user.project_render_item_id` | `project_render_item.id` | Q27–Q29, Q35–Q36 |
| `user_authority.authority_name` | `authority.name` | Q24, Q26 |

Lista completa de constraints: dump MySQL em [Dump MySQL base_laboratorial](../../dados/base_laboratorial.sql).

### Entidades-âncora para Text-to-SQL

| Entidade | Motivo |
|----------|--------|
| `franquias` | Junções centrais do domínio comercial (Q01–Q05). |
| `project` | Núcleo operacional de entregas e pagamentos (Q03–Q07, Q11–Q13). |
| `project_render_item` | Pedidos de vídeo e metadados JSON (Q27–Q40). |
| `transaction` | Movimentação financeira e filtros temporais (Q08, Q14–Q18). |
| `person` | Identidade, geografia e hierarquia sponsor (Q11, Q15–Q18, Q31–Q40). |
| `asset_category` | Hierarquia de categorias de mídia (Q21–Q26). |
| `product` / `product_type` | Catálogo e tipos (Q02, Q19). |

### Restrições

- PII institucional não é publicada na documentação entregável.
- Colunas semiestruturadas `json_data` e `data_source` em `project_render_item`: ver
  [json\_data e data\_source](../../evidence/json_data-data_source-schema-notes.md).

!!! tip "Recomendado para leitura posterior"
    Seguinte: **[Carga no cluster](carga-cluster-laboratorio.md)** — pipeline de ingestão no Hive/Atlas.
