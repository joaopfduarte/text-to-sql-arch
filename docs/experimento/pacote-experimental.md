---
description: Hub de reprodutibilidade do pacote experimental Text-to-SQL.
tags:
  - experimento
---

# Pacote experimental

Ordem fixa para replicar o experimento de avaliação Text-to-SQL com a massa de laboratório.

!!! warning "Dialeto MySQL"
    Todo o SQL publicado neste pacote (schema e gabarito) está no dialeto **MySQL 8 ou superior**
    (`JSON_*`, `ONLY_FULL_GROUP_BY`, tipos `bit(1)`, crases). O schema relacional canônico chama-se
    **`base_laboratorial`**.

## 1. Baixar e executar o schema (MySQL 8+)

| Recurso | Caminho |
|---------|---------|
| Dump DDL + dados | [Dump MySQL base_laboratorial](../dados/base_laboratorial.sql) |
| Instruções de import | [Instruções de importação MySQL](../dados/README.md) |

```bash
mysql -u root -p < dados/base_laboratorial.sql
```

Inventário de tabelas: [Schema massa de teste](../arquitetura/dados/schema-massa-teste.md).

## 2. Perguntas (linguagem natural)

[Bateria de 40 perguntas](../evidence/bateria-40-perguntas.csv) — enunciados em NL, seis cenários,
três níveis de dificuldade (10 / 10 / 20).

## 3. Respostas esperadas (SQL MySQL)

[Gabarito da bateria](../evidence/gabarito-bateria.md) — colas $G_i$ de referência em **MySQL 8+**,
schema **`base_laboratorial`**, identificadores reais (Q01–Q40).

Notas sobre colunas JSON: [json\_data e data\_source](../evidence/json_data-data_source-schema-notes.md).

## 4. Resultados baseline registrados

| Artefato | Conteúdo |
|----------|----------|
| [Métricas baseline](../evidence/baseline-metricas.csv) | 40 perguntas × 2 modelos (`gemini-3.5-flash`, `gemini-3.1-pro`) |
| [Auditoria baseline](../evidence/baseline-auditoria-gabarito.md) | Mapa $g_i$ e notas por pergunta |
| [Matriz de cobertura](../evidence/matriz-cobertura-bateria.md) | Cenário × dificuldade × tabelas |

## 5. Protocolo experimental

| Documento | Uso |
|-----------|-----|
| [Protocolo de avaliação](protocolo-avaliacao.md) | Desenho experimental e métricas |
| [Runbook de reprodutibilidade](runbook-reprodutibilidade.md) | Checklist operacional de corridas |
| [Inferência e prompts](llm-inferencia-e-prompts.md) | Configuração de modelos e prompts |

## Validação recomendada

1. Importar `base_laboratorial.sql` em MySQL 8+ local.
2. Executar as 40 colas do gabarito sem erro de sintaxe ou `#1054`.
3. Confirmar ausência de prefixos legados de nome de tabela nas colas publicadas.

A carga Hive/Atlas no cluster consome a mesma massa; para replicação local, use exclusivamente o dump
MySQL versionado em [Instruções de importação MySQL](../dados/README.md).
