---
description: Mapeamento tool MCP → porta → contrato → erro.
tags:
  - mcp
  - arquitetura
---

# Camadas do servidor MCP

!!! info "Recomendado para leitura prévia"
    - **[Visão lógica](visao-logica.md)** — camadas, fluxo operacional e zonas de rede.
    - **[Modelo de domínio](modelo-dominio.md)** — bounded contexts e agregados.
    - **[Contratos MCP v1](../contratos-mcp/contracts-v1.md)** — envelope JSON, tools e taxonomia de erro.


### Modelo de camadas para uma chamada MCP

![Camadas MCP](../../diagrams/camadas-mcp.svg){ .uml-diagram width="100%" }

Fonte: [Diagrama de camadas MCP](../../diagrams/camadas-mcp.svg)

### Catálogo fechado v1

O catálogo é **fechado em quinze tools** somente leitura: três basais (protocolo mínimo de avaliação) e doze
complementares. As basais já têm porta e adapter definidos. Para as doze complementares, porta e adapter são
**planejados** (desenho lógico, sem código Java nesta etapa), com referência cruzada ao endpoint Atlas. A seleção
está em [Matriz de 15 tools MCP](../../evidence/matriz-15-tools-mcp-v1.md).

### Tabela `tool -> porta Java -> contrato JSON -> erro canônico`

Erros canônicos abreviados: `inv` = `invalid_input`, `nf` = `not_found`, `cu` = `catalog_unavailable`,
`to` = `timeout`, `ie` = `internal_error`. Contrato JSON de cada tool em
[Contratos MCP v1](../contratos-mcp/contracts-v1.md).

#### Tools basais

| Tool MCP | Caso de uso | Porta de saída | Adapter concreto | Endpoint Atlas | Erros |
|----------|-------------|----------------|------------------|----------------|-------|
| `catalog.listTables` | `ListTablesUseCase` | `MetadataLookupPort.listTables(schema, limit, cursor)` | `AtlasMetadataAdapter` | `GET /v2/search/dsl` | `inv`, `cu`, `to`, `ie` |
| `catalog.describeTable` | `DescribeTableUseCase` | `MetadataLookupPort.describeTable(schema, table)` | `AtlasMetadataAdapter` | `GET /v2/entity/uniqueAttribute/type/{typeName}` | `inv`, `nf`, `cu`, `to`, `ie` |
| `catalog.listRelationships` | `ListRelationshipsUseCase` | `MetadataLookupPort.listRelationships(schema, table)` | `AtlasMetadataAdapter` (consulta manifesto de FKs quando o Atlas não tem relação modelada) | `GET /v2/types/relationshipdef/name/{name}` | `inv`, `nf`, `cu`, `to`, `ie` |

#### Tools complementares (porta e adapter planejados)

