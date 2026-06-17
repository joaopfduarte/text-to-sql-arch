# Banco de domínio PS

## Propósito

Resumo operacional do schema relacional do PS, identificando domínios, tabelas-âncora e FKs relevantes para o pipeline Text-to-SQL e para a carga no cluster.

## Leitor

Pessoa que implementa o adaptador MCP, monta o catálogo no Atlas ou prepara a carga no cluster.

## Pré-requisitos

- Acesso a [`../../db-reference/putz_db.md`](../../db-reference/putz_db.md) (índice de tabelas em L5–98; tabelas detalhadas a partir da L101).
- Acesso a [`../../db-reference/putz_db.pdf`](../../db-reference/putz_db.pdf) (leitura humana, mesma referência).

## Conteúdo

### Estatísticas observáveis

| Item | Valor | Fonte |
|------|-------|-------|
| Tabelas no índice | 92 + secção "Relational schema" | [`putz_db.md` L5–98](../../db-reference/putz_db.md) |
| Origem do export | Schema relacional MySQL com rastros de Liquibase | Tabelas `DATABASECHANGELOG`, `DATABASECHANGELOGLOCK` |
| Data declarada de geração das tabelas | Apr 28, 2026 | Cabeçalho "Creation" em cada tabela do export |
| Notação de FK no export | `coluna -> tabela_destino.coluna_destino` (com `ON UPDATE` / `ON DELETE`) | Ver `franquias.segmento_id -> franquias__segmentos.id` na [L1199](../../db-reference/putz_db.md) |

### Domínios identificados

| Domínio | Tabelas representativas | Uso no TCC |
|---------|-------------------------|------------|
| Controle Liquibase | `DATABASECHANGELOG`, `DATABASECHANGELOGLOCK` | Incluídas no schema; ruído operacional, raramente consultadas. |
| Ativos digitais | `asset_category`, `asset_item`, `asset_retail_product`, `asset_startup`, `asset_voice_speaker`, `asset_voice_voiceover` | Incluídas no schema; junções acessórias e catálogo de mídia. |
| Franquias | `franquias`, `franquias__segmentos`, `franquias__redes_franquia`, `franquias__unidades`, `franquias__premiacoes`, `franquias__taxas_franquia` | Domínio principal de avaliação (junções 1:N e M:N evidentes). |
| Geografia | `ibge__city`, `ibge__uf`, `ibge__name`, `ibge_name_group_sum`, `ibge_names_and_frequency` | Junção geográfica auxiliar. |
| Pessoa | `person`, `person_references` | Tabela-âncora referenciada por múltiplos domínios. |
| Produto | `product`, `product_type`, `product_group`, `product_competence`, `rel_product_type__groups`, `rel_product_type__tags` | Junções produto/tipo/grupo. |
| Projetos | `project`, `project_item`, `project_payment`, `project_render`, `project_step`, `project_calc`, `project_case`, `project__tags` | Domínio principal com enum (`project_status`), agregações e cadeias longas. |
| Transações | `transaction`, `transaction_coupon`, `transaction_coupon_remover`, `transaction_remover` | Agregações monetárias e filtros temporais. |
| Publicações | `publications`, `publications_complete`, `publications_source`, `publications_source__tags`, `publications_user`, `publication_task` | Junções entre origem, conteúdo e usuário. |
| Conta e segurança | `putz_user`, `putz_authority`, `putz_user_authority`, `putz_persistent_audit_event`, `putz_persistent_audit_evt_data` | Incluídas no schema; exigem mascaramento de PII na carga. |
| Integração externa | `openai_assistants`, `openai_conclusions`, `notification_whatsapp` | Incluídas no schema; dados de integração. |
| Tags e classificação | `tag`, `rel_product_type__tags`, `portfolio__tags`, `project__tags`, `franquias__sub_segmentos` | Junções M:N. |
| Apoio | `competence`, `competence_guide`, `config_params`, `page_faq`, `schedule`, `schedule_step`, `question`, `subscription_plans`, `subscriptions`, `timeline_attachment`, `timeline_comment`, `timeline_event`, `satisfaction_survey`, `render_item_resume`, `smart_websummit_rio` | Incluídas no schema; suporte operacional. |

### FKs concretas confirmadas no export

