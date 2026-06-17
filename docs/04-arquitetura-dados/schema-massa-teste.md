# Schema e massa de teste (PS)

## Propósito

Fixar o schema relacional PS que compõe a massa fixa do harness e definir as regras de
versionamento dessa massa.

## Leitor

Pessoa que prepara a massa, monta o catálogo no Atlas e roda corridas.

## Pré-requisitos

- [`banco-putz-dominio.md`](banco-putz-dominio.md)
- [`carga-cluster-putz.md`](carga-cluster-putz.md)
- [`catalogo-atlas.md`](catalogo-atlas.md)
- [`../../db-reference/putz_db.sql`](../../db-reference/putz_db.sql) (DDL canónico)
- [`../../db-reference/putz_db.md`](../../db-reference/putz_db.md) (export legível)

## Conteúdo

### Decisão

A massa de avaliação do TCC corresponde ao **schema completo** exportado do banco PS: **92 tabelas**
definidas em [`putz_db.sql`](../../db-reference/putz_db.sql). Esse recorte substitui qualquer schema
sintético (anteriormente `sales.*`) e qualquer lista parcial anterior de 14 tabelas. Toda referência
futura em contratos MCP, harness e exemplos deve citar tabelas reais desse inventário.

### Regras da massa

- O schema é fixado antes das corridas finais e versionado em `datasetVersion`.
- Cada pergunta tem SQL de referência ou resultado esperado, quando aplicável.
- Alteração do schema exposto exige nova versão e justificativa em ADR.
- Dados são extraídos do dump original e residem no cluster (HDFS/Hive), com mascaramento de PII quando
  necessário.

### Inventário completo (92 tabelas)

Fonte canónica: [`putz_db.sql`](../../db-reference/putz_db.sql). A tabela abaixo reproduz a ordem de
`CREATE TABLE` do DDL e agrupa por domínio operacional (ver [`banco-putz-dominio.md`](banco-putz-dominio.md)).

