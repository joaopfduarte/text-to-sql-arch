# Operação

!!! info "Recomendado para leitura prévia"
    - **[Runbook de reprodutibilidade](08-experimento-avaliacao/runbook-reprodutibilidade.md)** — passos para repetir uma corrida com evidências.
    - **[Protocolo de avaliação](08-experimento-avaliacao/protocolo-avaliacao.md)** — desenho experimental, bateria e critérios de desfecho.
    - **[Cluster Hadoop](05-infraestrutura/cluster-hadoop.md)** — serviços ODP, sizing e operação.


### Ciclo de uma corrida

1. Subir o cluster (ou validar que está estável).
2. Validar Atlas: tools MCP retornam o subconjunto laboratorial (92 tabelas) esperado.
3. Gerar `runId` no formato `run-YYYYMMDD-HHMM-<id-curto>` (ver runbook).
4. Registrar `context.json` com metadados completos (ver [Schema context.json v1](evidence/context-schema-v1.json) e [Inferência e prompts](08-experimento-avaliacao/llm-inferencia-e-prompts.md)): `runId`, `seed`, `modelVersion`, `provider`, `promptVersion`, `inferenceConfig`, `promptArtifactsHash`, `commitHash`, `datasetVersion`, `contractsVersion`.
5. Executar a bateria de perguntas do harness.
6. Coletar `session.jsonl`, `metrics.json` e `summary.md` em `evidence/<runId>/`.
7. Encerrar/desligar recursos não necessários para reduzir custo.

### Pasta de evidência

```
evidence/
  run-YYYYMMDD-HHMM-<id-curto>/
    session.jsonl
    metrics.json
    context.json
    summary.md
```

Convenções e exigências mínimas estão em [Evidências experimentais](evidence/README.md) e [Runbook de reprodutibilidade](08-experimento-avaliacao/runbook-reprodutibilidade.md).

### Política de retenção

- Nunca sobrescrever evidências de uma corrida.
- Correções implicam nova corrida com novo `runId`.
- Backup periódico do diretório `evidence/` (TBD: definir destino).

### Templates suportados

| Cenário | Template |
|---------|----------|
| Relatório de corrida | [Template de relatório de corrida](templates/run-report-template.md) |
| Templates de prompt LLM | [Manifesto de prompts v1](templates/prompts/prompts-manifest-v1.json) |
| Incidente operacional | [Template de incidente](templates/incident-template.md) |
| Revisão metodológica | [Template de revisão metodológica](templates/review-metodologico-template.md) |
| ADR | [Template de ADR](templates/adr-template.md) |

### Falhas comuns e recuperação

| Sintoma | Causa provável | Ação |
|---------|----------------|------|
| Tool MCP retorna `catalog_unavailable` | Atlas indisponível ou reinicialização do cluster | Validar status do Atlas; aplicar retry conforme política do servidor MCP. |
| Tool MCP retorna `not_found` para tabela do subconjunto | Registro Atlas incompleto após reingestão | Reexecutar carga (`carga-cluster-laboratorio.md`) e reabrir corrida. |
| SQL executa mas com `execution_error` recorrente | Hive Metastore inconsistente | Validar schema do Hive contra o subconjunto laboratorial (92 tabelas). |
| `runId` duplicado | Erro humano no template | Abortar corrida e gerar novo `runId`. |

### Custos e desligamento

- Ambiente AWS de estudo: desligar instâncias EC2 fora das corridas.
- TBD: definir orçamento mensal alvo no roadmap.

!!! tip "Recomendado para leitura posterior"
    Seguinte: **[Rastreabilidade académica](10-rastreabilidade-academica.md)** — relação com a documentação académica externa.
