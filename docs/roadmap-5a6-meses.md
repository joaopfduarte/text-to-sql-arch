# Roadmap de implantação (5 a 6 meses)

## Propósito

Marcos de execução do TCC até a apresentação no fim de novembro, com paralelismo entre infra, aplicação e redação.

## Leitor

Pessoa responsável pela condução do TCC e gestor de prazo.

## Pré-requisitos

- [`01-produto-e-escopo.md`](01-produto-e-escopo.md)
- [`adr/ADR-0002-topologia-aws-cluster-minimo.md`](adr/ADR-0002-topologia-aws-cluster-minimo.md)

## Conteúdo

### Premissas de prazo

- Início efetivo: maio 2026.
- Apresentação: fim de novembro 2026.
- Janela útil estimada: ~24 semanas após descontar buffer e feriados.

### Fase 1 (semanas 1-3): governança e fundação documental

- Bootstrap documental do repositório (concluído).
- ADR-0001 fundação arquitetural (concluído).
- ADR-0002 topologia AWS mínima (novo).
- Diagramas mestre, rede lógica e topologia AWS.

### Fase 2 (semanas 4-7): infra AWS e contratos

- Provisionamento AWS: VPC, subnets, security groups, EC2 master+workers.
- Contratos MCP `v1` reexemplificados com tabelas PS reais.
- Especificação da política de tool budget.
- VDF canônico fechado (x86_64 + Ubuntu 24.04 + ODP 1.3.1.0) registrado em ADR-0002.

### Fase 3 (semanas 6-10): cluster e ingestão PS

- Subset ODP estável (ZooKeeper, HDFS, YARN mínimo, Atlas) — paralelo a parte da Fase 2.
- Ingestão PS para HDFS/Hive (carga única, fixa).
- Registro do subconjunto PS em Apache Atlas.
- Smoke queries validando aderência do catálogo.

### Fase 4 (semanas 9-14): aplicação MCP e harness

- Implementação Java 25 + Spring Boot + Spring AI.
- Provedores LLM fixados: OpenAI e Google (Gemini), com `model-version` registrado por corrida.
- Servidor MCP local com tools `catalog.*`.
- Adapter Atlas → contrato canônico.
- Validador sintático Apache Calcite (dialeto Hive) e executor SQL em Hive.
- Harness experimental com logs JSONL.

### Fase 5 (semanas 15-18): corridas e métricas

- Execução de corridas planejadas sobre o subset PS fixo.
- Coleta automatizada das métricas essenciais.
- Consolidação de evidências em `evidence/<runId>/`.
- Revisão das ameaças à validade.

### Fase 6 (semanas 17-22): redação da monografia

- Capítulo de desenvolvimento (`content/cap6-desenvolvimento.tex`).
- Capítulo de resultados (`content/cap7-resultados.tex`).
- Revisão metodológica e ajustes nos capítulos prévios.

### Fase 7 (semanas 22-24): endurecimento e preparação

- Mock fiel de contingência (opcional pós-MVP).
- Sensibilidade de prompt (opcional).
- Preparação da apresentação.
- Buffer para imprevistos.

### Gate de prazo

Caso a Fase 3 (cluster) ultrapasse a semana 12 sem ambiente estável, acionar contingência do ADR-0002 com redução temporária de volume mantendo stack x86/Ubuntu/ODP 1.3.1.0.

## Próximo passo

[`adr/ADR-0002-topologia-aws-cluster-minimo.md`](adr/ADR-0002-topologia-aws-cluster-minimo.md)
