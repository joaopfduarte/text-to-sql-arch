# VDF ODP em x86

!!! info "Recomendado para leitura prévia"
    - **[Cluster Hadoop](cluster-hadoop.md)** — serviços ODP, sizing e operação.
    - **[VDF ODP x86](../assets/scripts/ODP-VDF.xml)** — definição canônica da stack alvo.


### VDF canônico (alvo da pesquisa)

Fonte de verdade: [VDF ODP x86](../assets/scripts/ODP-VDF.xml).

| Campo | Valor |
|-------|-------|
| Stack id | `ODP-1.3` |
| Versão | `1.3.1.0` |
| Build | `294` |
| Display | `ODP-1.3.1.0` |
| OS | `ubuntu24` |
| Arquitetura alvo | `x86_64` |
| Repositório | `https://clemlabs.s3.eu-west-3.amazonaws.com/ubuntu24/odp-release/1.3.1.0-294/ODP` |

### Serviços do alvo (extraídos do VDF canônico)

| Serviço | Versão |
|---------|--------|
| ATLAS | 2.4.0 |
| HIVE | 4.0.1 |
| HDFS | 3.4.1 |
| YARN | 3.4.1 |
| HBASE | 2.6.1 |
| KAFKA | 3.8.1 |
| ZOOKEEPER | 3.9.3 |
| SPARK3 | 3.5.6 |
| NIFI | 1.28.1 |
| RANGER | 2.6.0 |

### Implicação prática para a documentação

- O alvo da pesquisa está fechado em x86 + Ubuntu 24.04 com ODP 1.3.1.0.

!!! tip "Recomendado para leitura posterior"
    Seguinte: **[ADR-0002 Topologia AWS](../adr/ADR-0002-topologia-aws-cluster-minimo.md)** — cluster ODP mínimo, sizing e massa fixa.
