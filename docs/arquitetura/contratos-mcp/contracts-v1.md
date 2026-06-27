---
description: Envelope JSON, quinze tools MCP e taxonomia de erro v1.
tags:
  - mcp
---

# Contratos MCP v1

!!! info "Recomendado para leitura prévia"
    - **[Camadas MCP](../aplicacao/camadas-mcp.md)** — mapeamento tool → porta → contrato → erro.
    - **[Schema massa de teste](../dados/schema-massa-teste.md)** — inventário das 92 entidades.


### Política de versionamento

- Versionamento semântico: `vMAJOR.MINOR.PATCH`.
- `MAJOR`: quebra de contrato.
- `MINOR`: extensão compatível.
- `PATCH`: ajuste sem mudança de estrutura.

### Convenção de schema do catálogo

- `schema = "laboratorio"`: subconjunto laboratorial (92 entidades) registrado em Apache Atlas como database `hive_db` chamado `base_laboratorial`.
- Nomes de tabela e coluna usam identificadores reais do schema `base_laboratorial` conforme [Schema massa de teste](../dados/schema-massa-teste.md).

### Envelope padrão de resposta

```json
{
  "runId": "run-20260418-1530-a1b2",
  "toolVersion": "v1.0.0",
  "status": "ok",
  "data": {},
  "error": null
}
```

Em erro, `status = "error"`, `data = null` e `error = { "code": "<canonico>", "message": "<descricao>" }`.

### Catálogo fechado v1 (15 tools)

O catálogo da v1 é **fechado em quinze tools** de descoberta somente leitura sobre o Apache Atlas (API REST v2):
três basais (protocolo mínimo de avaliação) e doze complementares (mesmo contrato, mesmo orçamento de 10 chamadas por
sessão). Evidência da seleção em [Matriz de 15 tools MCP](../../evidence/matriz-15-tools-mcp.md).

| # | Tool MCP | Papel | Operação Atlas (v2) |
|---|----------|-------|---------------------|
| 1 | `catalog.listTables` | basal | `GET /v2/search/dsl` |
| 2 | `catalog.describeTable` | basal | `GET /v2/entity/uniqueAttribute/type/{typeName}` |
| 3 | `catalog.listRelationships` | basal | `GET /v2/types/relationshipdef/name/{name}` |
| 4 | `catalog.searchTables` | complementar | `GET /v2/search/dsl` |
| 5 | `catalog.quickSearch` | complementar | `GET /v2/search/quick` |
| 6 | `catalog.searchByAttribute` | complementar | `GET /v2/search/attribute` |
| 7 | `catalog.fullTextSearch` | complementar | `GET /v2/search/fulltext` |
| 8 | `catalog.getEntityByGuid` | complementar | `GET /v2/entity/guid/{guid}` |
| 9 | `catalog.getEntityByName` | complementar | `GET /v2/entity/uniqueAttribute/type/{typeName}` |
| 10 | `catalog.getEntityHeader` | complementar | `GET /v2/entity/guid/{guid}/header` |
| 11 | `catalog.getClassifications` | complementar | `GET /v2/entity/guid/{guid}/classifications` |
| 12 | `catalog.getEntityAudit` | complementar | `GET /v2/entity/{guid}/audit` |
| 13 | `catalog.getLineage` | complementar | `GET /v2/lineage/{guid}` |
| 14 | `catalog.getEntityTypeDef` | complementar | `GET /v2/types/entitydef/name/{name}` |
| 15 | `catalog.getRelationshipTypeDef` | complementar | `GET /v2/types/relationshipdef/name/{name}` |

### Tools basais do protocolo mínimo

#### 1) `catalog.listTables`

Entrada:

```json
{
  "schema": "laboratorio",
  "limit": 50,
  "cursor": null
}
```

Saída:

