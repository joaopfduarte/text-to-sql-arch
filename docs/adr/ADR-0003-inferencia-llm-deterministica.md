---
description: Inferência determinística, seeds e paridade de prompts entre modos.
status: Aceito
tags:
  - adr
  - experimento
  - mcp
---

# ADR-0003: Inferência LLM determinística e paridade de prompts

- **Status:** Aceito
- **Data:** 2026-06-14

## Contexto

A Seção de Registro Experimental do Cap. 4 exige especificação de hiperparâmetros de inferência e montagem
de prompts para os modos `mcp` e `baseline-static`. A revisão metodológica (`revision-control.md` §4.1–4.2)
identifica ausência de system prompt versionado e de `temperature` fixada como principal confound operacional
na comparação MCP vs baseline.

## Decisão

1. Fixar **`temperature = 0`** na campanha v1 com `gemini-3.5-flash` (baseline e MCP quando aplicável).
2. **Não definir `topP`** quando `temperature` estiver fixada (política Spring AI).
3. Fixar **`maxOutputTokens = 4096`** por request na v1.
4. Publicar templates versionados em [Manifesto de prompts v1](../templates/prompts/prompts-manifest-v1.json) com bloco
   **`system-shared-v1.md` idêntico** entre modos (regra de paridade anti-alucinação).
5. Estender `context.json` com `promptVersion`, `inferenceConfig`, `promptArtifacts` e
   `promptArtifactsHash` (schema [Schema context.json v1](../evidence/context-schema-v1.json)).
6. Para `gpt-5.4-nano` (MCP): registrar `temperatureSupported: false` e omitir `temperature` no request,
   conforme limitação dos modelos GPT-5 de raciocínio.
7. Documentação canónica: [Inferência e prompts](../08-experimento-avaliacao/llm-inferencia-e-prompts.md).

## Consequências

### Positivas

- Reduz variância estocástica não controlada entre corridas e entre modos.
- Isola a variável experimental «MCP vs DDL estático» das diferenças de prompt instrucional.
- Permite auditoria via hash dos templates e registro em `context.json`.

### Negativas

- APIs comerciais não garantem determinismo total mesmo com `temperature=0` e `seed` — variância residual
  deve ser declarada na metodologia.
- Templates v1 exigem revisão humana antes do congelamento da campanha.
- GPT-5 nano impõe assimetria documentada na configuração de inferência.

## Alternativas avaliadas

- **`temperature` default do provedor (0,7 no Gemini via Spring AI):** rejeitada — introduz aleatoriedade
  desnecessária em geração de SQL.
- **Prompts distintos sem bloco compartilhado:** rejeitada — confound de engenharia de prompt.
- **Omitir registro em `context.json`:** rejeitada — impede reprodutibilidade exigida pelo protocolo.

## Referências

- [Inferência e prompts](../08-experimento-avaliacao/llm-inferencia-e-prompts.md)
- [Manifesto de prompts v1](../templates/prompts/prompts-manifest-v1.json)
- [Schema context.json v1](../evidence/context-schema-v1.json)
