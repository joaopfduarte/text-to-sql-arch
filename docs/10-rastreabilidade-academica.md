# Rastreabilidade acadêmica

## Propósito

Mapear, para cada bloco da documentação operacional em `arch-product/`, o capítulo da monografia LaTeX correspondente em `content/`. Garante coerência entre o "como executar" (este pacote) e o "como narrar" (TCC).

## Leitor

Pessoa que mantém a documentação sincronizada com a monografia ou que precisa verificar a base operacional citada num capítulo.

## Pré-requisitos

- Conhecimento dos capítulos da monografia em [`content/`](../../../content/).
- Leitura prévia de [`01-produto-e-escopo.md`](01-produto-e-escopo.md).

## Conteúdo

### Princípio

A documentação em `guide-docs/arch-product/` é a fonte operacional viva. A monografia em `content/cap*.tex` resume cientificamente as decisões e evidências. Nada de texto da monografia é copiado para `arch-product/`; o que vai para o TCC é uma síntese aprovada pelo autor.

### Mapa documento → capítulo

| Bloco em `arch-product/` | Capítulo LaTeX | Conteúdo que alimenta o capítulo |
|--------------------------|----------------|----------------------------------|
| [`01-produto-e-escopo.md`](01-produto-e-escopo.md) | [`content/cap1-introducao.tex`](../../../content/cap1-introducao.tex) | Objetivo geral, escopo, definição de erro estrutural. |
| [`02-arquitetura-negocio.md`](02-arquitetura-negocio.md) | [`content/cap1-introducao.tex`](../../../content/cap1-introducao.tex) (arquitetura de alto nível) | Blocos de negócio e contratos macro. |
| [`03-arquitetura-aplicacao/visao-logica.md`](03-arquitetura-aplicacao/visao-logica.md) | [`content/cap4-metodologia.tex`](../../../content/cap4-metodologia.tex) (camadas e fluxo) | Camadas, casos de uso, padrões. |
| [`03-arquitetura-aplicacao/modelo-dominio.md`](03-arquitetura-aplicacao/modelo-dominio.md) | [`content/cap4-metodologia.tex`](../../../content/cap4-metodologia.tex) | DDD + SOLID. |
| [`03-arquitetura-aplicacao/camadas-mcp.md`](03-arquitetura-aplicacao/camadas-mcp.md) | [`content/cap4-metodologia.tex`](../../../content/cap4-metodologia.tex) (servidor MCP) e [`content/cap6-desenvolvimento.tex`](../../../content/cap6-desenvolvimento.tex) | Tabela tool → porta → contrato → erro. |
| [`04-arquitetura-dados/banco-putz-dominio.md`](04-arquitetura-dados/banco-putz-dominio.md) | [`content/cap4-metodologia.tex`](../../../content/cap4-metodologia.tex) (banco de testes) | Domínios e tabelas-âncora do Putz. |
| [`04-arquitetura-dados/schema-massa-teste.md`](04-arquitetura-dados/schema-massa-teste.md) | [`content/cap4-metodologia.tex`](../../../content/cap4-metodologia.tex) (massa de teste) | Subconjunto congelado. |
| [`04-arquitetura-dados/carga-cluster-putz.md`](04-arquitetura-dados/carga-cluster-putz.md) | [`content/cap6-desenvolvimento.tex`](../../../content/cap6-desenvolvimento.tex) | Ingestão no cluster. |
| [`04-arquitetura-dados/catalogo-atlas.md`](04-arquitetura-dados/catalogo-atlas.md) | [`content/cap4-metodologia.tex`](../../../content/cap4-metodologia.tex) (Apache Atlas) | Fronteira Atlas vs dicionário físico. |
| [`05-infraestrutura/visao-aws.md`](05-infraestrutura/visao-aws.md) | [`content/cap4-metodologia.tex`](../../../content/cap4-metodologia.tex) (ambiente laboratorial) | Topologia AWS. |
| [`05-infraestrutura/cluster-hadoop.md`](05-infraestrutura/cluster-hadoop.md) | [`content/cap6-desenvolvimento.tex`](../../../content/cap6-desenvolvimento.tex) | Matriz Hadoop. |
| [`05-infraestrutura/delta-oci-para-aws.md`](05-infraestrutura/delta-oci-para-aws.md) | [`content/cap6-desenvolvimento.tex`](../../../content/cap6-desenvolvimento.tex) (limitações e decisões) | Justificativa da topologia AWS. |
| [`05-infraestrutura/vdf-odp-x86.md`](05-infraestrutura/vdf-odp-x86.md) | [`content/cap6-desenvolvimento.tex`](../../../content/cap6-desenvolvimento.tex) | VDF e adaptações. |
| [`06-implementacao-java/modulos-spring.md`](06-implementacao-java/modulos-spring.md) | [`content/cap6-desenvolvimento.tex`](../../../content/cap6-desenvolvimento.tex) | Estrutura de pacotes. |
| [`06-implementacao-java/ports-adapters.md`](06-implementacao-java/ports-adapters.md) | [`content/cap6-desenvolvimento.tex`](../../../content/cap6-desenvolvimento.tex) | Portas/adaptadores. |
| [`07-contratos-mcp/contracts-v1.md`](07-contratos-mcp/contracts-v1.md) | [`content/cap4-metodologia.tex`](../../../content/cap4-metodologia.tex) (MCP) e [`content/cap6-desenvolvimento.tex`](../../../content/cap6-desenvolvimento.tex) | Contratos JSON. |
| [`08-experimento-avaliacao/protocolo-avaliacao.md`](08-experimento-avaliacao/protocolo-avaliacao.md) | [`content/cap4-metodologia.tex`](../../../content/cap4-metodologia.tex) (protocolo) e [`content/cap7-resultados.tex`](../../../content/cap7-resultados.tex) | Métricas e desfechos. |
| [`08-experimento-avaliacao/runbook-reprodutibilidade.md`](08-experimento-avaliacao/runbook-reprodutibilidade.md) | [`content/cap4-metodologia.tex`](../../../content/cap4-metodologia.tex) (registro experimental) | Identificadores e metadados. |
| [`09-operacao.md`](09-operacao.md) | [`content/cap6-desenvolvimento.tex`](../../../content/cap6-desenvolvimento.tex) | Operação. |
| [`roadmap-5a6-meses.md`](roadmap-5a6-meses.md) | Cronograma do TCC (capítulo introdutório ou apêndice). | Marcos e gates. |
| [`../adr/ADR-0001-fundacao-arquitetural.md`](../adr/ADR-0001-fundacao-arquitetural.md) | [`content/cap4-metodologia.tex`](../../../content/cap4-metodologia.tex) | Decisão arquitetural. |
| [`../adr/ADR-0002-topologia-aws-cluster-minimo.md`](../adr/ADR-0002-topologia-aws-cluster-minimo.md) | [`content/cap6-desenvolvimento.tex`](../../../content/cap6-desenvolvimento.tex) | Topologia AWS mínima. |

### Regra de manutenção

Cada mudança neste pacote que afete uma narrativa do TCC deve registrar:

- a versão do documento alterado;
- o capítulo LaTeX impactado;
- se há necessidade de ADR.

## Próximo passo

[`roadmap-5a6-meses.md`](roadmap-5a6-meses.md)
