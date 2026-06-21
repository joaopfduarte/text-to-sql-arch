# Módulos Spring

## Propósito

Mapear os pacotes Java/Spring do artefato aos bounded contexts e camadas da aplicação.

## Leitor

Pessoa desenvolvedora Java júnior que vai criar ou estender módulos.

## Pré-requisitos

- [`../03-arquitetura-aplicacao/modelo-dominio.md`](../03-arquitetura-aplicacao/modelo-dominio.md)
- [`../03-arquitetura-aplicacao/visao-logica.md`](../03-arquitetura-aplicacao/visao-logica.md)
- [`ports-adapters.md`](ports-adapters.md)

## Conteúdo

### Stack alvo

- Java 25 (LTS).
- Spring Boot 3.x.
- Spring AI com provedores `OpenAI` e `Google` (Gemini), via starters oficiais do ecossistema Spring AI.
- Spring MCP (componente para servidor MCP em Java; ver dependência específica disponível).
- Build com Maven ou Gradle (TBD).

### Estrutura de pacotes (raiz `com.tcc.text2sql`)

| Pacote | Responsabilidade | Camada |
|--------|------------------|--------|
| `com.tcc.text2sql.application` | Casos de uso: `DiscoverMetadataUseCase`, `GenerateSqlUseCase`, `ValidateAndExecuteUseCase`, `RecordRunUseCase`. | Application |
| `com.tcc.text2sql.domain` | Entidades, agregados, value objects, serviços de domínio (`StructuralAdherenceService`, `ToolBudgetPolicyService`, `TraceCompletenessService`). | Domain |
| `com.tcc.text2sql.ports` | Interfaces de entrada e saída (`MetadataLookupPort`, `SqlParsePort`, `SqlExecutionPort`, `RunEvidencePort`, `LlmCompletionPort`). | Domain/Application |
| `com.tcc.text2sql.adapters.in` | Adaptadores de entrada: servidor MCP, REST do orquestrador. Subpacotes `.mcp` e `.rest`. | Infrastructure |
| `com.tcc.text2sql.adapters.out` | Adaptadores de saída: Atlas, Apache Calcite (parse HiveQL), executor JDBC contra Hive, persistência de evidências (FS local ou S3). Subpacotes `.atlas`, `.calcite`, `.jdbc`, `.evidence`. | Infrastructure |
| `com.tcc.text2sql.config` | Configurações Spring (`@Configuration`), beans, properties. | Infrastructure |
| `com.tcc.text2sql.observability` | Logs estruturados, métricas, exportação JSONL. | Infrastructure |

### Mapeamento bounded context → módulos

| Bounded context | Pacote principal |
|------------------|-------------------|
| `QuestionIntakeContext` | `application.intake` |
| `MetadataDiscoveryContext` | `application.metadata` + `adapters.out.atlas` |
| `SqlSynthesisContext` | `application.synthesis` + `adapters.out.llm` |
| `SqlValidationExecutionContext` | `application.validation` + `adapters.out.calcite` + `adapters.out.jdbc` |
| `ExperimentTrackingContext` | `application.tracking` + `adapters.out.evidence` + `observability` |

### Properties principais (sugestão)

| Property | Função |
|----------|--------|
| `app.mcp.tool-budget.default` | Orçamento padrão de chamadas de tool por sessão (valor de referência: **10**). |
| `app.atlas.base-url` | Endpoint do Apache Atlas. |
| `app.atlas.auth.user` / `.password` | Credenciais Atlas via variáveis de ambiente ou vault (nunca em repositório). |
| `app.jdbc.hive.url` | JDBC URL do HiveServer2 (ex.: `jdbc:hive2://master:10000/laboratorio`). |
| `app.calcite.dialect` | Dialeto SQL do Calcite (valor de referência: `hive`). |
| `app.llm.provider` | Provedor ativo por corrida: `openai` ou `google`. |
| `app.llm.openai.model-version` | Versão fixa do modelo OpenAI usada na corrida. |
| `app.llm.google.model-version` | Versão fixa do modelo Google (Gemini) usada na corrida. |
| `app.llm.google.temperature` | Temperatura de decodificação Google (campanha v1: **0**). |
| `app.llm.openai.max-output-tokens` | Limite de tokens de saída OpenAI (v1: **4096**). |
| `app.llm.google.max-output-tokens` | Limite de tokens de saída Google (v1: **4096**). |
| `app.llm.prompt.version` | Versão dos templates de prompt (`v1`). |
| `app.llm.prompt.base-path` | Raiz dos templates ([`../templates/prompts/`](../templates/prompts/)). |
| `app.evidence.base-path` | Caminho/bucket para `evidence/<runId>/`. |
| `app.run-id.template` | Template para geração de `runId`. |

### Observações de organização

- Cada adaptador depende apenas das portas, não de outras camadas.
- Casos de uso são pequenos e orquestram portas; regras ficam em serviços de domínio.
- Logs estruturados (JSONL) emitidos por `observability` com base em eventos do harness.
- A combinação `provider + model-version + datasetVersion + runId` deve ser gravada em `context.json` para reprodutibilidade.
- Hiperparâmetros de inferência e `promptVersion` seguem [`../08-experimento-avaliacao/llm-inferencia-e-prompts.md`](../08-experimento-avaliacao/llm-inferencia-e-prompts.md).

## Próximo passo

[`ports-adapters.md`](ports-adapters.md)
