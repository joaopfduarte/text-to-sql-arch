# Modelo de domínio (DDD + SOLID)

!!! info "Recomendado para leitura prévia"
    - **[Visão lógica](visao-logica.md)** — camadas e fluxo.
    - **[Arquitetura de negócio](../negocio.md)** — responsabilidades de bloco.


### DDD estratégico: bounded contexts

- **QuestionIntakeContext**: normaliza pergunta e contexto de sessão.
- **MetadataDiscoveryContext**: consulta a camada semântica e de metadados (catálogo canônico) via tools MCP.
- **SqlSynthesisContext**: transforma contexto de metadados em SQL candidato.
- **SqlValidationExecutionContext**: valida sintaxe via Apache Calcite (dialeto Hive), executa e classifica desfecho.
- **ExperimentTrackingContext**: registra trilha da sessão e calcula métricas.
- **IdentityContext**: autentica operadores da API pública; isolado do experimento Text-to-SQL em
  Hive/Atlas (PostgreSQL local; ver [ADR-0005](../../adr/ADR-0005-convencao-maven-pacotes-producao.md)).

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

Raiz: `br.com.text2sql.api` ([ADR-0005](../../adr/ADR-0005-convencao-maven-pacotes-producao.md)).

- `br.com.text2sql.api.application`
- `br.com.text2sql.api.domain`
- `br.com.text2sql.api.ports`
- `br.com.text2sql.api.adapters.in`
- `br.com.text2sql.api.adapters.out`
- `br.com.text2sql.api.config`
- `br.com.text2sql.api.observability`
- `br.com.text2sql.api.identity` (bounded context Identity)

Detalhamento dos pacotes em [Módulos Spring](../../implementacao/modulos-spring.md) e das portas em [Ports e adapters](../../implementacao/ports-adapters.md).

!!! tip "Recomendado para leitura posterior"
    Seguinte: **[Camadas MCP](camadas-mcp.md)** — mapeamento tool → porta → contrato → erro.
