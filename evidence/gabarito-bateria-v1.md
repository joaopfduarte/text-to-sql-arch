# Gabarito da bateria de avaliação (v1)

## Status

- **batteryVersion:** v1
- **Commit de referência:** `9985067`
- **Revisão humana:** aprovada (11/06/2026)
- **auditoriaExecucao:** v1 (12/06/2026) — ver § Auditoria de executabilidade
- **baselineStaticV1:** `gemini-3.5-flash`, 30 corridas (12/06/2026) — ver § Campanha baseline-static v1

Fundamentado no DDL canônico das 92 tabelas
([`putz_db.sql`](../db-reference/putz_db.sql)). Cada entrada traz a cola SQL de
referência em MySQL, pronta para rodar contra a massa fixa `putz_teste`. Os valores numéricos
esperados dependem da massa e serão conferidos pelo autor na execução.

O mapa de migração completo está em
[`matriz-cobertura-bateria-v1.md`](matriz-cobertura-bateria-v1.md).

## Propósito

Definir $G_i$ (gabarito) por pergunta para classificação de desfecho e para a métrica baseline
$A_{\mathrm{gab}}$, conforme [`metricas-formulas.md`](../docs/08-experimento-avaliacao/metricas-formulas.md).

## Convenção CSV (`dificuldade`)

Valores em [`bateria-30-perguntas-v1.csv`](bateria-30-perguntas-v1.csv): `SIMPLES`, `MÉDIA`, `COMPLEXA`
(10 linhas cada).

## Convenções MySQL da cola de referência

- Dialeto do dump `putz_db.sql` (MySQL). Identificadores podem ser citados com crase quando necessário.
- `is_active`, `is_public` e similares são `bit(1)` na maioria das tabelas e `tinyint` em `subscriptions`;
  a comparação `= 1` vale para ambos.
- Funções temporais: `YEAR()`, `MONTH()`, `CASE` para faixas. Datas em colunas `datetime`/`date`.
- `GROUP BY` completo (compatível com `ONLY_FULL_GROUP_BY`): toda coluna não agregada do `SELECT` aparece
  no `GROUP BY`.
- Sem PII desnecessária: não se selecionam credenciais nem dados de auditoria. Em `putz_user` e `person`
  usam-se apenas chaves e agregações, nunca `login`, `email`, `password_hash` ou `danger_pass`.
- A cola é uma referência válida, não a única forma correta. A validação estrutural lista as tabelas
  reais (subconjunto das 92) que uma resposta correta deve usar.

## Auditoria de executabilidade (pré-baseline)

Antes da campanha `baseline-static`, as trinta colas $G_i$ foram executadas no MySQL contra a massa
`putz_teste` (phpMyAdmin). Na primeira rodada, **onze** perguntas falharam com erro `#1054` (literais enum
ou `CASE`/`GROUP BY` malformados): Q08, Q12, Q14, Q15, Q16, Q17, Q18, Q20, Q22, Q27 e Q28. Após correção
nos commits `b67e63e` e `41974c7`, as trinta colas passaram sem erro.

| Indicador | Valor |
|-----------|-------|
| Defeito inicial nas colas | 11/30 (36,67%) |
| Colas OK sem revisão | 19/30 (63,33%) |
| Executabilidade final | 30/30 (100%) |

## Campanha baseline-static v1 (resultado)

Campanha inicial do comparativo simples, **apenas** com Google `gemini-3.5-flash` (`campaignId`:
`baseline-static`). Registro linha a linha em
[`baseline-metricas-v1.csv`](baseline-metricas-v1.csv).

| Indicador | Valor |
|-----------|-------|
| Modelo | `gemini-3.5-flash` |
| Corridas $N_{\mathrm{base}}$ | 30 |
| $A_{\mathrm{gab}}$ | 19/30 (63,33%) |

Perguntas com `gabarito_match = false`: Q08, Q12, Q14, Q15, Q16, Q17, Q18, Q20, Q22, Q27, Q28.

## Entradas

### Q01

- **Gabarito ($G_i$):** por franquia, suas unidades com cidade e estado.
- **SQL de referência (MySQL):**

```sql
SELECT f.nome AS franquia, u.cidade, u.estado
FROM franquias f
JOIN franquias__unidades u ON u.franquia_id = f.id
ORDER BY f.nome, u.estado;
```