| # | Tabela | Domínio | Evidência (DDL) |
|---|--------|---------|-----------------|
| 1 | `asset_category` | Ativos digitais | [`putz_db.sql` L32](../../db-reference/putz_db.sql) |
| 2 | `asset_category__users` | Ativos digitais | [`putz_db.sql` L53](../../db-reference/putz_db.sql) |
| 3 | `asset_item` | Ativos digitais | [`putz_db.sql` L64](../../db-reference/putz_db.sql) |
| 4 | `asset_item__categories` | Ativos digitais | [`putz_db.sql` L90](../../db-reference/putz_db.sql) |
| 5 | `asset_item__voice_overs` | Ativos digitais | [`putz_db.sql` L101](../../db-reference/putz_db.sql) |
| 6 | `asset_retail_product` | Ativos digitais | [`putz_db.sql` L112](../../db-reference/putz_db.sql) |
| 7 | `asset_retail_product__categories` | Ativos digitais | [`putz_db.sql` L138](../../db-reference/putz_db.sql) |
| 8 | `asset_retail_product__voice_overs` | Ativos digitais | [`putz_db.sql` L149](../../db-reference/putz_db.sql) |
| 9 | `asset_retail_supplier` | Ativos digitais | [`putz_db.sql` L160](../../db-reference/putz_db.sql) |
| 10 | `asset_retail_unit` | Ativos digitais | [`putz_db.sql` L181](../../db-reference/putz_db.sql) |
| 11 | `asset_startup` | Ativos digitais | [`putz_db.sql` L200](../../db-reference/putz_db.sql) |
| 12 | `asset_voice_speaker` | Ativos digitais | [`putz_db.sql` L260](../../db-reference/putz_db.sql) |
| 13 | `asset_voice_voiceover` | Ativos digitais | [`putz_db.sql` L279](../../db-reference/putz_db.sql) |
| 14 | `competence` | Apoio operacional | [`putz_db.sql` L305](../../db-reference/putz_db.sql) |
| 15 | `competence_guide` | Apoio operacional | [`putz_db.sql` L323](../../db-reference/putz_db.sql) |
| 16 | `config_params` | Apoio operacional | [`putz_db.sql` L349](../../db-reference/putz_db.sql) |
| 17 | `DATABASECHANGELOG` | Controle Liquibase | [`putz_db.sql` L370](../../db-reference/putz_db.sql) |
| 18 | `DATABASECHANGELOGLOCK` | Controle Liquibase | [`putz_db.sql` L393](../../db-reference/putz_db.sql) |
| 19 | `franquias` | Franquias | [`putz_db.sql` L406](../../db-reference/putz_db.sql) |
| 20 | `franquias__expansao_interesse` | Franquias | [`putz_db.sql` L423](../../db-reference/putz_db.sql) |
| 21 | `franquias__investimentos_franquia` | Franquias | [`putz_db.sql` L438](../../db-reference/putz_db.sql) |
| 22 | `franquias__premiacoes` | Franquias | [`putz_db.sql` L454](../../db-reference/putz_db.sql) |
| 23 | `franquias__redes_franquia` | Franquias | [`putz_db.sql` L470](../../db-reference/putz_db.sql) |
| 24 | `franquias__redes_sociais` | Franquias | [`putz_db.sql` L486](../../db-reference/putz_db.sql) |
| 25 | `franquias__requisitos_franquia` | Franquias | [`putz_db.sql` L500](../../db-reference/putz_db.sql) |
| 26 | `franquias__segmentos` | Franquias | [`putz_db.sql` L517](../../db-reference/putz_db.sql) |
| 27 | `franquias__sub_segmentos` | Franquias | [`putz_db.sql` L529](../../db-reference/putz_db.sql) |
| 28 | `franquias__taxas_franquia` | Franquias | [`putz_db.sql` L542](../../db-reference/putz_db.sql) |
| 29 | `franquias__unidades` | Franquias | [`putz_db.sql` L559](../../db-reference/putz_db.sql) |
| 30 | `ibge_names_and_frequency` | Geografia (IBGE) | [`putz_db.sql` L575](../../db-reference/putz_db.sql) |
| 31 | `ibge_name_group_sum` | Geografia (IBGE) | [`putz_db.sql` L590](../../db-reference/putz_db.sql) |
| 32 | `ibge__city` | Geografia (IBGE) | [`putz_db.sql` L607](../../db-reference/putz_db.sql) |
| 33 | `ibge__name` | Geografia (IBGE) | [`putz_db.sql` L630](../../db-reference/putz_db.sql) |
| 34 | `ibge__name_frequency` | Geografia (IBGE) | [`putz_db.sql` L658](../../db-reference/putz_db.sql) |
| 35 | `ibge__name_group` | Geografia (IBGE) | [`putz_db.sql` L689](../../db-reference/putz_db.sql) |
| 36 | `ibge__name_render` | Geografia (IBGE) | [`putz_db.sql` L713](../../db-reference/putz_db.sql) |
| 37 | `ibge__uf` | Geografia (IBGE) | [`putz_db.sql` L733](../../db-reference/putz_db.sql) |
| 38 | `notification_whatsapp` | Integração externa | [`putz_db.sql` L754](../../db-reference/putz_db.sql) |
| 39 | `openai_assistants` | Integração externa | [`putz_db.sql` L806](../../db-reference/putz_db.sql) |
| 40 | `openai_conclusions` | Integração externa | [`putz_db.sql` L830](../../db-reference/putz_db.sql) |
| 41 | `page_faq` | Apoio operacional | [`putz_db.sql` L852](../../db-reference/putz_db.sql) |
| 42 | `person` | Pessoa | [`putz_db.sql` L872](../../db-reference/putz_db.sql) |
| 43 | `person_references` | Pessoa | [`putz_db.sql` L925](../../db-reference/putz_db.sql) |
| 44 | `portfolio` | Portfólio | [`putz_db.sql` L944](../../db-reference/putz_db.sql) |
| 45 | `portfolio__tags` | Portfólio | [`putz_db.sql` L973](../../db-reference/putz_db.sql) |
| 46 | `product` | Produto | [`putz_db.sql` L984](../../db-reference/putz_db.sql) |
| 47 | `product_competence` | Produto | [`putz_db.sql` L1005](../../db-reference/putz_db.sql) |
| 48 | `product_group` | Produto | [`putz_db.sql` L1022](../../db-reference/putz_db.sql) |
| 49 | `product_type` | Produto | [`putz_db.sql` L1039](../../db-reference/putz_db.sql) |
| 50 | `project` | Projetos | [`putz_db.sql` L1060](../../db-reference/putz_db.sql) |
| 51 | `project_calc` | Projetos | [`putz_db.sql` L1123](../../db-reference/putz_db.sql) |
| 52 | `project_case` | Projetos | [`putz_db.sql` L1169](../../db-reference/putz_db.sql) |
| 53 | `project_item` | Projetos | [`putz_db.sql` L1196](../../db-reference/putz_db.sql) |
| 54 | `project_item_request` | Projetos | [`putz_db.sql` L1236](../../db-reference/putz_db.sql) |
| 55 | `project_payment` | Projetos | [`putz_db.sql` L1256](../../db-reference/putz_db.sql) |
| 56 | `project_render` | Projetos | [`putz_db.sql` L1278](../../db-reference/putz_db.sql) |
| 57 | `project_render_group_name` | Projetos | [`putz_db.sql` L1336](../../db-reference/putz_db.sql) |
| 58 | `project_render_item` | Projetos | [`putz_db.sql` L1355](../../db-reference/putz_db.sql) |
| 59 | `project_render_log` | Projetos | [`putz_db.sql` L1411](../../db-reference/putz_db.sql) |
| 60 | `project_render_user` | Projetos | [`putz_db.sql` L1430](../../db-reference/putz_db.sql) |
| 61 | `project_step` | Projetos | [`putz_db.sql` L1442](../../db-reference/putz_db.sql) |
| 62 | `project__tags` | Projetos | [`putz_db.sql` L1473](../../db-reference/putz_db.sql) |
| 63 | `publications` | Publicações | [`putz_db.sql` L1484](../../db-reference/putz_db.sql) |
| 64 | `publications_complete` | Publicações | [`putz_db.sql` L1506](../../db-reference/putz_db.sql) |
| 65 | `publications_source` | Publicações | [`putz_db.sql` L1526](../../db-reference/putz_db.sql) |
| 66 | `publications_source__tags` | Publicações | [`putz_db.sql` L1561](../../db-reference/putz_db.sql) |
| 67 | `publications_source__type_users` | Publicações | [`putz_db.sql` L1573](../../db-reference/putz_db.sql) |
| 68 | `publications_user` | Publicações | [`putz_db.sql` L1590](../../db-reference/putz_db.sql) |
| 69 | `publication_task` | Publicações | [`putz_db.sql` L1619](../../db-reference/putz_db.sql) |
| 70 | `putz_authority` | Conta e segurança | [`putz_db.sql` L1650](../../db-reference/putz_db.sql) |
| 71 | `putz_persistent_audit_event` | Conta e segurança | [`putz_db.sql` L1661](../../db-reference/putz_db.sql) |
| 72 | `putz_persistent_audit_evt_data` | Conta e segurança | [`putz_db.sql` L1674](../../db-reference/putz_db.sql) |
| 73 | `putz_user` | Conta e segurança | [`putz_db.sql` L1686](../../db-reference/putz_db.sql) |
| 74 | `putz_user_authority` | Conta e segurança | [`putz_db.sql` L1716](../../db-reference/putz_db.sql) |
| 75 | `question` | Apoio operacional | [`putz_db.sql` L1727](../../db-reference/putz_db.sql) |
| 76 | `rel_product_type__groups` | Produto | [`putz_db.sql` L1746](../../db-reference/putz_db.sql) |
| 77 | `rel_product_type__tags` | Produto | [`putz_db.sql` L1757](../../db-reference/putz_db.sql) |
| 78 | `render_item_resume` | Apoio operacional | [`putz_db.sql` L1768](../../db-reference/putz_db.sql) |
| 79 | `satisfaction_survey` | Apoio operacional | [`putz_db.sql` L1785](../../db-reference/putz_db.sql) |
| 80 | `schedule` | Apoio operacional | [`putz_db.sql` L1804](../../db-reference/putz_db.sql) |
| 81 | `schedule_step` | Apoio operacional | [`putz_db.sql` L1822](../../db-reference/putz_db.sql) |
| 82 | `smart_websummit_rio` | Apoio operacional | [`putz_db.sql` L1845](../../db-reference/putz_db.sql) |
| 83 | `subscriptions` | Apoio operacional | [`putz_db.sql` L1862](../../db-reference/putz_db.sql) |
| 84 | `subscription_plans` | Apoio operacional | [`putz_db.sql` L1889](../../db-reference/putz_db.sql) |
| 85 | `tag` | Tags e classificação | [`putz_db.sql` L1918](../../db-reference/putz_db.sql) |
| 86 | `timeline_attachment` | Apoio operacional | [`putz_db.sql` L1937](../../db-reference/putz_db.sql) |
| 87 | `timeline_comment` | Apoio operacional | [`putz_db.sql` L1956](../../db-reference/putz_db.sql) |
| 88 | `timeline_event` | Apoio operacional | [`putz_db.sql` L1975](../../db-reference/putz_db.sql) |
| 89 | `transaction` | Transações | [`putz_db.sql` L2002](../../db-reference/putz_db.sql) |
| 90 | `transaction_coupon` | Transações | [`putz_db.sql` L2036](../../db-reference/putz_db.sql) |
| 91 | `transaction_coupon_remover` | Transações | [`putz_db.sql` L2065](../../db-reference/putz_db.sql) |
| 92 | `transaction_remover` | Transações | [`putz_db.sql` L2092](../../db-reference/putz_db.sql) |