| Tool MCP | Caso de uso (planejado) | Porta de saída (planejada) | Adapter (planejado) | Endpoint Atlas | Erros |
|----------|-------------------------|----------------------------|---------------------|----------------|-------|
| `catalog.searchTables` | `SearchTablesUseCase` | `AtlasDiscoveryPort.searchByDsl(...)` | `AtlasDiscoveryAdapter` | `GET /v2/search/dsl` | `inv`, `cu`, `to`, `ie` |
| `catalog.quickSearch` | `QuickSearchUseCase` | `AtlasDiscoveryPort.quickSearch(...)` | `AtlasDiscoveryAdapter` | `GET /v2/search/quick` | `inv`, `cu`, `to`, `ie` |
| `catalog.searchByAttribute` | `SearchByAttributeUseCase` | `AtlasDiscoveryPort.searchByAttribute(...)` | `AtlasDiscoveryAdapter` | `GET /v2/search/attribute` | `inv`, `cu`, `to`, `ie` |
| `catalog.fullTextSearch` | `FullTextSearchUseCase` | `AtlasDiscoveryPort.searchByFullText(...)` | `AtlasDiscoveryAdapter` | `GET /v2/search/fulltext` | `inv`, `cu`, `to`, `ie` |
| `catalog.getEntityByGuid` | `GetEntityByGuidUseCase` | `MetadataLookupPort.getEntityByGuid(guid)` | `AtlasMetadataAdapter` | `GET /v2/entity/guid/{guid}` | `inv`, `nf`, `cu`, `to`, `ie` |
| `catalog.getEntityByName` | `GetEntityByNameUseCase` | `MetadataLookupPort.getEntityByName(typeName, qualifiedName)` | `AtlasMetadataAdapter` | `GET /v2/entity/uniqueAttribute/type/{typeName}` | `inv`, `nf`, `cu`, `to`, `ie` |
| `catalog.getEntityHeader` | `GetEntityHeaderUseCase` | `MetadataLookupPort.getEntityHeader(guid)` | `AtlasMetadataAdapter` | `GET /v2/entity/guid/{guid}/header` | `inv`, `nf`, `cu`, `to`, `ie` |
| `catalog.getClassifications` | `GetClassificationsUseCase` | `MetadataLookupPort.getClassifications(guid)` | `AtlasMetadataAdapter` | `GET /v2/entity/guid/{guid}/classifications` | `inv`, `nf`, `cu`, `to`, `ie` |
| `catalog.getEntityAudit` | `GetEntityAuditUseCase` | `MetadataLookupPort.getEntityAudit(guid, count, offset)` | `AtlasMetadataAdapter` | `GET /v2/entity/{guid}/audit` | `inv`, `nf`, `cu`, `to`, `ie` |
| `catalog.getLineage` | `GetLineageUseCase` | `AtlasLineagePort.getLineage(guid, depth, direction)` | `AtlasLineageAdapter` | `GET /v2/lineage/{guid}` | `inv`, `nf`, `cu`, `to`, `ie` |
| `catalog.getEntityTypeDef` | `GetEntityTypeDefUseCase` | `AtlasTypeDefPort.getEntityDef(name)` | `AtlasTypeDefAdapter` | `GET /v2/types/entitydef/name/{name}` | `inv`, `nf`, `cu`, `to`, `ie` |
| `catalog.getRelationshipTypeDef` | `GetRelationshipTypeDefUseCase` | `AtlasTypeDefPort.getRelationshipDef(name)` | `AtlasTypeDefAdapter` | `GET /v2/types/relationshipdef/name/{name}` | `inv`, `nf`, `cu`, `to`, `ie` |

### Envelope padrão

Todas as tools retornam o envelope `{runId, toolVersion, status, data, error}` definido em [Contratos MCP v1](../contratos-mcp/contracts-v1.md). Em caso de erro, `status = "error"`, `data = null`, `error` preenchido com código canônico e mensagem.

### Política de tool budget

- Cada `QuerySession` carrega um `ToolBudget` (valor numérico configurado por corrida).
- Orçamento padrão de referência: **10 chamadas por sessão** (uma sessão por pergunta), alinhado ao capítulo metodológico.
- Cada chamada de tool decrementa o orçamento.
- Atingir o orçamento encerra a sessão com `RunRecord` marcado como `budget_exceeded` (registrado no harness, não no envelope MCP).

### Convenções de implementação

- Pacote: `com.tcc.text2sql.adapters.in.mcp` (servidor) e `com.tcc.text2sql.adapters.out.atlas` (adapter). Ver [Módulos Spring](../../implementacao/modulos-spring.md).
- Validação de entrada com Bean Validation (`jakarta.validation`).
- Timeout por chamada: configurável; default sugerido 5 s para Atlas.
- Retry com backoff exponencial limitado a 2 tentativas para `catalog_unavailable` ou `timeout`.

### Versionamento

- `toolVersion` segue o `vMAJOR.MINOR.PATCH` descrito em [Contratos MCP v1](../contratos-mcp/contracts-v1.md).
- Quebra de contrato implica nova versão `MAJOR` e ADR específico.

!!! tip "Recomendado para leitura posterior"
    Seguinte: **[Catálogo Atlas](../dados/catalogo-atlas.md)** — camada semântica e metadados no cluster.
