# Schema e massa de teste (subconjunto XPTO)

## Propósito

Fixar o subconjunto de tabelas do banco XPTO que compõe a massa congelada do harness e definir as regras de versionamento dessa massa.

## Leitor

Pessoa que prepara a massa, monta o catálogo no Atlas e roda corridas.

## Pré-requisitos

- [`banco-xpto-dominio.md`](banco-xpto-dominio.md)
- [`carga-cluster-xpto.md`](carga-cluster-xpto.md)
- [`catalogo-atlas.md`](catalogo-atlas.md)

## Conteúdo

### Decisão

O subconjunto XPTO substitui qualquer schema sintético legado como única massa de avaliação do TCC. Toda referência futura em contratos MCP, harness e exemplos deve usar **identificadores opacos** (`tbl_*`, `col_*`) definidos em [`banco-xpto-dominio.md`](banco-xpto-dominio.md); o dicionário físico completo permanece na [Monografia](../monografia.md).

### Regras da massa

- O subconjunto é congelado antes das corridas finais e versionado em `datasetVersion`.
- Cada pergunta tem SQL de referência ou resultado esperado, quando aplicável.
- Alteração do subconjunto exige nova versão e justificativa em ADR.
- Dados são extraídos do dump original e residem no cluster (HDFS/Hive), sem dados sensíveis ou pessoais sem mascaramento.

### Subconjunto inicial proposto

Critério de seleção: tabelas com FKs explícitas no export (notação `-> tabela.coluna`) ou tabelas-âncora de domínios distintos para cobrir filtros, agregações e junções.

| Tabela | Função na avaliação | Evidência |
|--------|---------------------|-----------|
| `tbl_b35a889b` | Tabela-âncora, possui FKs `col_65a24b80`, `col_d1dee7b9`. | [`base de referência XPTO.md` L1173–1215](../monografia.md) |
| `tbl_68086640` | Lookup para junções 1:N a partir de `tbl_b35a889b`. | [`base de referência XPTO.md` L1407+](../monografia.md) |
| `tbl_3decb5f8` | Lookup para junções 1:N a partir de `tbl_b35a889b`. | [`base de referência XPTO.md` L1319+](../monografia.md) |
| `tbl_619e750e` | Granularidade fina, suporta agregações. | [`base de referência XPTO.md` L1494+](../monografia.md) |
| `tbl_ea4e241a` | Tabela-âncora, enum `col_be09dec4`. | [`base de referência XPTO.md` L2709+](../monografia.md) |
| `tbl_dd1db895` | Filhos de `tbl_ea4e241a`, suporta junção + filtro. | [`base de referência XPTO.md` L3249+](../monografia.md) |
| `tbl_68a51161` | Permite agregações monetárias. | [`base de referência XPTO.md` L3385+](../monografia.md) |
| `tbl_3246b982` | Tabela-âncora referenciada por múltiplas tabelas do subconjunto. | [`base de referência XPTO.md` L2198+](../monografia.md) |
| `tbl_7f77967c` | Tabela-âncora simples, junções com `tbl_74a9f8a6`. | [`base de referência XPTO.md` L2550+](../monografia.md) |
| `tbl_74a9f8a6` | Lookup. | [`base de referência XPTO.md` L2668+](../monografia.md) |
| `tbl_baf8a113` | Tabela-âncora, suporta agregações e filtros temporais. | [`base de referência XPTO.md` L5343+](../monografia.md) |
| `tbl_f57abbbd` | Junção 1:N, cenário de filtro condicional. | [`base de referência XPTO.md` L5462+](../monografia.md) |
| `tbl_1d129a77` | Junção geográfica com FK para `tbl_f8413ca9`. | [`base de referência XPTO.md` L1523+](../monografia.md) |
| `tbl_f8413ca9` | Lookup. | [`base de referência XPTO.md` L1801+](../monografia.md) |

### FKs confirmadas do subconjunto

