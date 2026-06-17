# Cluster Hadoop (laboratório AWS)

## Propósito

Descrever os serviços Hadoop/ODP necessários ao Apache Atlas e ao armazenamento consultável pelo TCC, com matriz `serviço x nó x porta x dependência x fonte`.

## Leitor

Pessoa que opera ou valida o cluster.

## Pré-requisitos

- [`visao-aws.md`](visao-aws.md)
- [`delta-oci-para-aws.md`](delta-oci-para-aws.md)
- [`vdf-odp-x86.md`](vdf-odp-x86.md)
- [`../adr/ADR-0002-topologia-aws-cluster-minimo.md`](../adr/ADR-0002-topologia-aws-cluster-minimo.md)

## Conteúdo

### Análise de topologias

| Alternativa | Descrição | Prós | Contras |
|-------------|-----------|------|---------|
| A1: 1 master + 2 workers | Cluster compacto com Atlas no master e serviços de dados distribuídos em 2 workers. | Custo moderado e implantação rápida. | Menor folga para replicação HDFS 3 da massa fixa e picos de processamento. |
| A2: 1 master + 3 workers | Master dedicado ao plano de controle e catálogo; 3 workers para dados e processamento. | Melhor equilíbrio entre desempenho, resiliência e prazo. | Custo maior que A1. |
| A3: Atlas/Solr dedicado | Nó dedicado para Atlas/Solr além de master e workers de dados. | Isola catálogo e reduz contenção. | Custo e complexidade mais altos para o horizonte de novembro. |

### Recomendação aceita

Com base no ADR aceito, a recomendação é **A2 (1 master + 3 workers)** em AWS x86_64 com Ubuntu 24.04 e ODP 1.3.1.0.

| Papel | Instância recomendada | Memória/CPU | Disco |
|-------|------------------------|-------------|-------|
| Master | `m6i.2xlarge` | 8 vCPU, 32 GiB | EBS gp3 >= 100 GiB |
| Workers (3) | `m6i.2xlarge` | 8 vCPU, 32 GiB | EBS gp3 >= 100 GiB por nó |

Justificativa: evita o subdimensionamento do legado OCI (1 OCPU/6 GiB), suporta a massa `putz_teste` fixa com replicação HDFS 3 e mantém margem para Atlas + Hive + execução experimental.

### Matriz de serviços (referência de legado para composição)

| Serviço | Papel no alvo AWS | Fonte de referência |
|---------|--------------------|---------------------|
| ZooKeeper | Coordenação do cluster | [`../legacy-infra/assets/blueprint.json`](../legacy-infra/assets/blueprint.json) |
| HDFS (NN/DN) | Armazenamento da massa PS estável (92 tabelas) | [`../legacy-infra/assets/blueprint.json`](../legacy-infra/assets/blueprint.json) |
| YARN (RM/NM) | Execução distribuída dos jobs | [`../legacy-infra/assets/blueprint.json`](../legacy-infra/assets/blueprint.json) |
| Hive Metastore + HiveServer2 | Tabelas consultáveis (`putz_teste`) | [`../legacy-infra/assets/blueprint.json`](../legacy-infra/assets/blueprint.json) |
| Atlas | Catálogo canônico para o MCP | [`../assets/scripts/ODP-VDF.xml`](../assets/scripts/ODP-VDF.xml) |
| HBase/Solr/Kafka | Dependências operacionais do Atlas | [`../assets/scripts/ODP-VDF.xml`](../assets/scripts/ODP-VDF.xml) |

### Matriz de portas AWS (pendente na criação do projeto)

As portas abaixo **não** estão fechadas nesta documentação. Na criação do projeto AWS/Terraform, definir security groups com tráfego **intra-VPC** entre componentes. O arquivo [`../legacy-infra/security-list.tf`](../legacy-infra/security-list.tf) lista apenas exposições de operação no laboratório OCI e não deve ser tratado como lista final de portas AWS.

| Serviço | Porta(s) típica(s) | Estado |
|---------|---------------------|--------|
| DataNode | TBD na implementação | Pendente |
| NodeManager | TBD na implementação | Pendente |
| Hive Metastore | 9083 (confirmar na instalação) | Pendente |
| HiveServer2 | 10000 (confirmar na instalação) | Pendente |
| Apache Atlas | 21000, 31000 (confirmar na instalação) | Pendente |
| Kafka broker | TBD na implementação | Pendente |
| Solr | TBD na implementação | Pendente |
| HBase RegionServer | TBD na implementação | Pendente |

### Sequência de subida (legado OCI como referência)

1. Provisionar infraestrutura base e nós.
2. Aplicar bootstrap (`cloud-init`) e dependências.
3. Instalar Ambari/ODP e registrar VDF.
4. Aplicar blueprint de cluster.
5. Validar saúde do catálogo e do plano de dados.

Referências de execução no legado: [`../legacy-infra/cloud-init/master.yaml`](../legacy-infra/cloud-init/master.yaml), [`../legacy-infra/assets/site.yml`](../legacy-infra/assets/site.yml), [`../legacy-infra/assets/cluster_deploy.yml`](../legacy-infra/assets/cluster_deploy.yml).

### Diagrama

Ver [`../diagrams/cluster-topologia-aws.puml`](../diagrams/cluster-topologia-aws.puml).

### Estado dos pontos críticos

- Portas finais de segurança AWS: pendentes para fase de criação do projeto Terraform.
- Dimensionamento: resolvido no ADR-0002 (sizing robusto recomendado).
- Posicionamento do Atlas: resolvido, Atlas no cluster (co-localizado no master).

## Próximo passo

[`../04-arquitetura-dados/carga-cluster-putz.md`](../04-arquitetura-dados/carga-cluster-putz.md)
