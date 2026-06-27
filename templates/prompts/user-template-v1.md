# User message template v1

> Substituir placeholders antes de enviar ao provedor LLM.

## Estrutura comum

```text
## Pergunta

{{QUESTION_TEXT}}

{{MODE_SPECIFIC_BLOCK}}

## Instrução de resposta

Responda em PT-BR. Inclua SQL(s) em blocos ```sql``` conforme as regras do system prompt.
```

## Bloco específico — modo MCP (`campaignId: mcp`)

Substituir `{{MODE_SPECIFIC_BLOCK}}` por:

```text
## Contexto de metadados

Os metadados estruturais serão obtidos via tools MCP durante esta sessão. Não assuma nomes de
objetos que ainda não foram confirmados por uma tool call nesta sessão.
```

Opcionalmente, após tool calls, o harness pode anexar um resumo:

```text
## Snapshot de metadados consultados

{{METADATA_SNAPSHOT_JSON_OR_TEXT}}
```

## Bloco específico — modo baseline (`campaignId: baseline-static`)

Substituir `{{MODE_SPECIFIC_BLOCK}}` por:

```text
## Esquema relacional (DDL anexo)

O DDL completo do subconjunto laboratorial (92 tabelas) segue abaixo. Use apenas objetos definidos neste
DDL.

```sql
{{SCHEMA_DDL_OFFLINE}}
```
```

> **Nota operacional:** `{{SCHEMA_DDL_OFFLINE}}` é o conteúdo literal de
> [Dump MySQL base_laboratorial](../../dados/base_laboratorial.sql) (MySQL 8+, schema
> `base_laboratorial`) no `commitHash` registrado em `context.json`.
