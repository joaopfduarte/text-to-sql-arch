# Catálogo Apache Atlas

## Propósito

Definir o que o Apache Atlas governa neste TCC, o que permanece apenas no dicionário físico do XPTO, e a ordem de operações entre ingestão, catálogo e corridas Text-to-SQL.

## Leitor

Pessoa que opera o catálogo, implementa o adaptador MCP ou define cenários de avaliação.

## Pré-requisitos

- [`banco-xpto-dominio.md`](banco-xpto-dominio.md)
- [`carga-cluster-xpto.md`](carga-cluster-xpto.md)
- [`../03-arquitetura-aplicacao/camadas-mcp.md`](../03-arquitetura-aplicacao/camadas-mcp.md)

## Conteúdo

### Fronteira de governança

| Elemento | Onde reside | Quem governa |
|----------|-------------|--------------|
| Entidades técnicas (`hive_table`, `hive_column`, `hive_db`) | Apache Atlas no cluster | Atlas (fonte canônica para o pipeline) |
| Lineage entre tabelas Hive e arquivos HDFS | Apache Atlas | Atlas (hooks ou registro manual) |
| Classificações (PII, sensível) | Apache Atlas | Operador do catálogo |
| Dicionário físico exaustivo (todas as 92 tabelas do export) | [Monografia](../monografia.md) | Documento fonte (referência humana) |
| Subconjunto exposto ao agente LLM | Apache Atlas | Definição em [`schema-massa-teste.md`](schema-massa-teste.md) |

Decisão: o agente LLM consulta apenas o catálogo Atlas via servidor MCP. O dicionário físico do XPTO é referência para construção da massa, não para o pipeline em corrida.

### Ordem operacional

1. Pré-processamento: extrair subconjunto XPTO e mascarar PII (ver [`carga-cluster-xpto.md`](carga-cluster-xpto.md)).
2. Carga: subir para HDFS e registrar como tabelas Hive externas.
3. Catálogo: garantir que as entidades aparecem no Atlas (hook nativo ou registro manual via API).
4. Validação: tools MCP `catalog.listTables` / `describeTable` / `listRelationships` retornam o subconjunto esperado.
5. Corrida: agente LLM consulta tools MCP, gera SQL e executa contra o cluster.

### Entidades Atlas envolvidas

| Entidade Atlas | Origem | Comentário |
|----------------|--------|------------|
| `hive_db` (`xpto`) | Hive Metastore | Database lógico do subconjunto. |
| `hive_table` (`xpto.<tbl_opaco>`) | Hive Metastore | Uma por tabela do subconjunto. |
| `hive_column` | Hive Metastore | Colunas como objetos auditáveis. |
| Relacionamentos (FK lógica) | Registro manual via API Atlas (Hive não captura FKs) | Adiado: convenção final (atributo customizado vs tag) será fechada na etapa de implementação. |

Restrição: o Hive não preserva FKs do MySQL/MariaDB original; o adaptador Atlas precisa traduzir relacionamentos a partir de uma fonte adicional (ex.: arquivo de manifesto com as FKs documentadas em [`banco-xpto-dominio.md`](banco-xpto-dominio.md)).

### Contratos canônicos expostos

O adaptador Atlas traduz respostas em um contrato canônico (ver [`../07-contratos-mcp/contracts-v1.md`](../07-contratos-mcp/contracts-v1.md)). Mudanças na API do Atlas são absorvidas pelo adaptador, preservando a estabilidade do contrato MCP.

### Disponibilidade do Atlas

- Atlas roda no cluster (ver [`../05-infraestrutura/cluster-hadoop.md`](../05-infraestrutura/cluster-hadoop.md)).
- Decisão vigente no ADR-0002: Atlas no cluster ODP em AWS x86_64 (não standalone como solução principal).

## Próximo passo

[`../05-infraestrutura/visao-aws.md`](../05-infraestrutura/visao-aws.md)