| Origem (tabela.coluna) | Destino (tabela.coluna) | Restrição | Fonte |
|------------------------|--------------------------|-----------|-------|
| `franquias.segmento_id` | `franquias__segmentos.id` | `ON UPDATE RESTRICT` / `ON DELETE RESTRICT` | [`putz_db.md` L1199–1201](../../db-reference/putz_db.md) |
| `franquias.rede_id` | `franquias__redes_franquia.id` | `ON UPDATE RESTRICT` / `ON DELETE RESTRICT` | [`putz_db.md` L1203–1206](../../db-reference/putz_db.md) |
| `project_item.project_id` | `project.id` | `ON UPDATE CASCADE` / `ON DELETE CASCADE` | [`putz_db.md` L3257–3259](../../db-reference/putz_db.md) |
| `project_item.project_step_id` | `project_step.id` | `ON UPDATE CASCADE` / `ON DELETE RESTRICT` | [`putz_db.md` L3267–3269](../../db-reference/putz_db.md) |
| `project_item.product_id` | `product.id` | `ON UPDATE CASCADE` / `ON DELETE RESTRICT` | [`putz_db.md` L3271–3273](../../db-reference/putz_db.md) |
| `project_item.freelancer_id` | `person.id` | `ON UPDATE CASCADE` / `ON DELETE RESTRICT` | [`putz_db.md` L3282–3284](../../db-reference/putz_db.md) |
| `project_payment.project_id` | `project.id` | `ON UPDATE RESTRICT` / `ON DELETE RESTRICT` | [`putz_db.md` L3393–3395](../../db-reference/putz_db.md) |
| `transaction.person_id` | `person.id` | `ON UPDATE CASCADE` / `ON DELETE CASCADE` | [`putz_db.md` L5358–5360](../../db-reference/putz_db.md) |
| `transaction.project_id` | `project.id` | `ON UPDATE CASCADE` / `ON DELETE SET_NULL` | [`putz_db.md` L5363–5365](../../db-reference/putz_db.md) |
| `transaction.project_item_id` | `project_item.id` | `ON UPDATE CASCADE` / `ON DELETE RESTRICT` | [`putz_db.md` L5367–5369](../../db-reference/putz_db.md) |
| `transaction.subscription_id` | `subscriptions.id` | `ON UPDATE RESTRICT` / `ON DELETE RESTRICT` | [`putz_db.md` L5371–5373](../../db-reference/putz_db.md) |
| `transaction.related_transaction_id` | `transaction.id` | `ON UPDATE CASCADE` / `ON DELETE RESTRICT` | [`putz_db.md` L5433–5435](../../db-reference/putz_db.md) |
| `transaction_coupon.person_owner_id` | `person.id` | `ON UPDATE CASCADE` / `ON DELETE SET_NULL` | [`putz_db.md` L5475–5477](../../db-reference/putz_db.md) |
| `transaction_coupon.person_id` | `person.id` | `ON UPDATE CASCADE` / `ON DELETE CASCADE` | [`putz_db.md` L5483–5485](../../db-reference/putz_db.md) |
| `transaction_coupon.transaction_id` | `transaction.id` | `ON UPDATE RESTRICT` / `ON DELETE RESTRICT` | [`putz_db.md` L5513–5515](../../db-reference/putz_db.md) |
| `transaction_coupon.project_render_id` | `project_render.id` | `ON UPDATE RESTRICT` / `ON DELETE RESTRICT` | [`putz_db.md` L5521–5523](../../db-reference/putz_db.md) |
| `transaction_coupon.project_id` | `project.id` | `ON UPDATE RESTRICT` / `ON DELETE RESTRICT` | [`putz_db.md` L5525–5527](../../db-reference/putz_db.md) |
| `transaction_coupon.project_render_item_id` | `project_render_item.id` | `ON UPDATE CASCADE` / `ON DELETE RESTRICT` | [`putz_db.md` L5559–5561](../../db-reference/putz_db.md) |
| `transaction_coupon.publications_user_id` | `publications_user.id` | `ON UPDATE CASCADE` / `ON DELETE RESTRICT` | [`putz_db.md` L5567–5569](../../db-reference/putz_db.md) |
| `person.company_id` | `person.id` | `ON UPDATE CASCADE` / `ON DELETE RESTRICT` | [`putz_db.md` L2217–2219](../../db-reference/putz_db.md) |
| `person_references.person_id` | `person.id` | `ON UPDATE CASCADE` / `ON DELETE CASCADE` | [`putz_db.md` L2379–2381](../../db-reference/putz_db.md) |
| `product.product_type_id` | `product_type.id` | `ON UPDATE RESTRICT` / `ON DELETE RESTRICT` | [`putz_db.md` L2558–2560](../../db-reference/putz_db.md) |
| `ibge__city.uf_id` | `ibge__uf.id` | `ON UPDATE CASCADE` / `ON DELETE RESTRICT` | [`putz_db.md` L1540–1542](../../db-reference/putz_db.md) |

### Tabelas-âncora para Text-to-SQL

Definição: tabelas que aparecem como pivô de junções ou agregações nos cenários do harness.

| Tabela | Motivo | Linha no export |
|--------|--------|-----------------|
| `franquias` | Múltiplas FKs evidentes, agrega vários sub-domínios. | [L1173](../../db-reference/putz_db.md) |
| `project` | Enum (`project_status`), referenciada por `project_item`, `project_payment`, `project_render`. | [L2709](../../db-reference/putz_db.md) |
| `transaction` | Filtros temporais e agregações monetárias. | [L5343](../../db-reference/putz_db.md) |
| `person` | Pivô de pessoas com `person_references` e referências cruzadas. | [L2198](../../db-reference/putz_db.md) |
| `product` | Junção com `product_type` e `product_group`. | [L2550](../../db-reference/putz_db.md) |
| `ibge__city` | Junção geográfica com `ibge__uf`. | [L1523](../../db-reference/putz_db.md) |

### Restrições do MVP

- Não copiar as ~6640 linhas do export para `docs/`.
- Não inventar tabelas ou colunas fora do índice em [`putz_db.md` L5–98](../../db-reference/putz_db.md).
- Não inserir PII (e-mails, telefones, dados de `putz_user`) na massa de teste sem mascaramento.

## Próximo passo

[`carga-cluster-putz.md`](carga-cluster-putz.md)
