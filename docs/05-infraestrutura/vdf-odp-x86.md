# VDF ODP em x86

## Propósito

Documentar o VDF canônico do alvo AWS do TCC e separar explicitamente a referência de legado OCI.

## Leitor

Pessoa que valida stack/versões do cluster e prepara a implantação em AWS.

## Pré-requisitos

- [`cluster-hadoop.md`](cluster-hadoop.md)
- [`delta-oci-para-aws.md`](delta-oci-para-aws.md)
- [`../assets/scripts/ODP-VDF.xml`](../assets/scripts/ODP-VDF.xml)

## Conteúdo

### VDF canônico (alvo TCC)

Fonte de verdade: [`../assets/scripts/ODP-VDF.xml`](../assets/scripts/ODP-VDF.xml).

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

### VDF legado OCI (somente referência)

Fonte: [`../assets/scripts/ODP-VDF.xml`](../assets/scripts/ODP-VDF.xml).

| Campo | Valor |
|-------|-------|
| Stack id | `ODP-1.2` |
| Versão | `1.2.2.0` |
| OS | `redhat9` |
| Arquitetura | `aarch64` |
| Repositório | `centos9-aarch64` |

### Implicação prática para a documentação

- O alvo do TCC está fechado em x86 + Ubuntu 24.04 com ODP 1.3.1.0.
- O legado OCI permanece apenas como referência de migração e comparação.
- Qualquer citação a Graviton como alvo foi removida do pacote.

## Próximo passo

[`../adr/ADR-0002-topologia-aws-cluster-minimo.md`](../adr/ADR-0002-topologia-aws-cluster-minimo.md)
