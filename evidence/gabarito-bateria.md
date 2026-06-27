---
description: Colas SQL de referência e gabarito Gi por pergunta da bateria.
tags:
  - experimento
  - evidencia
---

# Gabarito da bateria de avaliação

## Status

- **Revisão humana:** aprovada (11/06/2026)
- **auditoriaExecucao:** 12/06/2026 — ver § Auditoria de executabilidade
- **baselineStatic:** `gemini-3.5-flash` e `gemini-3.1-pro`, 40 corridas cada (jun/2026) — ver § Campanha
  baseline-static e [Auditoria baseline](baseline-auditoria-gabarito.md)
- **Remodalização:** colas Q01–Q40 unificadas em MySQL 8+, schema `base_laboratorial`, identificadores reais
  (jun/2026)

Fundamentado no DDL canônico
[Dump MySQL base_laboratorial](../dados/base_laboratorial.sql) e no inventário em
[Schema massa de teste](../arquitetura/dados/schema-massa-teste.md). Cada entrada traz a cola SQL de
referência em **MySQL 8+**, pronta para rodar contra o schema **`base_laboratorial`**. Os valores numéricos
esperados dependem da massa e serão conferidos pelo autor na execução.

O mapa de cobertura está em
[Matriz de cobertura da bateria](matriz-cobertura-bateria.md).


## Convenção CSV (`dificuldade`)

Valores em [Bateria de perguntas](bateria-40-perguntas.csv): `SIMPLES`, `MÉDIA`, `COMPLEXA`.
Distribuição: `SIMPLES` 10, `MÉDIA` 10, `COMPLEXA` 20 (Q21–Q40), totalizando 40 perguntas.


## Convenções MySQL (colas de referência)

- Dialeto **MySQL 8 ou superior**; schema **`base_laboratorial`**; identificadores citados com crase quando
  necessário.
- Colunas `bit(1)` e `tinyint`: comparação `= 1` vale para ambos.
- Funções temporais: `YEAR()`, `MONTH()`, `DATEDIFF`, `DATE_SUB`, `CASE` para faixas.
- Funções JSON (Q31–Q40): `JSON_EXTRACT`, `JSON_UNQUOTE`, `JSON_VALID`, `JSON_CONTAINS_PATH`,
  `JSON_LENGTH`.
- `GROUP BY` completo (compatível com `ONLY_FULL_GROUP_BY`).
- Sem PII desnecessária: não se selecionam credenciais nem dados de auditoria sensíveis.
- Tabela-âncora das perguntas Q27–Q40 sobre pedidos de vídeo: `project_render_item` (alias `pri`).
- A cola é referência válida, não a única forma correta. A validação estrutural lista as tabelas reais
  que uma resposta correta deve usar.


## Auditoria de executabilidade (pré-baseline)

Antes da campanha `baseline-static`, as colas $G_i$ foram executadas em **MySQL 8+** contra
`base_laboratorial`. Na primeira rodada (subconjunto histórico de 30 perguntas), onze colas falharam com
erro `#1054`; após correção, todas passaram. A bateria expandida para 40 perguntas manteve a mesma
convenção MySQL.

| Indicador | Valor |
|-----------|-------|
| Defeito inicial (30 perguntas, histórico) | 11/30 (36,67%) |
| Executabilidade final (40 perguntas) | 40/40 (100%) |


## Campanha baseline-static (resultado)

Campanha do comparativo simples com Google `gemini-3.5-flash` e `gemini-3.1-pro` (`campaignId`:
`baseline-static`). Registro linha a linha em
[Métricas baseline](baseline-metricas.csv); mapa $g_i$ e notas em
[Auditoria baseline](baseline-auditoria-gabarito.md).

| Indicador | `gemini-3.5-flash` | `gemini-3.1-pro` |
|-----------|-------------------|------------------|
| Corridas $N_{\mathrm{base}}$ | 40 | 40 |
| $A_{\mathrm{gab}}$ | 19/40 (47,5%) | 31/40 (77,5%) |


## Entradas


### Q01

- **Gabarito ($G_i$):** Por franquia, unidades com cidade e estado.
- **SQL de referência (MySQL 8+, schema `base_laboratorial`):**

```sql
label={lst:gabarito-q01}]
SELECT f.nome AS franquia, u.cidade, u.estado
FROM franquias f
JOIN franquias__unidades u ON u.franquia_id = f.id
ORDER BY f.nome, u.estado;
```