#### Resumo por domínio

| Domínio | Quantidade |
|---------|------------|
| Ativos digitais | 13 |
| Apoio operacional | 15 |
| Controle Liquibase | 2 |
| Franquias | 11 |
| Geografia (IBGE) | 8 |
| Integração externa | 3 |
| Pessoa | 2 |
| Portfólio | 2 |
| Produto | 6 |
| Projetos | 13 |
| Publicações | 7 |
| Conta e segurança | 5 |
| Tags e classificação | 1 |
| Transações | 4 |
| **Total** | **92** |

### FKs do schema (109 restrições)

Lista derivada da secção `ALTER TABLE ... ADD CONSTRAINT` de [`putz_db.sql`](../../db-reference/putz_db.sql).
Notação: `origem.coluna -> destino.coluna`.

| Tabela origem | FK | Destino |
|---------------|----|---------|
| `asset_category` | `root_category_id` | `asset_category.id` |
| `asset_category__users` | `categories_id` | `asset_category.id` |
| `asset_category__users` | `person_id` | `putz_user.id` |
| `asset_item__categories` | `asset_item_id` | `asset_item.id` |
| `asset_item__categories` | `category_id` | `asset_category.id` |
| `asset_item__voice_overs` | `asset_item_id` | `asset_item.id` |
| `asset_item__voice_overs` | `voice_overs_id` | `asset_voice_voiceover.id` |
| `asset_retail_product` | `default_supplier_id` | `asset_retail_supplier.id` |
| `asset_retail_product` | `default_unit_id` | `asset_retail_unit.id` |
| `asset_retail_product__categories` | `asset_retail_product_id` | `asset_retail_product.id` |
| `asset_retail_product__categories` | `categories_id` | `asset_category.id` |
| `asset_retail_product__voice_overs` | `asset_retail_product_id` | `asset_retail_product.id` |
| `asset_retail_product__voice_overs` | `voice_overs_id` | `asset_voice_voiceover.id` |
| `asset_startup` | `category_id` | `asset_category.id` |
| `asset_voice_voiceover` | `category_id` | `asset_category.id` |
| `asset_voice_voiceover` | `speaker_id` | `asset_voice_speaker.id` |
| `competence_guide` | `competence_id` | `competence.id` |
| `franquias` | `segmento_id` | `franquias__segmentos.id` |
| `franquias` | `rede_id` | `franquias__redes_franquia.id` |
| `franquias__expansao_interesse` | `franquia_id` | `franquias.id` |
| `franquias__investimentos_franquia` | `franquia_id` | `franquias.id` |
| `franquias__premiacoes` | `franquia_id` | `franquias.id` |
| `franquias__redes_sociais` | `franquia_id` | `franquias.id` |
| `franquias__requisitos_franquia` | `franquia_id` | `franquias.id` |
| `franquias__sub_segmentos` | `segmento_id` | `franquias__segmentos.id` |
| `franquias__taxas_franquia` | `franquia_id` | `franquias.id` |
| `franquias__unidades` | `franquia_id` | `franquias.id` |
| `ibge__city` | `uf_id` | `ibge__uf.id` |
| `ibge__name` | `name_group_id` | `ibge__name_group.id` |
| `ibge__name_frequency` | `uf_id` | `ibge__uf.id` |
| `ibge__name_frequency` | `name_id` | `ibge__name.id` |
| `ibge__name_render` | `ibge_name_id` | `ibge__name.id` |
| `ibge__name_render` | `project_render_id` | `project_render.id` |
| `notification_whatsapp` | `time_line_event_id` | `timeline_event.id` |
| `notification_whatsapp` | `person_id` | `person.id` |
| `notification_whatsapp` | `project_render_item_id` | `project_render_item.id` |
| `person` | `company_id` | `person.id` |
| `person_references` | `person_id` | `person.id` |
| `portfolio` | `competence_id` | `competence.id` |
| `portfolio` | `person_id` | `person.id` |
| `portfolio__tags` | `portfolio_id` | `portfolio.id` |
| `portfolio__tags` | `tags_id` | `tag.id` |
| `product` | `product_type_id` | `product_type.id` |
| `product_competence` | `competence_id` | `competence.id` |
| `product_competence` | `product_type_id` | `product_type.id` |
| `project` | `agency_id` | `person.id` |
| `project` | `cancel_user_id` | `person.id` |
| `project` | `client_id` | `person.id` |
| `project` | `manager_id` | `person.id` |
| `project` | `root_project_id` | `project.id` |
| `project` | `vendor_id` | `person.id` |
| `project_calc` | `id` | `project.id` |
| `project_case` | `id` | `project.id` |
| `project_item` | `freelancer_id` | `person.id` |
| `project_item` | `product_id` | `product.id` |
| `project_item` | `project_id` | `project.id` |
| `project_item` | `project_step_id` | `project_step.id` |
| `project_item_request` | `freelancer_id` | `person.id` |
| `project_item_request` | `project_item_id` | `project_item.id` |
| `project_payment` | `project_id` | `project.id` |
| `project_render_group_name` | `ibge_name_group_id` | `ibge__name_group.id` |
| `project_render_group_name` | `render_id` | `project_render.id` |
| `project_render_item` | `person_id` | `person.id` |
| `project_render_item` | `render_project_id` | `project_render.id` |
| `project_render_log` | `project_render_item_id` | `project_render_item.id` |
| `project_step` | `project_id` | `project.id` |
| `project_step` | `step_id` | `schedule_step.id` |
| `project__tags` | `project_id` | `project.id` |
| `project__tags` | `tags_id` | `tag.id` |
| `publications` | `publications_source_id` | `publications_source.id` |
| `publications_source__tags` | `publication_source_id` | `publications_source.id` |
| `publications_source__tags` | `tags_id` | `tag.id` |
| `publications_source__type_users` | `person_id` | `person.id` |
| `publications_user` | `project_render_item_id` | `project_render_item.id` |
| `publications_user` | `publication_id` | `publications.id` |
| `publications_user` | `owner_id` | `putz_user.id` |
| `publication_task` | `publication_source_id` | `publications_source.id` |
| `putz_persistent_audit_evt_data` | `event_id` | `putz_persistent_audit_event.event_id` |
| `putz_user_authority` | `authority_name` | `putz_authority.name` |
| `putz_user_authority` | `user_id` | `putz_user.id` |
| `rel_product_type__groups` | `groups_id` | `product_group.id` |
| `rel_product_type__groups` | `product_type_id` | `product_type.id` |
| `rel_product_type__tags` | `product_type_id` | `product_type.id` |
| `rel_product_type__tags` | `tags_id` | `tag.id` |
| `satisfaction_survey` | `project_id` | `project.id` |
| `satisfaction_survey` | `question_id` | `question.id` |
| `schedule_step` | `schedule_id` | `schedule.id` |
| `subscriptions` | `user_id` | `putz_user.id` |
| `subscriptions` | `transaction_id` | `transaction.id` |
| `subscriptions` | `subscription_plan_id` | `subscription_plans.id` |
| `timeline_attachment` | `event_id` | `timeline_event.id` |
| `timeline_comment` | `created_by` | `putz_user.login` |
| `timeline_comment` | `event_id` | `timeline_event.id` |
| `timeline_comment` | `root_comment_id` | `timeline_comment.id` |
| `timeline_event` | `project_item_id` | `project_item.id` |
| `timeline_event` | `project_step_id` | `project_step.id` |
| `timeline_event` | `root_event_id` | `timeline_event.id` |
| `transaction` | `person_id` | `person.id` |
| `transaction` | `project_id` | `project.id` |
| `transaction` | `project_item_id` | `project_item.id` |
| `transaction` | `related_transaction_id` | `transaction.id` |
| `transaction` | `subscription_id` | `subscriptions.id` |
| `transaction_coupon` | `person_id` | `person.id` |
| `transaction_coupon` | `person_owner_id` | `person.id` |
| `transaction_coupon` | `project_id` | `project.id` |
| `transaction_coupon` | `publications_user_id` | `publications_user.id` |
| `transaction_coupon` | `project_render_id` | `project_render.id` |
| `transaction_coupon` | `project_render_item_id` | `project_render_item.id` |
| `transaction_coupon` | `transaction_id` | `transaction.id` |

