# Protocolo de avaliação experimental

## Propósito

Definir o procedimento experimental de cada corrida e as métricas que sustentam as conclusões do TCC.

## Leitor

Pessoa responsável por executar corridas e consolidar resultados.

## Pré-requisitos

- [`../01-produto-e-escopo.md`](../01-produto-e-escopo.md) (definição de erro estrutural)
- [`../04-arquitetura-dados/schema-massa-teste.md`](../04-arquitetura-dados/schema-massa-teste.md) (massa Putz congelada)
- [`runbook-reprodutibilidade.md`](runbook-reprodutibilidade.md)

## Conteúdo

### Unidade de avaliação

Cada execução da cadeia:

`pergunta -> tools MCP -> SQL final -> validação -> execução -> registro`

### Orçamento de tool calls

- Limite máximo fixado: **6 chamadas por sessão** (equivalente a 6 por pergunta).
- O consumo efetivo é registrado em `metrics.json` e na trilha `session.jsonl`.

### Etapas do protocolo

1. Receber pergunta e inicializar `run id`.
2. Consultar metadados via tools MCP sob orçamento fixado (máximo de 6 chamadas).
3. Gerar SQL candidato.
4. Executar validação sintática (`parse`).
5. Executar validação estrutural contra catálogo canônico (Atlas governa o subconjunto Putz registrado).
6. Executar SQL no banco de testes (subconjunto congelado do Putz).
7. Registrar trilha completa e métricas.

### Métricas essenciais

- **Aderência estrutural ao catálogo**: proporção sem erro estrutural.
- **Executabilidade**: proporção de SQL válido e executável sem exceção.
- **Rastreabilidade**: cobertura de trilha `pergunta -> tools -> metadados -> SQL`.
- **Orçamento de tool calls**: distribuição de chamadas por pergunta sob limite pré-definido de 6 por sessão.

### Métricas secundárias

- tokens (`prompt` e `completion`) quando a API fornecer coleta confiável;
- latência ponta a ponta (`p50`, `p95`).

### Classificação de desfecho

- `success`
- `syntax_error`
- `structural_error`
- `execution_error`

### Ameaças à validade

- sobreajuste de prompt à massa congelada do Putz;
- variação temporal de comportamento da API de LLM;
- simplificações do laboratório AWS frente a cenário corporativo real;
- viés de domínio do Putz (negócio de franquias/projetos) frente a outros domínios.

### Evidência mínima por corrida

- `runId`
- pergunta original
- chamadas de tool e payloads resumidos
- snapshot de metadados usados
- SQL final
- resultado de parse e execução
- `seed`, `modelVersion`, `commitHash`

## Próximo passo

[`runbook-reprodutibilidade.md`](runbook-reprodutibilidade.md)
