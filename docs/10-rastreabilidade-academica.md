# Rastreabilidade académica

!!! info "Recomendado para leitura prévia"
    - **[Glossário de anonimização](00-glossario-anonimizacao.md)** — vocabulário genérico obrigatório.
    - **[Produto e escopo](01-produto-e-escopo.md)** — artefato, recorte metodológico e decisões de ambiente.


### Princípio

Este repositório publica apenas documentação operacional **anonimizada**. A documentação académica externa LaTeX/PDF, evidências identificáveis e o export relacional completo permanecem offline, sob custódia do pesquisador na instituição federal de ensino superior.

### Mapa doc → capítulo (referência genérica)

| Bloco operacional | Capítulo académico (externo) | Conteúdo |
|-------------------|------------------------------|----------|
| [Produto e escopo](01-produto-e-escopo.md) | Introdução | Objetivo, escopo, erro estrutural |
| [Arquitetura de negócio](02-arquitetura-negocio.md) | Introdução / metodologia | Blocos e contratos macro |
| [Visão lógica](03-arquitetura-aplicacao/visao-logica.md) | Metodologia | Camadas, MCP, fluxo |
| [Banco laboratorial](04-arquitetura-dados/banco-laboratorio-dominio.md) | Metodologia | Massa laboratorial anonimizada |
| [Visão AWS](05-infraestrutura/visao-aws.md) | Metodologia / desenvolvimento | Cluster AWS |
| [Contratos MCP v1](07-contratos-mcp/contracts-v1.md) | Desenvolvimento | Contratos MCP v1 |
| [Protocolo de avaliação](08-experimento-avaliacao/protocolo-avaliacao.md) | Metodologia / resultados | Protocolo e métricas |
| [Evidências experimentais](evidence/README.md) | Resultados | Corridas e bateria |

### Regras

- Não copiar texto da documentação académica externa para este site.
- Alterações operacionais relevantes exigem ADR e, quando aplicável, atualização da documentação académica externa.
- Identificadores opacos publicados aqui **não** devem ser revertidos para nomes reais neste repositório.

!!! tip "Recomendado para leitura posterior"
    Seguinte: **[Índice de ADRs](adr/README.md)** — decisões arquiteturais registradas.