### Cenários de pergunta cobertos

A bateria definitiva (`batteryVersion` v1, commit `9985067`) distribui 30 perguntas em **seis cenários**
metodológicos. Removidos da taxonomia anterior de oito cenários: `Listagem simples` e `Filtro por enum`.

| Cenário | Perguntas (ex.) | Tipo de SQL esperado |
|---------|-----------------|----------------------|
| Junção 1:N | Q01--Q04 | `JOIN` directo |
| Junção em cadeia | Q05, Q11, Q12, Q21, Q22 | `JOIN` múltiplos no mesmo domínio |
| Agregação | Q06, Q07, Q13, Q23, Q24 | `SUM`/`COUNT`/`GROUP BY` |
| Filtro temporal | Q08, Q14, Q29 | `WHERE` datas, janelas, `CASE` temporal |
| Junção geográfica | Q09, Q10, Q15, Q30 | `JOIN` IBGE (`ibge__uf`, `ibge__city`) |
| Junção cross-domínio | Q16--Q20, Q25--Q28 | `JOIN` entre domínios (projetos, ativos, publicações) |

Inventário completo: [`../../evidence/bateria-30-perguntas-v1.csv`](../../evidence/bateria-30-perguntas-v1.csv).
Matriz de cobertura: [`../../evidence/matriz-cobertura-bateria-v1.md`](../../evidence/matriz-cobertura-bateria-v1.md).

