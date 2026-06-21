# Portas e adaptadores (hexagonal)

!!! info "Recomendado para leitura prévia"
    - **[Módulos Spring](modulos-spring.md)** — estrutura de projetos e dependências.
    - **[Modelo de domínio](../03-arquitetura-aplicacao/modelo-dominio.md)** — bounded contexts e agregados.
    - **[Camadas MCP](../03-arquitetura-aplicacao/camadas-mcp.md)** — mapeamento tool → porta → contrato → erro.


### Convenção

- Portas vivem em `com.tcc.text2sql.ports`.
- Cada porta é uma interface mínima (ISP).
- Adaptadores concretos implementam uma porta cada (SRP) e residem em `adapters.in` ou `adapters.out`.
- Adaptadores nunca dependem uns dos outros; podem depender de bibliotecas externas e da porta correspondente.

### Portas de entrada (driven by external)

| Porta | Adaptador concreto | Sistema externo |
|-------|--------------------|------------------|
| `OrchestratorApiPort` | `RestOrchestratorAdapter` (`adapters.in.rest`) | Cliente HTTP do avaliador. |
| `McpToolGatewayPort` | `SpringMcpServerAdapter` (`adapters.in.mcp`) | Servidor MCP exposto ao agente LLM. |

### Portas de saída (drives external)

| Porta | Adaptador concreto | Sistema externo |
|-------|--------------------|------------------|
| `MetadataLookupPort` | `AtlasMetadataAdapter` (`adapters.out.atlas`) | Apache Atlas via REST API. |
| `RelationshipManifestPort` (opcional) | `JsonManifestAdapter` (`adapters.out.atlas`) | Manifesto local de FKs (quando o Atlas não tem). |
| `LlmCompletionPort` | `SpringAiLlmAdapter` (`adapters.out.llm`) | Provedores LLM via Spring AI (`openai` e `google`). |
| `SqlParsePort` | `CalciteSqlParseAdapter` (`adapters.out.calcite`) | Apache Calcite (dialeto Hive). |
| `SqlExecutionPort` | `HiveJdbcAdapter` (`adapters.out.jdbc`) | HiveServer2 (subconjunto PS, 92 tabelas). |
| `RunEvidencePort` | `FileSystemEvidenceAdapter` ou `S3EvidenceAdapter` (`adapters.out.evidence`) | Filesystem local ou S3. |
| `MetricsSinkPort` | `JsonlMetricsAdapter` (`observability`) | Arquivo `metrics.json` por corrida. |

O `SpringAiLlmAdapter` seleciona o provider por configuração (`app.llm.provider`) e exige versão explícita por corrida (`app.llm.openai.model-version` ou `app.llm.google.model-version`). Deve aplicar a política de inferência v1 (`temperature=0` no Google; omitir `temperature` em GPT-5 nano) e serializar `inferenceConfig`, `promptArtifacts` e `promptArtifactsHash` em `context.json` via `RunEvidencePort` (ver [`../08-experimento-avaliacao/llm-inferencia-e-prompts.md`](../08-experimento-avaliacao/llm-inferencia-e-prompts.md)).

### Decisões de implementação

| Tópico | Decisão / direção |
|--------|---------------------|
| Estilo do servidor MCP | TBD (depende do componente Spring MCP escolhido). |
| Parser SQL | **Apache Calcite** (dialeto Hive). Decisão fechada; ver Cap.~4 (Escolhas Arquiteturais). |
| Driver JDBC | `hive-jdbc` oficial para o subconjunto PS (92 tabelas) no cluster. |
| Evidências | Filesystem local no MVP; S3 quando habilitarmos. |
| Manifesto de FKs | JSON estático alinhado a [`../04-arquitetura-dados/banco-laboratorio-dominio.md`](../04-arquitetura-dados/banco-laboratorio-dominio.md). |

### Testabilidade

- Testes unitários: substituem cada porta por um mock simples.
- Testes de integração: usam Testcontainers (Atlas, Hive) ou mock local fiel (pós-MVP).
- Testes de contrato MCP: validam payloads contra [`../07-contratos-mcp/contracts-v1.md`](../07-contratos-mcp/contracts-v1.md).

!!! tip "Recomendado para leitura posterior"
    Seguinte: **[Contratos MCP v1](../07-contratos-mcp/contracts-v1.md)** — envelope JSON, tools e taxonomia de erro.
