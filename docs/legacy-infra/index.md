# Infraestrutura legado OCI

> **Nota:** Esta pasta descreve legado OCI e **não** é o alvo do TCC. O alvo é AWS x86 com stack ODP documentada na [Monografia](../monografia.md). Preserva-se apenas como referência de migração (ODP 1.2.2.0, `centos9-aarch64`).

O código Terraform e Ansible permanece em `legacy-infra/` na raiz do repositório (fora do site publicado). Para o delta OCI → AWS, ver [Delta OCI para AWS](../05-infraestrutura/delta-oci-para-aws.md).

## Objetivo

Framework de infraestrutura como código que provisiona um cluster Big Data em OCI (Oracle Cloud Infrastructure), com Ambari/Hadoop em instâncias ARM (Ampere) e Oracle Linux 9.

## Arquitetura (OCI)

```mermaid
graph TD
    User[Usuário]
    subgraph OCI [Oracle Cloud Infrastructure]
        subgraph VCN [VCN 10.0.0.0/24]
            IG[Internet Gateway]
            SL[Security List]
            subgraph Subnet [Subnet Pública]
                Master["Master Node<br/>(Ansible Controller)<br/>10.0.0.2"]
                Node1["Worker Node 1<br/>10.0.0.3"]
                Node2["Worker Node 2<br/>10.0.0.4"]
                Node3["Worker Node 3<br/>10.0.0.5"]
            end
        end
    end
    User -->|Terraform Apply| OCI
    User -->|Acesso Web / SSH| Master
    Master -->|Ansible SSH| Node1
    Master -->|Ansible SSH| Node2
    Master -->|Ansible SSH| Node3
```

## Fluxo de provisionamento

```mermaid
sequenceDiagram
    participant User as Usuário
    participant OCI as OCI Terraform
    participant Master as Master Node
    participant Cluster as Cluster Workers
    User->>OCI: Terraform Apply
    OCI-->>User: Criação de VCN e Instâncias
    Master->>Cluster: Ansible Playbooks
    Master-->>User: Cluster Pronto
```
