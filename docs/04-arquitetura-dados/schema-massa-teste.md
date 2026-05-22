# Schema e massa de teste (subconjunto Putz)

## Propósito

Fixar o subconjunto de tabelas do banco Putz que compõe a massa congelada do harness e definir as regras de versionamento dessa massa.

## Leitor

Pessoa que prepara a massa, monta o catálogo no Atlas e roda corridas.

## Pré-requisitos

- [`banco-putz-dominio.md`](banco-putz-dominio.md)
- [`carga-cluster-putz.md`](carga-cluster-putz.md)
- [`catalogo-atlas.md`](catalogo-atlas.md)

## Conteúdo

### Decisão

O subconjunto Putz substitui qualquer schema sintético (anteriormente `sales.*`) como única massa de avaliação do TCC. Toda referência futura em contratos MCP, harness e exemplos deve citar tabelas reais do Putz, presentes em [`../../db-reference/putz_db.md`](../../db-reference/putz_db.md).

### Regras da massa

- O subconjunto é congelado antes das corridas finais e versionado em `datasetVersion`.
- Cada pergunta tem SQL de referência ou resultado esperado, quando aplicável.
- Alteração do subconjunto exige nova versão e justificativa em ADR.
- Dados são extraídos do dump original e residem no cluster (HDFS/Hive), sem dados sensíveis ou pessoais sem mascaramento.

### Subconjunto inicial proposto

Critério de seleção: tabelas com FKs explícitas no export (notação `-> tabela.coluna`) ou tabelas-âncora de domínios distintos para cobrir filtros, agregações e junções.

| Tabela | Domínio | Função na avaliação | Evidência |
|--------|---------|---------------------|-----------|
| `franquias` | Franquias | Tabela-âncora, possui FKs `segmento_id`, `rede_id`. | [`putz_db.md` L1173–1215](../../db-reference/putz_db.md) |
| `franquias__segmentos` | Franquias | Lookup para junções 1:N a partir de `franquias`. | [`putz_db.md` L1407+](../../db-reference/putz_db.md) |
| `franquias__redes_franquia` | Franquias | Lookup para junções 1:N a partir de `franquias`. | [`putz_db.md` L1319+](../../db-reference/putz_db.md) |
| `franquias__unidades` | Franquias | Granularidade fina, suporta agregações. | [`putz_db.md` L1494+](../../db-reference/putz_db.md) |
| `project` | Projetos | Tabela-âncora, enum `project_status`. | [`putz_db.md` L2709+](../../db-reference/putz_db.md) |
| `project_item` | Projetos | Filhos de `project`, suporta junção + filtro. | [`putz_db.md` L3249+](../../db-reference/putz_db.md) |
| `project_payment` | Projetos | Permite agregações monetárias. | [`putz_db.md` L3385+](../../db-reference/putz_db.md) |
| `person` | Pessoa | Tabela-âncora referenciada por múltiplos domínios. | [`putz_db.md` L2198+](../../db-reference/putz_db.md) |
| `product` | Produto | Tabela-âncora simples, junções com `product_type`. | [`putz_db.md` L2550+](../../db-reference/putz_db.md) |
| `product_type` | Produto | Lookup. | [`putz_db.md` L2668+](../../db-reference/putz_db.md) |
| `transaction` | Transação | Tabela-âncora, suporta agregações e filtros temporais. | [`putz_db.md` L5343+](../../db-reference/putz_db.md) |
| `transaction_coupon` | Transação | Junção 1:N, cenário de filtro condicional. | [`putz_db.md` L5462+](../../db-reference/putz_db.md) |
| `ibge__city` | Geografia | Junção geográfica com FK para `ibge__uf`. | [`putz_db.md` L1523+](../../db-reference/putz_db.md) |
| `ibge__uf` | Geografia | Lookup. | [`putz_db.md` L1801+](../../db-reference/putz_db.md) |

### FKs confirmadas do subconjunto

