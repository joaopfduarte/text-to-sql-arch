---
description: Notas de exploração das colunas semiestruturadas json_data e data_source de project_render_item e tabelas correlatas, para desenho de Q31–Q40.
tags:
  - experimento
  - evidencia
  - notas-trabalho
---

# Notas de schema: json_data e data_source (Q31–Q40)

Levantamento das colunas JSON usadas nas perguntas Q31–Q40. Fontes: DDL MySQL em
[Dump MySQL base_laboratorial](../dados/base_laboratorial.sql) (tabelas `project_render_item`,
`publications_user`, `transaction_coupon`, `notification_whatsapp`) e amostragem de conteúdo da massa
de laboratório.

> A massa canônica está versionada como schema **`base_laboratorial`** (MySQL 8+, 92 tabelas). A
> validação numérica fica pendente de execução local do autor contra o dump publicado.

## 1. `project_render_item` (tabela-âncora obrigatória de Q31–Q40)

Coluna LOB `json_data` e `data_source` (tipo `clob`/`LONGTEXT`). Não-nulos no snapshot:

| Coluna | Não-nulos | Total | Cobertura |
|--------|-----------|-------|-----------|
| `json_data` | 72 885 | 73 981 | ~98,5% |
| `data_source` | 72 915 | 73 981 | ~98,6% |
| `whatsapp` | 43 502 | 73 981 | ~58,8% |

Colunas escalares úteis: `id`, `person_id` (FK `person`), `render_project_id` (FK `project_render`),
`render_status`, `type`, `origin`, `name`, `email`, `whatsapp`, `whatsapp_status`, `created_date`,
`render_slug`.

Valores reais observados (não inventar enum):

- `render_status`: `FINISHED` (52 933), `ERROR` (9 577), `EXPIRED` (5 822), `SAMBA_HOST` (4 639),
  `CANCELED` (1 001), `NO_CODE` (9).
- `type`: `NEW`, `COPY`, `default`, `NULL`.
- `origin`: `CSV`, `NULL`, `API`, `JSON`, `OPENAI`.
- `whatsapp_status`: `NULL`, `DELIVERED`, `EXPIRED`, `INVITED`, `ERROR`, `CANCELED`.

### 1.1 `data_source` — objeto JSON de negócio do render

Objeto JSON; chaves variam conforme o template do render (semiestruturado). Frequência das chaves mais
comuns no snapshot:

| Chave JSON | Ocorrências | Path testável |
|------------|-------------|---------------|
| `name` | 58 473 | `JSON_EXTRACT(data_source, '$.name')` |
| `groupName` | 53 740 | `data_source LIKE '%groupName":"Default%'` (cf. comentário do DTO) |
| `whatsapp` | 31 144 | `JSON_UNQUOTE(JSON_EXTRACT(data_source, '$.whatsapp'))` |
| `uf` | 20 989 | `JSON_UNQUOTE(JSON_EXTRACT(data_source, '$.uf'))` |
| `city` | 19 262 | `JSON_UNQUOTE(JSON_EXTRACT(data_source, '$.city'))` |
| `company` | 14 963 | `JSON_EXTRACT(data_source, '$.company')` |
| `companyBusiness` | 11 142 | `JSON_EXTRACT(data_source, '$.companyBusiness')` |
| `email` | 5 620 | `JSON_EXTRACT(data_source, '$.email')` |

Exemplo real (template de empréstimo):

```json
{"name":"ANA","reason":"INSERT_VIAGEM.mp4","warranty":"Garantia_IMOVEL.mp3","loanValue":"50000",
 "rate":"0.99","portionValue":"2500","date":15,"city":"Timoteo","uf":"MG"}
```

Comentários do autor em `ProjectRenderItemDTO.java` (L641+) confirmam o padrão de uso real:

```sql
SELECT DISTINCT(JSON_EXTRACT(data_source, "$.name")) FROM project_render_item
WHERE render_slug LIKE 'minas-summit-2023' AND data_source LIKE '%groupName":"Default%';
```

