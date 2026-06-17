# Visão lógica da aplicação

## Propósito

Descrever camadas, casos de uso, fluxo operacional e padrões de engenharia da aplicação Java que orquestra o pipeline Text-to-SQL.

## Leitor

Pessoa desenvolvedora Java júnior que irá implementar ou estender a aplicação.

## Pré-requisitos

- [`../02-arquitetura-negocio.md`](../02-arquitetura-negocio.md)
- [`modelo-dominio.md`](modelo-dominio.md)

## Conteúdo

### Objetivo arquitetural

Construir um pipeline `Text-to-SQL` reprodutível que consulte metadados por `MCP` antes da geração de SQL, com validação estrutural, execução controlada e rastreabilidade completa por corrida.

### Camadas

| Camada | Responsabilidade |
|--------|------------------|
| Edge/API | Recebe a pergunta, valida entrada e gera `runId`. |
| Application | Executa os casos de uso `DiscoverMetadata`, `GenerateSql`, `ValidateAndExecute`, `RecordRun`. |
| Domain | Aplica regras de aderência estrutural, orçamento de tool calls e critérios de rastreabilidade. |
| Infrastructure | Adapters para `MCP`, `Atlas`, Apache Calcite (parse HiveQL), banco PS (Hive) e persistência de evidências. |
| Observability | Trilhas JSONL, métricas essenciais e metadados de reprodutibilidade. |

### Casos de uso principais

- `DiscoverMetadataUseCase`: consulta tools MCP sob orçamento.
- `GenerateSqlUseCase`: pede ao LLM o SQL candidato com base no snapshot de metadados.
- `ValidateAndExecuteUseCase`: parse sintático via Apache Calcite (dialeto Hive), validação estrutural e execução controlada.
- `RecordRunUseCase`: consolida trilha JSONL e métricas.

### Fluxo operacional (passo a passo)

1. Pergunta em linguagem natural chega ao Edge.
2. Descoberta dirigida de metadados por tools MCP.
3. Geração de SQL ancorada no contexto recuperado.
4. Validação sintática via Apache Calcite (dialeto Hive) e validação estrutural.
5. Execução controlada no subconjunto PS (92 tabelas).
6. Registro de trilha e cálculo de métricas.

Diagrama: [`../diagrams/diagrama-mestre.puml`](../diagrams/diagrama-mestre.puml).

### Zonas lógicas de rede

| Zona lógica | Componentes | Política |
|-------------|-------------|----------|
| `NetPublic` | Entrada HTTP do orquestrador. | Único ponto de entrada externo. |
| `NetInternalApp` | Aplicação, MCP, adaptadores. | Tráfego privado, `deny by default` para fora. |
| `NetDataPlane` | Apache Atlas, banco PS no cluster. | Acessível apenas pelo validador/executor e pelo adaptador Atlas. |
| `NetObservability` | Armazenamento de evidências e métricas. | Escrita por `runId`, sem sobrescrita. |

Diagrama lógico: [`../diagrams/rede-implantacao.puml`](../diagrams/rede-implantacao.puml). Para a tradução física para AWS, ver [`../05-infraestrutura/visao-aws.md`](../05-infraestrutura/visao-aws.md).

### Padrões de engenharia

- Arquitetura hexagonal por contexto (`ports and adapters`).
- Contratos MCP versionados semanticamente.
- Timeouts e retry com backoff para integrações externas.
- Falhas classificadas em `syntax_error`, `structural_error`, `execution_error`.
- Servidor MCP nunca acessa o banco PS; apenas o validador/executor.

## Próximo passo

[`camadas-mcp.md`](camadas-mcp.md)
