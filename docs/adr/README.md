# ADRs (Architecture Decision Records)

Toda mudança arquitetural relevante deve ser registrada como ADR.

## Quando abrir ADR

- mudança de contrato MCP;
- mudança de bounded context ou modelo de domínio;
- mudança de protocolo de avaliação e métricas essenciais;
- mudança de estratégia de reprodutibilidade/evidência.

## Fluxo

1. Copiar [Template de ADR](../templates/adr-template.md).
2. Nomear como `ADR-XXXX-titulo-curto.md`.
3. Descrever contexto, decisão, impactos e alternativas.
4. Referenciar diagrama e documentos alterados.

## Estado permitido

- `Proposto`
- `Aceito`
- `Substituido`
- `Deprecado`

## Índice (aceitos)

| ADR | Título |
|-----|--------|
| [ADR-0001](ADR-0001-fundacao-arquitetural.md) | Fundação arquitetural do artefato |
| [ADR-0002](ADR-0002-topologia-aws-cluster-minimo.md) | Topologia AWS cluster mínimo |
| [ADR-0003](ADR-0003-inferencia-llm-deterministica.md) | Inferência LLM determinística |
| [ADR-0004](ADR-0004-politica-select-only-passo5.md) | Política SELECT-only passo 5 |
| [ADR-0005](ADR-0005-convencao-maven-pacotes-producao.md) | Convenção Maven e pacotes Java para produção |