- **Tolerância:** junção 1:N por `franquia_id`; franquias sem unidade podem ser omitidas.
- **Validação estrutural:** `franquias`, `franquias__unidades`.

### Q02

- **Gabarito ($G_i$):** produto ativo e o nome do seu tipo.
- **SQL de referência (MySQL):**

```sql
SELECT p.name AS produto, pt.name AS tipo
FROM product p
JOIN product_type pt ON p.product_type_id = pt.id
WHERE p.is_active = 1
ORDER BY pt.name, p.name;
```

- **Tolerância:** junção por `product_type_id`; filtro de ativo aceitável.
- **Validação estrutural:** `product`, `product_type`.

### Q03

- **Gabarito ($G_i$):** pagamentos por projeto, com projeto, valor e data.
- **SQL de referência (MySQL):**

```sql
SELECT pr.name AS projeto, pp.payment_value, pp.payment_date
FROM project pr
JOIN project_payment pp ON pp.project_id = pr.id
WHERE pp.is_active = 1
ORDER BY pp.payment_date DESC;
```

- **Tolerância:** junção por `project_id`; filtro de ativo aceitável.
- **Validação estrutural:** `project`, `project_payment`.

### Q04

- **Gabarito ($G_i$):** contagem de franquias por rede.
- **SQL de referência (MySQL):**

```sql
SELECT r.nome AS rede, COUNT(f.id) AS total_franquias
FROM franquias__redes_franquia r
LEFT JOIN franquias f ON f.rede_id = r.id
GROUP BY r.id, r.nome
ORDER BY total_franquias DESC;
```

- **Tolerância:** `LEFT JOIN` preserva redes sem franquia; ordem livre.
- **Validação estrutural:** `franquias__redes_franquia`, `franquias`.

### Q05

- **Gabarito ($G_i$):** franquia com seu segmento e sua rede.
- **SQL de referência (MySQL):**

```sql
SELECT f.nome AS franquia, s.nome AS segmento, r.nome AS rede
FROM franquias f
LEFT JOIN franquias__segmentos s ON f.segmento_id = s.id
LEFT JOIN franquias__redes_franquia r ON f.rede_id = r.id
ORDER BY f.nome;
```

- **Tolerância:** `LEFT JOIN` preserva franquias sem segmento ou rede; `INNER JOIN` também aceito.
- **Validação estrutural:** `franquias`, `franquias__segmentos`, `franquias__redes_franquia`.

### Q06

- **Gabarito ($G_i$):** soma de pagamentos por projeto.
- **SQL de referência (MySQL):**

```sql
SELECT pr.name AS projeto, SUM(pp.payment_value) AS total_pago
FROM project pr
JOIN project_payment pp ON pp.project_id = pr.id
WHERE pp.is_active = 1
GROUP BY pr.id, pr.name
ORDER BY total_pago DESC;
```

- **Tolerância:** agregação por projeto; ordem livre.
- **Validação estrutural:** `project`, `project_payment`.

### Q07

- **Gabarito ($G_i$):** contagem de projetos por `project_status`.
- **SQL de referência (MySQL):**

```sql
SELECT project_status, COUNT(*) AS total
FROM project
GROUP BY project_status
ORDER BY total DESC;
```

- **Tolerância:** todos os status presentes na massa; ordem livre.
- **Validação estrutural:** `project`.

### Q08

- **Gabarito ($G_i$):** soma do valor de transações `SUCCESS` por mês em 2026.
- **SQL de referência (MySQL):**

```sql
SELECT MONTH(created_date) AS mes, SUM(amount) AS total
FROM transaction
WHERE status = 'SUCCESS'
  AND YEAR(created_date) = 2026
GROUP BY MONTH(created_date)
ORDER BY mes;
```

- **Tolerância:** literal enum `SUCCESS` obrigatório (`transaction.status`: `WAITING_PAYMENT`, `SUCCESS`,
  `NO_PAY`, `SCHEDULED`, `ERROR`); agrupamento mensal; meses sem transação podem não aparecer.
- **Validação estrutural:** `transaction`.

### Q09

- **Gabarito ($G_i$):** cidades por UF, com sigla da UF e nome da cidade.
- **SQL de referência (MySQL):**

```sql
SELECT uf.uf, c.name AS cidade
FROM ibge__uf uf
JOIN ibge__city c ON c.uf_id = uf.id
WHERE c.is_active = 1
ORDER BY uf.uf, c.name;
```

