---
description: Ponto de entrada da arquitetura e engenharia do artefato Text-to-SQL com MCP e Apache Atlas.
tags:
  - onboarding
---

# Arquitetura e engenharia do produto TCC

Um pipeline Text-to-SQL em que um agente LLM consulta a camada semântica e de metadados via servidor MCP antes de gerar SQL, valida a aderência estrutural contra o catálogo canônico e executa o SQL sob ambiente controlado, registrando trilha completa por corrida.

## Por onde começar

| Papel | Leitura inicial |
|-------|-----------------|
| Qualquer pessoa nova no projeto | [Leitura rápida](00-leitura-rapida.md) |
| Dev Java | [Visão lógica](03-arquitetura-aplicacao/visao-logica.md) → [Módulos Spring](06-implementacao-java/modulos-spring.md) → [Contratos MCP](07-contratos-mcp/contracts-v1.md) |
| Engenheiro de infra/dados | [Visão AWS](05-infraestrutura/visao-aws.md) → [Cluster Hadoop](05-infraestrutura/cluster-hadoop.md) → [Carga no cluster](04-arquitetura-dados/carga-cluster-laboratorio.md) |
| Operador de corridas | [Runbook](08-experimento-avaliacao/runbook-reprodutibilidade.md) → [Operação](09-operacao.md) |
| Pesquisador (TCC) | [Rastreabilidade acadêmica](10-rastreabilidade-academica.md) |