### 1.2 `json_data` — objeto JSON do template/render

Objeto JSON com chaves de topo `template`, `actions`, `assets` (~55 mil objetos parseáveis). Há sujidade
real de dados: a chave `assets` aparece grafada como `asssets` (typo) em 139 linhas — útil para perguntas
de qualidade de dado e `JSON_VALID`/existência de chave.

Paths testáveis:

- `JSON_EXTRACT(json_data, '$.template.composition')`
- `JSON_EXTRACT(json_data, '$.template.output')`
- `JSON_LENGTH(json_data, '$.assets')` (número de camadas do template)
- `JSON_CONTAINS_PATH(json_data, 'one', '$.assets')` vs `'$.asssets'`
- `JSON_VALID(json_data)`

## 2. Normalização de telefone (`whatsapp`)

`project_render_item.whatsapp` guarda o número no formato `+55DDDNNNNNNNN` (ex.: `+553188887770`).
`person.phone_whatsapp` guarda o telefone da conta. Para casar render anónimo com conta criada depois, a
normalização recomendada remove não-dígitos de ambos os lados:

```sql
REGEXP_REPLACE(pri.whatsapp, '[^0-9]', '') = REGEXP_REPLACE(pe.phone_whatsapp, '[^0-9]', '')
```

Também há a chave `data_source.$.whatsapp` (31 144 ocorrências) como alternativa quando a coluna escalar
`whatsapp` está nula.

## 3. Outras colunas JSON correlatas

- `notification_whatsapp.data_source`: objeto de notícia/conteúdo
  (`{"title","published","image","type":"notícia","link","excerpt"}`). FK `project_render_item_id`,
  `person_id`, `time_line_event_id`. `notification_direction` ∈ {`OUTBOUND_API`, `INBOUND`, `OUTBOUND-API`,
  `REPLY_INBOUND`}; `notification_status` ∈ {`READ`, `DELIVERED`, `SENT`, `FAILED`, `UNDELIVERED`, ...}.
- `publications_user.json_publication` (LONGTEXT) e `publications.json_data` (LONGTEXT, NOT NULL); FK
  `publications_user.project_render_item_id`, `owner_id` (NULL = sem conta), `requester_id` (NOT NULL),
  `publication_id`, `status`, `platform`.
- `project_render.json_template`, `project_render.json_data_source` (template-mãe do render).

## 4. Grafo de junções confirmado (FKs)

```
project_render_item.render_project_id      -> project_render.id
project_render_item.person_id              -> person.id
person.company_id                          -> person.id          (hierarquia sponsor: filho.company_id = sponsor.id)
person.address_uf                          -> ibge__uf.uf
publications_user.project_render_item_id   -> project_render_item.id
publications_user.owner_id / requester_id  -> person.id
publications_user.publication_id           -> publications.id
transaction_coupon.project_render_item_id  -> project_render_item.id
transaction_coupon.person_owner_id         -> person.id          (afiliado dono do cupom)
transaction_coupon.person_id               -> person.id          (usuário do cupom)
transaction_coupon.transaction_id          -> transaction.id
notification_whatsapp.project_render_item_id -> project_render_item.id
notification_whatsapp.person_id            -> person.id
```

## 5. Perspectivas de usuário (papéis reais, `AuthoritiesConstants`)

- `ROLE_ADMIN`: visão global; agregações analíticas (cohort de tempo, região via `ibge__uf`,
  status de render, qualidade de JSON).
- `ROLE_PUBLISHER`: publicação de renders em plataformas via `publications_user` (status, plataforma).
- `ROLE_AFFILIATE`: cupons (`transaction_coupon.person_owner_id`) atrelados a renders.
- `ROLE_SPONSOR`: empresa-mãe que vê renders dos filhos (`person.company_id = sponsor.id`;
  `CONTABILIDADE_SPONSOR_ID = 3118`).
