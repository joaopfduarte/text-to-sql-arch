---
description: Cluster ODP mínimo em AWS x86, sizing e massa fixa de teste.
status: Aceito
tags:
  - adr
  - infra
---

# ADR-0002: Topologia AWS de cluster mínimo

- **Status:** Aceito
- **Data:** 2026-05-16

## Contexto

A pesquisa precisa de um ambiente laboratorial reprodutível para executar o pipeline Text-to-SQL com catálogo Apache Atlas e massa de laboratório (`base_laboratorial`, 92 entidades).

A stack alvo está fechada no VDF canônico [VDF ODP x86](../assets/scripts/ODP-VDF.xml):

- ODP 1.3.1.0 (build 294)
- Ubuntu 24.04
- arquitetura x86_64

## Decisão

Adotar **cluster ODP em AWS x86_64 (Ubuntu 24.04, ODP 1.3.1.0)** com topologia experimental:

- 1 master `m6i.2xlarge` (8 vCPU, 32 GiB) para Ambari, ZooKeeper, NameNode, ResourceManager e Atlas.
- 3 workers `m6i.2xlarge` (8 vCPU, 32 GiB) para DataNode/NodeManager/Hive/HBase/Kafka.
- EBS gp3 mínimo de 100 GiB por nó para suportar massa fixa ~1,4 GB com replicação HDFS 3.

**Posicionamento do Atlas:** co-localizado no master, com dependências HBase/Solr/Kafka distribuídas no cluster.

## Consequências

### Positivas

- Alinhamento com o VDF canônico.
- Folga suficiente para massa laboratorial fixa e execução experimental.
- Atlas no cluster distribuído conforme objetivo da pesquisa.

### Negativas

- Custo superior a topologias mínimas de 2 nós.
- Exige desligamento disciplinado fora das janelas de experimento.

## Alternativas rejeitadas

- **Topologias ARM ou subdimensionadas:** fora do escopo do VDF canônico x86.
- **Atlas standalone:** contingência apenas; não solução principal.

## Referências

- [Cluster Hadoop](../infraestrutura/cluster-hadoop.md)
- [VDF ODP x86](../infraestrutura/vdf-odp-x86.md)
- [Catálogo Atlas](../arquitetura/dados/catalogo-atlas.md)
- [ADR-0001](ADR-0001-fundacao-arquitetural.md)