- **Tolerância:** Junção 1:N por `franquia_id`; franquias sem unidade podem ser omitidas.
- **Validação estrutural:** `franquias`, `franquias__unidades`.

### Q02

- **Gabarito ($G_i$):** Produto ativo e rótulo do tipo.
- **SQL de referência (MySQL 8+, schema `base_laboratorial`):**

```sql
label={lst:gabarito-q02}]
SELECT p.name AS produto, pt.name AS tipo
FROM product p
JOIN product_type pt ON p.product_type_id = pt.id
WHERE p.is_active = 1
ORDER BY pt.name, p.name;
```

- **Tolerância:** Junção por `product_type_id`; filtro `is_active = 1` aceitável.
- **Validação estrutural:** `product`, `product_type`.

### Q03

- **Gabarito ($G_i$):** Pagamentos por projeto, com valor e data.
- **SQL de referência (MySQL 8+, schema `base_laboratorial`):**

```sql
label={lst:gabarito-q03}]
SELECT pr.name AS projeto, pp.payment_value, pp.payment_date
FROM project pr
JOIN project_payment pp ON pp.project_id = pr.id
WHERE pp.is_active = 1
ORDER BY pp.payment_date DESC;
```

- **Tolerância:** Junção por `project_id`; filtro de pagamento ativo aceitável.
- **Validação estrutural:** `project`, `project_payment`.

### Q04

- **Gabarito ($G_i$):** Contagem de franquias por rede.
- **SQL de referência (MySQL 8+, schema `base_laboratorial`):**

```sql
label={lst:gabarito-q04}]
SELECT r.nome AS rede, COUNT(f.id) AS total_franquias
FROM franquias__redes_franquia r
LEFT JOIN franquias f ON f.rede_id = r.id
GROUP BY r.id, r.nome
ORDER BY total_franquias DESC;
```

- **Tolerância:** `LEFT JOIN` preserva redes sem franquia; ordem livre.
- **Validação estrutural:** `franquias__redes_franquia`, `franquias`.

### Q05

- **Gabarito ($G_i$):** Franquia com segmento e rede.
- **SQL de referência (MySQL 8+, schema `base_laboratorial`):**

```sql
label={lst:gabarito-q05}]
SELECT f.nome AS franquia, s.nome AS segmento, r.nome AS rede
FROM franquias f
LEFT JOIN franquias__segmentos s ON f.segmento_id = s.id
LEFT JOIN franquias__redes_franquia r ON f.rede_id = r.id
ORDER BY f.nome;
```

- **Tolerância:** `LEFT JOIN` preserva franquias sem segmento ou rede.
- **Validação estrutural:** `franquias`, `franquias__segmentos`, `franquias__redes_franquia`.

### Q06

- **Gabarito ($G_i$):** Soma de pagamentos por projeto.
- **SQL de referência (MySQL 8+, schema `base_laboratorial`):**

```sql
label={lst:gabarito-q06}]
SELECT pr.name AS projeto, SUM(pp.payment_value) AS total_pago
FROM project pr
JOIN project_payment pp ON pp.project_id = pr.id
WHERE pp.is_active = 1
GROUP BY pr.id, pr.name
ORDER BY total_pago DESC;
```

- **Tolerância:** Agregação por projeto; ordem livre.
- **Validação estrutural:** `project`, `project_payment`.

### Q07

- **Gabarito ($G_i$):** Contagem de projetos por `project_status`.
- **SQL de referência (MySQL 8+, schema `base_laboratorial`):**

```sql
label={lst:gabarito-q07}]
SELECT project_status, COUNT(*) AS total
FROM project
GROUP BY project_status
ORDER BY total DESC;
```

- **Tolerância:** Todos os status presentes na massa; ordem livre.
- **Validação estrutural:** `project`.

### Q08

- **Gabarito ($G_i$):** Soma de transações `SUCCESS` por mês em 2026.
- **SQL de referência (MySQL 8+, schema `base_laboratorial`):**

```sql
label={lst:gabarito-q08}]
SELECT MONTH(created_date) AS mes, SUM(amount) AS total
FROM transaction
WHERE status = 'SUCCESS'
  AND YEAR(created_date) = 2026
GROUP BY MONTH(created_date)
ORDER BY mes;
```

- **Tolerância:** Literal enum `SUCCESS` obrigatório; agrupamento mensal.
- **Validação estrutural:** `transaction`.

### Q09

- **Gabarito ($G_i$):** Cidades por UF com sigla e nome.
- **SQL de referência (MySQL 8+, schema `base_laboratorial`):**

