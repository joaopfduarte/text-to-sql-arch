---
description: Notas históricas da expansão Q31–Q40 (referência compacta).
tags:
  - experimento
  - evidencia
---

# Notas de expansão Q31–Q40

Documento histórico compacto. Fontes canônicas atuais:

- [Pacote experimental](../experimento/pacote-experimental.md)
- [Bateria de perguntas](bateria-40-perguntas.csv)
- [Gabarito da bateria](gabarito-bateria.md)
- [Matriz de cobertura](matriz-cobertura-bateria.md)

## Decisões de desenho

- Bateria expandida de 30 para **40 perguntas** (10 / 10 / 20 por dificuldade).
- Q31–Q40 são **COMPLEXA**, todas com junção a `project_render_item` e exploração de `json_data`
  e/ou `data_source`.
- Quatro perspectivas: admin, publisher, affiliate, sponsor (papéis `ROLE_*` do domínio).
- Colas em **MySQL 8+**, schema **`base_laboratorial`**, identificadores reais — mesma convenção que
  Q01–Q40 após remodalização (jun/2026).

## Referências técnicas

- DDL: [Dump MySQL base_laboratorial](../dados/base_laboratorial.sql)
- Caminhos JSON: [json\_data e data\_source](json_data-data_source-schema-notes.md)