```json
{
  "tables": [
    { "name": "franquias", "type": "TABLE" },
    { "name": "franquias__segmentos", "type": "TABLE" },
    { "name": "franquias__redes_franquia", "type": "TABLE" },
    { "name": "franquias__unidades", "type": "TABLE" },
    { "name": "project", "type": "TABLE" },
    { "name": "project_item", "type": "TABLE" },
    { "name": "project_payment", "type": "TABLE" },
    { "name": "person", "type": "TABLE" },
    { "name": "product", "type": "TABLE" },
    { "name": "product_type", "type": "TABLE" },
    { "name": "transaction", "type": "TABLE" },
    { "name": "transaction_coupon", "type": "TABLE" },
    { "name": "ibge__city", "type": "TABLE" },
    { "name": "ibge__uf", "type": "TABLE" }
  ],
  "nextCursor": null
}
```

#### 2) `catalog.describeTable`

Entrada:

```json
{
  "schema": "laboratorio",
  "table": "franquias"
}
```

Saída (colunas observadas em [Schema massa de teste](../dados/schema-massa-teste.md)):

```json
{
  "table": "franquias",
  "columns": [
    { "name": "id", "dataType": "INT", "nullable": false },
    { "name": "col_c0d85479", "dataType": "VARCHAR(255)", "nullable": false },
    { "name": "col_632ad9d4", "dataType": "VARCHAR(255)", "nullable": true },
    { "name": "col_6e8c4b2c", "dataType": "VARCHAR(255)", "nullable": true },
    { "name": "segmento_id", "dataType": "INT", "nullable": true },
    { "name": "rede_id", "dataType": "INT", "nullable": true },
    { "name": "col_ee3dab3a", "dataType": "DATETIME", "nullable": true },
    { "name": "col_acadb37c", "dataType": "DATETIME", "nullable": true }
  ]
}
```

#### 3) `catalog.listRelationships`

Entrada:

```json
{
  "schema": "laboratorio",
  "table": "franquias"
}
```

Saída (FKs confirmadas em [Schema massa de teste](../dados/schema-massa-teste.md)):

```json
{
  "relationships": [
    {
      "fromTable": "franquias",
      "fromColumn": "segmento_id",
      "toTable": "franquias__segmentos",
      "toColumn": "id",
      "relationshipType": "FK"
    },
    {
      "fromTable": "franquias",
      "fromColumn": "rede_id",
      "toTable": "franquias__redes_franquia",
      "toColumn": "id",
      "relationshipType": "FK"
    }
  ]
}
```

### Tools complementares do catálogo v1

As doze tools abaixo compartilham o envelope, a taxonomia de erro e o versionamento das basais. Todas são somente
leitura sobre o Apache Atlas. Os exemplos usam entidades reais da massa laboratorial (`base_laboratorial.franquias`, `base_laboratorial.project`).

#### 4) `catalog.searchTables`

Mapeia `searchUsingDSL` (`GET /v2/search/dsl`). Localiza tabelas por termo antes de descrevê-las.

Entrada:

```json
{
  "schema": "laboratorio",
  "query": "franquias",
  "typeName": "hive_table",
  "limit": 25,
  "offset": 0
}
```

Saída:

```json
{
  "approximateCount": 4,
  "entities": [
    { "guid": "a1b2-...", "name": "franquias", "typeName": "hive_table", "qualifiedName": "base_laboratorial.franquias@cluster" },
    { "guid": "c3d4-...", "name": "franquias__segmentos", "typeName": "hive_table", "qualifiedName": "base_laboratorial.franquias__segmentos@cluster" }
  ]
}
```

#### 5) `catalog.quickSearch`

Mapeia `quickSearch` (`GET /v2/search/quick`). Ranqueia candidatos com métricas de agregação.

Entrada:

```json
{
  "schema": "laboratorio",
  "query": "project",
  "typeName": "hive_table",
  "excludeDeletedEntities": true,
  "limit": 25,
  "offset": 0
}
```

Saída:

