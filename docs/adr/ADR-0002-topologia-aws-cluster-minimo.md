# ADR-0002: Topologia AWS de cluster mínimo

- **Status:** Aceito
- **Data:** 2026-05-16

## Contexto

O TCC precisa de um ambiente laboratorial reprodutível para executar o pipeline Text-to-SQL com catálogo real (Apache Atlas) e massa XPTO. O legado OCI, agora em [legacy-infra](../legacy-infra/index.md), é somente referência de migração e não alvo de implantação final.

A decisão de stack do alvo já está fechada no VDF canônico [Monografia](../monografia.md):

- ODP 1.3.1.0 (build 294)
- Ubuntu 24.04
- arquitetura x86_64

## Decisão

Adotar **cluster ODP em AWS x86_64 (Ubuntu 24.04, ODP 1.3.1.0)** com topologia de produção experimental:

- 1 master `m6i.2xlarge` (8 vCPU, 32 GiB) para Ambari, ZooKeeper, NameNode, ResourceManager e Atlas.
- 3 workers `m6i.4xlarge` (16 vCPU, 64 GiB) para DataNode/NodeManager/Hive/HBase/Kafka.
- EBS gp3 mínimo de 200 GiB por worker para suportar massa `xpto_teste` amplificada (50 GiB) com replicação HDFS 3 e margem operacional.

**Posicionamento do Atlas:** Atlas co-localizado no master, com dependências HBase/Solr/Kafka distribuídas no cluster.

## Consequências

### Positivas

- Alinhamento direto com o VDF canônico do projeto.
- Melhor folga de recursos para carga e consulta em volume de estudo.
- Menor risco de regressão arquitetural ao manter Atlas no cluster distribuído.

### Negativas

- Custo maior que topologias mínimas de 2 nós.
- Exige disciplina de desligamento fora das janelas de experimento.

## Alternativas rejeitadas

- **Opção 2 (Graviton ARM):** rejeitada pelo autor; não é o alvo do TCC.
- **Opção 3 (Atlas standalone):** rejeitada como solução principal por reduzir aderência ao objetivo de catálogo distribuído; mantém-se apenas como contingência de prazo.
- **Replica integral do legado OCI (`legacy-infra/`):** rejeitada por usar stack ODP 1.2.2.0 em `aarch64`.

## Ligação com o prazo de novembro

- A topologia aceita prioriza estabilidade para corrida experimental até novembro.
- Se houver degradação de prazo/custo na implantação, aplicar onda de contingência com redução temporária de volume, mantendo stack x86/Ubuntu/ODP 1.3.1.0.

## Referências

- [Cluster Hadoop](../05-infraestrutura/cluster-hadoop.md)
- [Delta OCI para AWS](../05-infraestrutura/delta-oci-para-aws.md)
- [VDF ODP x86](../05-infraestrutura/vdf-odp-x86.md)
- [Catálogo Atlas](../04-arquitetura-dados/catalogo-atlas.md)
- [Monografia](../monografia.md)
- [`ADR-0001-fundacao-arquitetural.md`](ADR-0001-fundacao-arquitetural.md)