- **Tolerância:** junção por `uf_id`; filtro de ativo aceitável.
- **Validação estrutural:** `ibge__uf`, `ibge__city`.

### Q10

- **Gabarito ($G_i$):** contagem de cidades por UF.
- **SQL de referência (MySQL):**

```sql
SELECT uf.uf, COUNT(c.id) AS total_cidades
FROM ibge__uf uf
JOIN ibge__city c ON c.uf_id = uf.id
GROUP BY uf.id, uf.uf
ORDER BY total_cidades DESC;
```

- **Tolerância:** agregação por UF; ordem livre.
- **Validação estrutural:** `ibge__uf`, `ibge__city`.

### Q11

- **Gabarito ($G_i$):** por item de projeto, o projeto, o produto e o freelancer.
- **SQL de referência (MySQL):**

```sql
SELECT p.name AS projeto, prod.name AS produto, fr.name AS freelancer
FROM project_item pi
JOIN project p ON pi.project_id = p.id
JOIN product prod ON pi.product_id = prod.id
JOIN person fr ON pi.freelancer_id = fr.id
WHERE pi.is_active = 1
ORDER BY p.name;
```

- **Tolerância:** cadeia de 3 junções; itens sem produto ou freelancer podem ser omitidos.
- **Validação estrutural:** `project_item`, `project`, `product`, `person`.

### Q12

- **Gabarito ($G_i$):** eventos de timeline com `event_type = 'APPROVED'`, com projeto e etapa.
- **SQL de referência (MySQL):**

```sql
SELECT p.name AS projeto, ps.name AS etapa, te.title AS evento, te.conclusion_date
FROM timeline_event te
JOIN project_step ps ON te.project_step_id = ps.id
JOIN project p ON ps.project_id = p.id
WHERE te.event_type = 'APPROVED'
ORDER BY te.conclusion_date DESC;
```

- **Tolerância:** literal enum `APPROVED` obrigatório (`timeline_event.event_type`: `TOPIC`, `PARTIAL`,
  `COMMIT`, `APPROVED`, `SOLVED`, `REQUEST`); cadeia via `project_step`.
- **Validação estrutural:** `timeline_event`, `project_step`, `project`.

### Q13

- **Gabarito ($G_i$):** projetos cujo total de pagamentos supera a média do total por projeto.
- **SQL de referência (MySQL):**

```sql
SELECT pr.name AS projeto, SUM(pp.payment_value) AS total_pago
FROM project pr
JOIN project_payment pp ON pp.project_id = pr.id
WHERE pp.is_active = 1
GROUP BY pr.id, pr.name
HAVING SUM(pp.payment_value) > (
    SELECT AVG(soma)
    FROM (
        SELECT SUM(payment_value) AS soma
        FROM project_payment
        WHERE is_active = 1
        GROUP BY project_id
    ) AS medias
)
ORDER BY total_pago DESC;
```

- **Tolerância:** a média é sobre o total por projeto (não sobre linhas de pagamento).
- **Validação estrutural:** `project`, `project_payment`.

### Q14

- **Gabarito ($G_i$):** contagem de transações `SUCCESS` por semestre de 2026. Aceita até 2 SQLs (ex.: uma
  por semestre, ou uma única com `CASE`).
- **SQL de referência (MySQL):**

```sql
SELECT
    CASE
        WHEN MONTH(created_date) <= 6 THEN 'S1'
        ELSE 'S2'
    END AS semestre,
    COUNT(*) AS total
FROM transaction
WHERE status = 'SUCCESS'
  AND YEAR(created_date) = 2026
GROUP BY semestre
ORDER BY semestre
LIMIT 0, 25;
```

- **Tolerância:** literal enum `SUCCESS` obrigatório; divisão semestral por mês; rótulos `S1`/`S2` livres.
- **Validação estrutural:** `transaction`.

### Q15

- **Gabarito ($G_i$):** soma de transações `SUCCESS` por UF do cliente (via `person.address_uf`).
- **SQL de referência (MySQL):**

```sql
SELECT uf.uf, uf.region, SUM(t.amount) AS total
FROM transaction t
JOIN person pe ON t.person_id = pe.id
JOIN ibge__uf uf ON pe.address_uf = uf.uf
WHERE t.status = 'SUCCESS'
GROUP BY uf.id, uf.uf, uf.region
ORDER BY total DESC;
```

- **Tolerância:** literal enum `SUCCESS` obrigatório; join geográfico usa `address_uf = uf.uf`; pressupõe UF
  normalizada na massa.