```json
{
  "approximateCount": 3,
  "entities": [
    { "guid": "e5f6-...", "name": "project", "typeName": "hive_table", "qualifiedName": "base_laboratorial.project@cluster" },
    { "guid": "g7h8-...", "name": "project_item", "typeName": "hive_table", "qualifiedName": "base_laboratorial.project_item@cluster" }
  ],
  "aggregationMetrics": { "typeName": [ { "name": "hive_table", "count": 3 } ] }
}
```

#### 6) `catalog.searchByAttribute`

Mapeia `searchUsingAttribute` (`GET /v2/search/attribute`). Casa entidades por atributo exato ou prefixo.

Entrada:

```json
{
  "schema": "laboratorio",
  "typeName": "hive_table",
  "attrName": "name",
  "attrValuePrefix": "transaction",
  "limit": 25,
  "offset": 0
}
```

Saída:

```json
{
  "approximateCount": 2,
  "entities": [
    { "guid": "i9j0-...", "name": "transaction", "typeName": "hive_table", "qualifiedName": "base_laboratorial.transaction@cluster" },
    { "guid": "k1l2-...", "name": "transaction_coupon", "typeName": "hive_table", "qualifiedName": "base_laboratorial.transaction_coupon@cluster" }
  ]
}
```

#### 7) `catalog.fullTextSearch`

Mapeia `searchUsingFullText` (`GET /v2/search/fulltext`). Recupera entidades por texto livre quando o termo é incerto.

Entrada:

```json
{
  "schema": "laboratorio",
  "query": "franquias__segmentos",
  "excludeDeletedEntities": true,
  "limit": 25,
  "offset": 0
}
```

Saída:

```json
{
  "approximateCount": 2,
  "entities": [
    { "guid": "m3n4-...", "name": "franquias__segmentos", "typeName": "hive_table", "qualifiedName": "base_laboratorial.franquias__segmentos@cluster" }
  ]
}
```

#### 8) `catalog.getEntityByGuid`

Mapeia `getById` (`GET /v2/entity/guid/{guid}`). Resolve a entidade completa de uma tabela ou coluna.

Entrada:

```json
{
  "guid": "a1b2-...",
  "minExtInfo": true
}
```

Saída:

```json
{
  "entity": {
    "guid": "a1b2-...",
    "typeName": "hive_table",
    "status": "ACTIVE",
    "attributes": { "name": "franquias", "qualifiedName": "base_laboratorial.franquias@cluster" },
    "classificationNames": []
  }
}
```

#### 9) `catalog.getEntityByName`

Mapeia `getByUniqueAttributes` (`GET /v2/entity/uniqueAttribute/type/{typeName}`). Resolve a entidade pelo nome
canônico sem conhecer o GUID. O atributo único é passado como `attr:qualifiedName`.

Entrada:

```json
{
  "typeName": "hive_table",
  "qualifiedName": "base_laboratorial.franquias@cluster",
  "minExtInfo": true
}
```

Saída:

```json
{
  "entity": {
    "guid": "a1b2-...",
    "typeName": "hive_table",
    "status": "ACTIVE",
    "attributes": { "name": "franquias", "qualifiedName": "base_laboratorial.franquias@cluster" }
  }
}
```

#### 10) `catalog.getEntityHeader`

Mapeia `getHeaderById` (`GET /v2/entity/guid/{guid}/header`). Cabeçalho enxuto para confirmar existência e tipo.

Entrada:

```json
{
  "guid": "e5f6-..."
}
```

Saída:

```json
{
  "guid": "e5f6-...",
  "typeName": "hive_table",
  "status": "ACTIVE",
  "displayText": "project",
  "classificationNames": []
}
```

#### 11) `catalog.getClassifications`

Mapeia `getClassifications` (`GET /v2/entity/guid/{guid}/classifications`). Sinaliza entidades sensíveis ou
de governança.

Entrada:

```json
{
  "guid": "a1b2-..."
}
```

Saída:

```json
{
  "classifications": [
    { "typeName": "PII", "entityGuid": "a1b2-...", "propagate": true }
  ],
  "totalCount": 1
}
```

#### 12) `catalog.getEntityAudit`

