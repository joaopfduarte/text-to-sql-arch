# Carga do Putz no cluster

## Propósito

Definir como o subconjunto Putz entra no cluster (formato, destino, validação) e a fronteira entre a ingestão e o catálogo Atlas.

## Leitor

Pessoa que opera a ingestão de dados ou prepara o ambiente para corridas.

## Pré-requisitos

- [`banco-putz-dominio.md`](banco-putz-dominio.md)
- [`schema-massa-teste.md`](schema-massa-teste.md)
- [`../05-infraestrutura/cluster-hadoop.md`](../05-infraestrutura/cluster-hadoop.md)

## Conteúdo

### Origem

- Dump do banco relacional Putz (export descrito em [`../../db-reference/putz_db.md`](../../db-reference/putz_db.md), gerado em Apr 28, 2026).
- Subconjunto restrito a tabelas listadas em [`schema-massa-teste.md`](schema-massa-teste.md).

### Pré-requisitos de formato

| Item | Decisão | Observação |
|------|---------|------------|
| Formato de entrega da extração | Parquet por tabela (preferencial) | CSV só para contingência de ingestão inicial. |
| Codificação | UTF-8 | Putz tem acentuação em português. |
| Separador (se CSV) | `,` com aspas duplas para campos com vírgula | Padronizar para evitar erros de parse. |
| Tratamento de PII | Mascaramento ou exclusão das colunas pessoais antes do upload | Domínio "Conta e segurança" do Putz é excluído do MVP. |

### Destino no cluster

| Camada | Localização proposta | Tooling | Estado |
|--------|----------------------|---------|--------|
| Bruto | `hdfs:///dados/putz/bronze/<tabela>/` | `spark.write.parquet` | Definido |
| Consultável | Tabelas Hive `putz_teste.<tabela>` em `hive_metastore` | `CREATE EXTERNAL TABLE` apontando para o bruto | Definido |
| Catálogo | Entidades `hive_table` registradas em Apache Atlas | Hook nativo do Hive ou registro manual via API Atlas | Ver [`catalogo-atlas.md`](catalogo-atlas.md) |

Camadas bronze/silver/gold não são adotadas porque o MVP não exige transformações intermediárias; o Putz entra como camada única consultável.

### Sequência operacional

1. Exportar do dump original apenas as tabelas listadas em [`schema-massa-teste.md`](schema-massa-teste.md).
2. Aplicar mascaramento/exclusão de PII.
3. Subir os arquivos para HDFS (`/dados/putz/bronze/`).
4. Criar tabelas externas no Hive Metastore com schema alinhado ao dump.
5. Disparar o registro no Apache Atlas (hook automático ou script).
6. Executar smoke queries (próxima secção).
7. Congelar `datasetVersion` e registrar no `evidence/<runId>/context.json` da primeira corrida.

### Amplificação da massa `putz_teste` (1,3 GB -> 50 GB)

O baseline observado do schema `putz_teste` é ~1388,27 MB. A carga para estudo de escala deve atingir ~50 GB no HDFS/Hive (aprox. 38x).

Fluxo recomendado:

1. **Bronze:** ingestão do baseline em Parquet.
2. **Amplificação sintética:** geração de lotes adicionais preservando FKs (prioridade para `project_item`, `transaction`, `transaction_coupon`).
3. **Prata consultável:** publicação das tabelas amplificadas em `putz_teste`.
4. **Registro:** atualização de `datasetVersion` e metadados de amplificação por corrida.

Métodos de amplificação documentados:

- replicação estratificada por domínio;
- expansão temporal de transações;
- variação de atributos não sensíveis;
- bootstrap com chaves surrogate para manter integridade.

Riscos e controles:

- **integridade referencial:** validar FKs em cada lote;
- **deriva estatística:** comparar distribuições de colunas-chave com baseline;
- **tempo de carga:** execução incremental por janelas;
- **armazenamento:** considerar replicação HDFS 3 e manter margem de disco.

### Validação pós-carga

| Verificação | Critério mínimo | Como medir |
|-------------|-----------------|------------|
| Contagem de registros | `COUNT(*)` por tabela bate com o dump original (±0). | `hive -e "SELECT COUNT(*) FROM putz.<tabela>"` |
| Smoke query simples | `SELECT * FROM putz.franquias LIMIT 5` retorna 5 linhas. | Cliente Hive ou Spark SQL. |
| Smoke query com junção | `SELECT f.nome, s.nome FROM putz.franquias f JOIN putz.franquias__segmentos s ON f.segmento_id = s.id LIMIT 5` retorna linhas. | Cliente Hive ou Spark SQL. |
| Registro no Atlas | Entidade `hive_table` aparece para todas as tabelas selecionadas. | API Atlas: `GET /api/atlas/v2/search/dsl?query=hive_table`. |

### Diagrama

Ver [`../../diagrams/ingestao-putz.mmd`](../../diagrams/ingestao-putz.mmd).

### Estado dos pontos pendentes

- Ferramenta de ingestão: **Spark preferencial**, com CSV de contingência.
- Estratégia de catálogo no Atlas: manter hook do Hive quando disponível; fallback por API manual.
- Frequência: carga única congelada para o MVP, com nova versão apenas quando houver nova amplificação.

## Próximo passo

[`catalogo-atlas.md`](catalogo-atlas.md)