- **Validação estrutural:** `transaction`, `person`, `ibge__uf`.

### Q16

- **Gabarito ($G_i$):** transações `SUCCESS` ligadas a itens, com valor, projeto, produto e cliente.
- **SQL de referência (MySQL):**

```sql
SELECT t.amount, p.name AS projeto, prod.name AS produto, cli.name AS cliente
FROM transaction t
JOIN project_item pi ON t.project_item_id = pi.id
JOIN project p ON pi.project_id = p.id
JOIN product prod ON pi.product_id = prod.id
JOIN person cli ON p.client_id = cli.id
WHERE t.status = 'SUCCESS'
ORDER BY t.amount DESC;
```

- **Tolerância:** literal enum `SUCCESS` obrigatório; cadeia cross-domínio de 5 tabelas; cliente via
  `project.client_id`.
- **Validação estrutural:** `transaction`, `project_item`, `project`, `product`, `person`.

### Q17

- **Gabarito ($G_i$):** cupons `USED` por projeto, com tipo, status, desconto e usuário do cupom.
- **SQL de referência (MySQL):**

```sql
SELECT p.name AS projeto, tc.coupon_type, tc.code_status,
       tc.discount_percentual, usr.name AS usuario_cupom
FROM transaction_coupon tc
JOIN project p ON tc.project_id = p.id
JOIN person usr ON tc.person_id = usr.id
WHERE tc.code_status = 'USED'
ORDER BY tc.discount_percentual DESC;
```

- **Tolerância:** literal enum `USED` obrigatório (`transaction_coupon.code_status`: `AVAILABLE`, `PROMOTIONAL`,
  `WAITING_PAYMENT`, `USED`, `GIFT_CODE`, `EXPIRED`, `WAITING_VIDEO`, `OTHER`); usuário via
  `transaction_coupon.person_id`.
- **Validação estrutural:** `transaction_coupon`, `project`, `person`.

### Q18

- **Gabarito ($G_i$):** por cliente, contagem de projetos distintos e total movimentado em `SUCCESS`.
- **SQL de referência (MySQL):**

```sql
SELECT pe.name AS cliente, COUNT(DISTINCT t.project_id) AS projetos,
       SUM(t.amount) AS total
FROM transaction t
JOIN person pe ON t.person_id = pe.id
WHERE t.status = 'SUCCESS'
GROUP BY pe.id, pe.name
ORDER BY total DESC;
```

- **Tolerância:** literal enum `SUCCESS` obrigatório; agregação por pessoa; `COUNT(DISTINCT project_id)`
  aceitável como complemento.
- **Validação estrutural:** `transaction`, `person`.

### Q19

- **Gabarito ($G_i$):** por tipo de produto, contagem de itens de projeto e soma do `value_base`. Aceita
  até 2 SQLs (ex.: contagem e soma separadas).
- **SQL de referência (MySQL):**

```sql
SELECT pt.name AS tipo_produto, COUNT(pi.id) AS total_itens,
       SUM(pi.value_base) AS soma_valor_base
FROM project_item pi
JOIN product prod ON pi.product_id = prod.id
JOIN product_type pt ON prod.product_type_id = pt.id
WHERE pi.is_active = 1
GROUP BY pt.id, pt.name
ORDER BY soma_valor_base DESC;
```

- **Tolerância:** cadeia `project_item`->`product`->`product_type`; agregações por tipo.
- **Validação estrutural:** `project_item`, `product`, `product_type`.

### Q20

- **Gabarito ($G_i$):** assinaturas `ACTIVE` com plano, categoria e valor da transação de pagamento.
- **SQL de referência (MySQL):**

```sql
SELECT s.id, sp.plan_name, sp.plan_category, t.amount AS valor_transacao,
       s.subscription_status
FROM subscriptions s
JOIN subscription_plans sp ON s.subscription_plan_id = sp.id
LEFT JOIN transaction t ON s.transaction_id = t.id
WHERE s.subscription_status = "ACTIVE"
ORDER BY t.amount DESC;
```

- **Tolerância:** literal enum `ACTIVE` obrigatório (`subscriptions.subscription_status`: `PENDING`, `ACTIVE`,
  `EXPIRED`, `CANCELED`); `LEFT JOIN` na transação preserva assinaturas sem pagamento.
- **Validação estrutural:** `subscriptions`, `subscription_plans`, `transaction`.

