# Arquitetura de negócio

## Propósito

Identificar os blocos de negócio do artefato Text-to-SQL, suas responsabilidades e os contratos macro entre eles.

## Leitor

Pessoa que precisa entender o que o sistema faz (sem entrar em camadas técnicas ou tecnologia).

## Pré-requisitos

- [`01-produto-e-escopo.md`](01-produto-e-escopo.md)

## Conteúdo

### Atores

| Ator | Papel |
|------|-------|
| Pessoa avaliadora | Submete pergunta em linguagem natural, recebe SQL e desfecho da execução. |
| Operadora de corrida | Configura `runId`, dataset e contratos versionados. |
| Camada semântica e de metadados (catálogo canônico) | Fonte de verdade dos metadados sobre o subconjunto PS (92 tabelas); implementada com Apache Atlas. |
| Banco relacional PS | Fonte dos dados consultáveis (92 tabelas, subconjunto fixo). |

### Blocos de negócio

| Bloco | Responsabilidade |
|-------|------------------|
| Agente/orquestrador LLM | Executa estratégia de tool-use, respeita orçamento de até 10 chamadas por sessão e produz SQL candidato a partir do contexto obtido por MCP. |
| Servidor MCP | Expõe tools com contratos estáveis, aplica validações de entrada e saída e centraliza a integração com o adaptador da camada semântica. |
| Tools MCP | Descoberta de tabelas, detalhamento de colunas e inspeção de relacionamentos. |
| Adaptador da camada semântica | Traduz respostas do catálogo canônico (Apache Atlas) para contrato interno, desacoplando mudanças de API. |
| Catálogo canônico de metadados | Apache Atlas registra entidades técnicas e classificações do subconjunto PS (92 tabelas) exposto. |
| Banco relacional de avaliação | Subconjunto estável do PS (92 tabelas), sem dados sensíveis, residente no cluster. |
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

Ver [`diagrams/diagrama-mestre.puml`](diagrams/diagrama-mestre.puml).

### Fronteira deste documento

Este documento descreve o "o quê" do sistema. O "como" (camadas, padrões, tecnologia) está em [`03-arquitetura-aplicacao/visao-logica.md`](03-arquitetura-aplicacao/visao-logica.md) e o vocabulário de domínio em [`03-arquitetura-aplicacao/modelo-dominio.md`](03-arquitetura-aplicacao/modelo-dominio.md).

## Próximo passo

[`03-arquitetura-aplicacao/visao-logica.md`](03-arquitetura-aplicacao/visao-logica.md)
