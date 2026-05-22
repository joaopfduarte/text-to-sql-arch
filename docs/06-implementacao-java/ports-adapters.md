# Portas e adaptadores (hexagonal)

## Propósito

Listar as portas (interfaces) e os adaptadores concretos da aplicação, deixando explícita a fronteira entre o domínio e as integrações externas.

## Leitor

Pessoa desenvolvedora Java que implementa um adaptador novo ou faz mock para testes.

## Pré-requisitos

- [`modulos-spring.md`](modulos-spring.md)
- [`../03-arquitetura-aplicacao/modelo-dominio.md`](../03-arquitetura-aplicacao/modelo-dominio.md)
- [`../03-arquitetura-aplicacao/camadas-mcp.md`](../03-arquitetura-aplicacao/camadas-mcp.md)

## Conteúdo

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
| `SqlParsePort` | `JSqlParserAdapter` (`adapters.out.sqlparser`) | Biblioteca de parsing SQL. |
| `SqlExecutionPort` | `HiveJdbcAdapter` (`adapters.out.jdbc`) | HiveServer2 (subconjunto Putz). |
| `RunEvidencePort` | `FileSystemEvidenceAdapter` ou `S3EvidenceAdapter` (`adapters.out.evidence`) | Filesystem local ou S3. |
| `MetricsSinkPort` | `JsonlMetricsAdapter` (`observability`) | Arquivo `metrics.json` por corrida. |

O `SpringAiLlmAdapter` seleciona o provider por configuração (`app.llm.provider`) e exige versão explícita por corrida (`app.llm.openai.model-version` ou `app.llm.google.model-version`).

### Decisões de implementação

| Tópico | Decisão / direção |
|--------|---------------------|
| Estilo do servidor MCP | TBD (depende do componente Spring MCP escolhido). |
| Parser SQL | JSqlParser ou Calcite. TBD com base no dialeto Hive. |
| Driver JDBC | `hive-jdbc` oficial para o subconjunto Putz no cluster. |
| Evidências | Filesystem local no MVP; S3 quando habilitarmos. |
| Manifesto de FKs | JSON estático, fonte única alinhada a [`../04-arquitetura-dados/banco-putz-dominio.md`](../04-arquitetura-dados/banco-putz-dominio.md). |

### Testabilidade

- Testes unitários: substituem cada porta por um mock simples.
- Testes de integração: usam Testcontainers (Atlas, Hive) ou mock local fiel (pós-MVP).
- Testes de contrato MCP: validam payloads contra [`../07-contratos-mcp/contracts-v1.md`](../07-contratos-mcp/contracts-v1.md).

## Próximo passo

[`../07-contratos-mcp/contracts-v1.md`](../07-contratos-mcp/contracts-v1.md)