```sql
label={lst:gabarito-q09}]
SELECT uf.uf, c.name AS cidade
FROM ibge__uf uf
JOIN ibge__city c ON c.uf_id = uf.id
WHERE c.is_active = 1
ORDER BY uf.uf, c.name;
```

- **Tolerância:** Junção por `uf_id`; filtro de cidade ativa aceitável.
- **Validação estrutural:** `ibge__uf`, `ibge__city`.

### Q10

- **Gabarito ($G_i$):** Contagem de cidades por UF.
- **SQL de referência (MySQL 8+, schema `base_laboratorial`):**

```sql
label={lst:gabarito-q10}]
SELECT uf.uf, COUNT(c.id) AS total_cidades
FROM ibge__uf uf
JOIN ibge__city c ON c.uf_id = uf.id
GROUP BY uf.id, uf.uf
ORDER BY total_cidades DESC;
```

- **Tolerância:** Agregação por UF; ordem livre.
- **Validação estrutural:** `ibge__uf`, `ibge__city`.

### Q11

- **Gabarito ($G_i$):** Por item de projeto: projeto, produto e freelancer.
- **SQL de referência (MySQL 8+, schema `base_laboratorial`):**

```sql
label={lst:gabarito-q11}]
SELECT p.name AS projeto, prod.name AS produto, fr.name AS freelancer
FROM project_item pi
JOIN project p ON pi.project_id = p.id
JOIN product prod ON pi.product_id = prod.id
JOIN person fr ON pi.freelancer_id = fr.id
WHERE pi.is_active = 1
ORDER BY p.name;
```

- **Tolerância:** Cadeia de três junções; itens sem produto ou freelancer podem ser omitidos.
- **Validação estrutural:** `project_item`, `project`, `product`, `person`.

### Q12

- **Gabarito ($G_i$):** Eventos de timeline `APPROVED`, com projeto e etapa.
- **SQL de referência (MySQL 8+, schema `base_laboratorial`):**

```sql
label={lst:gabarito-q12}]
SELECT p.name AS projeto, ps.name AS etapa, te.title AS evento, te.conclusion_date
FROM timeline_event te
JOIN project_step ps ON te.project_step_id = ps.id
JOIN project p ON ps.project_id = p.id
WHERE te.event_type = 'APPROVED'
ORDER BY te.conclusion_date DESC;
```

- **Tolerância:** Literal enum `APPROVED` obrigatório; cadeia via `project_step`.
- **Validação estrutural:** `timeline_event`, `project_step`, `project`.

### Q13

- **Gabarito ($G_i$):** Projetos cujo total de pagamentos supera a média por projeto.
- **SQL de referência (MySQL 8+, schema `base_laboratorial`):**

```sql
label={lst:gabarito-q13}]
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

- **Tolerância:** A média é sobre o total por projeto, não por linha de pagamento.
- **Validação estrutural:** `project`, `project_payment`.

### Q14

- **Gabarito ($G_i$):** Contagem de transações `SUCCESS` por semestre de 2026.
- **SQL de referência (MySQL 8+, schema `base_laboratorial`):**

```sql
label={lst:gabarito-q14}]
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

- **Tolerância:** Literal `SUCCESS`; divisão semestral por mês; rótulos `S1`/`S2` livres.
- **Validação estrutural:** `transaction`.

### Q15

- **Gabarito ($G_i$):** Soma de transações `SUCCESS` por UF do cliente.
- **SQL de referência (MySQL 8+, schema `base_laboratorial`):**

```sql
label={lst:gabarito-q15}]
SELECT uf.uf, uf.region, SUM(t.amount) AS total
FROM transaction t
JOIN person pe ON t.person_id = pe.id
JOIN ibge__uf uf ON pe.address_uf = uf.uf
WHERE t.status = 'SUCCESS'
GROUP BY uf.id, uf.uf, uf.region
ORDER BY total DESC;
```

- **Tolerância:** Literal `SUCCESS`; join geográfico via `person.address_uf`.
- **Validação estrutural:** `transaction`, `person`, `ibge__uf`.

### Q16

- **Gabarito ($G_i$):** Transações `SUCCESS` ligadas a itens, com valor, projeto, produto e cliente.
- **SQL de referência (MySQL 8+, schema `base_laboratorial`):**

