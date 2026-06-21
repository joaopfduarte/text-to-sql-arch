# Delta ambiente legado → AWS

## Propósito

Comparar, em termos genéricos, o ambiente legado subdimensionado (removido deste repositório) com o alvo AWS do TCC.

## Leitor

Pessoa que provisiona o cluster AWS.

## Pré-requisitos

- [`visao-aws.md`](visao-aws.md)
- [`cluster-hadoop.md`](cluster-hadoop.md)
- [`vdf-odp-x86.md`](vdf-odp-x86.md)

## Conteúdo

### Síntese

O legado usava instâncias ARM pequenas, stack ODP 1.2.x e rede `/24` simples. O alvo do TCC é AWS x86_64, Ubuntu 24.04, ODP 1.3.1.0, com subnets segmentadas e sizing robusto (ADR-0002).

### Tabela delta

| Item | Legado (referência removida) | AWS (alvo TCC) |
|------|------------------------------|----------------|
| Provedor | Nuvem alternativa ARM | AWS |
| Arquitetura | `aarch64` | `x86_64` |
| SO | Oracle Linux 9 | Ubuntu 24.04 |
| ODP | 1.2.2.0 | 1.3.1.0 (build 294) |
| Sizing | ~1 OCPU / 6 GiB por nó | `m6i.2xlarge` (8 vCPU, 32 GiB) |
| Rede | `/24` flat | VPC `/24` + subnets |
| Massa | Não fixada para experimento | `massa_teste_laboratorio` (~1,4 GB) |

### Sequência de migração

1. Provisionar VPC/subnets/security groups AWS.
2. Instalar ODP 1.3.1.0 via VDF canônico.
3. Carregar massa conforme [`../04-arquitetura-dados/carga-cluster-laboratorio.md`](../04-arquitetura-dados/carga-cluster-laboratorio.md).
4. Registrar catálogo Atlas e validar tools MCP basais.

## Próximo passo

[`cluster-hadoop.md`](cluster-hadoop.md)
