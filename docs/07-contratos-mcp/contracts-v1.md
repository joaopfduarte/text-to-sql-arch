# Contratos MCP v1

## Propósito

Definir os contratos JSON estáveis das tools MCP da v1, com exemplos baseados em tabelas reais do banco PS (92 tabelas; massa fixa do TCC).

## Leitor

Pessoa desenvolvedora Java que implementa o servidor MCP ou um cliente, e pessoa que escreve cenários do harness.

## Pré-requisitos

- [`../03-arquitetura-aplicacao/camadas-mcp.md`](../03-arquitetura-aplicacao/camadas-mcp.md)
- [`../04-arquitetura-dados/schema-massa-teste.md`](../04-arquitetura-dados/schema-massa-teste.md)

## Conteúdo

### Política de versionamento

- Versionamento semântico: `vMAJOR.MINOR.PATCH`.
- `MAJOR`: quebra de contrato.
- `MINOR`: extensão compatível.
- `PATCH`: ajuste sem mudança de estrutura.

### Convenção de schema do catálogo

- `schema = "putz"`: subconjunto PS (92 tabelas) registrado em Apache Atlas como database `hive_db` chamado `putz`.
- Nomes de tabela e coluna seguem exatamente o export PS (ex.: `franquias`, `franquias__segmentos`, `segmento_id`).

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
sessão). Evidência da seleção em [`../evidence/matriz-15-tools-mcp-v1.md`](../evidence/matriz-15-tools-mcp-v1.md).

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
  "schema": "putz",
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
  "schema": "putz",
  "table": "franquias"
}
```

Saída (colunas observadas em [`putz_db.md` L1173–1215](../db-reference/putz_db.md)):

```json
{
  "table": "franquias",
  "columns": [
    { "name": "id", "dataType": "INT", "nullable": false },
    { "name": "nome", "dataType": "VARCHAR(255)", "nullable": false },
    { "name": "nome_fantasia", "dataType": "VARCHAR(255)", "nullable": true },
    { "name": "razao_social", "dataType": "VARCHAR(255)", "nullable": true },
    { "name": "segmento_id", "dataType": "INT", "nullable": true },
    { "name": "rede_id", "dataType": "INT", "nullable": true },
    { "name": "data_coleta", "dataType": "DATETIME", "nullable": true },
    { "name": "ultima_atualizacao", "dataType": "DATETIME", "nullable": true }
  ]
}
```

#### 3) `catalog.listRelationships`

Entrada:

```json
{
  "schema": "putz",
  "table": "franquias"
}
```

Saída (FKs confirmadas em [`putz_db.md` L1199–1206](../db-reference/putz_db.md)):

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
leitura sobre o Apache Atlas. Os exemplos usam entidades reais da massa PS (`putz.franquias`, `putz.project`).

#### 4) `catalog.searchTables`

Mapeia `searchUsingDSL` (`GET /v2/search/dsl`). Localiza tabelas por termo antes de descrevê-las.

Entrada:

```json
{
  "schema": "putz",
  "query": "franquia",
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
    { "guid": "a1b2-...", "name": "franquias", "typeName": "hive_table", "qualifiedName": "putz.franquias@cluster" },
    { "guid": "c3d4-...", "name": "franquias__segmentos", "typeName": "hive_table", "qualifiedName": "putz.franquias__segmentos@cluster" }
  ]
}
```

#### 5) `catalog.quickSearch`

Mapeia `quickSearch` (`GET /v2/search/quick`). Ranqueia candidatos com métricas de agregação.

Entrada:

```json
{
  "schema": "putz",
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
    { "guid": "e5f6-...", "name": "project", "typeName": "hive_table", "qualifiedName": "putz.project@cluster" },
    { "guid": "g7h8-...", "name": "project_item", "typeName": "hive_table", "qualifiedName": "putz.project_item@cluster" }
  ],
  "aggregationMetrics": { "typeName": [ { "name": "hive_table", "count": 3 } ] }
}
```

#### 6) `catalog.searchByAttribute`

Mapeia `searchUsingAttribute` (`GET /v2/search/attribute`). Casa entidades por atributo exato ou prefixo.

Entrada:

```json
{
  "schema": "putz",
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
    { "guid": "i9j0-...", "name": "transaction", "typeName": "hive_table", "qualifiedName": "putz.transaction@cluster" },
    { "guid": "k1l2-...", "name": "transaction_coupon", "typeName": "hive_table", "qualifiedName": "putz.transaction_coupon@cluster" }
  ]
}
```

#### 7) `catalog.fullTextSearch`

Mapeia `searchUsingFullText` (`GET /v2/search/fulltext`). Recupera entidades por texto livre quando o termo é incerto.

Entrada:

```json
{
  "schema": "putz",
  "query": "segmento",
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
    { "guid": "m3n4-...", "name": "franquias__segmentos", "typeName": "hive_table", "qualifiedName": "putz.franquias__segmentos@cluster" }
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
    "attributes": { "name": "franquias", "qualifiedName": "putz.franquias@cluster" },
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
  "qualifiedName": "putz.franquias@cluster",
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
    "attributes": { "name": "franquias", "qualifiedName": "putz.franquias@cluster" }
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
    "message": "Tabela 'sales.orders' nao existe no catalogo 'putz'."
  }
}
```

### Compatibilidade e depreciação

- Campos novos devem ser opcionais por no mínimo uma versão `MINOR`.
- Mudanças destrutivas exigem novo `MAJOR` e janela de migração documentada.
- Depreciação deve indicar prazo, versão alvo e alternativa de uso.

### Mapeamento para validação estrutural

A taxonomia de erro do envelope MCP é distinta da classificação de desfecho do SQL (`structural_error`, `syntax_error`, `execution_error`, `success`) registrada pelo harness. Ver [`../08-experimento-avaliacao/protocolo-avaliacao.md`](../08-experimento-avaliacao/protocolo-avaliacao.md). Erros MCP indicam falha de descoberta; erros do SQL indicam falha do agente em produzir um SQL aderente ao catálogo.

## Próximo passo

[`../08-experimento-avaliacao/protocolo-avaliacao.md`](../08-experimento-avaliacao/protocolo-avaliacao.md)