```sql
label={lst:gabarito-q16}]
SELECT t.amount, p.name AS projeto, prod.name AS produto, cli.name AS cliente
FROM transaction t
JOIN project_item pi ON t.project_item_id = pi.id
JOIN project p ON pi.project_id = p.id
JOIN product prod ON pi.product_id = prod.id
JOIN person cli ON p.client_id = cli.id
WHERE t.status = 'SUCCESS'
ORDER BY t.amount DESC;
```

- **Tolerância:** Literal `SUCCESS`; cadeia cross-domínio de cinco tabelas.
- **Validação estrutural:** `transaction`, `project_item`, `project`, `product`, `person`.

### Q17

- **Gabarito ($G_i$):** Cupons `USED` por projeto, com tipo, status, desconto e usuário.
- **SQL de referência (MySQL 8+, schema `base_laboratorial`):**

```sql
label={lst:gabarito-q17}]
SELECT p.name AS projeto, tc.coupon_type, tc.code_status,
       tc.discount_percentual, usr.name AS usuario_cupom
FROM transaction_coupon tc
JOIN project p ON tc.project_id = p.id
JOIN person usr ON tc.person_id = usr.id
WHERE tc.code_status = 'USED'
ORDER BY tc.discount_percentual DESC;
```

- **Tolerância:** Literal enum `USED` obrigatório.
- **Validação estrutural:** `transaction_coupon`, `project`, `person`.

### Q18

- **Gabarito ($G_i$):** Por cliente, projetos distintos e total movimentado em `SUCCESS`.
- **SQL de referência (MySQL 8+, schema `base_laboratorial`):**

```sql
label={lst:gabarito-q18}]
SELECT pe.name AS cliente, COUNT(DISTINCT t.project_id) AS projetos,
       SUM(t.amount) AS total
FROM transaction t
JOIN person pe ON t.person_id = pe.id
WHERE t.status = 'SUCCESS'
GROUP BY pe.id, pe.name
ORDER BY total DESC;
```

- **Tolerância:** Literal `SUCCESS`; agregação por cliente.
- **Validação estrutural:** `transaction`, `person`.

### Q19

- **Gabarito ($G_i$):** Por tipo de produto, contagem de itens e soma de `value_base`.
- **SQL de referência (MySQL 8+, schema `base_laboratorial`):**

```sql
label={lst:gabarito-q19}]
SELECT pt.name AS tipo_produto, COUNT(pi.id) AS total_itens,
       SUM(pi.value_base) AS soma_valor_base
FROM project_item pi
JOIN product prod ON pi.product_id = prod.id
JOIN product_type pt ON prod.product_type_id = pt.id
WHERE pi.is_active = 1
GROUP BY pt.id, pt.name
ORDER BY soma_valor_base DESC;
```

- **Tolerância:** Cadeia `project_item` → `product` → `product_type`.
- **Validação estrutural:** `project_item`, `product`, `product_type`.

### Q20

- **Gabarito ($G_i$):** Assinaturas `ACTIVE` com plano, categoria e valor da transação.
- **SQL de referência (MySQL 8+, schema `base_laboratorial`):**

```sql
label={lst:gabarito-q20}]
SELECT s.id, sp.plan_name, sp.plan_category, t.amount AS valor_transacao,
       s.subscription_status
FROM subscriptions s
JOIN subscription_plans sp ON s.subscription_plan_id = sp.id
LEFT JOIN transaction t ON s.transaction_id = t.id
WHERE s.subscription_status = "ACTIVE"
ORDER BY t.amount DESC;
```

- **Tolerância:** Literal `ACTIVE`; `LEFT JOIN` na transação preserva assinaturas sem pagamento.
- **Validação estrutural:** `subscriptions`, `subscription_plans`, `transaction`.

### Q21

- **Gabarito ($G_i$):** Por item de ativo ativo, categoria e categoria-raiz.
- **SQL de referência (MySQL 8+, schema `base_laboratorial`):**

```sql
label={lst:gabarito-q21}]
SELECT ai.name AS item, c.name AS categoria, raiz.name AS categoria_raiz
FROM asset_item ai
JOIN asset_item__categories aic ON aic.asset_item_id = ai.id
JOIN asset_category c ON aic.category_id = c.id
LEFT JOIN asset_category raiz ON c.root_category_id = raiz.id
WHERE ai.is_active = 1
ORDER BY raiz.name, c.name, ai.name;
```

- **Tolerância:** M:N via `asset_item__categories`; raiz por auto-junção.
- **Validação estrutural:** `asset_item`, `asset_item__categories`, `asset_category`.

### Q22

