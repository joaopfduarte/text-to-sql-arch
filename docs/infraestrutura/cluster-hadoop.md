---
description: Serviços ODP, sizing e operação do cluster Hadoop mínimo.
tags:
  - infra
---

# Cluster Hadoop (laboratório AWS)

!!! info "Recomendado para leitura prévia"
    - **[Visão AWS](visao-aws.md)** — topologia de rede e componentes na nuvem.
    - **[Delta legado para AWS](delta-oci-para-aws.md)** — comparativo ambiente subdimensionado vs alvo x86.
    - **[VDF ODP x86](vdf-odp-x86.md)** — stack canônica ODP 1.3.1.0 para o cluster.
    - **[ADR-0002 Topologia AWS](../adr/ADR-0002-topologia-aws-cluster-minimo.md)** — cluster ODP mínimo, sizing e massa fixa.


### Topologia aceita (ADR-0002)

**1 master + 3 workers** em AWS x86_64, Ubuntu 24.04, ODP 1.3.1.0.

| Papel | Instância | Memória/CPU | Disco |
|-------|----------|-------------|-------|
| Master | `m6i.2xlarge` | 8 vCPU, 32 GiB | EBS gp3 >= 100 GiB |
| Workers (3) | `m6i.2xlarge` | 8 vCPU, 32 GiB | EBS gp3 >= 100 GiB |

Justificativa: suporta `massa_teste_laboratorio` (~1,4 GB) com replicação HDFS 3 e margem para Atlas + Hive.

### Serviços ODP

| Serviço | Papel |
|---------|-------|
| ZooKeeper | Coordenação |
| HDFS | Armazenamento da massa (92 entidades) |
| YARN | Execução distribuída |
| Hive Metastore + HiveServer2 | Consultas SQL (`massa_teste_laboratorio`) |
| Apache Atlas | Catálogo MCP |
| HBase / Solr / Kafka | Dependências do Atlas |

Referência de versões: [VDF ODP x86](../assets/scripts/ODP-VDF.xml).

### Portas (pendente Terraform)

| Serviço | Porta(s) típica(s) | Estado |
|---------|---------------------|--------|
| Hive Metastore | 9083 | Confirmar na instalação |
| HiveServer2 | 10000 | Confirmar na instalação |
| Apache Atlas | 21000, 31000 | Confirmar na instalação |
| Outros (DN, NM, Kafka, Solr, HBase) | TBD | Pendente |

Definir security groups intra-VPC na fase de implementação.

### Sequência de subida

1. Provisionar VPC e instâncias EC2.
2. Instalar Ambari/ODP com VDF canônico.
3. Validar HDFS, Hive e Atlas.
4. Executar carga laboratorial e smoke queries.

### Diagrama

![Topologia do cluster AWS](../diagrams/cluster-topologia-aws.svg){ .uml-diagram width="100%" }

!!! tip "Recomendado para leitura posterior"
    Seguinte: **[Carga no cluster](../arquitetura/dados/carga-cluster-laboratorio.md)** — pipeline de ingestão da massa `massa_teste_laboratorio`.
