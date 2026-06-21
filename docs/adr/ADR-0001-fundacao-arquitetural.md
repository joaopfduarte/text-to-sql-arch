---
description: Fundação hexagonal, MCP versionado e evidência por runId.
status: Aceito
tags:
  - adr
  - arquitetura
  - mcp
---

# ADR-0001: Fundação arquitetural do artefato

- **Status:** Aceito
- **Data:** 2026-04-18

## Contexto

O TCC define um artefato único `Text-to-SQL` com consulta de metadados por `MCP` antes da geração de SQL.
Era necessário estabelecer uma fundação arquitetural que favorecesse evolução incremental, reprodutibilidade
experimental e baixo acoplamento entre aplicação e integrações externas.

## Decisão

Adotar arquitetura hexagonal por contexto, com:

- separação entre `Application`, `Domain` e `Adapters`;
- bounded contexts explícitos para intake, descoberta, síntese, validação e tracking;
- contratos MCP versionados;
- trilha de evidências por `run id`.

## Consequências

### Positivas

- maior testabilidade por portas e adapters;
- menor impacto de mudança de integração Atlas/MCP;
- rastreabilidade consistente para análise experimental.

### Negativas

- custo inicial de modelagem e governança documental;
- maior disciplina de versionamento e manutenção de contratos.

## Alternativas avaliadas

- arquitetura em camadas sem portas explícitas;
- acoplamento direto de orquestrador a APIs externas.

Ambas foram rejeitadas por risco de regressão arquitetural e baixa auditabilidade.
