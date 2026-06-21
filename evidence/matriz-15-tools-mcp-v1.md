---
description: Seleção das quinze tools do catálogo MCP fechado.
tags:
  - mcp
  - evidencia
---

# Matriz das quinze tools MCP v1

## Fonte

- Inventário: [Inventário Atlas API](inventario-atlas-api-para-mcp.md)
- Swagger: `assets/scripts/atlas-api-swagger.json` (documentação acadêmica offline)


## Catálogo fechado (15 tools)

`schema = "laboratorio"`; `typeName` relevante: `hive_table`, `hive_column`, `hive_db`.

### Tools basais (protocolo mínimo de avaliação)

| Tool MCP | operationId Atlas (base) | Path | Benefício de schema linking |
|----------|--------------------------|------|------------------------------|
| `catalog.listTables` | `searchUsingDSL` sobre `hive_table` | `GET /v2/search/dsl` | Inventário de tabelas do schema governado. |
| `catalog.describeTable` | `getByUniqueAttributes` | `GET /v2/entity/uniqueAttribute/type/{typeName}` | Colunas e tipos de uma tabela canônica. |
| `catalog.listRelationships` | `getRelationshipDefByName` + manifesto de FKs | `GET /v2/types/relationshipdef/name/{name}` | Junções suportadas entre tabelas. |

As três basais permanecem inalteradas e cobrem o percurso mínimo de schema linking.

### Tools complementares (mesmo contrato v1, mesmo orçamento de 10 chamadas)

| Tool MCP | operationId Atlas | Path | Entrada principal | Benefício de schema linking |
|----------|-------------------|------|-------------------|------------------------------|
| `catalog.searchTables` | `searchUsingDSL` | `GET /v2/search/dsl` | `query`, `typeName`, `limit`, `offset` | Localiza tabelas por termo da pergunta antes de descrever. |
| `catalog.quickSearch` | `quickSearch` | `GET /v2/search/quick` | `query`, `typeName`, `limit`, `offset` | Ranqueia candidatos com métricas de agregação. |
| `catalog.searchByAttribute` | `searchUsingAttribute` | `GET /v2/search/attribute` | `attrName`, `attrValuePrefix`, `typeName` | Casa colunas ou tabelas por atributo exato. |
| `catalog.fullTextSearch` | `searchUsingFullText` | `GET /v2/search/fulltext` | `query`, `excludeDeletedEntities` | Recupera entidades por texto livre quando o termo é incerto. |
| `catalog.getEntityByGuid` | `getById` | `GET /v2/entity/guid/{guid}` | `guid`, `minExtInfo` | Resolve a entidade completa de uma tabela ou coluna. |
| `catalog.getEntityByName` | `getByUniqueAttributes` | `GET /v2/entity/uniqueAttribute/type/{typeName}` | `typeName`, `attr:qualifiedName` | Resolve entidade pelo nome canônico sem conhecer o GUID. |
| `catalog.getEntityHeader` | `getHeaderById` | `GET /v2/entity/guid/{guid}/header` | `guid` | Cabeçalho enxuto para confirmar existência e tipo. |
| `catalog.getClassifications` | `getClassifications` | `GET /v2/entity/guid/{guid}/classifications` | `guid` | Sinaliza colunas sensíveis ou de governança. |
| `catalog.getEntityAudit` | `getAuditEvents` | `GET /v2/entity/{guid}/audit` | `guid`, `count`, `offset` | Confirma se a entidade reflete o estado corrente da massa. |
| `catalog.getLineage` | `getLineageGraph` | `GET /v2/lineage/{guid}` | `guid`, `depth`, `direction` | Expõe dependências entre tabelas para junções plausíveis. |
| `catalog.getEntityTypeDef` | `getEntityDefByName` | `GET /v2/types/entitydef/name/{name}` | `name` | Recupera a definição de `hive_table` ou `hive_column`. |
| `catalog.getRelationshipTypeDef` | `getRelationshipDefByName` | `GET /v2/types/relationshipdef/name/{name}` | `name` | Cardinalidade e pontas dos relacionamentos modelados. |


## Justificativa da contagem

- Doze operações distintas e somente leitura, sem aliases das basais e sem operações de escrita.
- Buscas limitadas a quatro modos não redundantes (DSL, quick, atributo, texto livre).
- Leituras de entidade cobrem GUID, nome canônico, cabeçalho, classificações e auditoria.
- Linhagem e definições de tipo completam o contexto estrutural sem repetir as basais.


## Erros canônicos

Todas as tools usam o envelope e a taxonomia de
[Contratos MCP v1](../arquitetura/contratos-mcp/contracts-v1.md):
`invalid_input`, `not_found`, `catalog_unavailable`, `timeout`, `internal_error`.
