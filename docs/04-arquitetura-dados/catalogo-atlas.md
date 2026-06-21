# Catálogo Apache Atlas

## Propósito

Definir o que o Apache Atlas governa neste TCC, a fronteira com o export offline e a ordem de operações entre ingestão, catálogo e corridas Text-to-SQL.

## Leitor

Pessoa que opera o catálogo, implementa o adaptador MCP ou define cenários de avaliação.

## Pré-requisitos

- [`banco-laboratorio-dominio.md`](banco-laboratorio-dominio.md)
- [`carga-cluster-laboratorio.md`](carga-cluster-laboratorio.md)
- [`../03-arquitetura-aplicacao/camadas-mcp.md`](../03-arquitetura-aplicacao/camadas-mcp.md)

## Conteúdo

### Camada semântica e catálogo canônico

A **camada semântica e de metadados** expõe ao agente inventário estruturado de esquema via MCP. No recorte experimental, materializa-se como **catálogo canônico** implementado com Apache Atlas no cluster laboratorial.

### Fronteira de governança

| Elemento | Onde reside | Quem governa |
|----------|-------------|--------------|
| Entidades técnicas (`hive_table`, `hive_column`, `hive_db`) | Apache Atlas no cluster | Atlas (fonte canônica) |
| Lineage entre tabelas Hive e arquivos HDFS | Apache Atlas | Atlas |
| Classificações (PII, sensível) | Apache Atlas | Operador do catálogo |
| Export relacional completo (92 entidades) | Offline (fora do git) | Pesquisador |
| Schema exposto ao agente LLM | Apache Atlas | [`schema-massa-teste.md`](schema-massa-teste.md) |

Decisão: o agente consulta apenas o catálogo canônico via MCP. O export offline serve à carga, não à corrida.

### Ordem operacional

1. Pré-processamento: extrair 92 entidades e mascarar PII ([`carga-cluster-laboratorio.md`](carga-cluster-laboratorio.md)).
2. Carga: HDFS + tabelas Hive externas em `massa_teste_laboratorio`.
3. Catálogo: entidades visíveis no Atlas.
4. Validação: tools basais MCP retornam o schema esperado.
5. Corrida: agente gera SQL e executa no cluster.

### Entidades Atlas envolvidas

| Entidade Atlas | Origem | Comentário |
|----------------|--------|------------|
| `hive_db` (`schema_laboratorio`) | Hive Metastore | Database lógico fixo. |
| `hive_table` (`schema_laboratorio.tbl_*`) | Hive Metastore | Uma por entidade (92). |
| `hive_column` | Hive Metastore | Colunas auditáveis (`col_*`). |
| Relacionamentos (FK lógica) | Manifesto + API Atlas | Hive não preserva FKs originais. |

Restrição: o adaptador Atlas traduz relacionamentos a partir do manifesto documentado em [`banco-laboratorio-dominio.md`](banco-laboratorio-dominio.md).

### Contratos expostos

Ver [`../07-contratos-mcp/contracts-v1.md`](../07-contratos-mcp/contracts-v1.md). Catálogo fechado de quinze tools: [`../evidence/matriz-15-tools-mcp-v1.md`](../evidence/matriz-15-tools-mcp-v1.md).

### Disponibilidade

- Atlas no cluster ([`../05-infraestrutura/cluster-hadoop.md`](../05-infraestrutura/cluster-hadoop.md)).
- ADR-0002: co-localizado no master ODP AWS x86_64.

## Próximo passo

[`../05-infraestrutura/visao-aws.md`](../05-infraestrutura/visao-aws.md)
