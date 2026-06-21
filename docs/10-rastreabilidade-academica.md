# Rastreabilidade acadêmica

!!! info "Recomendado para leitura prévia"
    - **[Produto e escopo](01-produto-e-escopo.md)** — artefato, recorte metodológico e decisões de ambiente.


### Princípio

Os blocos operacionais abaixo alimentam a documentação acadêmica (LaTeX/PDF), mantida offline pelo pesquisador na instituição federal de ensino superior. Evidências identificáveis e o export relacional completo permanecem sob custódia do pesquisador.

### Mapa doc → capítulo (referência genérica)

| Bloco operacional | Capítulo acadêmico (externo) | Conteúdo |
|-------------------|------------------------------|----------|
| [Produto e escopo](01-produto-e-escopo.md) | Introdução | Objetivo, escopo, erro estrutural |
| [Arquitetura de negócio](02-arquitetura-negocio.md) | Introdução / metodologia | Blocos e contratos macro |
| [Visão lógica](03-arquitetura-aplicacao/visao-logica.md) | Metodologia | Camadas, MCP, fluxo |
| [Banco laboratorial](04-arquitetura-dados/banco-laboratorio-dominio.md) | Metodologia | Massa laboratorial |
| [Visão AWS](05-infraestrutura/visao-aws.md) | Metodologia / desenvolvimento | Cluster AWS |
| [Contratos MCP v1](07-contratos-mcp/contracts-v1.md) | Desenvolvimento | Contratos MCP v1 |
| [Protocolo de avaliação](08-experimento-avaliacao/protocolo-avaliacao.md) | Metodologia / resultados | Protocolo e métricas |
| [Evidências experimentais](evidence/README.md) | Resultados | Corridas e bateria |

### Regras

- Não copiar texto integral da documentação acadêmica para blocos operacionais.
- Alterações operacionais relevantes exigem ADR e, quando aplicável, atualização da documentação acadêmica.

!!! tip "Recomendado para leitura posterior"
    Seguinte: **[Índice de ADRs](adr/README.md)** — decisões arquiteturais registradas.