A bateria de 30 perguntas deve distribuir cenários sobre domínios distintos do inventário completo.

### Volume da massa `putz_teste` (fixa)

O schema PS permanece inalterado no volume observado de `putz_teste` (~1388,27 MB), sem amplificação
sintética. O volume é suficiente para os cenários de pergunta definidos no protocolo experimental e dispensa
geração de dados artificiais que poderiam introduzir viés no cálculo da aderência estrutural.

Regras de volume:

1. a massa é extraída do dump original e fixada antes das corridas finais;
2. nenhuma replicação ou geração sintética de registros é adotada no MVP;
3. alteração do schema exposto exige nova `datasetVersion` e justificativa;
4. contagens por tabela são validadas contra o dump original na carga.

Riscos e controles:

- privacidade: manter mascaramento de colunas sensíveis na fixação;
- custo/tempo de carga: validar contagens por domínio após a ingestão única;
- reprodutibilidade: `datasetVersion` fixa identifica a massa estável de cada campanha.

### Artefatos esperados

- Script de extração e fixação das 92 tabelas (a partir do dump original do PS).
- Script de carga no cluster (ver [`carga-cluster-putz.md`](carga-cluster-putz.md)).
- Inventário de perguntas por cenário.
- Matriz de cobertura pergunta x tabelas/colunas/relacionamentos esperados.
- Registro `datasetVersion` em cada `evidence/<runId>/context.json`.

## Próximo passo

[`catalogo-atlas.md`](catalogo-atlas.md)
