---
description: Vocabulário genérico obrigatório do artefato.
tags:
  - glossario
  - onboarding
---

# Glossário de anonimização

*[MCP]: Model Context Protocol
*[ODP]: Open Data Platform (stack Hadoop/Hive do cluster)
*[Atlas]: Apache Atlas — catálogo canônico de metadados
*[ADR]: Architecture Decision Record
*[PII]: Personally Identifiable Information — dados identificáveis de pessoa
*[FK]: Foreign Key — chave estrangeira
*[DDL]: Data Definition Language
*[HiveQL]: Dialeto SQL do Apache Hive


### Termos genéricos obrigatórios

| Categoria | Usar | Não usar |
|-----------|------|----------|
| Autor / operador | pesquisador, operador do experimento | nomes próprios, `@author` |
| Instituição | instituição federal de ensino superior | nomes de universidades, paths LaTeX externos |
| Empresa fonte dos dados | empresa privada | marcas, produtos ou integrações identificáveis |
| Schema relacional | `schema_laboratorio` | nomes reais de bases ou schemas |
| Massa Hive de teste | `massa_teste_laboratorio` | nomes reais de schemas de teste |
| Subconjunto fixo | subconjunto laboratorial (92 entidades) | codenames de produção |
| Tabelas | `tbl_<8 hex>` | nomes físicos de tabelas |
| Colunas | `col_<8 hex>` | nomes físicos de colunas |

### Domínios genéricos (rótulos de negócio)

| Rótulo genérico | Uso na pesquisa |
|-----------------|------------|
| domínio comercial principal | Junções 1:N e M:N centrais na bateria |
| domínio operacional de entregas | Cadeias longas, enums, agregações |
| domínio financeiro | Valores monetários e filtros temporais |
| domínio de identidade | PII potencial; mascarar na carga |
| domínio de catálogo | Produto, tipo, grupo |
| domínio de conteúdo externo | Origem, publicação, solicitações |
| domínio geográfico de referência | Junções geográficas auxiliares |
| domínio de mídia | Ativos digitais (fora do MVP) |
| domínio de acesso e auditoria | Contas e permissões (fora do MVP) |
| domínio de conectores | Integrações externas (fora do MVP) |
| controle de migração | Tabelas de ferramenta de schema (ruído) |
| apoio operacional | Tabelas auxiliares (fora do MVP) |

### Identificadores opacos

- Tabelas: `tbl_<8 caracteres hex minúsculos>`
- Colunas: `col_<8 caracteres hex minúsculos>`
- Algoritmo interno (convenção da pesquisa): `SHA-256("lab-doc" + nome_interno)[:8]` — **nomes internos não são publicados**.

### Artefatos offline

O pesquisador mantém offline:

- Export DDL completo anonimizado ou original usado na carga
- Documentação acadêmica (LaTeX/PDF)
- Mapeamento opaco ↔ físico, se necessário para operação local

!!! tip "Recomendado para leitura posterior"
    Seguinte: **[Leitura rápida](leitura-rapida.md)** — visão geral do sistema em até 30 minutos.