- **Gabarito ($G_i$):** Itens de ativo `IMAGE` em categorias públicas, com raiz e tipo.
- **SQL de referência (MySQL 8+, schema `base_laboratorial`):**

```sql
label={lst:gabarito-q22}]
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

- **Tolerância:** Literal `IMAGE`; filtro `is_public = 1`.
- **Validação estrutural:** `asset_item`, `asset_item__categories`, `asset_category`.

### Q23

- **Gabarito ($G_i$):** Contagem de itens ativos por categoria-raiz pública.
- **SQL de referência (MySQL 8+, schema `base_laboratorial`):**

```sql
label={lst:gabarito-q23}]
SELECT raiz.name AS categoria_raiz, COUNT(ai.id) AS total_itens
FROM asset_category raiz
JOIN asset_category c ON c.root_category_id = raiz.id
JOIN asset_item__categories aic ON aic.category_id = c.id
JOIN asset_item ai ON aic.asset_item_id = ai.id
WHERE raiz.is_public = 1 AND ai.is_active = 1
GROUP BY raiz.id, raiz.name
ORDER BY total_itens DESC;
```

- **Tolerância:** Cadeia raiz → categoria → item via M:N.
- **Validação estrutural:** `asset_category`, `asset_item__categories`, `asset_item`.

### Q24

- **Gabarito ($G_i$):** Por autoridade, contagem de usuários e descrição. Sem PII.
- **SQL de referência (MySQL 8+, schema `base_laboratorial`):**

```sql
label={lst:gabarito-q24}]
SELECT a.name AS autoridade, a.description, COUNT(ua.user_id) AS total_usuarios
FROM authority a
LEFT JOIN user_authority ua ON ua.authority_name = a.name
GROUP BY a.name, a.description
ORDER BY total_usuarios DESC;
```

- **Tolerância:** `LEFT JOIN` preserva autoridades sem usuário; só contagens.
- **Validação estrutural:** `authority`, `user_authority`.

### Q25

- **Gabarito ($G_i$):** Por categoria de ativo, usuários com acesso e categoria-raiz.
- **SQL de referência (MySQL 8+, schema `base_laboratorial`):**

```sql
label={lst:gabarito-q25}]
SELECT c.name AS categoria, raiz.name AS categoria_raiz,
       COUNT(acu.person_id) AS total_usuarios
FROM asset_category c
LEFT JOIN asset_category raiz ON c.root_category_id = raiz.id
LEFT JOIN asset_category__users acu ON acu.categories_id = c.id
GROUP BY c.id, c.name, raiz.name
ORDER BY total_usuarios DESC;
```

- **Tolerância:** Só contagens via `asset_category__users`; sem PII.
- **Validação estrutural:** `asset_category`, `asset_category__users`.

### Q26

- **Gabarito ($G_i$):** Por autoridade, usuários distintos com acesso a categorias públicas.
- **SQL de referência (MySQL 8+, schema `base_laboratorial`):**

```sql
label={lst:gabarito-q26}]
SELECT ua.authority_name AS autoridade, COUNT(DISTINCT u.id) AS usuarios_com_acesso
FROM user_authority ua
JOIN user u ON ua.user_id = u.id
JOIN asset_category__users acu ON acu.person_id = u.id
JOIN asset_category c ON acu.categories_id = c.id
WHERE c.is_public = 1
GROUP BY ua.authority_name
ORDER BY usuarios_com_acesso DESC;
```

- **Tolerância:** Cadeia permissão → usuário → acesso → categoria; sem PII no `SELECT`.
- **Validação estrutural:** `user_authority`, `user`, `asset_category__users`, `asset_category`.

### Q27

- **Gabarito ($G_i$):** Itens de render no painel, separando sem conta e com conta.
- **SQL de referência (MySQL 8+, schema `base_laboratorial`):**

```sql
label={lst:gabarito-q27}]
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

- **Tolerância:** Rótulos `SEM_CONTA`/`COM_CONTA` livres; `owner_id IS NULL` = sem conta.
- **Validação estrutural:** `publications_user`, `project_render_item`, `project_render`.

### Q28

- **Gabarito ($G_i$):** Solicitações com render e publicação, status e situação de conta.
- **SQL de referência (MySQL 8+, schema `base_laboratorial`):**

