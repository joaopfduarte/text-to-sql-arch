# Banco de domínio XPTO

## Propósito

Resumo operacional do schema relacional do XPTO, identificando domínios, tabelas-âncora e FKs relevantes para o pipeline Text-to-SQL e para a carga no cluster.

## Leitor

Pessoa que implementa o adaptador MCP, monta o catálogo no Atlas ou prepara a carga no cluster.

## Pré-requisitos

- [Monografia](../monografia.md) (dicionário completo e linhas de referência).

## Conteúdo

### Estatísticas observáveis

| Item | Valor | Fonte |
|------|-------|-------|
| Tabelas no índice | 92 + secção "Relational schema" | [`base de referência XPTO.md` L5–98](../monografia.md) |
| Origem do export | Schema relacional MySQL com rastros de Liquibase | Tabelas `DATABASECHANGELOG`, `DATABASECHANGELOGLOCK` |
| Data declarada de geração das tabelas | Apr 28, 2026 | Cabeçalho "Creation" em cada tabela do export |
| Notação de FK no export | `coluna -> tabela_destino.coluna_destino` (com `ON UPDATE` / `ON DELETE`) | Ver `franquias.segmento_id -> franquias__segmentos.id` na [L1199](../monografia.md) |

### Domínios identificados

| Domínio | Tabelas representativas | Uso no TCC |
|---------|-------------------------|------------|
| Controle Liquibase | `DATABASECHANGELOG`, `DATABASECHANGELOGLOCK` | Ignorar na massa de avaliação (ruído). |
| Ativos digitais | `asset_category`, `asset_item`, `asset_retail_product`, `asset_startup`, `asset_voice_speaker`, `asset_voice_voiceover` | Não selecionado no MVP (alto número de junções acessórias). |
| Franquias | `franquias`, `franquias__segmentos`, `franquias__redes_franquia`, `franquias__unidades`, `franquias__premiacoes`, `franquias__taxas_franquia` | Domínio principal de avaliação (junções 1:N e M:N evidentes). |
| Geografia | `ibge__city`, `ibge__uf`, `ibge__name`, `ibge_name_group_sum`, `ibge_names_and_frequency` | Junção geográfica auxiliar. |
| Pessoa | `person`, `person_references` | Tabela-âncora referenciada por múltiplos domínios. |
| Produto | `product`, `product_type`, `product_group`, `product_competence`, `rel_product_type__groups`, `rel_product_type__tags` | Junções produto/tipo/grupo. |
| Projetos | `project`, `project_item`, `project_payment`, `project_render`, `project_step`, `project_calc`, `project_case`, `project__tags` | Domínio principal com enum (`project_status`), agregações e cadeias longas. |
| Transações | `transaction`, `transaction_coupon`, `transaction_coupon_remover`, `transaction_remover` | Agregações monetárias e filtros temporais. |
| Publicações | `publications`, `publications_complete`, `publications_source`, `publications_source__tags`, `publications_user`, `publication_task` | Junções entre origem, conteúdo e usuário. |
| Conta e segurança | `xpto_user`, `xpto_authority`, `xpto_user_authority`, `xpto_persistent_audit_event`, `xpto_persistent_audit_evt_data` | Não selecionado no MVP (PII potencial). |
| Integração externa | `openai_assistants`, `openai_conclusions`, `notification_whatsapp` | Não selecionado no MVP (dados de integração). |
| Tags e classificação | `tag`, `rel_product_type__tags`, `portfolio__tags`, `project__tags`, `franquias__sub_segmentos` | Junções M:N. |
| Apoio | `competence`, `competence_guide`, `config_params`, `page_faq`, `schedule`, `schedule_step`, `question`, `subscription_plans`, `subscriptions`, `timeline_attachment`, `timeline_comment`, `timeline_event`, `satisfaction_survey`, `render_item_resume`, `smart_websummit_rio` | Não selecionado no MVP. |

### FKs concretas confirmadas no export