### Q21

- **Gabarito ($G_i$):** por item de ativo ativo, a categoria e a categoria-raiz correspondente.
- **SQL de referência (MySQL):**

```sql
SELECT ai.name AS item, c.name AS categoria, raiz.name AS categoria_raiz
FROM asset_item ai
JOIN asset_item__categories aic ON aic.asset_item_id = ai.id
JOIN asset_category c ON aic.category_id = c.id
LEFT JOIN asset_category raiz ON c.root_category_id = raiz.id
WHERE ai.is_active = 1
ORDER BY raiz.name, c.name, ai.name;
```

- **Tolerância:** M:N via `asset_item__categories`; raiz por auto-junção `root_category_id`; categorias-raiz
  sem pai podem ter `categoria_raiz` nula.
- **Validação estrutural:** `asset_item`, `asset_item__categories`, `asset_category`.

### Q22

- **Gabarito ($G_i$):** itens de ativo `IMAGE` com categoria, raiz e tipo, só categorias públicas.
- **SQL de referência (MySQL):**

```sql
SELECT ai.name AS item, c.name AS categoria, c.category_type AS tipo_categoria,
       raiz.name AS categoria_raiz
FROM asset_item ai
JOIN asset_item__categories aic ON aic.asset_item_id = ai.id
JOIN asset_category c ON aic.category_id = c.id
LEFT JOIN asset_category raiz ON c.root_category_id = raiz.id
WHERE ai.resource_type = 'IMAGE'
  AND c.is_public = 1
ORDER BY raiz.name, c.name, ai.name;
```

- **Tolerância:** literal enum `IMAGE` obrigatório (`asset_item.resource_type`: `LETTERING`, `VIDEO`, `AUDIO`,
  `IMAGE`, `COMPANY`); filtro `is_public = 1`; raiz por auto-junção.
- **Validação estrutural:** `asset_item`, `asset_item__categories`, `asset_category`.

### Q23

- **Gabarito ($G_i$):** contagem de itens ativos por categoria-raiz pública e a raiz com mais itens. Aceita
  até 2 SQLs (ex.: a contagem por raiz e uma consulta auxiliar do topo).
- **SQL de referência (MySQL):**

```sql
SELECT raiz.name AS categoria_raiz, COUNT(ai.id) AS total_itens
FROM asset_category raiz
JOIN asset_category c ON c.root_category_id = raiz.id
JOIN asset_item__categories aic ON aic.category_id = c.id
JOIN asset_item ai ON aic.asset_item_id = ai.id
WHERE raiz.is_public = 1 AND ai.is_active = 1
GROUP BY raiz.id, raiz.name
ORDER BY total_itens DESC;
```

- **Tolerância:** cadeia raiz->categoria->item via M:N; topo pode vir por `LIMIT 1` em SQL auxiliar.
- **Validação estrutural:** `asset_category`, `asset_item__categories`, `asset_item`.

### Q24

- **Gabarito ($G_i$):** por autoridade, contagem de usuários e a descrição da autoridade. Sem PII.
- **SQL de referência (MySQL):**

```sql
SELECT a.name AS autoridade, a.description, COUNT(ua.user_id) AS total_usuarios
FROM putz_authority a
LEFT JOIN putz_user_authority ua ON ua.authority_name = a.name
GROUP BY a.name, a.description
ORDER BY total_usuarios DESC;
```

- **Tolerância:** `LEFT JOIN` preserva autoridades sem usuário; só contagens, nunca dados do usuário.
- **Validação estrutural:** `putz_authority`, `putz_user_authority`.

### Q25

- **Gabarito ($G_i$):** por categoria de ativo, contagem de usuários com acesso e a categoria-raiz.
- **SQL de referência (MySQL):**

```sql
SELECT c.name AS categoria, raiz.name AS categoria_raiz,
       COUNT(acu.person_id) AS total_usuarios
FROM asset_category c
LEFT JOIN asset_category raiz ON c.root_category_id = raiz.id
LEFT JOIN asset_category__users acu ON acu.categories_id = c.id
GROUP BY c.id, c.name, raiz.name
ORDER BY total_usuarios DESC;
```

- **Tolerância:** `asset_category__users.person_id` referencia `putz_user`; só contagens, sem PII.
- **Validação estrutural:** `asset_category`, `asset_category__users`.

### Q26