```sql
label={lst:gabarito-q28}]
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

- **Tolerância:** `INNER JOIN` exige render e publicação; situação por `owner_id`.
- **Validação estrutural:** `publications_user`, `project_render_item`, `project_render`, `publications`.

### Q29

- **Gabarito ($G_i$):** Solicitações criadas por mês em 2026, separando com e sem conta.
- **SQL de referência (MySQL 8+, schema `base_laboratorial`):**

```sql
label={lst:gabarito-q29}]
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

- **Tolerância:** Agrupamento mensal por `created_date`.
- **Validação estrutural:** `publications_user`, `project_render_item`, `project_render`.

### Q30

- **Gabarito ($G_i$):** Itens de render por UF do cliente, com região.
- **SQL de referência (MySQL 8+, schema `base_laboratorial`):**

```sql
label={lst:gabarito-q30}]
SELECT uf.uf, uf.region, COUNT(pri.id) AS total_itens_render
FROM project_render_item pri
JOIN person pe ON pri.person_id = pe.id
JOIN ibge__uf uf ON pe.address_uf = uf.uf
JOIN project_render pr ON pri.render_project_id = pr.id
GROUP BY uf.id, uf.uf, uf.region
ORDER BY total_itens_render DESC;
```

- **Tolerância:** Join geográfico via `person.address_uf`.
- **Validação estrutural:** `project_render_item`, `person`, `ibge__uf`, `project_render`.

### Q31

- **Gabarito ($G_i$):** Perspectiva admin. Tempo médio entre primeiro render e criação da conta, por região.
- **SQL de referência (MySQL 8+, schema `base_laboratorial`):**

```sql
label={lst:gabarito-q31}]
SELECT uf.region,
       COUNT(DISTINCT pe.id) AS contas,
       AVG(DATEDIFF(pe.created_date, r.primeiro_render)) AS dias_medios
FROM (
    SELECT REGEXP_REPLACE(COALESCE(NULLIF(pri.whatsapp, ''),
              JSON_UNQUOTE(JSON_EXTRACT(pri.data_source, '$.whatsapp'))), '[^0-9]', '') AS fone,
           MIN(pri.created_date) AS primeiro_render
    FROM project_render_item pri
    WHERE pri.created_date >= DATE_SUB(
            (SELECT MAX(created_date) FROM project_render_item), INTERVAL 1 YEAR)
      AND COALESCE(NULLIF(pri.whatsapp, ''),
            JSON_UNQUOTE(JSON_EXTRACT(pri.data_source, '$.whatsapp'))) IS NOT NULL
    GROUP BY fone
) r
JOIN person pe ON REGEXP_REPLACE(pe.phone_whatsapp, '[^0-9]', '') = r.fone
JOIN ibge__uf uf ON pe.address_uf = uf.uf
WHERE pe.created_date >= r.primeiro_render
GROUP BY uf.region
ORDER BY dias_medios DESC;
```

- **Tolerância:** Match por telefone normalizado; janela de doze meses relativa ao render mais recente.
- **Validação estrutural:** `project_render_item`, `person`, `ibge__uf`.

### Q32

- **Gabarito ($G_i$):** Perspectiva admin. UF no `data_source` vs UF da conta, por região.
- **SQL de referência (MySQL 8+, schema `base_laboratorial`):**

```sql
label={lst:gabarito-q32}]
SELECT uf.region,
       COUNT(*) AS itens_finalizados,
       SUM(CASE WHEN JSON_UNQUOTE(JSON_EXTRACT(pri.data_source, '$.uf')) = pe.address_uf
                THEN 1 ELSE 0 END) AS uf_coincide,
       SUM(CASE WHEN JSON_EXTRACT(pri.data_source, '$.uf') IS NOT NULL
                 AND JSON_UNQUOTE(JSON_EXTRACT(pri.data_source, '$.uf')) <> pe.address_uf
                THEN 1 ELSE 0 END) AS uf_diverge
FROM project_render_item pri
JOIN person pe ON pri.person_id = pe.id
JOIN ibge__uf uf ON pe.address_uf = uf.uf
WHERE pri.render_status = 'FINISHED'
  AND JSON_VALID(pri.data_source) = 1
GROUP BY uf.region
ORDER BY itens_finalizados DESC;
```

- **Tolerância:** Itens `FINISHED`; `JSON_VALID` obrigatório.
- **Validação estrutural:** `project_render_item`, `person`, `ibge__uf`.

### Q33

- **Gabarito ($G_i$):** Perspectiva admin. Qualidade do `json_data` por template e composição.
- **SQL de referência (MySQL 8+, schema `base_laboratorial`):**

