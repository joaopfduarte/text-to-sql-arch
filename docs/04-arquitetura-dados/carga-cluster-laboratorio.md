---
description: Pipeline de ingestão da massa massa_teste_laboratorio no cluster.
tags:
  - dados
  - infra
---

# Carga no cluster (massa laboratorial)

!!! info "Recomendado para leitura prévia"
    - **[Banco laboratorial](banco-laboratorio-dominio.md)** — domínios genéricos, entidades-âncora e FKs.
    - **[Schema massa de teste](schema-massa-teste.md)** — inventário das 92 entidades.
    - **[Catálogo Atlas](catalogo-atlas.md)** — camada semântica e metadados no cluster.


### Pipeline

1. Export relacional offline (92 entidades).
2. Mascaramento de PII conforme [Banco laboratorial](banco-laboratorio-dominio.md).
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

!!! tip "Recomendado para leitura posterior"
    Seguinte: **[Catálogo Atlas](catalogo-atlas.md)** — camada semântica e metadados no cluster.