| Tabela | FK | Evidência |
|--------|----|-----------|
| `tbl_dd1db895` | `col_d10d1c97 -> tbl_ea4e241a.col_9b7089a7` | [`base de referência XPTO.md` L3257–3259](../monografia.md) |
| `tbl_dd1db895` | `col_539dd83b -> tbl_ffa1d754.col_9b7089a7` | [`base de referência XPTO.md` L3267–3269](../monografia.md) |
| `tbl_dd1db895` | `col_fa844dc1 -> tbl_7f77967c.col_9b7089a7` | [`base de referência XPTO.md` L3271–3273](../monografia.md) |
| `tbl_dd1db895` | `col_40b4119e -> tbl_3246b982.col_9b7089a7` | [`base de referência XPTO.md` L3282–3284](../monografia.md) |
| `tbl_68a51161` | `col_d10d1c97 -> tbl_ea4e241a.col_9b7089a7` | [`base de referência XPTO.md` L3393–3395](../monografia.md) |
| `tbl_baf8a113` | `col_04492fad -> tbl_3246b982.col_9b7089a7` | [`base de referência XPTO.md` L5358–5360](../monografia.md) |
| `tbl_baf8a113` | `col_d10d1c97 -> tbl_ea4e241a.col_9b7089a7` | [`base de referência XPTO.md` L5363–5365](../monografia.md) |
| `tbl_baf8a113` | `col_fbd94d49 -> tbl_dd1db895.col_9b7089a7` | [`base de referência XPTO.md` L5367–5369](../monografia.md) |
| `tbl_baf8a113` | `col_0340d3c6 -> tbl_8919b733.col_9b7089a7` | [`base de referência XPTO.md` L5371–5373](../monografia.md) |
| `tbl_baf8a113` | `col_277d4ade -> tbl_baf8a113.col_9b7089a7` | [`base de referência XPTO.md` L5433–5435](../monografia.md) |
| `tbl_f57abbbd` | `col_0b5aab7e -> tbl_3246b982.col_9b7089a7` | [`base de referência XPTO.md` L5475–5477](../monografia.md) |
| `tbl_f57abbbd` | `col_04492fad -> tbl_3246b982.col_9b7089a7` | [`base de referência XPTO.md` L5483–5485](../monografia.md) |
| `tbl_f57abbbd` | `col_15f81457 -> tbl_baf8a113.col_9b7089a7` | [`base de referência XPTO.md` L5513–5515](../monografia.md) |
| `tbl_f57abbbd` | `col_79e8b94d -> tbl_0ce9df9e.col_9b7089a7` | [`base de referência XPTO.md` L5521–5523](../monografia.md) |
| `tbl_f57abbbd` | `col_d10d1c97 -> tbl_ea4e241a.col_9b7089a7` | [`base de referência XPTO.md` L5525–5527](../monografia.md) |
| `tbl_f57abbbd` | `col_4ec44780 -> tbl_bccb4cb4.col_9b7089a7` | [`base de referência XPTO.md` L5559–5561](../monografia.md) |
| `tbl_f57abbbd` | `col_face3af8 -> tbl_2547c5c5.col_9b7089a7` | [`base de referência XPTO.md` L5567–5569](../monografia.md) |
| `tbl_3246b982` | `col_197d8d97 -> tbl_3246b982.col_9b7089a7` | [`base de referência XPTO.md` L2217–2219](../monografia.md) |
| `tbl_5833cd7d` | `col_04492fad -> tbl_3246b982.col_9b7089a7` | [`base de referência XPTO.md` L2379–2381](../monografia.md) |
| `tbl_7f77967c` | `col_9874c09e -> tbl_74a9f8a6.col_9b7089a7` | [`base de referência XPTO.md` L2558–2560](../monografia.md) |
| `tbl_1d129a77` | `col_aa55341f -> tbl_f8413ca9.col_9b7089a7` | [`base de referência XPTO.md` L1540–1542](../monografia.md) |

### Cenários de pergunta cobertos

| Cenário | Tabelas envolvidas | Tipo de SQL esperado |
|---------|--------------------|----------------------|
| Listagem simples | `tbl_b35a889b` | `SELECT ... FROM` |
| Filtro por enum | `tbl_ea4e241a` (`col_be09dec4`) | `SELECT ... WHERE col_be09dec4 = '...'` |
| Junção 1:N | `tbl_b35a889b` + `tbl_619e750e` | `JOIN` |
| Junção em cadeia | `tbl_b35a889b` + `tbl_68086640` + `tbl_3decb5f8` | `JOIN` múltiplos |
| Agregação | `tbl_68a51161` | `SUM/COUNT/GROUP BY` |
| Filtro temporal | `tbl_baf8a113` | `WHERE col_73b74c75 BETWEEN ...` |
| Junção geográfica | `tbl_1d129a77` + `tbl_f8413ca9` | `JOIN` com lookup |

### Amplificação da massa `xpto_teste` (1,3 GB -> 50 GB)

Baseline observada do schema `xpto_teste`: ~1388,27 MB. Para estudo de escala do TCC, a massa no cluster deve alcançar ~50 GB (aprox. 38x) por amplificação sintética controlada.

Métodos documentados:

1. replicação estratificada de tabelas filhas (`tbl_dd1db895`, `tbl_f57abbbd`) preservando FKs;
2. geração sintética de eventos em `tbl_baf8a113` com distribuição temporal;
3. variação de atributos não sensíveis para reduzir duplicidade literal;
4. bootstrap por domínio com checkpoints de consistência.

Riscos e controles:

- deriva estatística: registrar premissas e limitações no protocolo experimental;
- privacidade: manter mascaramento e evitar amplificação de colunas sensíveis;
- custo/tempo de carga: executar em lotes e validar contagens por domínio;
- reprodutibilidade: cada rodada de amplificação incrementa `datasetVersion`.

### Artefatos esperados

- Script de seleção e congelamento do subconjunto (a partir do dump original do XPTO).
- Script de carga no cluster (ver [`carga-cluster-xpto.md`](carga-cluster-xpto.md)).
- Inventário de perguntas por cenário.
- Matriz de cobertura pergunta x tabelas/colunas/relacionamentos esperados.
- Registro `datasetVersion` em cada `evidence/<runId>/context.json`.

## Próximo passo

[`catalogo-atlas.md`](catalogo-atlas.md)