```sql
label={lst:gabarito-q33}]
SELECT pr.name AS template,
       JSON_UNQUOTE(JSON_EXTRACT(pri.json_data, '$.template.composition')) AS composicao,
       COUNT(*) AS itens_json_validos,
       SUM(JSON_CONTAINS_PATH(pri.json_data, 'one', '$.assets')) AS com_assets,
       SUM(JSON_CONTAINS_PATH(pri.json_data, 'one', '$.asssets')) AS com_asssets_typo
FROM project_render_item pri
JOIN project_render pr ON pri.render_project_id = pr.id
WHERE JSON_VALID(pri.json_data) = 1
GROUP BY pr.name, composicao
ORDER BY itens_json_validos DESC;
```

- **Tolerância:** Contabiliza chaves `$.assets` e typo `$.asssets` separadamente.
- **Validação estrutural:** `project_render_item`, `project_render`.

### Q34

- **Gabarito ($G_i$):** Perspectiva admin. Itens de clientes pagantes por tipo de pagamento e status.
- **SQL de referência (MySQL 8+, schema `base_laboratorial`):**

```sql
label={lst:gabarito-q34}]
SELECT pr.user_payment_type,
       pri.render_status,
       COUNT(*) AS itens,
       COUNT(DISTINCT JSON_UNQUOTE(JSON_EXTRACT(pri.data_source, '$.company'))) AS empresas_distintas
FROM project_render_item pri
JOIN project_render pr ON pri.render_project_id = pr.id
JOIN person pe ON pri.person_id = pe.id
WHERE pe.current_balance > 0
  AND JSON_VALID(pri.data_source) = 1
GROUP BY pr.user_payment_type, pri.render_status
ORDER BY itens DESC;
```

- **Tolerância:** Pagante = `current_balance > 0`; empresas por `$.company`.
- **Validação estrutural:** `project_render_item`, `project_render`, `person`.

### Q35

- **Gabarito ($G_i$):** Perspectiva publisher. Publicações por plataforma, status e situação de conta.
- **SQL de referência (MySQL 8+, schema `base_laboratorial`):**

```sql
label={lst:gabarito-q35}]
SELECT pu.platform,
       pu.status,
       CASE WHEN pu.owner_id IS NULL THEN 'SEM_CONTA' ELSE 'COM_CONTA' END AS situacao,
       COUNT(DISTINCT pri.id) AS itens_render,
       COUNT(DISTINCT JSON_UNQUOTE(JSON_EXTRACT(pri.data_source, '$.name'))) AS beneficiarios_distintos
FROM publications_user pu
JOIN project_render_item pri ON pu.project_render_item_id = pri.id
WHERE JSON_VALID(pri.data_source) = 1
GROUP BY pu.platform, pu.status, situacao
ORDER BY itens_render DESC;
```

- **Tolerância:** Beneficiários por `$.name` distinto.
- **Validação estrutural:** `publications_user`, `project_render_item`.

### Q36

- **Gabarito ($G_i$):** Perspectiva publisher. Publicações com composição de template mais frequente.
- **SQL de referência (MySQL 8+, schema `base_laboratorial`):**

```sql
label={lst:gabarito-q36}]
SELECT pu.id AS publicacao_usuario,
       pu.status,
       pub.platform AS plataforma_origem,
       pu.publication_date,
       JSON_UNQUOTE(JSON_EXTRACT(pri.json_data, '$.template.composition')) AS composicao
FROM publications_user pu
JOIN project_render_item pri ON pu.project_render_item_id = pri.id
JOIN publications pub ON pu.publication_id = pub.id
WHERE pu.is_active = 1
  AND JSON_VALID(pri.json_data) = 1
  AND JSON_UNQUOTE(JSON_EXTRACT(pri.json_data, '$.template.composition')) = (
      SELECT JSON_UNQUOTE(JSON_EXTRACT(p2.json_data, '$.template.composition')) AS comp
      FROM project_render_item p2
      WHERE JSON_VALID(p2.json_data) = 1
      GROUP BY comp
      ORDER BY COUNT(*) DESC
      LIMIT 1)
ORDER BY pu.publication_date DESC;
```

- **Tolerância:** Subconsulta elege composição modal; `is_active = 1`.
- **Validação estrutural:** `publications_user`, `project_render_item`, `publications`.

### Q37

- **Gabarito ($G_i$):** Perspectiva affiliate. Cupons por afiliado, itens e UFs distintas.
- **SQL de referência (MySQL 8+, schema `base_laboratorial`):**

