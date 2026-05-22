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

O subconjunto XPTO substitui qualquer schema sintético (anteriormente `sales.*`) como única massa de avaliação do TCC. Toda referência futura em contratos MCP, harness e exemplos deve citar tabelas reais do XPTO, presentes em [Monografia](../monografia.md).

### Regras da massa

- O subconjunto é congelado antes das corridas finais e versionado em `datasetVersion`.
- Cada pergunta tem SQL de referência ou resultado esperado, quando aplicável.
- Alteração do subconjunto exige nova versão e justificativa em ADR.
- Dados são extraídos do dump original e residem no cluster (HDFS/Hive), sem dados sensíveis ou pessoais sem mascaramento.

### Subconjunto inicial proposto

Critério de seleção: tabelas com FKs explícitas no export (notação `-> tabela.coluna`) ou tabelas-âncora de domínios distintos para cobrir filtros, agregações e junções.

| Tabela | Domínio | Função na avaliação | Evidência |
|--------|---------|---------------------|-----------|
| `franquias` | Franquias | Tabela-âncora, possui FKs `segmento_id`, `rede_id`. | [`base de referência XPTO.md` L1173–1215](../monografia.md) |
| `franquias__segmentos` | Franquias | Lookup para junções 1:N a partir de `franquias`. | [`base de referência XPTO.md` L1407+](../monografia.md) |
| `franquias__redes_franquia` | Franquias | Lookup para junções 1:N a partir de `franquias`. | [`base de referência XPTO.md` L1319+](../monografia.md) |
| `franquias__unidades` | Franquias | Granularidade fina, suporta agregações. | [`base de referência XPTO.md` L1494+](../monografia.md) |
| `project` | Projetos | Tabela-âncora, enum `project_status`. | [`base de referência XPTO.md` L2709+](../monografia.md) |
| `project_item` | Projetos | Filhos de `project`, suporta junção + filtro. | [`base de referência XPTO.md` L3249+](../monografia.md) |
| `project_payment` | Projetos | Permite agregações monetárias. | [`base de referência XPTO.md` L3385+](../monografia.md) |
| `person` | Pessoa | Tabela-âncora referenciada por múltiplos domínios. | [`base de referência XPTO.md` L2198+](../monografia.md) |
| `product` | Produto | Tabela-âncora simples, junções com `product_type`. | [`base de referência XPTO.md` L2550+](../monografia.md) |
| `product_type` | Produto | Lookup. | [`base de referência XPTO.md` L2668+](../monografia.md) |
| `transaction` | Transação | Tabela-âncora, suporta agregações e filtros temporais. | [`base de referência XPTO.md` L5343+](../monografia.md) |
| `transaction_coupon` | Transação | Junção 1:N, cenário de filtro condicional. | [`base de referência XPTO.md` L5462+](../monografia.md) |
| `ibge__city` | Geografia | Junção geográfica com FK para `ibge__uf`. | [`base de referência XPTO.md` L1523+](../monografia.md) |
| `ibge__uf` | Geografia | Lookup. | [`base de referência XPTO.md` L1801+](../monografia.md) |

### FKs confirmadas do subconjunto

| Tabela | FK | Evidência |
|--------|----|-----------|
| `project_item` | `project_id -> project.id` | [`base de referência XPTO.md` L3257–3259](../monografia.md) |
| `project_item` | `project_step_id -> project_step.id` | [`base de referência XPTO.md` L3267–3269](../monografia.md) |
| `project_item` | `product_id -> product.id` | [`base de referência XPTO.md` L3271–3273](../monografia.md) |
| `project_item` | `freelancer_id -> person.id` | [`base de referência XPTO.md` L3282–3284](../monografia.md) |
| `project_payment` | `project_id -> project.id` | [`base de referência XPTO.md` L3393–3395](../monografia.md) |
| `transaction` | `person_id -> person.id` | [`base de referência XPTO.md` L5358–5360](../monografia.md) |
| `transaction` | `project_id -> project.id` | [`base de referência XPTO.md` L5363–5365](../monografia.md) |
| `transaction` | `project_item_id -> project_item.id` | [`base de referência XPTO.md` L5367–5369](../monografia.md) |
| `transaction` | `subscription_id -> subscriptions.id` | [`base de referência XPTO.md` L5371–5373](../monografia.md) |
| `transaction` | `related_transaction_id -> transaction.id` | [`base de referência XPTO.md` L5433–5435](../monografia.md) |
| `transaction_coupon` | `person_owner_id -> person.id` | [`base de referência XPTO.md` L5475–5477](../monografia.md) |
| `transaction_coupon` | `person_id -> person.id` | [`base de referência XPTO.md` L5483–5485](../monografia.md) |
| `transaction_coupon` | `transaction_id -> transaction.id` | [`base de referência XPTO.md` L5513–5515](../monografia.md) |
| `transaction_coupon` | `project_render_id -> project_render.id` | [`base de referência XPTO.md` L5521–5523](../monografia.md) |
| `transaction_coupon` | `project_id -> project.id` | [`base de referência XPTO.md` L5525–5527](../monografia.md) |
| `transaction_coupon` | `project_render_item_id -> project_render_item.id` | [`base de referência XPTO.md` L5559–5561](../monografia.md) |
| `transaction_coupon` | `publications_user_id -> publications_user.id` | [`base de referência XPTO.md` L5567–5569](../monografia.md) |
| `person` | `company_id -> person.id` | [`base de referência XPTO.md` L2217–2219](../monografia.md) |
| `person_references` | `person_id -> person.id` | [`base de referência XPTO.md` L2379–2381](../monografia.md) |
| `product` | `product_type_id -> product_type.id` | [`base de referência XPTO.md` L2558–2560](../monografia.md) |
| `ibge__city` | `uf_id -> ibge__uf.id` | [`base de referência XPTO.md` L1540–1542](../monografia.md) |

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

### Amplificação da massa `xpto_teste` (1,3 GB -> 50 GB)

Baseline observada do schema `xpto_teste`: ~1388,27 MB. Para estudo de escala do TCC, a massa no cluster deve alcançar ~50 GB (aprox. 38x) por amplificação sintética controlada.

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

- Script de seleção e congelamento do subconjunto (a partir do dump original do XPTO).
- Script de carga no cluster (ver [`carga-cluster-xpto.md`](carga-cluster-xpto.md)).
- Inventário de perguntas por cenário.
- Matriz de cobertura pergunta x tabelas/colunas/relacionamentos esperados.
- Registro `datasetVersion` em cada `evidence/<runId>/context.json`.

## Próximo passo

[`catalogo-atlas.md`](catalogo-atlas.md)
