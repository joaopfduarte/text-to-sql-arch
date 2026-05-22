# ADRs (Architecture Decision Records)

Toda mudança arquitetural relevante deve ser registrada como ADR.

## Quando abrir ADR

- mudança de contrato MCP;
- mudança de bounded context ou modelo de domínio;
- mudança de protocolo de avaliação e métricas essenciais;
- mudança de estratégia de reprodutibilidade/evidência.

## Fluxo

1. Copiar template em [`../templates/adr-template.md`](../templates/adr-template.md).
2. Nomear como `ADR-XXXX-titulo-curto.md`.
3. Descrever contexto, decisão, impactos e alternativas.
4. Referenciar diagrama e documentos alterados.

## Estado permitido

- `Proposto`
- `Aceito`
- `Substituido`
- `Deprecado`