Mapeia `getAuditEvents` (`GET /v2/entity/{guid}/audit`). Confirma se a entidade reflete o estado corrente da massa.

Entrada:

```json
{
  "guid": "a1b2-...",
  "count": 10,
  "offset": 0
}
```

Saída:

```json
{
  "events": [
    { "entityId": "a1b2-...", "action": "ENTITY_CREATE", "user": "hive", "timestamp": 1713456000000 }
  ]
}
```

#### 13) `catalog.getLineage`

Mapeia `getLineageGraph` (`GET /v2/lineage/{guid}`). Expõe dependências entre tabelas para junções plausíveis.

Entrada:

```json
{
  "guid": "a1b2-...",
  "depth": 3,
  "direction": "BOTH"
}
```

Saída:

```json
{
  "baseEntityGuid": "a1b2-...",
  "lineageDirection": "BOTH",
  "relations": [
    { "fromEntityId": "src-...", "toEntityId": "a1b2-...", "relationshipId": "rel-..." }
  ],
  "guidEntityMap": {
    "a1b2-...": { "typeName": "hive_table", "displayText": "franquias" }
  }
}
```

#### 14) `catalog.getEntityTypeDef`

Mapeia `getEntityDefByName` (`GET /v2/types/entitydef/name/{name}`). Recupera a definição de `hive_table` ou
`hive_column`.

Entrada:

```json
{
  "name": "hive_table"
}
```

Saída:

```json
{
  "category": "ENTITY",
  "name": "hive_table",
  "superTypes": ["DataSet"],
  "attributeDefs": [
    { "name": "name", "typeName": "string", "isOptional": false },
    { "name": "qualifiedName", "typeName": "string", "isOptional": false }
  ]
}
```

#### 15) `catalog.getRelationshipTypeDef`

Mapeia `getRelationshipDefByName` (`GET /v2/types/relationshipdef/name/{name}`). Cardinalidade e pontas dos
relacionamentos modelados.

Entrada:

```json
{
  "name": "hive_table_columns"
}
```

Saída:

```json
{
  "category": "RELATIONSHIP",
  "name": "hive_table_columns",
  "relationshipCategory": "COMPOSITION",
  "endDef1": { "type": "hive_table", "name": "columns", "cardinality": "SET" },
  "endDef2": { "type": "hive_column", "name": "table", "cardinality": "SINGLE" }
}
```

### Taxonomia de erro

| Código | Significado |
|--------|-------------|
| `invalid_input` | Erro de contrato de entrada (schema desconhecido, parâmetro ausente, tipo errado). |
| `catalog_unavailable` | Falha de comunicação com Apache Atlas. |
| `not_found` | Tabela ou schema inexistente no catálogo. |
| `timeout` | Excedeu o SLA de chamada. |
| `internal_error` | Falha inesperada no servidor MCP. |

Exemplo de resposta de erro:

```json
{
  "runId": "run-20260418-1530-a1b2",
  "toolVersion": "v1.0.0",
  "status": "error",
  "data": null,
  "error": {
    "code": "not_found",
    "message": "Tabela 'inexistente' nao existe no catalogo 'laboratorio'."
  }
}
```

### Compatibilidade e depreciação

- Campos novos devem ser opcionais por no mínimo uma versão `MINOR`.
- Mudanças destrutivas exigem novo `MAJOR` e janela de migração documentada.
- Depreciação deve indicar prazo, versão alvo e alternativa de uso.

### Mapeamento para validação estrutural

A taxonomia de erro do envelope MCP é distinta da classificação de desfecho do SQL (`structural_error`, `syntax_error`, `execution_error`, `success`) registrada pelo harness. Ver [Protocolo de avaliação](../../experimento/protocolo-avaliacao.md). Erros MCP indicam falha de descoberta; erros do SQL indicam falha do agente em produzir um SQL aderente ao catálogo.

!!! tip "Recomendado para leitura posterior"
    Seguinte: **[Protocolo de avaliação](../../experimento/protocolo-avaliacao.md)** — desenho experimental, bateria e critérios de desfecho.
