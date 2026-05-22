# Banco de domínio XPTO

## Propósito

Resumo operacional do schema relacional do XPTO, identificando domínios, tabelas-âncora e FKs relevantes para o pipeline Text-to-SQL e para a carga no cluster.

## Leitor

Pessoa que implementa o adaptador MCP, monta o catálogo no Atlas ou prepara a carga no cluster.

## Pré-requisitos

- [Monografia](../monografia.md) (dicionário completo e linhas de referência).

## Conteúdo

### Identificadores opacos (compliance)

Por política de publicação, **nomes físicos de tabelas e colunas não aparecem neste site**. O catálogo operacional usa identificadores estáveis:

- Tabelas: `tbl_<8 caracteres hex>` (ex.: `tbl_b35a889b`)
- Colunas: `col_<8 caracteres hex>` (ex.: `col_65a24b80`)

Cada identificador é derivado de forma determinística a partir do nome interno (`SHA-256` com prefixo `xpto-doc`, 8 primeiros dígitos hex). O mapeamento completo permanece apenas na [Monografia](../monografia.md) (PDF, acesso restrito). Contratos MCP, SQL de exemplo e metadados do Atlas devem usar **somente** esses identificadores opacos.

### Estatísticas observáveis

| Item | Valor | Fonte |
|------|-------|-------|
| Tabelas no índice | 92 + secção "Relational schema" | [`base de referência XPTO.md` L5–98](../monografia.md) |
| Origem do export | Schema relacional MySQL com rastros de Liquibase | Tabelas `tbl_f38c20bb`, `tbl_6947ed9e` |
| Data declarada de geração das tabelas | Apr 28, 2026 | Cabeçalho "Creation" em cada tabela do export |
| Notação de FK no export | `col_<opaco> -> tbl_<opaco>.col_<opaco>` (com `ON UPDATE` / `ON DELETE`) | Exemplo na monografia [L1199](../monografia.md) (`tbl_b35a889b.col_65a24b80 -> tbl_68086640.col_9b7089a7`) |

### Domínios identificados

| Domínio | Tabelas representativas | Uso no TCC |
|---------|-------------------------|------------|
| Controle Liquibase | `tbl_f38c20bb`, `tbl_6947ed9e` | Ignorar na massa de avaliação (ruído). |
| Ativos digitais | `tbl_416086cb`, `tbl_1c513a6a`, `tbl_2d998afa`, `tbl_d9ee9424`, `tbl_d68e3e72`, `tbl_ee1df82f` | Não selecionado no MVP (alto número de junções acessórias). |
| Franquias | `tbl_b35a889b`, `tbl_68086640`, `tbl_3decb5f8`, `tbl_619e750e`, `tbl_8232e4bf`, `tbl_63d26474` | Domínio principal de avaliação (junções 1:N e M:N evidentes). |
| Geografia | `tbl_1d129a77`, `tbl_f8413ca9`, `tbl_621c759b`, `tbl_aaacd100`, `tbl_b742d031` | Junção geográfica auxiliar. |
| Pessoa | `tbl_3246b982`, `tbl_5833cd7d` | Tabela-âncora referenciada por múltiplos domínios. |
| Produto | `tbl_7f77967c`, `tbl_74a9f8a6`, `tbl_5c417c09`, `tbl_f9075de1`, `tbl_a0c59ad8`, `tbl_ab7c799d` | Junções produto/tipo/grupo. |
| Projetos | `tbl_ea4e241a`, `tbl_dd1db895`, `tbl_68a51161`, `tbl_0ce9df9e`, `tbl_ffa1d754`, `tbl_0bfc7795`, `tbl_361f2f03`, `tbl_2a724e79` | Domínio principal com enum (`col_be09dec4`), agregações e cadeias longas. |
| Transações | `tbl_baf8a113`, `tbl_f57abbbd`, `tbl_f81c28cd`, `tbl_4e6f6dba` | Agregações monetárias e filtros temporais. |
| Publicações | `tbl_78a318a8`, `tbl_b4188823`, `tbl_efc3e1d8`, `tbl_27f14b92`, `tbl_2547c5c5`, `tbl_ac129694` | Junções entre origem, conteúdo e usuário. |
| Conta e segurança | `tbl_bca93322`, `tbl_4dd3e419`, `tbl_7e875755`, `tbl_5350bee3`, `tbl_dcd6e5f0` | Não selecionado no MVP (PII potencial). |
| Integração externa | `tbl_2bfaaa4f`, `tbl_e6b6f50e`, `tbl_5b21c6ff` | Não selecionado no MVP (dados de integração). |
| Tags e classificação | `tbl_7766ef88`, `tbl_ab7c799d`, `tbl_088cfa0b`, `tbl_2a724e79`, `tbl_c954111d` | Junções M:N. |
| Apoio | `tbl_f371608b`, `tbl_15bb7c52`, `tbl_63aa08a6`, `tbl_38bf3937`, `tbl_4df1d560`, `tbl_cf47054d`, `tbl_89ef50cd`, `tbl_440d3b9d`, `tbl_8919b733`, `tbl_2bcb6733`, `tbl_271b72e6`, `tbl_cab1b6b7`, `tbl_cb5b1e15`, `tbl_6d540eb1`, `tbl_1e38d9f7` | Não selecionado no MVP. |

