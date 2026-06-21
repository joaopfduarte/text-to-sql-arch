---
description: Domínios genéricos, entidades-âncora e FKs do schema laboratorial.
tags:
  - dados
---

# Banco de domínio laboratorial

!!! info "Recomendado para leitura prévia"
    - **[Glossário de anonimização](../00-glossario-anonimizacao.md)** — vocabulário genérico obrigatório.
    - **[Schema massa de teste](schema-massa-teste.md)** — inventário das 92 entidades anonimizadas.


### Identificadores opacos

- Tabelas: `tbl_<8 hex>`
- Colunas: `col_<8 hex>`
- Algoritmo: `SHA-256("lab-doc" + nome_interno)[:8]` — nomes internos **não** são publicados.

### Estatísticas

| Item | Valor |
|------|-------|
| Entidades no índice | 92 |
| Schema Hive/MySQL | `schema_laboratorio` / `massa_teste_laboratorio` |

### Domínios identificados

| Domínio genérico | Entidades representativas | Uso no TCC |
|------------------|-------------------------|------------|
| apoio operacional | `tbl_5e464b14`, `tbl_cef676c5`, `tbl_bb1c74b7`, `tbl_a63ac3ee`, `tbl_bd19ace7`, `tbl_0b894724`, … | Fora do MVP ou ruído |
| controle de migração | `tbl_d1cb73f6`, `tbl_b7dfbbcb` | Fora do MVP ou ruído |
| domínio comercial principal | `tbl_162cf7be`, `tbl_93460c22`, `tbl_54c1256a`, `tbl_254c881e`, `tbl_4c8d7ae5`, `tbl_05dc6f7a`, … | MVP |
| domínio de acesso e auditoria | `tbl_d1556a76`, `tbl_a4806350`, `tbl_a707320d`, `tbl_c127eea9`, `tbl_54cf92bb` | Fora do MVP ou ruído |
| domínio de catálogo | `tbl_f0944b44`, `tbl_ea9d95de`, `tbl_891b1fc9`, `tbl_feb88f1f`, `tbl_97a28ae4`, `tbl_ed8b2873`, … | MVP |
| domínio de conectores | `tbl_9b02bb2c`, `tbl_d94d1042`, `tbl_508411b3` | Fora do MVP ou ruído |
| domínio de conteúdo externo | `tbl_4e5786c9`, `tbl_03f58275`, `tbl_ed7e8f08`, `tbl_0f03f20e`, `tbl_9705264a`, `tbl_06d78b0c`, … | Fora do MVP ou ruído |
| domínio de identidade | `tbl_f193a446`, `tbl_ae0a73d5` | Fora do MVP ou ruído |
| domínio de mídia | `tbl_d58bb5a4`, `tbl_cca22dd2`, `tbl_a6e2174e`, `tbl_c311310d`, `tbl_69fab9c0`, `tbl_0bd3e50a`, … | Fora do MVP ou ruído |
| domínio financeiro | `tbl_6cf5e405`, `tbl_6cc6cc99`, `tbl_c066178a`, `tbl_6b881dfd`, `tbl_365b81cc`, `tbl_63f841a0` | MVP |
| domínio geográfico de referência | `tbl_23a8dee5`, `tbl_f64a1c03`, `tbl_2c1fc4f7`, `tbl_0c30d74e`, `tbl_bd01b86d`, `tbl_c6092460`, … | MVP |
| domínio operacional de entregas | `tbl_363ae7e9`, `tbl_b8f84c29`, `tbl_fb0188bb`, `tbl_3a2c56ff`, `tbl_73f0363b`, `tbl_6696932f`, … | MVP |
| tags e classificação | `tbl_7933f344` | Fora do MVP ou ruído |

### FKs confirmadas (amostra MVP)

| Origem | Destino | Restrição |
|--------|---------|-----------|
| `tbl_162cf7be.col_2cd9416d` | `tbl_8991e9dc.col_d7247819` | documentado em schema-massa-teste |
| `tbl_162cf7be.col_1d3e13bf` | `tbl_4c8d7ae5.col_d7247819` | documentado em schema-massa-teste |
| `tbl_93460c22.col_0bee3ba9` | `tbl_162cf7be.col_d7247819` | documentado em schema-massa-teste |
| `tbl_54c1256a.col_0bee3ba9` | `tbl_162cf7be.col_d7247819` | documentado em schema-massa-teste |
| `tbl_254c881e.col_0bee3ba9` | `tbl_162cf7be.col_d7247819` | documentado em schema-massa-teste |
| `tbl_05dc6f7a.col_0bee3ba9` | `tbl_162cf7be.col_d7247819` | documentado em schema-massa-teste |
| `tbl_fada6213.col_0bee3ba9` | `tbl_162cf7be.col_d7247819` | documentado em schema-massa-teste |
| `tbl_40b45933.col_0bee3ba9` | `tbl_162cf7be.col_d7247819` | documentado em schema-massa-teste |
| `tbl_973ec6fa.col_0bee3ba9` | `tbl_162cf7be.col_d7247819` | documentado em schema-massa-teste |
| `tbl_2c1fc4f7.col_7e317139` | `tbl_c78eb7ee.col_d7247819` | documentado em schema-massa-teste |
| `tbl_9b02bb2c.col_3e19be2e` | `tbl_f193a446.col_d7247819` | documentado em schema-massa-teste |
| `tbl_f193a446.col_35f9c31c` | `tbl_f193a446.col_d7247819` | documentado em schema-massa-teste |
| `tbl_ae0a73d5.col_3e19be2e` | `tbl_f193a446.col_d7247819` | documentado em schema-massa-teste |
| `tbl_f0944b44.col_3e19be2e` | `tbl_f193a446.col_d7247819` | documentado em schema-massa-teste |
| `tbl_891b1fc9.col_b80b7e90` | `tbl_ed8b2873.col_d7247819` | documentado em schema-massa-teste |

### Entidades-âncora para Text-to-SQL

| Entidade | Motivo |
|----------|--------|
| `tbl_162cf7be` | Junções centrais do domínio comercial principal. |
| `tbl_363ae7e9` | Enum e cadeias longas no domínio operacional. |
| `tbl_c066178a` | Agregações no domínio financeiro. |
| `tbl_f193a446` | Pivô do domínio de identidade. |
| `tbl_891b1fc9` | Junções no domínio de catálogo. |
| `tbl_2c1fc4f7` | Junção geográfica auxiliar. |

### Restrições

- Não publicar nomes físicos de tabelas ou colunas.
- Não incluir PII na massa publicada sem mascaramento.

!!! tip "Recomendado para leitura posterior"
    Seguinte: **[Carga no cluster](carga-cluster-laboratorio.md)** — pipeline de ingestão da massa `massa_teste_laboratorio`.
