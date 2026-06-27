# Schema de laboratório — MySQL 8+

Artefacto SQL versionado para reprodução local do experimento Text-to-SQL.

## Arquivo canônico

| Arquivo | Conteúdo |
|----------|----------|
| [`base_laboratorial.sql`](base_laboratorial.sql) | DDL + dados; schema **`base_laboratorial`** |

Todo o SQL publicado neste pacote (schema e gabarito em
[`../evidence/gabarito-bateria.md`](../evidence/gabarito-bateria.md)) está no dialeto **MySQL 8 ou
superior** (`JSON_*`, `ONLY_FULL_GROUP_BY`, tipos `bit(1)`, crases).

## Requisitos

- MySQL **8.0+** (ou MariaDB compatível com as construções do dump)
- Cliente `mysql` na linha de comando

## Importação

```bash
mysql -u root -p < base_laboratorial.sql
```

O script cria a base `base_laboratorial` e carrega tabelas e dados de laboratório.

Alternativa explícita:

```bash
mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS base_laboratorial;"
mysql -u root -p base_laboratorial < base_laboratorial.sql
```

## Colunas legadas

Algumas colunas mantêm prefixos legados no DDL (ex.: hash interno em `transaction`) por serem
nomes de coluna internos, não identificadores de tabela. As colas de referência da bateria (Q01–Q40)
não referenciam tabelas com prefixos legados de schema anterior.

## Pacote experimental completo

Ordem de leitura e arquivos associados:
[`../experimento/pacote-experimental.md`](../experimento/pacote-experimental.md).
