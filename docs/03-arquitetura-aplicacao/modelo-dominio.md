# Modelo de domínio (DDD + SOLID)

## Propósito

Descrever o vocabulário tático e estratégico do artefato (bounded contexts, agregados, portas) que sustenta o pipeline Text-to-SQL e a aplicação de SOLID.

## Leitor

Pessoa desenvolvedora Java júnior responsável pela implementação dos casos de uso e adapters.

## Pré-requisitos

- [`visao-logica.md`](visao-logica.md) (camadas e fluxo)
- [`../02-arquitetura-negocio.md`](../02-arquitetura-negocio.md) (responsabilidades de bloco)

## Conteúdo

### DDD estratégico: bounded contexts

- **QuestionIntakeContext**: normaliza pergunta e contexto de sessão.
- **MetadataDiscoveryContext**: consulta catálogo via tools MCP.
- **SqlSynthesisContext**: transforma contexto de metadados em SQL candidato.
- **SqlValidationExecutionContext**: valida, executa e classifica desfecho.
- **ExperimentTrackingContext**: registra trilha da sessão e calcula métricas.

### Context map

- `QuestionIntakeContext -> MetadataDiscoveryContext` (upstream/downstream).
- `MetadataDiscoveryContext -> SqlSynthesisContext` (conformist, contrato MCP versionado).
- `SqlSynthesisContext -> SqlValidationExecutionContext` (published language: `SqlCandidate`).
- `SqlValidationExecutionContext -> ExperimentTrackingContext` (eventos e métricas).

### DDD tático

#### Agregados

- `QuerySessionAggregate`: ciclo de vida da sessão, orçamento de tools e estado da corrida.
- `SqlAttemptAggregate`: tentativa de SQL, validação, execução e classificação final.

#### Entidades

- `QuerySession`
- `ToolCall`
- `MetadataSnapshot`
- `SqlCandidate`
- `ExecutionResult`
- `RunRecord`

#### Objetos de valor

- `RunId`
- `ModelVersion`
- `Seed`
- `CommitHash`
- `ToolBudget`
- `StructuralError`

#### Serviços de domínio

- `StructuralAdherenceService`
- `ToolBudgetPolicyService`
- `TraceCompletenessService`

### Aplicação de SOLID

- **SRP**: cada adapter integra um único sistema externo.
- **OCP**: novas tools MCP entram por extensão de contrato.
- **LSP**: implementações de `MetadataProviderPort` respeitam semântica canônica.
- **ISP**: interfaces curtas por propósito (`MetadataLookupPort`, `SqlParsePort`, `RunEvidencePort`).
- **DIP**: casos de uso dependem de portas, não de adapters concretos.

### Convenção de pacotes (Spring Boot)

- `com.tcc.text2sql.application`
- `com.tcc.text2sql.domain`
- `com.tcc.text2sql.ports`
- `com.tcc.text2sql.adapters.in`
- `com.tcc.text2sql.adapters.out`
- `com.tcc.text2sql.config`
- `com.tcc.text2sql.observability`

Detalhamento dos pacotes em [`../06-implementacao-java/modulos-spring.md`](../06-implementacao-java/modulos-spring.md) e das portas em [`../06-implementacao-java/ports-adapters.md`](../06-implementacao-java/ports-adapters.md).

## Próximo passo

[`camadas-mcp.md`](camadas-mcp.md)
