# Operação

## Propósito

Reunir, num único lugar, o ciclo operacional do TCC: como rodar uma corrida, onde guardar evidências, como recuperar de falhas comuns e qual a política de retenção.

## Leitor

Pessoa que executa o ambiente e arquiva evidências.

## Pré-requisitos

- [`08-experimento-avaliacao/runbook-reprodutibilidade.md`](08-experimento-avaliacao/runbook-reprodutibilidade.md)
- [`08-experimento-avaliacao/protocolo-avaliacao.md`](08-experimento-avaliacao/protocolo-avaliacao.md)
- [`05-infraestrutura/cluster-hadoop.md`](05-infraestrutura/cluster-hadoop.md)

## Conteúdo

### Ciclo de uma corrida

1. Subir o cluster (ou validar que está estável).
2. Validar Atlas: tools MCP retornam o subconjunto PS (92 tabelas) esperado.
3. Gerar `runId` no formato `run-YYYYMMDD-HHMM-<id-curto>` (ver runbook).
4. Registrar `context.json` com metadados completos (ver [`evidence/context-schema-v1.json`](../evidence/context-schema-v1.json) e [`08-experimento-avaliacao/llm-inferencia-e-prompts.md`](08-experimento-avaliacao/llm-inferencia-e-prompts.md)): `runId`, `seed`, `modelVersion`, `provider`, `promptVersion`, `inferenceConfig`, `promptArtifactsHash`, `commitHash`, `datasetVersion`, `contractsVersion`.
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

Convenções e exigências mínimas estão em [`evidence/README.md`](../evidence/README.md) e [`08-experimento-avaliacao/runbook-reprodutibilidade.md`](08-experimento-avaliacao/runbook-reprodutibilidade.md).

### Política de retenção

- Nunca sobrescrever evidências de uma corrida.
- Correções implicam nova corrida com novo `runId`.
- Backup periódico do diretório `evidence/` (TBD: definir destino).

### Templates suportados

| Cenário | Template |
|---------|----------|
| Relatório de corrida | [`templates/run-report-template.md`](../templates/run-report-template.md) |
| Templates de prompt LLM | [`templates/prompts/prompts-manifest-v1.json`](../templates/prompts/prompts-manifest-v1.json) |
| Incidente operacional | [`templates/incident-template.md`](../templates/incident-template.md) |
| Revisão metodológica | [`templates/review-metodologico-template.md`](../templates/review-metodologico-template.md) |
| ADR | [`templates/adr-template.md`](../templates/adr-template.md) |

### Falhas comuns e recuperação

| Sintoma | Causa provável | Ação |
|---------|----------------|------|
| Tool MCP retorna `catalog_unavailable` | Atlas indisponível ou reinicialização do cluster | Validar status do Atlas; aplicar retry conforme política do servidor MCP. |
| Tool MCP retorna `not_found` para tabela do subconjunto | Registro Atlas incompleto após reingestão | Reexecutar carga (`carga-cluster-putz.md`) e reabrir corrida. |
| SQL executa mas com `execution_error` recorrente | Hive Metastore inconsistente | Validar schema do Hive contra o subconjunto PS (92 tabelas). |
| `runId` duplicado | Erro humano no template | Abortar corrida e gerar novo `runId`. |

### Custos e desligamento

- Ambiente AWS de estudo: desligar instâncias EC2 fora das corridas.
- TBD: definir orçamento mensal alvo no roadmap.

## Próximo passo

[`10-rastreabilidade-academica.md`](10-rastreabilidade-academica.md)