```sql
label={lst:gabarito-q37}]
SELECT owner.id AS afiliado,
       owner.name AS nome_afiliado,
       COUNT(DISTINCT tc.project_render_item_id) AS itens_com_cupom,
       SUM(CASE WHEN tc.code_status = 'USED' THEN 1 ELSE 0 END) AS cupons_utilizados,
       COUNT(DISTINCT JSON_UNQUOTE(JSON_EXTRACT(pri.data_source, '$.uf'))) AS ufs_distintas
FROM transaction_coupon tc
JOIN project_render_item pri ON tc.project_render_item_id = pri.id
JOIN person owner ON tc.person_owner_id = owner.id
WHERE tc.person_owner_id IS NOT NULL
  AND JSON_VALID(pri.data_source) = 1
GROUP BY owner.id, owner.name
ORDER BY itens_com_cupom DESC;
```

- **Tolerância:** `person_owner_id` identifica o afiliado; `USED` contabilizado à parte.
- **Validação estrutural:** `transaction_coupon`, `project_render_item`, `person`.

### Q38

- **Gabarito ($G_i$):** Perspectiva affiliate. Cupons ativos no último ano por status e origem.
- **SQL de referência (MySQL 8+, schema `base_laboratorial`):**

```sql
label={lst:gabarito-q38}]
SELECT pri.render_status,
       pri.origin,
       tc.coupon_type,
       COUNT(*) AS cupons,
       AVG(tc.discount_percentual) AS desconto_medio,
       AVG(CAST(JSON_UNQUOTE(JSON_EXTRACT(pri.data_source, '$.loanValue')) AS DECIMAL(15,2)))
           AS valor_emprestimo_medio
FROM transaction_coupon tc
JOIN project_render_item pri ON tc.project_render_item_id = pri.id
WHERE tc.is_active = 1
  AND tc.created_date >= DATE_SUB(
        (SELECT MAX(created_date) FROM transaction_coupon), INTERVAL 1 YEAR)
  AND JSON_VALID(pri.data_source) = 1
GROUP BY pri.render_status, pri.origin, tc.coupon_type
ORDER BY cupons DESC;
```

- **Tolerância:** Janela de um ano relativa ao cupom mais recente.
- **Validação estrutural:** `transaction_coupon`, `project_render_item`.

### Q39

- **Gabarito ($G_i$):** Perspectiva sponsor. Pedidos das contas-filho por patrocinador.
- **SQL de referência (MySQL 8+, schema `base_laboratorial`):**

```sql
label={lst:gabarito-q39}]
SELECT sp.id AS patrocinador,
       sp.name AS nome_patrocinador,
       filho.name AS conta_filho,
       JSON_UNQUOTE(JSON_EXTRACT(pri.json_data, '$.template.composition')) AS composicao,
       JSON_UNQUOTE(JSON_EXTRACT(pri.data_source, '$.city')) AS cidade
FROM person sp
JOIN person filho ON filho.company_id = sp.id
JOIN project_render_item pri ON pri.person_id = filho.id
WHERE sp.company_type IS NOT NULL
  AND JSON_VALID(pri.json_data) = 1
  AND JSON_VALID(pri.data_source) = 1
ORDER BY sp.name, filho.name;
```

- **Tolerância:** Hierarquia `person.company_id = sponsor.id`.
- **Validação estrutural:** `person`, `project_render_item`.

### Q40

- **Gabarito ($G_i$):** Perspectiva sponsor. Volume mensal de itens finalizados em 2025–2026.
- **SQL de referência (MySQL 8+, schema `base_laboratorial`):**

```sql
label={lst:gabarito-q40}]
SELECT sp.name AS patrocinador,
       YEAR(pri.created_date) AS ano,
       MONTH(pri.created_date) AS mes,
       COUNT(*) AS itens_finalizados,
       COUNT(DISTINCT JSON_UNQUOTE(JSON_EXTRACT(pri.data_source, '$.company'))) AS empresas_no_json
FROM person sp
JOIN person filho ON filho.company_id = sp.id
JOIN project_render_item pri ON pri.person_id = filho.id
WHERE pri.render_status = 'FINISHED'
  AND YEAR(pri.created_date) IN (2025, 2026)
  AND JSON_VALID(pri.data_source) = 1
GROUP BY sp.name, ano, mes
ORDER BY sp.name, ano, mes;
```

- **Tolerância:** `render_status = 'FINISHED'`; empresas por `$.company`.
- **Validação estrutural:** `person`, `project_render_item`.
