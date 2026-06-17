# Rastreabilidade acadêmica

## Propósito

Mapear, para cada bloco da documentação operacional em `artifact-docs/`, o capítulo da monografia LaTeX correspondente em `content/`. Garante coerência entre o "como executar" (este pacote) e o "como narrar" (TCC).

## Leitor

Pessoa que mantém a documentação sincronizada com a monografia ou que precisa verificar a base operacional citada num capítulo.

## Pré-requisitos

- Conhecimento dos capítulos da monografia em [`content/`](monografia.md).
- Leitura prévia de [`01-produto-e-escopo.md`](01-produto-e-escopo.md).

## Conteúdo

### Princípio

A documentação em `artifact-docs/` é a fonte operacional viva. A monografia em `content/cap*.tex` resume cientificamente as decisões e evidências. Nada de texto da monografia é copiado para `artifact-docs/`; o que vai para o TCC é uma síntese aprovada pelo autor.

### Mapa documento → capítulo

| Bloco em `artifact-docs/` | Capítulo LaTeX | Conteúdo que alimenta o capítulo |
|--------------------------|----------------|----------------------------------|
| [`01-produto-e-escopo.md`](01-produto-e-escopo.md) | [`content/cap1-introducao.tex`](monografia.md) | Objetivo geral, escopo, definição de erro estrutural. |
| [`02-arquitetura-negocio.md`](02-arquitetura-negocio.md) | [`content/cap1-introducao.tex`](monografia.md) (arquitetura de alto nível) | Blocos de negócio e contratos macro. |
| [`03-arquitetura-aplicacao/visao-logica.md`](03-arquitetura-aplicacao/visao-logica.md) | [`content/cap4-metodologia.tex`](monografia.md) (camadas e fluxo) | Camadas, casos de uso, padrões. |
| [`03-arquitetura-aplicacao/modelo-dominio.md`](03-arquitetura-aplicacao/modelo-dominio.md) | [`content/cap4-metodologia.tex`](monografia.md) | DDD + SOLID. |
| [`03-arquitetura-aplicacao/camadas-mcp.md`](03-arquitetura-aplicacao/camadas-mcp.md) | [`content/cap4-metodologia.tex`](monografia.md) (servidor MCP) e [`content/cap6-desenvolvimento.tex`](monografia.md) | Tabela tool → porta → contrato → erro. |
| [`04-arquitetura-dados/banco-putz-dominio.md`](04-arquitetura-dados/banco-putz-dominio.md) | [`content/cap4-metodologia.tex`](monografia.md) (banco de testes) | Domínios e tabelas-âncora do PS. |
| [`04-arquitetura-dados/schema-massa-teste.md`](04-arquitetura-dados/schema-massa-teste.md) | [`content/cap4-metodologia.tex`](monografia.md) (massa de teste) | Subconjunto fixo. |
| [`04-arquitetura-dados/carga-cluster-putz.md`](04-arquitetura-dados/carga-cluster-putz.md) | [`content/cap6-desenvolvimento.tex`](monografia.md) | Ingestão no cluster. |
| [`04-arquitetura-dados/catalogo-atlas.md`](04-arquitetura-dados/catalogo-atlas.md) | [`content/cap4-metodologia.tex`](monografia.md) (Apache Atlas) | Fronteira Atlas vs dicionário físico. |
| [`05-infraestrutura/visao-aws.md`](05-infraestrutura/visao-aws.md) | [`content/cap4-metodologia.tex`](monografia.md) (ambiente laboratorial) | Topologia AWS. |
| [`05-infraestrutura/cluster-hadoop.md`](05-infraestrutura/cluster-hadoop.md) | [`content/cap6-desenvolvimento.tex`](monografia.md) | Matriz Hadoop. |
| [`05-infraestrutura/delta-oci-para-aws.md`](05-infraestrutura/delta-oci-para-aws.md) | [`content/cap6-desenvolvimento.tex`](monografia.md) (limitações e decisões) | Justificativa da topologia AWS. |
| [`05-infraestrutura/vdf-odp-x86.md`](05-infraestrutura/vdf-odp-x86.md) | [`content/cap6-desenvolvimento.tex`](monografia.md) | VDF e adaptações. |
| [`06-implementacao-java/modulos-spring.md`](06-implementacao-java/modulos-spring.md) | [`content/cap6-desenvolvimento.tex`](monografia.md) | Estrutura de pacotes. |
| [`06-implementacao-java/ports-adapters.md`](06-implementacao-java/ports-adapters.md) | [`content/cap6-desenvolvimento.tex`](monografia.md) | Portas/adaptadores. |
| [`07-contratos-mcp/contracts-v1.md`](07-contratos-mcp/contracts-v1.md) | [`content/cap4-metodologia.tex`](monografia.md) (MCP) e [`content/cap6-desenvolvimento.tex`](monografia.md) | Contratos JSON. |
| [`08-experimento-avaliacao/protocolo-avaliacao.md`](08-experimento-avaliacao/protocolo-avaliacao.md) | [`content/cap4-metodologia.tex`](monografia.md) (protocolo) e [`content/cap7-resultados.tex`](monografia.md) | Métricas e desfechos. |
| [`08-experimento-avaliacao/runbook-reprodutibilidade.md`](08-experimento-avaliacao/runbook-reprodutibilidade.md) | [`content/cap4-metodologia.tex`](monografia.md) (registro experimental) | Identificadores e metadados. |
| [`08-experimento-avaliacao/llm-inferencia-e-prompts.md`](08-experimento-avaliacao/llm-inferencia-e-prompts.md) | [`content/cap4-metodologia.tex`](monografia.md) (§ Registro Experimental) | Hiperparâmetros LLM, prompts e `context.json`. |
| [`09-operacao.md`](09-operacao.md) | [`content/cap6-desenvolvimento.tex`](monografia.md) | Operação. |
| [`roadmap-5a6-meses.md`](roadmap-5a6-meses.md) | Cronograma do TCC (capítulo introdutório ou apêndice). | Marcos e gates. |
| [`adr/ADR-0001-fundacao-arquitetural.md`](adr/ADR-0001-fundacao-arquitetural.md) | [`content/cap4-metodologia.tex`](monografia.md) | Decisão arquitetural. |
| [`adr/ADR-0002-topologia-aws-cluster-minimo.md`](adr/ADR-0002-topologia-aws-cluster-minimo.md) | [`content/cap6-desenvolvimento.tex`](monografia.md) | Topologia AWS mínima. |
| [`adr/ADR-0003-inferencia-llm-deterministica.md`](adr/ADR-0003-inferencia-llm-deterministica.md) | [`content/cap4-metodologia.tex`](monografia.md) (§ Registro Experimental) | Política `temperature=0` e paridade de prompts. |

### Regra de manutenção

Cada mudança neste pacote que afete uma narrativa do TCC deve registrar:

- a versão do documento alterado;
- o capítulo LaTeX impactado;
- se há necessidade de ADR.

## Próximo passo

[`roadmap-5a6-meses.md`](roadmap-5a6-meses.md)
