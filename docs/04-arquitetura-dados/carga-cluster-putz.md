# Carga do PS no cluster

## Propósito

Definir como o schema PS (92 tabelas) entra no cluster (formato, destino, validação) e a fronteira entre a
ingestão e o catálogo Atlas.

## Leitor

Pessoa que opera a ingestão de dados ou prepara o ambiente para corridas.

## Pré-requisitos

- [`banco-putz-dominio.md`](banco-putz-dominio.md)
- [`schema-massa-teste.md`](schema-massa-teste.md)
- [`../05-infraestrutura/cluster-hadoop.md`](../05-infraestrutura/cluster-hadoop.md)

## Conteúdo

### Origem

- Dump do banco relacional PS (DDL em [`../db-reference/putz_db.sql`](../db-reference/putz_db.sql), export
  legível em [`../db-reference/putz_db.md`](../db-reference/putz_db.md), gerado em Apr 28, 2026).
- Schema completo: **92 tabelas** listadas em [`schema-massa-teste.md`](schema-massa-teste.md).

### Pré-requisitos de formato

| Item | Decisão | Observação |
|------|---------|------------|
| Formato de entrega da extração | Parquet por tabela (preferencial) | CSV só para contingência de ingestão inicial. |
| Codificação | UTF-8 | PS tem acentuação em português. |
| Separador (se CSV) | `,` com aspas duplas para campos com vírgula | Padronizar para evitar erros de parse. |
| Tratamento de PII | Mascaramento ou exclusão de colunas pessoais antes do upload | Aplica-se a domínios sensíveis (ex.: conta e segurança); tabelas permanecem no schema. |

### Destino no cluster

| Camada | Localização proposta | Tooling | Estado |
|--------|----------------------|---------|--------|
| Bruto | `hdfs:///dados/putz/bronze/<tabela>/` | `spark.write.parquet` | Definido |
| Consultável | Tabelas Hive `putz_teste.<tabela>` em `hive_metastore` | `CREATE EXTERNAL TABLE` apontando para o bruto | Definido |
| Catálogo | Entidades `hive_table` registradas em Apache Atlas | Hook nativo do Hive ou registro manual via API Atlas | Ver [`catalogo-atlas.md`](catalogo-atlas.md) |

Camadas bronze/silver/gold não são adotadas porque o MVP não exige transformações intermediárias; o PS entra como camada única consultável.

### Sequência operacional

1. Exportar do dump original as **92 tabelas** listadas em [`schema-massa-teste.md`](schema-massa-teste.md).
2. Aplicar mascaramento/exclusão de PII.
3. Subir os arquivos para HDFS (`/dados/putz/bronze/`).
4. Criar tabelas externas no Hive Metastore com schema alinhado ao dump.
5. Disparar o registro no Apache Atlas (hook automático ou script).
6. Executar smoke queries (próxima secção).
7. Fixar `datasetVersion` e registrar no `evidence/<runId>/context.json` da primeira corrida.

### Volume da massa `putz_teste` (fixa)

O volume observado do schema `putz_teste` é ~1388,27 MB. A carga publica esse schema fixo no HDFS/Hive, sem
amplificação sintética.

Fluxo recomendado:

1. **Ingestão:** carga das 92 tabelas PS em Parquet a partir do dump original.
2. **Publicação consultável:** registro das tabelas em `putz_teste` no Hive Metastore.
3. **Registro:** fixação de `datasetVersion` para a massa estável da campanha.

Controles:

- **integridade referencial:** validar FKs após a carga única;
- **tempo de carga:** execução em lote único inalterado;
- **armazenamento:** considerar replicação HDFS 3 e manter margem de disco.

### Validação pós-carga

| Verificação | Critério mínimo | Como medir |
|-------------|-----------------|------------|
| Contagem de registros | `COUNT(*)` por tabela bate com o dump original (±0). | `hive -e "SELECT COUNT(*) FROM putz.<tabela>"` |
| Smoke query simples | `SELECT * FROM putz.franquias LIMIT 5` retorna 5 linhas. | Cliente Hive ou Spark SQL. |
| Smoke query com junção | `SELECT f.nome, s.nome FROM putz.franquias f JOIN putz.franquias__segmentos s ON f.segmento_id = s.id LIMIT 5` retorna linhas. | Cliente Hive ou Spark SQL. |
| Registro no Atlas | Entidade `hive_table` aparece para as 92 tabelas do schema. | API Atlas: `GET /api/atlas/v2/search/dsl?query=hive_table`. |

### Diagrama

Ver [`../diagrams/ingestao-putz.puml`](../diagrams/ingestao-putz.puml).

### Estado dos pontos pendentes

- Ferramenta de ingestão: **Spark preferencial**, com CSV de contingência.
- Estratégia de catálogo no Atlas: manter hook do Hive quando disponível; fallback por API manual.
- Frequência: carga única fixa para o MVP, com nova versão apenas quando o schema PS mudar.

## Próximo passo

[`catalogo-atlas.md`](catalogo-atlas.md)
