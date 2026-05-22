# Contratos MCP v1

## Propósito

Definir os contratos JSON estáveis das tools MCP da v1, com exemplos baseados no subconjunto XPTO (identificadores opacos `tbl_*` / `col_*`, massa congelada do TCC).

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

- `schema = "xpto"`: subconjunto XPTO registrado em Apache Atlas como database `hive_db` chamado `xpto`.
- Nomes de tabela e coluna no catálogo público são **somente** identificadores opacos (`tbl_*`, `col_*`), estáveis entre versões do dataset (ex.: `tbl_b35a889b`, `tbl_68086640`, `col_65a24b80`). O mapeamento para nomes físicos não é publicado neste site.

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
  "schema": "xpto",
  "limit": 50,
  "cursor": null
}

```

Saída:

```json
{
  "tables": [
    { "name": "tbl_b35a889b", "type": "TABLE" },
    { "name": "tbl_68086640", "type": "TABLE" },
    { "name": "tbl_3decb5f8", "type": "TABLE" },
    { "name": "tbl_619e750e", "type": "TABLE" },
    { "name": "tbl_ea4e241a", "type": "TABLE" },
    { "name": "tbl_dd1db895", "type": "TABLE" },
    { "name": "tbl_68a51161", "type": "TABLE" },
    { "name": "tbl_3246b982", "type": "TABLE" },
    { "name": "tbl_7f77967c", "type": "TABLE" },
    { "name": "tbl_74a9f8a6", "type": "TABLE" },
    { "name": "tbl_baf8a113", "type": "TABLE" },
    { "name": "tbl_f57abbbd", "type": "TABLE" },
    { "name": "tbl_1d129a77", "type": "TABLE" },
    { "name": "tbl_f8413ca9", "type": "TABLE" }
  ],
  "nextCursor": null
}

```

#### 2) `catalog.describeTable`

Entrada:

```json
{
  "schema": "xpto",
  "table": "tbl_b35a889b"
}

```

Saída (colunas observadas — ver [Monografia](../monografia.md)):

```json
{
  "table": "tbl_b35a889b",
  "columns": [
    { "name": "col_9b7089a7", "dataType": "INT", "nullable": false },
    { "name": "col_571df720", "dataType": "VARCHAR(255)", "nullable": false },
    { "name": "col_b492c65b", "dataType": "VARCHAR(255)", "nullable": true },
    { "name": "col_819b45fc", "dataType": "VARCHAR(255)", "nullable": true },
    { "name": "col_65a24b80", "dataType": "INT", "nullable": true },
    { "name": "col_d1dee7b9", "dataType": "INT", "nullable": true },
    { "name": "col_6bcf6472", "dataType": "DATETIME", "nullable": true },
    { "name": "col_69aefc30", "dataType": "DATETIME", "nullable": true }
  ]
}

```

#### 3) `catalog.listRelationships`

Entrada:

```json
{
  "schema": "xpto",
  "table": "tbl_b35a889b"
}

```

Saída (FKs confirmadas — ver [Monografia](../monografia.md)):

```json
{
  "relationships": [
    {
      "fromTable": "tbl_b35a889b",
      "fromColumn": "col_65a24b80",
      "toTable": "tbl_68086640",
      "toColumn": "col_9b7089a7",
      "relationshipType": "FK"
    },
    {
      "fromTable": "tbl_b35a889b",
      "fromColumn": "col_d1dee7b9",
      "toTable": "tbl_3decb5f8",
      "toColumn": "col_9b7089a7",
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
    "message": "Tabela 'tbl_db78aebf.tbl_a3e9e3e4' nao existe no catalogo 'xpto'."
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