- **Gabarito ($G_i$):** por autoridade, usuários distintos com acesso a categorias de ativo públicas.
- **SQL de referência (MySQL):**

```sql
SELECT ua.authority_name AS autoridade, COUNT(DISTINCT u.id) AS usuarios_com_acesso
FROM putz_user_authority ua
JOIN putz_user u ON ua.user_id = u.id
JOIN asset_category__users acu ON acu.person_id = u.id
JOIN asset_category c ON acu.categories_id = c.id
WHERE c.is_public = 1
GROUP BY ua.authority_name
ORDER BY usuarios_com_acesso DESC;
```

- **Tolerância:** cadeia permissão->usuário->acesso->categoria; `putz_user` só em junção, sem PII no
  `SELECT`.
- **Validação estrutural:** `putz_user_authority`, `putz_user`, `asset_category__users`, `asset_category`.

### Q27

- **Gabarito ($G_i$):** itens de render no painel, separando solicitações sem conta e com conta. Aceita até
  2 SQLs (ex.: um por situação, ou um único com `CASE`).
- **SQL de referência (MySQL):**

```sql
SELECT
    CASE
        WHEN pu.owner_id IS NULL THEN 'SEM_CONTA'
        ELSE 'COM_CONTA'
    END AS situacao,
    COUNT(DISTINCT pri.id) AS total_itens_render
FROM publications_user pu
JOIN project_render_item pri ON pu.project_render_item_id = pri.id
JOIN project_render pr ON pri.render_project_id = pr.id
GROUP BY situacao
ORDER BY situacao;
```

- **Tolerância:** rótulos `SEM_CONTA`/`COM_CONTA` livres; `owner_id IS NULL` = pediu sem conta;
  `owner_id IS NOT NULL` = criou conta depois.
- **Validação estrutural:** `publications_user`, `project_render_item`, `project_render`.

### Q28

- **Gabarito ($G_i$):** solicitações com render e publicação, com status, render e situação de conta.
- **SQL de referência (MySQL):**

```sql
SELECT
    pu.status,
    pr.name AS render,
    pub.platform,
    CASE
        WHEN pu.owner_id IS NULL THEN 'SEM_CONTA'
        ELSE 'COM_CONTA'
    END AS situacao
FROM publications_user pu
JOIN project_render_item pri ON pu.project_render_item_id = pri.id
JOIN project_render pr ON pri.render_project_id = pr.id
JOIN publications pub ON pu.publication_id = pub.id
ORDER BY pu.status;
```

- **Tolerância:** rótulos `SEM_CONTA`/`COM_CONTA` livres; `INNER JOIN` exige render e publicação presentes;
  situação por `owner_id`.
- **Validação estrutural:** `publications_user`, `project_render_item`, `project_render`, `publications`.

### Q29

- **Gabarito ($G_i$):** solicitações criadas por mês em 2026, separando com e sem conta.
- **SQL de referência (MySQL):**

```sql
SELECT MONTH(pu.created_date) AS mes,
       SUM(CASE WHEN pu.owner_id IS NULL THEN 1 ELSE 0 END) AS sem_conta,
       SUM(CASE WHEN pu.owner_id IS NOT NULL THEN 1 ELSE 0 END) AS com_conta
FROM publications_user pu
JOIN project_render_item pri ON pu.project_render_item_id = pri.id
JOIN project_render pr ON pri.render_project_id = pr.id
WHERE YEAR(pu.created_date) = 2026
GROUP BY MONTH(pu.created_date)
ORDER BY mes;
```

- **Tolerância:** agrupamento mensal por `created_date`; meses sem solicitação podem não aparecer.
- **Validação estrutural:** `publications_user`, `project_render_item`, `project_render`.

### Q30

- **Gabarito ($G_i$):** itens de render solicitados por clientes de cada UF, com a região.
- **SQL de referência (MySQL):**

```sql
SELECT uf.uf, uf.region, COUNT(pri.id) AS total_itens_render
FROM project_render_item pri
JOIN person pe ON pri.person_id = pe.id
JOIN ibge__uf uf ON pe.address_uf = uf.uf
JOIN project_render pr ON pri.render_project_id = pr.id
GROUP BY uf.id, uf.uf, uf.region
ORDER BY total_itens_render DESC;
```

- **Tolerância:** join geográfico por `person.address_uf = uf.uf`; pressupõe UF normalizada na massa.
- **Validação estrutural:** `project_render_item`, `person`, `ibge__uf`, `project_render`.
