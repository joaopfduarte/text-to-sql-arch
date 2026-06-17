# CDP Infrastructure on OCI (Terraform + Ansible)

> **Nota — Esta pasta é legado OCI e não o alvo do TCC.** O alvo do TCC é AWS x86 com VDF canônico em [`../../assets/scripts/ODP-VDF.xml`](../../assets/scripts/ODP-VDF.xml). Esta pasta preserva somente a referência de migração OCI (ODP 1.2.2.0, `centos9-aarch64`).

**Documentação Principal:** [https://github.com/Ecosystem-CDP/docs/tree/main](https://github.com/Ecosystem-CDP/docs/tree/main)

**Vídeo demonstrativo do processo de Deploy:** [Tutorial para deploy de um Cluster Hadoop na OCI](https://youtu.be/MbpKeu-Jw_Y)

Este projeto automatiza o deploy completo de um cluster Hadoop em nuvem, utilizando a Oracle Cloud Infrastructure (OCI). O objetivo é fornecer uma "Stack" pronta para uso que provisiona um Data Lake completo baseado em metadados (Blueprints), utilizando instâncias ARM (Ampere) com Oracle Linux 9.

## Objetivo

Criar um framework de infraestrutura como código que permite a qualquer usuário instanciar um cluster Big Data funcional apenas registrando esta stack no OCI Resource Manager ou executando via Terraform CLI. O projeto vai além do provisionamento de máquinas, entregando o software (Ambari/Hadoop) instalado e configurado.

## Arquitetura

O projeto combina **Terraform** para a infraestrutura física e de rede, com **Ansible** (executado via **Cloud-Init**) para a configuração de software e orquestração do cluster.

```plantuml
@startuml
top to bottom direction
actor Usuario as user
frame "Oracle Cloud Infrastructure" as oci {
  frame "VCN 10.0.0.0/24" as vcn {
    rectangle "Internet Gateway" as ig
    rectangle "Security List" as sl
    frame "Subnet Publica" as subnet {
      rectangle "Master Node\\n(Ansible Controller)\\n10.0.0.2" as master
      rectangle "Worker Node 1\\n10.0.0.3" as node1
      rectangle "Worker Node 2\\n10.0.0.4" as node2
      rectangle "Worker Node 3\\n10.0.0.5" as node3
    }
  }
}
user --> oci : Terraform Apply
user --> master : Acesso Web / SSH
master --> node1 : Ansible SSH
master --> node2 : Ansible SSH
master --> node3 : Ansible SSH
@enduml
```

### Componentes de Infraestrutura (Terraform)
*   **OCI Core**: VCN, Subnets, Internet Gateways, Security Lists.
*   **Compute Instances**:
    *   **1 Master Node** (`master.cdp`): Responsável por gerenciar o cluster e executar o Ansible.
    *   **3 Worker Nodes** (`node1.cdp`, `node2.cdp`, `node3.cdp`): Nós de processamento e armazenamento.
*   **SO**: Oracle Linux 9 (Arquitetura Aarch64/Ampere).
*   **Network**: Rede privada interna `10.0.0.x` para comunicação do cluster.

### Fluxo de Provisionamento

```plantuml
@startuml
actor Usuario as user
participant "OCI (Terraform)" as oci
participant "Master Node" as master
participant "Cluster (Workers)" as cluster

user -> oci : Terraform Apply
oci --> user : Criacao de VCN e Instancias

opt Cloud-Init (Master)
  master -> master : Instalacao de Pkgs (Ansible/Git)
  master -> master : Configuracao de Chaves SSH
  master -> cluster : Aguarda conectividade SSH
end

note over master
Inicio da Orquestracao
end note

master -> cluster : Ansible Playbook (site.yml)
note right of cluster
Setup de SO, Kernel, Firewalls
end note

master -> cluster : Ansible Playbook (cluster_deploy.yml)
note right of cluster
Install Ambari Server/Agents
Deploy Blueprint Hadoop
end note

master --> user : Cluster pronto para uso
@enduml
```

1.  **Terraform**:
    *   Cria a infraestrutura de rede e segurança.
    *   Sobe as instâncias VM.
    *   Gera chaves SSH dinâmicas para comunicação entre nós.
    *   Faz o upload dos *assets* (Playbooks, Blueprint, Templates) para o nó Master via provisionador `file`.
2.  **Cloud-Init (Master)**:
    *   Configura o ambiente inicial.
    *   Instala dependências (Python, Ansible, Git).
    *   Aguarda a disponibilidade dos Worker nodes (SSH check).
    *   Dispara o script de orquestração `run-ansible.sh`.
3.  **Ansible (Master -> Cluster)**:
    *   **Infra Setup** (`site.yml`): Prepara o SO, ajusta kernel, firewalls e pré-requisitos do Ambari em todos os nós.
    *   **Cluster Deploy** (`cluster_deploy.yml`): Instala o Ambari Server, Ambari Agents e realiza o deploy dos serviços Hadoop conforme definido no `blueprint.json`.

## Configuração Obrigatória

### Variável: `my_client_ip`
Para garantir a segurança do acesso às interfaces web (Ambari, NiFi, Zeppelin, etc.), é **obrigatório** fornecer o seu endereço IP público atual. O Terraform utilizará este IP para criar regras de Security List específicas, permitindo o tráfego apenas da sua origem.

*   **Descrição**: Lista de IPs públicos da sua máquina (notebook/desktop) separados por vírgula.
*   **Como obter**: Acesse [https://api.ipify.org](https://api.ipify.org) ou [https://whatismyip.com](https://whatismyip.com).
*   **Exemplo**: `203.0.113.15, 198.51.100.12`

## Visão Geral dos Arquivos
*   `compute.tf`: Definição das VMs e *User Data* (Cloud-Init).
*   `network.tf`: Configuração de VCN e rede.
*   `provider.tf`: Configuração do OCI Provider.
*   `cloud-init/`: Scripts de inicialização YAML (Master e Workers).
*   `assets/`:
    *   `blueprint.json`: Definição completa dos serviços Hadoop a serem instalados.
    *   `ODP-VDF.xml`: Definição de versão do stack (Version Definition File).
    *   `*.yml`: Playbooks do Ansible.
