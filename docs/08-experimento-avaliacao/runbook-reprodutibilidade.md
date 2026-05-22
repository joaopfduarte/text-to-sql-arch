# Runbook de operação e reprodutibilidade

## Propósito

Padronizar identificação, metadados e artefatos de cada corrida para garantir reprodutibilidade.

## Leitor

Pessoa que executa corridas e arquiva evidências em `evidence/`.

## Pré-requisitos

- [`protocolo-avaliacao.md`](protocolo-avaliacao.md)
- [`../07-contratos-mcp/contracts-v1.md`](../07-contratos-mcp/contracts-v1.md) (versão de contrato MCP)

## Conteúdo

### Convenção de identificador

Formato obrigatório:

`run-YYYYMMDD-HHMM-<id-curto>`

Exemplo: `run-20260418-1540-7f3c`.

### Metadados obrigatórios por execução

- `runId`
- `modelVersion`
- `seed`
- `commitHash`
- `datasetVersion`
- `contractsVersion`
- `toolBudget` (limite máximo de chamadas por sessão; valor de referência: **6**)

### Estrutura de evidência

Pasta por corrida:

`evidence/<runId>/`

Arquivos mínimos:

- `session.jsonl` (trilha completa da sessão)
- `metrics.json` (métricas essenciais e secundárias, quando disponível)
- `context.json` (metadados de reprodutibilidade)
- `summary.md` (resultado descritivo da corrida)

### Checklist de reprodutibilidade

1. Commit limpo e registrado.
2. Versão do contrato MCP fixada.
3. Dataset congelado e versionado (subconjunto XPTO indicado em `schema-massa-teste.md`).
4. Seed explícita.
5. Modelo e parâmetros de inferência registrados.
6. Política de tool budget registrada.
7. Evidências salvas em pasta da corrida.

### Política de retenção

- Nunca sobrescrever evidências de corrida.
- Correções devem gerar nova corrida com novo `runId`.

## Próximo passo

[`../09-operacao.md`](../09-operacao.md)
