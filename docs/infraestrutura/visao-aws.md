---
description: Topologia de rede e componentes AWS do ambiente de avaliação.
tags:
  - infra
---

# Visão de infraestrutura AWS

!!! info "Recomendado para leitura prévia"
    - **[Visão lógica](../arquitetura/aplicacao/visao-logica.md)** — zonas lógicas de rede.
    - **[Delta legado para AWS](delta-oci-para-aws.md)** — comparativo ambiente subdimensionado vs alvo x86.
    - **[Cluster Hadoop](cluster-hadoop.md)** — serviços ODP, sizing e operação.


### Premissas

- Conta AWS de estudo, sem dependência de tenant corporativo.
- Região única (a definir; sugestão: `sa-east-1` ou `us-east-1` por custo).
- Infraestrutura provisionada por Terraform (o código não faz parte do escopo desta pesquisa; documenta-se apenas a topologia alvo).

### Topologia alvo (versão mínima)

![Topologia AWS lógica](../diagrams/visao-aws-logica.svg){ .uml-diagram width="100%" }

Fonte: [Diagrama lógico AWS](../diagrams/visao-aws-logica.svg)

### Diagramas de referência

![Topologia do cluster](../diagrams/cluster-topologia-aws.svg){ .uml-diagram width="100%" }

Fonte: [Topologia do cluster AWS](../diagrams/cluster-topologia-aws.svg)

![Rede AWS](../diagrams/rede-aws.svg){ .uml-diagram width="100%" }

Fonte: [Diagrama de rede AWS](../diagrams/rede-aws.svg)

### Mapeamento de zonas lógicas para AWS

| Zona lógica (visão-logica.md) | Recurso AWS | Função |
|-------------------------------|-------------|--------|
| `NetPublic` | Subnet pública + Security Group de entrada (porta 443/22 restrita por IP). | Recebe a pergunta no orquestrador. |
| `NetInternalApp` | Subnet privada + SG de aplicação. | Hospeda a aplicação MCP. |
| `NetDataPlane` | Subnet privada de dados + SG do cluster (acesso restrito ao master/worker). | Atlas, HDFS, Hive Metastore, massa laboratorial. |
| `NetObservability` | Bucket S3 dedicado + IAM role da aplicação. | Evidências por `runId`, retenção sem sobrescrita. |

### Recursos por categoria

| Categoria | Recurso AWS | Tamanho/nota | Estado |
|-----------|-------------|--------------|--------|
| Rede | VPC `/24` | Equivalente ao `vcn-data-lake` (ver [Delta legado para AWS](delta-oci-para-aws.md)). | Definir Terraform |
| Rede | Subnets pública + privada | Mínimo 2 subnets em AZs diferentes para futuro HA. | Definir Terraform |
| Computação | EC2 master (1 instância) | `m6i.2xlarge` (8 vCPU, 32 GiB), Atlas co-localizado. | Definido (ADR-0002) |
| Computação | EC2 workers (3 instâncias) | `m6i.2xlarge` (8 vCPU, 32 GiB) para HDFS/YARN/Hive/HBase/Kafka. | Definido (ADR-0002) |
| Computação | EC2 aplicação MCP (1 instância) | `m6i.2xlarge` (8 vCPU, 32 GiB), nó dedicado na topologia alvo (`NetInternalApp`); co-localização no master apenas como contingência de MVP. | Definido (visão AWS) |
| Armazenamento | EBS por instância | gp3 >= 100 GiB por nó do cluster (master e workers), com replicação HDFS 3. | Definido |
| Armazenamento | Bucket S3 (evidências) | Versionamento ativado, retenção. | Definir |
| Segurança | Security Groups (3+: edge, app, data). | `deny by default`. | Definir |
| Segurança | IAM roles (EC2 -> S3) | Mínimo privilégio. | Definir |
| Acesso | Bastion ou Session Manager (preferível) | Evitar exposição SSH direta. | Decisão de operação |

### Ambiente legado

Um ambiente legado subdimensionado foi descartado do escopo operacional atual. Diferenças consolidadas em [Delta legado para AWS](delta-oci-para-aws.md).

### Custos e dimensionamento

- Estimativa de custo mensal fica para a fase operacional, após provisionamento real e medição de uso.
- Premissa: ambiente de estudo, ligado sob demanda durante corridas, não 24/7.

!!! tip "Recomendado para leitura posterior"
    Seguinte: **[Cluster Hadoop](cluster-hadoop.md)** — serviços ODP, sizing e operação.
