# Arquitetura de negócio

!!! info "Recomendado para leitura prévia"
    - **[Produto e escopo](../produto/escopo.md)** — artefato, recorte metodológico e decisões de ambiente.


### Atores

| Ator | Papel |
|------|-------|
| Pessoa avaliadora | Submete pergunta em linguagem natural, recebe SQL e desfecho da execução. |
| Operadora de corrida | Configura `runId`, dataset e contratos versionados. |
| Camada semântica e de metadados (catálogo canônico) | Fonte de verdade dos metadados sobre o subconjunto laboratorial (92 tabelas); implementada com Apache Atlas. |
| Banco relacional subconjunto laboratorial | Fonte dos dados consultáveis (92 tabelas, subconjunto fixo). |

### Blocos de negócio

| Bloco | Responsabilidade |
|-------|------------------|
| Agente/orquestrador LLM | Executa estratégia de tool-use, respeita orçamento de até 10 chamadas por sessão e produz SQL candidato a partir do contexto obtido por MCP. |
| Servidor MCP | Expõe tools com contratos estáveis, aplica validações de entrada e saída e centraliza a integração com o adaptador da camada semântica. |
| Tools MCP | Descoberta de tabelas, detalhamento de colunas e inspeção de relacionamentos. |
| Adaptador da camada semântica | Traduz respostas do catálogo canônico (Apache Atlas) para contrato interno, desacoplando mudanças de API. |
| Catálogo canônico de metadados | Apache Atlas registra entidades técnicas e classificações do subconjunto laboratorial (92 tabelas) exposto. |
| Banco relacional de avaliação | Subconjunto estável do subconjunto laboratorial (92 tabelas), sem dados sensíveis, residente no cluster. |
| Validador e executor SQL | Parse sintático via **Apache Calcite** (dialeto Hive), validação estrutural contra catálogo canônico e execução controlada em Hive com classificação de erro. |
| Harness experimental | Registra trilha completa por corrida, calcula métricas essenciais e consolida evidências em JSONL. |

### Contratos macro entre blocos

| Contrato | Origem -> Destino | Conteúdo |
|----------|-------------------|----------|
| `QuestionIntake -> MetadataDiscovery` | Edge -> Aplicação | Pergunta normalizada e contexto da sessão. |
| `MetadataDiscovery -> SqlSynthesis` | Aplicação -> Aplicação | Snapshot de metadados canônicos. |
| `SqlSynthesis -> ValidationExecution` | Aplicação -> Aplicação | SQL candidato com metadados de geração. |
| `ValidationExecution -> ExperimentTracking` | Aplicação -> Observabilidade | Resultado de parse, execução e classificação. |

### Diagrama lógico

![Diagrama mestre](../diagrams/diagrama-mestre.svg){ .uml-diagram width="100%" }

Fonte: [Diagrama mestre — fluxo lógico](../diagrams/diagrama-mestre.svg)

### Fronteira deste documento

Este documento descreve o "o quê" do sistema. O "como" (camadas, padrões, tecnologia) está em [Visão lógica](aplicacao/visao-logica.md) e o vocabulário de domínio em [Modelo de domínio](aplicacao/modelo-dominio.md).

!!! tip "Recomendado para leitura posterior"
    Seguinte: **[Visão lógica](aplicacao/visao-logica.md)** — camadas, fluxo operacional e zonas de rede.
