# Carga no cluster (massa laboratorial)

## Propósito

Descrever a ingestão da massa relacional anonimizada no cluster Hadoop/Hive e o registro no Apache Atlas.

## Leitor

Pessoa responsável pela carga de dados e validação pós-ingestão.

## Pré-requisitos

- [`banco-laboratorio-dominio.md`](banco-laboratorio-dominio.md)
- [`schema-massa-teste.md`](schema-massa-teste.md)
- [`catalogo-atlas.md`](catalogo-atlas.md)

## Conteúdo

### Pipeline

1. Export relacional offline (92 entidades, anonimizado).
2. Mascaramento de PII conforme glossário.
3. Carga HDFS (`/dados/laboratorio/bronze/`).
4. Tabelas externas Hive em `massa_teste_laboratorio`.
5. Registro no Apache Atlas (`schema_laboratorio`).

### Volume

Massa fixa ~1388 MB em `massa_teste_laboratorio` (sem amplificação sintética no MVP).

### Smoke queries

| Teste | SQL esperado |
|-------|--------------|
| Simples | `SELECT * FROM tbl_162cf7be LIMIT 5` |
| Junção | `SELECT a.col_2cd9416d, b.col_d7247819 FROM tbl_162cf7be a JOIN tbl_8991e9dc b ON a.col_2cd9416d = b.col_d7247819 LIMIT 5` |

## Próximo passo

[`catalogo-atlas.md`](catalogo-atlas.md)
