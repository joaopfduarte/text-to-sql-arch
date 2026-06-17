# Catálogo Apache Atlas

## Propósito

Definir o que o Apache Atlas governa neste TCC, o que permanece apenas no dicionário físico do PS, e a ordem de operações entre ingestão, catálogo e corridas Text-to-SQL.

## Leitor

Pessoa que opera o catálogo, implementa o adaptador MCP ou define cenários de avaliação.

## Pré-requisitos

- [`banco-putz-dominio.md`](banco-putz-dominio.md)
- [`carga-cluster-putz.md`](carga-cluster-putz.md)
- [`../03-arquitetura-aplicacao/camadas-mcp.md`](../03-arquitetura-aplicacao/camadas-mcp.md)

## Conteúdo

### Camada semântica e catálogo canônico

Na monografia, a **camada semântica e de metadados** designa a componente que expõe ao agente inventário
estruturado de esquema via MCP. No recorte experimental deste TCC, essa camada materializa-se como
**catálogo canônico de metadados**. A escolha de **Apache Atlas** como produto concreto é de
engenharia para o ambiente laboratorial (integração ODP/Hive, linhagem); ver também
[`../../../content/cap4-metodologia.tex`](../../../content/cap4-metodologia.tex) (escolhas arquiteturais).

### Fronteira de governança

| Elemento | Onde reside | Quem governa |
|----------|-------------|--------------|
| Entidades técnicas (`hive_table`, `hive_column`, `hive_db`) | Apache Atlas no cluster | Atlas (fonte canônica para o pipeline) |
| Lineage entre tabelas Hive e arquivos HDFS | Apache Atlas | Atlas (hooks ou registro manual) |
| Classificações (PII, sensível) | Apache Atlas | Operador do catálogo |
| Dicionário físico exaustivo (todas as 92 tabelas do export) | [`../../db-reference/putz_db.md`](../../db-reference/putz_db.md) | Documento fonte (referência humana) |
| Schema exposto ao agente LLM (92 tabelas) | Apache Atlas | Definição em [`schema-massa-teste.md`](schema-massa-teste.md) |

Decisão: o agente LLM consulta apenas o catálogo canônico (Apache Atlas) via servidor MCP. O dicionário físico do PS é referência para construção da massa, não para o pipeline em corrida.

### Ordem operacional

1. Pré-processamento: extrair as 92 tabelas PS e mascarar PII (ver [`carga-cluster-putz.md`](carga-cluster-putz.md)).
2. Carga: subir para HDFS e registrar como tabelas Hive externas.
3. Catálogo: garantir que as entidades aparecem no Atlas (hook nativo ou registro manual via API).
4. Validação: tools MCP `catalog.listTables` / `describeTable` / `listRelationships` retornam o schema esperado (92
   tabelas).
5. Corrida: agente LLM consulta tools MCP, gera SQL e executa contra o cluster.

### Entidades Atlas envolvidas

| Entidade Atlas | Origem | Comentário |
|----------------|--------|------------|
| `hive_db` (`putz`) | Hive Metastore | Database lógico do schema fixo. |
| `hive_table` (`putz.<tabela>`) | Hive Metastore | Uma por tabela do schema (92 entidades). |
| `hive_column` | Hive Metastore | Colunas como objetos auditáveis. |
| Relacionamentos (FK lógica) | Registro manual via API Atlas (Hive não captura FKs) | Adiado: convenção final (atributo customizado vs tag) será fechada na etapa de implementação. |

Restrição: o Hive não preserva FKs do MySQL/MariaDB original; o adaptador Atlas precisa traduzir relacionamentos a partir de uma fonte adicional (ex.: arquivo de manifesto com as FKs documentadas em [`banco-putz-dominio.md`](banco-putz-dominio.md)).

### Contratos canônicos expostos

O adaptador Atlas traduz respostas em um contrato canônico (ver [`../07-contratos-mcp/contracts-v1.md`](../07-contratos-mcp/contracts-v1.md)). Mudanças na API do Atlas são absorvidas pelo adaptador, preservando a estabilidade do contrato MCP.

O catálogo MCP v1 é **fechado em quinze tools** de descoberta somente leitura sobre a API REST v2 do Atlas: três
basais (`catalog.listTables`, `catalog.describeTable`, `catalog.listRelationships`) e doze complementares. A validação
do passo 4 usa as três basais; as complementares apoiam o schema linking sob o mesmo orçamento de chamadas. Seleção e
mapeamento em [`../../evidence/matriz-15-tools-mcp-v1.md`](../../evidence/matriz-15-tools-mcp-v1.md).

### Disponibilidade do Atlas

- Atlas roda no cluster (ver [`../05-infraestrutura/cluster-hadoop.md`](../05-infraestrutura/cluster-hadoop.md)).
- Decisão vigente no ADR-0002: Atlas no cluster ODP em AWS x86_64 (não standalone como solução principal).

## Próximo passo

[`../05-infraestrutura/visao-aws.md`](../05-infraestrutura/visao-aws.md)