| Origem (tabela.coluna) | Destino (tabela.coluna) | Restrição | Fonte |
|------------------------|--------------------------|-----------|-------|
| `franquias.segmento_id` | `franquias__segmentos.id` | `ON UPDATE RESTRICT` / `ON DELETE RESTRICT` | [`base de referência XPTO.md` L1199–1201](../monografia.md) |
| `franquias.rede_id` | `franquias__redes_franquia.id` | `ON UPDATE RESTRICT` / `ON DELETE RESTRICT` | [`base de referência XPTO.md` L1203–1206](../monografia.md) |
| `project_item.project_id` | `project.id` | `ON UPDATE CASCADE` / `ON DELETE CASCADE` | [`base de referência XPTO.md` L3257–3259](../monografia.md) |
| `project_item.project_step_id` | `project_step.id` | `ON UPDATE CASCADE` / `ON DELETE RESTRICT` | [`base de referência XPTO.md` L3267–3269](../monografia.md) |
| `project_item.product_id` | `product.id` | `ON UPDATE CASCADE` / `ON DELETE RESTRICT` | [`base de referência XPTO.md` L3271–3273](../monografia.md) |
| `project_item.freelancer_id` | `person.id` | `ON UPDATE CASCADE` / `ON DELETE RESTRICT` | [`base de referência XPTO.md` L3282–3284](../monografia.md) |
| `project_payment.project_id` | `project.id` | `ON UPDATE RESTRICT` / `ON DELETE RESTRICT` | [`base de referência XPTO.md` L3393–3395](../monografia.md) |
| `transaction.person_id` | `person.id` | `ON UPDATE CASCADE` / `ON DELETE CASCADE` | [`base de referência XPTO.md` L5358–5360](../monografia.md) |
| `transaction.project_id` | `project.id` | `ON UPDATE CASCADE` / `ON DELETE SET_NULL` | [`base de referência XPTO.md` L5363–5365](../monografia.md) |
| `transaction.project_item_id` | `project_item.id` | `ON UPDATE CASCADE` / `ON DELETE RESTRICT` | [`base de referência XPTO.md` L5367–5369](../monografia.md) |
| `transaction.subscription_id` | `subscriptions.id` | `ON UPDATE RESTRICT` / `ON DELETE RESTRICT` | [`base de referência XPTO.md` L5371–5373](../monografia.md) |
| `transaction.related_transaction_id` | `transaction.id` | `ON UPDATE CASCADE` / `ON DELETE RESTRICT` | [`base de referência XPTO.md` L5433–5435](../monografia.md) |
| `transaction_coupon.person_owner_id` | `person.id` | `ON UPDATE CASCADE` / `ON DELETE SET_NULL` | [`base de referência XPTO.md` L5475–5477](../monografia.md) |
| `transaction_coupon.person_id` | `person.id` | `ON UPDATE CASCADE` / `ON DELETE CASCADE` | [`base de referência XPTO.md` L5483–5485](../monografia.md) |
| `transaction_coupon.transaction_id` | `transaction.id` | `ON UPDATE RESTRICT` / `ON DELETE RESTRICT` | [`base de referência XPTO.md` L5513–5515](../monografia.md) |
| `transaction_coupon.project_render_id` | `project_render.id` | `ON UPDATE RESTRICT` / `ON DELETE RESTRICT` | [`base de referência XPTO.md` L5521–5523](../monografia.md) |
| `transaction_coupon.project_id` | `project.id` | `ON UPDATE RESTRICT` / `ON DELETE RESTRICT` | [`base de referência XPTO.md` L5525–5527](../monografia.md) |
| `transaction_coupon.project_render_item_id` | `project_render_item.id` | `ON UPDATE CASCADE` / `ON DELETE RESTRICT` | [`base de referência XPTO.md` L5559–5561](../monografia.md) |
| `transaction_coupon.publications_user_id` | `publications_user.id` | `ON UPDATE CASCADE` / `ON DELETE RESTRICT` | [`base de referência XPTO.md` L5567–5569](../monografia.md) |
| `person.company_id` | `person.id` | `ON UPDATE CASCADE` / `ON DELETE RESTRICT` | [`base de referência XPTO.md` L2217–2219](../monografia.md) |
| `person_references.person_id` | `person.id` | `ON UPDATE CASCADE` / `ON DELETE CASCADE` | [`base de referência XPTO.md` L2379–2381](../monografia.md) |
| `product.product_type_id` | `product_type.id` | `ON UPDATE RESTRICT` / `ON DELETE RESTRICT` | [`base de referência XPTO.md` L2558–2560](../monografia.md) |
| `ibge__city.uf_id` | `ibge__uf.id` | `ON UPDATE CASCADE` / `ON DELETE RESTRICT` | [`base de referência XPTO.md` L1540–1542](../monografia.md) |

### Tabelas-âncora para Text-to-SQL

Definição: tabelas que aparecem como pivô de junções ou agregações nos cenários do harness.

| Tabela | Motivo | Linha no export |
|--------|--------|-----------------|
| `franquias` | Múltiplas FKs evidentes, agrega vários sub-domínios. | [L1173](../monografia.md) |
| `project` | Enum (`project_status`), referenciada por `project_item`, `project_payment`, `project_render`. | [L2709](../monografia.md) |
| `transaction` | Filtros temporais e agregações monetárias. | [L5343](../monografia.md) |
| `person` | Pivô de pessoas com `person_references` e referências cruzadas. | [L2198](../monografia.md) |
| `product` | Junção com `product_type` e `product_group`. | [L2550](../monografia.md) |
| `ibge__city` | Junção geográfica com `ibge__uf`. | [L1523](../monografia.md) |

### Restrições do MVP

- Não copiar as ~6640 linhas do export para `docs/`.
- Não inventar tabelas ou colunas fora do índice em [`base de referência XPTO.md` L5–98](../monografia.md).
- Não inserir PII (e-mails, telefones, dados de `xpto_user`) na massa de teste sem mascaramento.

## Próximo passo

[`carga-cluster-xpto.md`](carga-cluster-xpto.md)
