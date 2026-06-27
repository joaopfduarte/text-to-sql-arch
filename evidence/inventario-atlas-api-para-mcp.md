---
description: Triagem das operações de leitura da API REST v2 do Apache Atlas.
tags:
  - mcp
  - evidencia
---

# Inventário Atlas API para o catálogo MCP

## Fonte

- `assets/scripts/atlas-api-swagger.json` (Swagger oficial do Atlas v2; fonte primária; documentação acadêmica offline)
- `assets/scripts/Atlas REST API-documentation.html` (documentação humana complementar; documentação acadêmica offline)


## Critérios de triagem

1. Somente leitura: `GET` ou busca sem efeito colateral. Excluídas `create*`, `update*`, `delete*`, `import*`.
2. Aderência ao schema linking sobre entidades `hive_table` / `hive_column` / `hive_db` do schema `laboratorio`.
3. Payload mapeável para o envelope MCP com custo compatível com o orçamento de 10 chamadas por sessão.
4. Não duplicar as três basais (`catalog.listTables`, `catalog.describeTable`, `catalog.listRelationships`).
5. Tags fora de escopo: `GlossaryREST`, `NotificationREST`, `IndexRecoveryREST` e demais operações de escrita.


## Mapa por tag REST

Utilidade Text-to-SQL avaliada de 1 (baixa) a 5 (alta). `L` indica leitura e `E` escrita.

### DiscoveryREST

| operationId | Path | L/E | Utilidade | Risco | Decisão |
|-------------|------|-----|-----------|-------|---------|
| `searchUsingDSL` | `GET /v2/search/dsl` | L | 5 | Sintaxe DSL exige validação de entrada | Selecionada |
| `quickSearch` | `GET /v2/search/quick` | L | 4 | Payload com métricas de agregação | Selecionada |
| `searchUsingAttribute` | `GET /v2/search/attribute` | L | 4 | Prefixo de atributo amplo pode retornar muito | Selecionada |
| `searchUsingFullText` | `GET /v2/search/fulltext` | L | 3 | Recall textual sem tipagem | Selecionada |
| `searchUsingBasic` | `GET /v2/search/basic` | L | 3 | Sobrepõe parcialmente DSL e quick | Descartada (redundância) |
| `searchWithParameters` | `POST /v2/search/basic` | L | 3 | Igual a basic via corpo | Descartada (redundância) |
| `relationSearch` | `GET /v2/search/relations` | L | 2 | Sobrepõe `catalog.listRelationships` | Descartada (sobreposição) |
| `searchRelatedEntities` | `GET /v2/search/relationship` | L | 2 | Sobrepõe `catalog.listRelationships` | Descartada (sobreposição) |
| `getSuggestions` | `GET /v2/search/suggestions` | L | 2 | Autocomplete pouco útil em massa fixa | Descartada (baixo ganho) |
| `getSavedSearches` | `GET /v2/search/saved` | L | 1 | Recurso de UI, sem valor de schema linking | Descartada |

### EntityREST

| operationId | Path | L/E | Utilidade | Risco | Decisão |
|-------------|------|-----|-----------|-------|---------|
| `getById` | `GET /v2/entity/guid/{guid}` | L | 5 | Payload extenso com `referredEntities` | Selecionada |
| `getByUniqueAttributes` | `GET /v2/entity/uniqueAttribute/type/{typeName}` | L | 5 | Exige `attr:qualifiedName` correto | Selecionada |
| `getHeaderById` | `GET /v2/entity/guid/{guid}/header` | L | 4 | Cabeçalho enxuto, baixo risco | Selecionada |
| `getClassifications` | `GET /v2/entity/guid/{guid}/classifications` | L | 4 | Depende de governança populada | Selecionada |
| `getAuditEvents` | `GET /v2/entity/{guid}/audit` | L | 3 | Histórico pode ser volumoso | Selecionada |
| `getByGuids` | `GET /v2/entity/bulk` | L | 3 | Lote de GUIDs; ganho marginal sobre `getById` | Descartada (redundância) |
| `getEntityHeaders` | `GET /v2/entity/bulk/headers` | L | 2 | Lote de cabeçalhos; pouco usado por pergunta | Descartada |

### LineageREST

| operationId | Path | L/E | Utilidade | Risco | Decisão |
|-------------|------|-----|-----------|-------|---------|
| `getLineageGraph` | `GET /v2/lineage/{guid}` | L | 4 | Profundidade alta aumenta payload | Selecionada |
| `getLineageByUniqueAttribute` | `GET /v2/lineage/uniqueAttribute/type/{typeName}` | L | 3 | Mesmo dado por qualifiedName | Descartada (redundância) |

### TypesREST

| operationId | Path | L/E | Utilidade | Risco | Decisão |
|-------------|------|-----|-----------|-------|---------|
| `getEntityDefByName` | `GET /v2/types/entitydef/name/{name}` | L | 4 | Definição de `hive_table` / `hive_column` | Selecionada |
| `getRelationshipDefByName` | `GET /v2/types/relationshipdef/name/{name}` | L | 4 | Cardinalidade e pontas de relacionamento | Selecionada |
| `getAllTypeDefs` | `GET /v2/types/typedefs` | L | 2 | Catálogo de tipos inteiro, payload grande | Descartada |
| `getTypeDefByName` | `GET /v2/types/typedef/name/{name}` | L | 2 | Genérico; coberto por entitydef/relationshipdef | Descartada |


## Resultado

Doze operações selecionadas como tools complementares. Somadas às três basais, fecham o catálogo MCP em quinze
tools de descoberta somente leitura. A decisão final consta em
[Matriz de 15 tools MCP](matriz-15-tools-mcp.md).
