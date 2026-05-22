# Delta de infraestrutura OCI → AWS

## Propósito

Listar as diferenças concretas entre o laboratório de referência (OCI ARM) e o alvo do TCC (AWS x86), com base em evidência de [`../../legacy-infra/`](../../legacy-infra/) e no VDF canônico [`../../../../assets/scripts/ODP-VDF.xml`](../../../../assets/scripts/ODP-VDF.xml).

## Leitor

Pessoa que vai portar a infra do exemplo OCI para a AWS.

## Pré-requisitos

- [`visao-aws.md`](visao-aws.md)
- [`cluster-hadoop.md`](cluster-hadoop.md)
- [`vdf-odp-x86.md`](vdf-odp-x86.md)
- Leitura mínima dos arquivos: [`compute.tf`](../../legacy-infra/compute.tf), [`network.tf`](../../legacy-infra/network.tf), [`security-list.tf`](../../legacy-infra/security-list.tf), [`site.yml`](../../legacy-infra/assets/site.yml), [`ODP-VDF.xml`](../../legacy-infra/assets/ODP-VDF.xml) e [`../../../../assets/scripts/ODP-VDF.xml`](../../../../assets/scripts/ODP-VDF.xml).

## Conteúdo

### Síntese

O exemplo OCI provisiona 4 instâncias `VM.Standard.A1.Flex` (Ampere ARM, Oracle Linux 9) numa VCN `/24`, instala Ambari + ODP 1.2.2.0 (repos `centos9-aarch64`) via Ansible/cloud-init e cria um cluster completo de referência. O alvo do TCC é AWS x86_64 com Ubuntu 24.04 e ODP 1.3.1.0, conforme VDF canônico.

### Tabela delta

| Item | OCI (atual em `legacy-infra/`) | AWS (alvo do TCC) | Evidência OCI |
|------|------------------------------------|--------------------|---------------|
| Provedor | Oracle Cloud Infrastructure | AWS | [`provider.tf`](../../legacy-infra/provider.tf) |
| Região | Variável `region` no legado | A definir em conta AWS de estudo | [`variables.tf`](../../legacy-infra/variables.tf) |
| Rede principal | VCN `10.0.0.0/24` | VPC `/24` + subnets segmentadas | [`network.tf`](../../legacy-infra/network.tf) |
| Conflito documental legado | README legado tinha `/16`; `network.tf` usa `/24` | `/24` é a referência correta | [`README.md`](../../legacy-infra/README.md), [`network.tf`](../../legacy-infra/network.tf) |
| Arquitetura de CPU | ARM (`VM.Standard.A1.Flex`) | x86_64 | [`compute.tf`](../../legacy-infra/compute.tf) |
| SO / VDF | ODP 1.2.2.0 em `redhat9` + `aarch64` | ODP 1.3.1.0 em `ubuntu24` + x86_64 | [`../../legacy-infra/assets/ODP-VDF.xml`](../../legacy-infra/assets/ODP-VDF.xml), [`../../../../assets/scripts/ODP-VDF.xml`](../../../../assets/scripts/ODP-VDF.xml) |
| Sizing | 1 OCPU / 6 GiB (legado) | Master `m6i.2xlarge`, workers `m6i.4xlarge` | [`variables.tf`](../../legacy-infra/variables.tf), [`../../adr/ADR-0002-topologia-aws-cluster-minimo.md`](../../adr/ADR-0002-topologia-aws-cluster-minimo.md) |
| Número de nós | 1 master + 3 workers | 1 master + 3 workers (recomendação) | [`cluster-template.json`](../../legacy-infra/assets/cluster-template.json), ADR-0002 |
| Armazenamento | Boot 50 GiB | EBS gp3 >= 200 GiB por worker | `compute.tf` (legado), ADR-0002 |
| Segurança | Security List única | Security groups intra-VPC por papel | [`security-list.tf`](../../legacy-infra/security-list.tf) |

### Itens fora do MVP (presentes no legado OCI e opcionais no alvo)

- NiFi (`NIFI_MASTER`).
- Spark3 ThriftServer e JobHistoryServer (a menos que o agente precise de Spark SQL).
- Ranger Admin (segurança avançada).
- Phoenix Query Server.
- PostgreSQL como backing do Ambari pode ser AWS RDS, mas o overhead provavelmente não compensa no MVP.

### Sequência de port para AWS (alto nível)

1. Aplicar ADR-0002 aceito (x86 + Ubuntu 24.04 + ODP 1.3.1.0).
2. Reescrever blueprint para a topologia mínima.
3. Parametrizar repositórios a partir do VDF canônico em `assets/scripts`.
4. Portar Terraform: provider AWS, VPC, subnets, SGs, EC2.
5. Portar cloud-init/Ansible: substituir cadeia `aarch64` por pacotes x86_64 e base Ubuntu 24.04.
6. Executar `site.yml` adaptado, depois `cluster_deploy.yml`.
7. Carregar Putz conforme [`../04-arquitetura-dados/carga-cluster-putz.md`](../04-arquitetura-dados/carga-cluster-putz.md).

## Próximo passo

[`vdf-odp-x86.md`](vdf-odp-x86.md)
