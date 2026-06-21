# Rastreabilidade académica

## Propósito

Indicar como a documentação operacional deste repositório se relaciona com a redação académica do TCC, mantida **fora** deste git.

## Leitor

Pesquisador responsável por alinhar execução técnica e narrativa científica.

## Pré-requisitos

- [`00-glossario-anonimizacao.md`](00-glossario-anonimizacao.md)
- [`01-produto-e-escopo.md`](01-produto-e-escopo.md)

## Conteúdo

### Princípio

Este repositório publica apenas documentação operacional **anonimizada**. A documentação académica externa LaTeX/PDF, evidências identificáveis e o export relacional completo permanecem offline, sob custódia do pesquisador na instituição federal de ensino superior.

### Mapa doc → capítulo (referência genérica)

| Bloco operacional | Capítulo académico (externo) | Conteúdo |
|-------------------|------------------------------|----------|
| [`01-produto-e-escopo.md`](01-produto-e-escopo.md) | Introdução | Objetivo, escopo, erro estrutural |
| [`02-arquitetura-negocio.md`](02-arquitetura-negocio.md) | Introdução / metodologia | Blocos e contratos macro |
| [`03-arquitetura-aplicacao/`](03-arquitetura-aplicacao/visao-logica.md) | Metodologia | Camadas, MCP, fluxo |
| [`04-arquitetura-dados/`](04-arquitetura-dados/banco-laboratorio-dominio.md) | Metodologia | Massa laboratorial anonimizada |
| [`05-infraestrutura/`](05-infraestrutura/visao-aws.md) | Metodologia / desenvolvimento | Cluster AWS |
| [`07-contratos-mcp/`](07-contratos-mcp/contracts-v1.md) | Desenvolvimento | Contratos MCP v1 |
| [`08-experimento-avaliacao/`](08-experimento-avaliacao/protocolo-avaliacao.md) | Metodologia / resultados | Protocolo e métricas |
| [`evidence/`](evidence/README.md) | Resultados | Corridas e bateria |

### Regras

- Não copiar texto da documentação académica externa para este site.
- Alterações operacionais relevantes exigem ADR e, quando aplicável, atualização da documentação académica externa.
- Identificadores opacos publicados aqui **não** devem ser revertidos para nomes reais neste repositório.

## Próximo passo

[`adr/README.md`](adr/README.md)
