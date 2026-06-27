# Módulos Spring

!!! info "Recomendado para leitura prévia"
    - **[Modelo de domínio](../arquitetura/aplicacao/modelo-dominio.md)** — bounded contexts e agregados.
    - **[Visão lógica](../arquitetura/aplicacao/visao-logica.md)** — camadas, fluxo operacional e zonas de rede.
    - **[Ports e adapters](ports-adapters.md)** — portas hexagonais e adaptadores.
    - **[ADR-0005 Convenção Maven](../adr/ADR-0005-convencao-maven-pacotes-producao.md)** — decisão de `groupId`, pacote raiz e identity.


### Stack alvo

- Java 25 (LTS).
- Spring Boot 4.1.0.
- Spring AI com provedores `OpenAI` e `Google` (Gemini), via starters oficiais do ecossistema Spring AI.
- Spring MCP Server e Spring MCP Client (starters `spring-ai-mcp-server`, `spring-ai-mcp-client`).
- Build com **Maven** (geração base via [Spring Initializr](https://start.spring.io)).

### Coordenadas Maven (Spring Initializr)

| Campo | Valor |
|-------|-------|
| Group | `br.com.text2sql` |
| Artifact | `api` |
| Name | `text2sql-api` |
| Package name | `br.com.text2sql.api` |
| Packaging | Jar |
| Java | 25 |
| Spring Boot | 4.1.0 |

Classe principal: `br.com.text2sql.api.Text2sqlApiApplication`.

Dependências essenciais no Initializr (além do núcleo acima):

| Categoria | Dependências (IDs Initializr) |
|-----------|-------------------------------|
| Web | `web`, `spring-restclient` |
| SQL (experimento + identity) | `jdbc`, `data-jpa`, `postgresql`, `flyway` |
| Segurança | `security` |
| I/O | `validation` |
| Ops | `actuator` |
| Testes | `testcontainers` |
| AI | `spring-ai-mcp-server`, `spring-ai-mcp-client`, `spring-ai-openai`, `spring-ai-google-genai` |

Dependências manuais no `pom.xml` (fora do Initializr): `calcite-core` (dialeto Hive), `hive-jdbc`
(executor no cluster ODP).

### Estrutura de pacotes (raiz `br.com.text2sql.api`)

| Pacote | Responsabilidade | Camada |
|--------|------------------|--------|
| `br.com.text2sql.api.application` | Casos de uso: `DiscoverMetadataUseCase`, `GenerateSqlUseCase`, `ValidateAndExecuteUseCase`, `RecordRunUseCase`. | Application |
| `br.com.text2sql.api.domain` | Entidades, agregados, value objects, serviços de domínio (`StructuralAdherenceService`, `ToolBudgetPolicyService`, `TraceCompletenessService`). | Domain |
| `br.com.text2sql.api.ports` | Interfaces de entrada e saída (`MetadataLookupPort`, `SqlParsePort`, `SqlExecutionPort`, `RunEvidencePort`, `LlmCompletionPort`). | Domain/Application |
| `br.com.text2sql.api.adapters.in` | Adaptadores de entrada: servidor MCP, REST do orquestrador. Subpacotes `.mcp` e `.rest`. | Infrastructure |
| `br.com.text2sql.api.adapters.out` | Adaptadores de saída: Atlas, Apache Calcite (parse HiveQL), executor JDBC contra Hive, persistência de evidências (FS local ou S3). Subpacotes `.atlas`, `.calcite`, `.jdbc`, `.evidence`. | Infrastructure |
| `br.com.text2sql.api.config` | Configurações Spring (`@Configuration`), beans, properties. | Infrastructure |
| `br.com.text2sql.api.observability` | Logs estruturados, métricas, exportação JSONL. | Infrastructure |

### Bounded context Identity

Autenticação de operadores da API pública (`api.text2sql.com.br`). Persistência em **PostgreSQL local**,
isolada da massa experimental Hive/Atlas. Pacotes sob `br.com.text2sql.api.identity`:

| Pacote | Responsabilidade |
|--------|------------------|
| `identity.domain` | Entidades `User`, `Role`; regras de credencial. |
| `identity.application` | `AuthenticateUserUseCase`, `RegisterUserUseCase` (planejados). |
| `identity.ports` | `AuthApiPort`, `UserRepositoryPort`. |
| `identity.adapters.in.rest` | Endpoints `/api/v1/auth/*`. |
| `identity.adapters.out.jpa` | Repositório JPA + Flyway (`users`, `user_roles`). |

### Mapeamento bounded context → módulos

Caminhos **relativos** à raiz `br.com.text2sql.api`:

| Bounded context | Pacote principal |
|------------------|-------------------|
| `QuestionIntakeContext` | `application.intake` |
| `MetadataDiscoveryContext` | `application.metadata` + `adapters.out.atlas` |
| `SqlSynthesisContext` | `application.synthesis` + `adapters.out.llm` |
| `SqlValidationExecutionContext` | `application.validation` + `adapters.out.calcite` + `adapters.out.jdbc` |
| `ExperimentTrackingContext` | `application.tracking` + `adapters.out.evidence` + `observability` |
| `IdentityContext` | `identity.application` + `identity.adapters.out.jpa` |

### Deploy

| Item | Valor |
|------|-------|
| Domínio público | `text2sql.com.br` |
| API REST | `https://api.text2sql.com.br` |
| Property sugerida | `app.public.base-url` = `https://api.text2sql.com.br` |
| CORS (frontend) | `https://text2sql.com.br`, `https://www.text2sql.com.br` |

Configuração de proxy reverso (TLS, `X-Forwarded-*`) em `config`; ver [Visão AWS](../infraestrutura/visao-aws.md).

### Properties principais (sugestão)

| Property | Função |
|----------|--------|
| `app.public.base-url` | URL pública da API (`https://api.text2sql.com.br`). |
| `app.public.allowed-origins` | Origens CORS permitidas para o frontend. |
| `app.mcp.tool-budget.default` | Orçamento padrão de chamadas de tool por sessão (valor de referência: **10**). |
| `app.atlas.base-url` | Endpoint do Apache Atlas. |
| `app.atlas.auth.user` / `.password` | Credenciais Atlas via variáveis de ambiente ou vault (nunca versionadas no código-fonte). |
| `app.jdbc.hive.url` | JDBC URL do HiveServer2 (ex.: `jdbc:hive2://master:10000/laboratorio`). |
| `app.calcite.dialect` | Dialeto SQL do Calcite (valor de referência: `hive`). |
| `app.llm.provider` | Provedor ativo por corrida: `openai` ou `google`. |
| `app.llm.openai.model-version` | Versão fixa do modelo OpenAI usada na corrida. |
| `app.llm.google.model-version` | Versão fixa do modelo Google (Gemini) usada na corrida. |
| `app.llm.google.temperature` | Temperatura de decodificação Google (campanha v1: **0**). |
| `app.llm.openai.max-output-tokens` | Limite de tokens de saída OpenAI (v1: **4096**). |
| `app.llm.google.max-output-tokens` | Limite de tokens de saída Google (v1: **4096**). |
| `app.llm.prompt.version` | Versão dos templates de prompt (`v1`). |
| `app.llm.prompt.base-path` | Raiz dos templates ([Manifesto de prompts v1](../templates/prompts/prompts-manifest-v1.json)). |
| `app.evidence.base-path` | Caminho/bucket para `evidence/<runId>/`. |
| `app.run-id.template` | Template para geração de `runId`. |
| `spring.datasource.url` | JDBC PostgreSQL para identity (ex.: `jdbc:postgresql://localhost:5432/text2sql_identity`). |

### Observações de organização

- Cada adaptador depende apenas das portas, não de outras camadas.
- Casos de uso são pequenos e orquestram portas; regras ficam em serviços de domínio.
- Logs estruturados (JSONL) emitidos por `observability` com base em eventos do harness.
- A combinação `provider + model-version + datasetVersion + runId` deve ser gravada em `context.json` para reprodutibilidade.
- Hiperparâmetros de inferência e `promptVersion` seguem [Inferência e prompts](../experimento/llm-inferencia-e-prompts.md).
- PostgreSQL (identity) e Hive (experimento) são stores distintos; não compartilham esquema.

!!! tip "Recomendado para leitura posterior"
    Seguinte: **[Ports e adapters](ports-adapters.md)** — portas hexagonais e adaptadores.
