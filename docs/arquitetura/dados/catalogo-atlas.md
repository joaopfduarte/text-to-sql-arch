---
description: Camada semântica e catálogo canônico Apache Atlas no cluster.
tags:
  - dados
  - mcp
---

# Catálogo Apache Atlas

!!! info "Recomendado para leitura prévia"
    - **[Banco laboratorial](banco-laboratorio-dominio.md)** — domínios genéricos, entidades-âncora e FKs.
    - **[Carga no cluster](carga-cluster-laboratorio.md)** — pipeline de ingestão da massa `base_laboratorial`.
    - **[Camadas MCP](../aplicacao/camadas-mcp.md)** — mapeamento tool → porta → contrato → erro.


### Camada semântica e catálogo canônico

A **camada semântica e de metadados** expõe ao agente inventário estruturado de esquema via MCP. No recorte experimental, materializa-se como **catálogo canônico** implementado com Apache Atlas no cluster laboratorial.

### Fronteira de governança

| Elemento | Onde reside | Quem governa |
|----------|-------------|--------------|
| Entidades técnicas (`hive_table`, `hive_column`, `hive_db`) | Apache Atlas no cluster | Atlas (fonte canônica) |
| Lineage entre tabelas Hive e arquivos HDFS | Apache Atlas | Atlas |
| Classificações (PII, sensível) | Apache Atlas | Operador do catálogo |
| Export relacional completo (92 entidades) | Offline (pesquisador) | Pesquisador |
| Schema exposto ao agente LLM | Apache Atlas | [Schema massa de teste](schema-massa-teste.md) |

Decisão: o agente consulta apenas o catálogo canônico via MCP. O export offline serve à carga, não à corrida.

### Ordem operacional

1. Pré-processamento: extrair 92 entidades e mascarar PII ([Carga no cluster](carga-cluster-laboratorio.md)).
2. Carga: HDFS + tabelas Hive externas espelhando **`base_laboratorial`**.
3. Catálogo: entidades visíveis no Atlas.
4. Validação: tools basais MCP retornam o schema esperado.
5. Corrida: agente gera SQL e executa no cluster.

### Entidades Atlas envolvidas

| Entidade Atlas | Origem | Comentário |
|----------------|--------|------------|
| `hive_db` (`base_laboratorial`) | Hive Metastore | Database lógico fixo. |
| `hive_table` (`base_laboratorial.*`) | Hive Metastore | Uma por entidade (92). |
| `hive_column` | Hive Metastore | Colunas auditáveis (`col_*`). |
| Relacionamentos (FK lógica) | Manifesto + API Atlas | Hive não preserva FKs originais. |

Restrição: o adaptador Atlas traduz relacionamentos a partir do manifesto documentado em [Banco laboratorial](banco-laboratorio-dominio.md).

### Contratos expostos

Ver [Contratos MCP v1](../contratos-mcp/contracts-v1.md). Catálogo fechado de quinze tools: [Matriz de 15 tools MCP](../../evidence/matriz-15-tools-mcp.md).

### Disponibilidade

- Atlas no cluster ([Cluster Hadoop](../../infraestrutura/cluster-hadoop.md)).
- ADR-0002: co-localizado no master ODP AWS x86_64.

!!! tip "Recomendado para leitura posterior"
    Seguinte: **[Visão AWS](../../infraestrutura/visao-aws.md)** — topologia de rede e componentes na nuvem.
