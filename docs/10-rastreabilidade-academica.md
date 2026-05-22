# Rastreabilidade acadêmica

## Propósito

Mapear, para cada bloco da documentação operacional deste site e o capítulo correspondente na [Monografia](monografia.md). Garante coerência entre o "como executar" (este pacote) e o "como narrar" (TCC).

## Leitor

Pessoa que mantém a documentação sincronizada com a monografia ou que precisa verificar a base operacional citada num capítulo.

## Pré-requisitos

- [Monografia](monografia.md) (PDF com capítulos completos).
- Leitura prévia de [`01-produto-e-escopo.md`](01-produto-e-escopo.md).

## Conteúdo

### Princípio

Este site é a fonte operacional viva. A [Monografia](monografia.md) resume cientificamente as decisões e evidências.

### Mapa documento → capítulo

| Documento operacional | Monografia | Conteúdo que alimenta o capítulo |
|--------------------------|----------------|----------------------------------|
| [`01-produto-e-escopo.md`](01-produto-e-escopo.md) | [Monografia](monografia.md) | Objetivo geral, escopo, definição de erro estrutural. |
| [`02-arquitetura-negocio.md`](02-arquitetura-negocio.md) | [Monografia](monografia.md) (arquitetura de alto nível) | Blocos de negócio e contratos macro. |
| [`03-arquitetura-aplicacao/visao-logica.md`](03-arquitetura-aplicacao/visao-logica.md) | [Monografia](monografia.md) (camadas e fluxo) | Camadas, casos de uso, padrões. |
| [`03-arquitetura-aplicacao/modelo-dominio.md`](03-arquitetura-aplicacao/modelo-dominio.md) | [Monografia](monografia.md) | DDD + SOLID. |
| [`03-arquitetura-aplicacao/camadas-mcp.md`](03-arquitetura-aplicacao/camadas-mcp.md) | [Monografia](monografia.md) (servidor MCP) e [Monografia](monografia.md) | Tabela tool → porta → contrato → erro. |
| [`04-arquitetura-dados/banco-xpto-dominio.md`](04-arquitetura-dados/banco-xpto-dominio.md) | [Monografia](monografia.md) (banco de testes) | Domínios e tabelas-âncora do XPTO. |
| [`04-arquitetura-dados/schema-massa-teste.md`](04-arquitetura-dados/schema-massa-teste.md) | [Monografia](monografia.md) (massa de teste) | Subconjunto congelado. |
| [`04-arquitetura-dados/carga-cluster-xpto.md`](04-arquitetura-dados/carga-cluster-xpto.md) | [Monografia](monografia.md) | Ingestão no cluster. |
| [`04-arquitetura-dados/catalogo-atlas.md`](04-arquitetura-dados/catalogo-atlas.md) | [Monografia](monografia.md) (Apache Atlas) | Fronteira Atlas vs dicionário físico. |
| [`05-infraestrutura/visao-aws.md`](05-infraestrutura/visao-aws.md) | [Monografia](monografia.md) (ambiente laboratorial) | Topologia AWS. |
| [`05-infraestrutura/cluster-hadoop.md`](05-infraestrutura/cluster-hadoop.md) | [Monografia](monografia.md) | Matriz Hadoop. |
| [`05-infraestrutura/delta-oci-para-aws.md`](05-infraestrutura/delta-oci-para-aws.md) | [Monografia](monografia.md) (limitações e decisões) | Justificativa da topologia AWS. |
| [`05-infraestrutura/vdf-odp-x86.md`](05-infraestrutura/vdf-odp-x86.md) | [Monografia](monografia.md) | VDF e adaptações. |
| [`06-implementacao-java/modulos-spring.md`](06-implementacao-java/modulos-spring.md) | [Monografia](monografia.md) | Estrutura de pacotes. |
| [`06-implementacao-java/ports-adapters.md`](06-implementacao-java/ports-adapters.md) | [Monografia](monografia.md) | Portas/adaptadores. |
| [`07-contratos-mcp/contracts-v1.md`](07-contratos-mcp/contracts-v1.md) | [Monografia](monografia.md) (MCP) e [Monografia](monografia.md) | Contratos JSON. |
| [`08-experimento-avaliacao/protocolo-avaliacao.md`](08-experimento-avaliacao/protocolo-avaliacao.md) | [Monografia](monografia.md) (protocolo) e [Monografia](monografia.md) | Métricas e desfechos. |
| [`08-experimento-avaliacao/runbook-reprodutibilidade.md`](08-experimento-avaliacao/runbook-reprodutibilidade.md) | [Monografia](monografia.md) (registro experimental) | Identificadores e metadados. |
| [`09-operacao.md`](09-operacao.md) | [Monografia](monografia.md) | Operação. |
| [`roadmap-5a6-meses.md`](roadmap-5a6-meses.md) | Cronograma do TCC (capítulo introdutório ou apêndice). | Marcos e gates. |
| [`adr/ADR-0001-fundacao-arquitetural.md`](adr/ADR-0001-fundacao-arquitetural.md) | [Monografia](monografia.md) | Decisão arquitetural. |
| [`adr/ADR-0002-topologia-aws-cluster-minimo.md`](adr/ADR-0002-topologia-aws-cluster-minimo.md) | [Monografia](monografia.md) | Topologia AWS mínima. |

### Regra de manutenção

Cada mudança neste pacote que afete uma narrativa do TCC deve registrar:

- a versão do documento alterado;
- a monografia impactada;
- se há necessidade de ADR.

## Próximo passo

[`roadmap-5a6-meses.md`](roadmap-5a6-meses.md)