| Tabela | FK | Evidência |
|--------|----|-----------|
| `project_item` | `project_id -> project.id` | [`putz_db.md` L3257–3259](../../db-reference/putz_db.md) |
| `project_item` | `project_step_id -> project_step.id` | [`putz_db.md` L3267–3269](../../db-reference/putz_db.md) |
| `project_item` | `product_id -> product.id` | [`putz_db.md` L3271–3273](../../db-reference/putz_db.md) |
| `project_item` | `freelancer_id -> person.id` | [`putz_db.md` L3282–3284](../../db-reference/putz_db.md) |
| `project_payment` | `project_id -> project.id` | [`putz_db.md` L3393–3395](../../db-reference/putz_db.md) |
| `transaction` | `person_id -> person.id` | [`putz_db.md` L5358–5360](../../db-reference/putz_db.md) |
| `transaction` | `project_id -> project.id` | [`putz_db.md` L5363–5365](../../db-reference/putz_db.md) |
| `transaction` | `project_item_id -> project_item.id` | [`putz_db.md` L5367–5369](../../db-reference/putz_db.md) |
| `transaction` | `subscription_id -> subscriptions.id` | [`putz_db.md` L5371–5373](../../db-reference/putz_db.md) |
| `transaction` | `related_transaction_id -> transaction.id` | [`putz_db.md` L5433–5435](../../db-reference/putz_db.md) |
| `transaction_coupon` | `person_owner_id -> person.id` | [`putz_db.md` L5475–5477](../../db-reference/putz_db.md) |
| `transaction_coupon` | `person_id -> person.id` | [`putz_db.md` L5483–5485](../../db-reference/putz_db.md) |
| `transaction_coupon` | `transaction_id -> transaction.id` | [`putz_db.md` L5513–5515](../../db-reference/putz_db.md) |
| `transaction_coupon` | `project_render_id -> project_render.id` | [`putz_db.md` L5521–5523](../../db-reference/putz_db.md) |
| `transaction_coupon` | `project_id -> project.id` | [`putz_db.md` L5525–5527](../../db-reference/putz_db.md) |
| `transaction_coupon` | `project_render_item_id -> project_render_item.id` | [`putz_db.md` L5559–5561](../../db-reference/putz_db.md) |
| `transaction_coupon` | `publications_user_id -> publications_user.id` | [`putz_db.md` L5567–5569](../../db-reference/putz_db.md) |
| `person` | `company_id -> person.id` | [`putz_db.md` L2217–2219](../../db-reference/putz_db.md) |
| `person_references` | `person_id -> person.id` | [`putz_db.md` L2379–2381](../../db-reference/putz_db.md) |
| `product` | `product_type_id -> product_type.id` | [`putz_db.md` L2558–2560](../../db-reference/putz_db.md) |
| `ibge__city` | `uf_id -> ibge__uf.id` | [`putz_db.md` L1540–1542](../../db-reference/putz_db.md) |

### Cenários de pergunta cobertos

| Cenário | Tabelas envolvidas | Tipo de SQL esperado |
|---------|--------------------|----------------------|
| Listagem simples | `franquias` | `SELECT ... FROM` |
| Filtro por enum | `project` (`project_status`) | `SELECT ... WHERE project_status = '...'` |
| Junção 1:N | `franquias` + `franquias__unidades` | `JOIN` |
| Junção em cadeia | `franquias` + `franquias__segmentos` + `franquias__redes_franquia` | `JOIN` múltiplos |
| Agregação | `project_payment` | `SUM/COUNT/GROUP BY` |
| Filtro temporal | `transaction` | `WHERE data_* BETWEEN ...` |
| Junção geográfica | `ibge__city` + `ibge__uf` | `JOIN` com lookup |

### Amplificação da massa `putz_teste` (1,3 GB -> 50 GB)

Baseline observada do schema `putz_teste`: ~1388,27 MB. Para estudo de escala do TCC, a massa no cluster deve alcançar ~50 GB (aprox. 38x) por amplificação sintética controlada.

Métodos documentados:

1. replicação estratificada de tabelas filhas (`project_item`, `transaction_coupon`) preservando FKs;
2. geração sintética de eventos em `transaction` com distribuição temporal;
3. variação de atributos não sensíveis para reduzir duplicidade literal;
4. bootstrap por domínio com checkpoints de consistência.

Riscos e controles:

- deriva estatística: registrar premissas e limitações no protocolo experimental;
- privacidade: manter mascaramento e evitar amplificação de colunas sensíveis;
- custo/tempo de carga: executar em lotes e validar contagens por domínio;
- reprodutibilidade: cada rodada de amplificação incrementa `datasetVersion`.

### Artefatos esperados

- Script de seleção e congelamento do subconjunto (a partir do dump original do Putz).
- Script de carga no cluster (ver [`carga-cluster-putz.md`](carga-cluster-putz.md)).
- Inventário de perguntas por cenário.
- Matriz de cobertura pergunta x tabelas/colunas/relacionamentos esperados.
- Registro `datasetVersion` em cada `evidence/<runId>/context.json`.

## Próximo passo

[`catalogo-atlas.md`](catalogo-atlas.md)