### FKs concretas confirmadas no export

| Origem (tabela.coluna) | Destino (tabela.coluna) | Restrição | Fonte |
|------------------------|--------------------------|-----------|-------|
| `tbl_b35a889b.col_65a24b80` | `tbl_68086640.col_9b7089a7` | `ON UPDATE RESTRICT` / `ON DELETE RESTRICT` | [`base de referência XPTO.md` L1199–1201](../monografia.md) |
| `tbl_b35a889b.col_d1dee7b9` | `tbl_3decb5f8.col_9b7089a7` | `ON UPDATE RESTRICT` / `ON DELETE RESTRICT` | [`base de referência XPTO.md` L1203–1206](../monografia.md) |
| `tbl_dd1db895.col_d10d1c97` | `tbl_ea4e241a.col_9b7089a7` | `ON UPDATE CASCADE` / `ON DELETE CASCADE` | [`base de referência XPTO.md` L3257–3259](../monografia.md) |
| `tbl_dd1db895.col_539dd83b` | `tbl_ffa1d754.col_9b7089a7` | `ON UPDATE CASCADE` / `ON DELETE RESTRICT` | [`base de referência XPTO.md` L3267–3269](../monografia.md) |
| `tbl_dd1db895.col_fa844dc1` | `tbl_7f77967c.col_9b7089a7` | `ON UPDATE CASCADE` / `ON DELETE RESTRICT` | [`base de referência XPTO.md` L3271–3273](../monografia.md) |
| `tbl_dd1db895.col_40b4119e` | `tbl_3246b982.col_9b7089a7` | `ON UPDATE CASCADE` / `ON DELETE RESTRICT` | [`base de referência XPTO.md` L3282–3284](../monografia.md) |
| `tbl_68a51161.col_d10d1c97` | `tbl_ea4e241a.col_9b7089a7` | `ON UPDATE RESTRICT` / `ON DELETE RESTRICT` | [`base de referência XPTO.md` L3393–3395](../monografia.md) |
| `tbl_baf8a113.col_04492fad` | `tbl_3246b982.col_9b7089a7` | `ON UPDATE CASCADE` / `ON DELETE CASCADE` | [`base de referência XPTO.md` L5358–5360](../monografia.md) |
| `tbl_baf8a113.col_d10d1c97` | `tbl_ea4e241a.col_9b7089a7` | `ON UPDATE CASCADE` / `ON DELETE SET_NULL` | [`base de referência XPTO.md` L5363–5365](../monografia.md) |
| `tbl_baf8a113.col_fbd94d49` | `tbl_dd1db895.col_9b7089a7` | `ON UPDATE CASCADE` / `ON DELETE RESTRICT` | [`base de referência XPTO.md` L5367–5369](../monografia.md) |
| `tbl_baf8a113.col_0340d3c6` | `tbl_8919b733.col_9b7089a7` | `ON UPDATE RESTRICT` / `ON DELETE RESTRICT` | [`base de referência XPTO.md` L5371–5373](../monografia.md) |
| `tbl_baf8a113.col_277d4ade` | `tbl_baf8a113.col_9b7089a7` | `ON UPDATE CASCADE` / `ON DELETE RESTRICT` | [`base de referência XPTO.md` L5433–5435](../monografia.md) |
| `tbl_f57abbbd.col_0b5aab7e` | `tbl_3246b982.col_9b7089a7` | `ON UPDATE CASCADE` / `ON DELETE SET_NULL` | [`base de referência XPTO.md` L5475–5477](../monografia.md) |
| `tbl_f57abbbd.col_04492fad` | `tbl_3246b982.col_9b7089a7` | `ON UPDATE CASCADE` / `ON DELETE CASCADE` | [`base de referência XPTO.md` L5483–5485](../monografia.md) |
| `tbl_f57abbbd.col_15f81457` | `tbl_baf8a113.col_9b7089a7` | `ON UPDATE RESTRICT` / `ON DELETE RESTRICT` | [`base de referência XPTO.md` L5513–5515](../monografia.md) |
| `tbl_f57abbbd.col_79e8b94d` | `tbl_0ce9df9e.col_9b7089a7` | `ON UPDATE RESTRICT` / `ON DELETE RESTRICT` | [`base de referência XPTO.md` L5521–5523](../monografia.md) |
| `tbl_f57abbbd.col_d10d1c97` | `tbl_ea4e241a.col_9b7089a7` | `ON UPDATE RESTRICT` / `ON DELETE RESTRICT` | [`base de referência XPTO.md` L5525–5527](../monografia.md) |
| `tbl_f57abbbd.col_4ec44780` | `tbl_bccb4cb4.col_9b7089a7` | `ON UPDATE CASCADE` / `ON DELETE RESTRICT` | [`base de referência XPTO.md` L5559–5561](../monografia.md) |
| `tbl_f57abbbd.col_face3af8` | `tbl_2547c5c5.col_9b7089a7` | `ON UPDATE CASCADE` / `ON DELETE RESTRICT` | [`base de referência XPTO.md` L5567–5569](../monografia.md) |
| `tbl_3246b982.col_197d8d97` | `tbl_3246b982.col_9b7089a7` | `ON UPDATE CASCADE` / `ON DELETE RESTRICT` | [`base de referência XPTO.md` L2217–2219](../monografia.md) |
| `tbl_5833cd7d.col_04492fad` | `tbl_3246b982.col_9b7089a7` | `ON UPDATE CASCADE` / `ON DELETE CASCADE` | [`base de referência XPTO.md` L2379–2381](../monografia.md) |
| `tbl_7f77967c.col_9874c09e` | `tbl_74a9f8a6.col_9b7089a7` | `ON UPDATE RESTRICT` / `ON DELETE RESTRICT` | [`base de referência XPTO.md` L2558–2560](../monografia.md) |
| `tbl_1d129a77.col_aa55341f` | `tbl_f8413ca9.col_9b7089a7` | `ON UPDATE CASCADE` / `ON DELETE RESTRICT` | [`base de referência XPTO.md` L1540–1542](../monografia.md) |

