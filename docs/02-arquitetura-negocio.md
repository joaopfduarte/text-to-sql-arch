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
| Catálogo canônico (Apache Atlas) | Fonte de verdade dos metadados sobre o subconjunto Putz. |
| Banco relacional Putz | Fonte dos dados consultáveis (subconjunto congelado). |

### Blocos de negócio

| Bloco | Responsabilidade |
|-------|------------------|
| Agente/orquestrador LLM | Executa estratégia de tool-use, respeita orçamento de até 6 chamadas por sessão e produz SQL candidato a partir do contexto obtido por MCP. |
| Servidor MCP | Expõe tools com contratos estáveis, aplica validações de entrada e saída e centraliza a integração com o adaptador de catálogo. |
| Tools MCP | Descoberta de tabelas, detalhamento de colunas e inspeção de relacionamentos. |
| Adaptador de catálogo | Traduz respostas do Atlas para contrato interno canônico, desacoplando mudanças de API. |
| Fonte canônica de metadados | Apache Atlas registra entidades técnicas e classificações do subconjunto Putz exposto. |
| Banco relacional de avaliação | Subconjunto congelado do Putz, sem dados sensíveis, residente no cluster. |
| Validador e executor SQL | Parse sintático, validação estrutural contra catálogo e execução controlada com classificação de erro. |
| Harness experimental | Registra trilha completa por corrida, calcula métricas essenciais e consolida evidências em JSONL. |

### Contratos macro entre blocos

| Contrato | Origem -> Destino | Conteúdo |
|----------|-------------------|----------|
| `QuestionIntake -> MetadataDiscovery` | Edge -> Aplicação | Pergunta normalizada e contexto da sessão. |
| `MetadataDiscovery -> SqlSynthesis` | Aplicação -> Aplicação | Snapshot de metadados canônicos. |
| `SqlSynthesis -> ValidationExecution` | Aplicação -> Aplicação | SQL candidato com metadados de geração. |
| `ValidationExecution -> ExperimentTracking` | Aplicação -> Observabilidade | Resultado de parse, execução e classificação. |

### Diagrama lógico

Ver [`../diagrams/diagrama-mestre.mmd`](../diagrams/diagrama-mestre.mmd).

### Fronteira deste documento

Este documento descreve o "o quê" do sistema. O "como" (camadas, padrões, tecnologia) está em [`03-arquitetura-aplicacao/visao-logica.md`](03-arquitetura-aplicacao/visao-logica.md) e o vocabulário de domínio em [`03-arquitetura-aplicacao/modelo-dominio.md`](03-arquitetura-aplicacao/modelo-dominio.md).

## Próximo passo

[`03-arquitetura-aplicacao/visao-logica.md`](03-arquitetura-aplicacao/visao-logica.md)
