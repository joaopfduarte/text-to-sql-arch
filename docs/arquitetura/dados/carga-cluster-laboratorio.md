---
description: Pipeline de ingestão da massa base_laboratorial no cluster.
tags:
  - dados
  - infra
---

# Carga no cluster (massa laboratorial)

!!! info "Recomendado para leitura prévia"
    - **[Banco laboratorial](banco-laboratorio-dominio.md)** — domínios de negócio e entidades-âncora.
    - **[Schema massa de teste](schema-massa-teste.md)** — inventário MySQL das 92 entidades.
    - **[Catálogo Atlas](catalogo-atlas.md)** — camada semântica e metadados no cluster.


### Pipeline

1. Dump MySQL versionado: [Dump MySQL base_laboratorial](../../dados/base_laboratorial.sql).
2. Mascaramento de PII conforme [Banco laboratorial](banco-laboratorio-dominio.md).
3. Carga HDFS (`/dados/laboratorio/bronze/`).
4. Tabelas externas Hive espelhando o schema **`base_laboratorial`**.
5. Registro no Apache Atlas.

### Volume

Massa fixa ~1388 MB (mesma base relacional do dump MySQL publicado).

### Smoke queries (Hive, nomes reais)

| Teste | SQL esperado |
|-------|--------------|
| Simples | `SELECT * FROM franquias LIMIT 5` |
| Junção | `SELECT a.segmento_id, b.id FROM franquias a JOIN franquias__segmentos b ON a.segmento_id = b.id LIMIT 5` |

Para reprodução local do experimento Text-to-SQL, use o dump **MySQL** em `dados/`, não um
script Hive versionado neste repositório.

!!! tip "Recomendado para leitura posterior"
    Seguinte: **[Catálogo Atlas](catalogo-atlas.md)** — camada semântica e metadados no cluster.
