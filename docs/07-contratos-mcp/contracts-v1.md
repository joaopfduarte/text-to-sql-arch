# Contratos MCP v1

## Propósito

Definir os contratos JSON estáveis das tools MCP da v1, com exemplos baseados em tabelas reais do banco Putz (massa congelada do TCC).

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

- `schema = "putz"`: subconjunto Putz registrado em Apache Atlas como database `hive_db` chamado `putz`.
- Nomes de tabela e coluna seguem exatamente o export Putz (ex.: `franquias`, `franquias__segmentos`, `segmento_id`).

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

### Tools mínimas obrigatórias

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

Saída (colunas observadas em [`putz_db.md` L1173–1215](../../db-reference/putz_db.md)):

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

Saída (FKs confirmadas em [`putz_db.md` L1199–1206](../../db-reference/putz_db.md)):

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