### Tabelas-âncora para Text-to-SQL

Definição: tabelas que aparecem como pivô de junções ou agregações nos cenários do harness.

| Tabela | Motivo | Linha no export |
|--------|--------|-----------------|
| `tbl_b35a889b` | Múltiplas FKs evidentes, agrega vários sub-domínios. | [L1173](../monografia.md) |
| `tbl_ea4e241a` | Enum (`col_be09dec4`), referenciada por `tbl_dd1db895`, `tbl_68a51161`, `tbl_0ce9df9e`. | [L2709](../monografia.md) |
| `tbl_baf8a113` | Filtros temporais e agregações monetárias. | [L5343](../monografia.md) |
| `tbl_3246b982` | Pivô de pessoas com `tbl_5833cd7d` e referências cruzadas. | [L2198](../monografia.md) |
| `tbl_7f77967c` | Junção com `tbl_74a9f8a6` e `tbl_5c417c09`. | [L2550](../monografia.md) |
| `tbl_1d129a77` | Junção geográfica com `tbl_f8413ca9`. | [L1523](../monografia.md) |

### Restrições do MVP

- Não copiar as ~6640 linhas do export para `docs/`.
- Não inventar tabelas ou colunas fora do índice em [`base de referência XPTO.md` L5–98](../monografia.md).
- Não inserir PII (e-mails, telefones, dados de `tbl_bca93322`) na massa de teste sem mascaramento.

## Próximo passo

[`carga-cluster-xpto.md`](carga-cluster-xpto.md)
