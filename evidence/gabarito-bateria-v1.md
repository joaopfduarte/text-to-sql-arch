---
description: Colas SQL de referência e gabarito Gi por pergunta da bateria v1.
tags:
  - experimento
  - evidencia
---

# Gabarito da bateria de avaliação (v1)

## Status

- **batteryVersion:** v1
- **Commit de referência:** `9985067`
- **Revisão humana:** aprovada (11/06/2026)
- **auditoriaExecucao:** v1 (12/06/2026) — ver § Auditoria de executabilidade
- **baselineStaticV1:** `gemini-3.5-flash`, 30 corridas (12/06/2026) — ver § Campanha baseline-static v1

Fundamentado no DDL canônico das 92 tabelas
([Schema massa de teste](../04-arquitetura-dados/schema-massa-teste.md)). Cada entrada traz a cola SQL de
referência em SGBD relacional, pronta para rodar contra a massa fixa `massa_teste_laboratorio`. Os valores numéricos
esperados dependem da massa e serão conferidos pelo autor na execução.

O mapa de migração completo está em
[Matriz de cobertura da bateria](matriz-cobertura-bateria-v1.md).


## Convenção CSV (`dificuldade`)

Valores em [Bateria de 30 perguntas](bateria-30-perguntas-v1.csv): `SIMPLES`, `MÉDIA`, `COMPLEXA`
(10 linhas cada).


## Convenções SGBD relacional da cola de referência

- Dialeto do dump `schema-massa-teste.md` (SGBD relacional). Identificadores podem ser citados com crase quando necessário.
- `col_2af3538d`, `col_ced61dd5` e similares são `bit(1)` na maioria das tabelas e `tinyint` em `tbl_6cf5e405`;
  a comparação `= 1` vale para ambos.
- Funções temporais: `YEAR()`, `MONTH()`, `CASE` para faixas. Datas em colunas `datetime`/`date`.
- `GROUP BY` completo (compatível com `ONLY_FULL_GROUP_BY`): toda coluna não agregada do `SELECT` aparece
  no `GROUP BY`.
- Sem PII desnecessária: não se selecionam credenciais nem dados de auditoria. Em `tbl_c127eea9` e `tbl_f193a446`
  usam-se apenas chaves e agregações, nunca `col_45c646de`, `col_13d94b90`, `col_2b88e5ce` ou `col_59ce7306`.
- A cola é uma referência válida, não a única forma correta. A validação estrutural lista as tabelas
  reais (subconjunto das 92) que uma resposta correta deve usar.


## Auditoria de executabilidade (pré-baseline)

Antes da campanha `baseline-static`, as trinta colas $G_i$ foram executadas no SGBD relacional contra a massa
`massa_teste_laboratorio` (SGBD relacional da massa de teste). Na primeira rodada, **onze** perguntas falharam com erro `#1054` (literais enum
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
[Métricas baseline v1](baseline-metricas-v1.csv).

| Indicador | Valor |
|-----------|-------|
| Modelo | `gemini-3.5-flash` |
| Corridas $N_{\mathrm{base}}$ | 30 |
| $A_{\mathrm{gab}}$ | 19/30 (63,33%) |

Perguntas com `gabarito_match = false`: Q08, Q12, Q14, Q15, Q16, Q17, Q18, Q20, Q22, Q27, Q28.


## Entradas

### Q01

- **Gabarito ($G_i$):** por entidade do domínio comercial col_0f533cff, suas unidades com col_6b0bb26b e col_31de628c.
- **SQL de referência (SGBD relacional):**

```sql
SELECT f.col_c0d85479 AS entidade do domínio comercial col_0f533cff, u.col_6b0bb26b, u.col_31de628c
FROM tbl_162cf7be f
JOIN tbl_973ec6fa u ON u.entidade do domínio comercial principal_id = f.col_d7247819
ORDER BY f.col_c0d85479, u.col_31de628c;
```

- **Tolerância:** junção 1:N por `entidade do domínio comercial principal_id`; tbl_162cf7be sem unidade podem ser omitidas.
- **Validação estrutural:** `tbl_162cf7be`, `tbl_973ec6fa`.

### Q02

- **Gabarito ($G_i$):** item ativo do domínio de catálogo e o rótulo do seu tipo.
- **SQL de referência (SGBD relacional):**

```sql
SELECT p.col_903c5b86 AS item_catalogo, pt.col_903c5b86 AS tipo_item
FROM tbl_891b1fc9 p
JOIN tbl_ed8b2873 pt ON p.col_b80b7e90 = pt.col_d7247819
WHERE p.col_2af3538d = 1
ORDER BY pt.col_903c5b86, p.col_903c5b86;
```

- **Tolerância:** junção por `col_b80b7e90`; filtro de ativo aceitável.
- **Validação estrutural:** `tbl_891b1fc9`, `tbl_ed8b2873`.

### Q03

- **Gabarito ($G_i$):** pagamentos por entrega operacional, com entrega operacional, valor e data.
- **SQL de referência (SGBD relacional):**

```sql
SELECT pr.col_903c5b86 AS entrega_operacional, pp.col_cb78b495, pp.col_47a1931f
FROM tbl_363ae7e9 pr
JOIN tbl_6696932f pp ON pp.col_170f453c = pr.col_d7247819
WHERE pp.col_2af3538d = 1
ORDER BY pp.col_47a1931f DESC;
```

- **Tolerância:** junção por `col_170f453c`; filtro de ativo aceitável.
- **Validação estrutural:** `tbl_363ae7e9`, `tbl_6696932f`.

### Q04

- **Gabarito ($G_i$):** contagem de tbl_162cf7be por rede.
- **SQL de referência (SGBD relacional):**

```sql
SELECT r.col_c0d85479 AS rede, COUNT(f.col_d7247819) AS total_entidade do domínio comercial col_0f533cff
FROM tbl_4c8d7ae5 r
LEFT JOIN tbl_162cf7be f ON f.col_1d3e13bf = r.col_d7247819
GROUP BY r.col_d7247819, r.col_c0d85479
ORDER BY total_entidade do domínio comercial col_0f533cff DESC;
```

- **Tolerância:** `LEFT JOIN` preserva redes sem entidade do domínio comercial col_0f533cff; ordem livre.
- **Validação estrutural:** `tbl_4c8d7ae5`, `tbl_162cf7be`.

### Q05

- **Gabarito ($G_i$):** entidade do domínio comercial col_0f533cff com seu segmento e sua rede.
- **SQL de referência (SGBD relacional):**

```sql
SELECT f.col_c0d85479 AS entidade do domínio comercial col_0f533cff, s.col_c0d85479 AS segmento, r.col_c0d85479 AS rede
FROM tbl_162cf7be f
LEFT JOIN tbl_8991e9dc s ON f.col_2cd9416d = s.col_d7247819
LEFT JOIN tbl_4c8d7ae5 r ON f.col_1d3e13bf = r.col_d7247819
ORDER BY f.col_c0d85479;
```

- **Tolerância:** `LEFT JOIN` preserva tbl_162cf7be sem segmento ou rede; `INNER JOIN` também aceito.
- **Validação estrutural:** `tbl_162cf7be`, `tbl_8991e9dc`, `tbl_4c8d7ae5`.

### Q06

- **Gabarito ($G_i$):** soma de pagamentos por entrega operacional.
- **SQL de referência (SGBD relacional):**

```sql
SELECT pr.col_903c5b86 AS entrega_operacional, SUM(pp.col_cb78b495) AS total_pago
FROM tbl_363ae7e9 pr
JOIN tbl_6696932f pp ON pp.col_170f453c = pr.col_d7247819
WHERE pp.col_2af3538d = 1
GROUP BY pr.col_d7247819, pr.col_903c5b86
ORDER BY total_pago DESC;
```

- **Tolerância:** agregação por entrega operacional; ordem livre.
- **Validação estrutural:** `tbl_363ae7e9`, `tbl_6696932f`.

### Q07

- **Gabarito ($G_i$):** contagem de entrega operacional por `col_4fd5b762`.
- **SQL de referência (SGBD relacional):**

```sql
SELECT col_4fd5b762, COUNT(*) AS total
FROM tbl_363ae7e9
GROUP BY col_4fd5b762
ORDER BY total DESC;
```

- **Tolerância:** todos os col_adc4200c presentes na massa; ordem livre.
- **Validação estrutural:** `tbl_363ae7e9`.

### Q08

- **Gabarito ($G_i$):** soma do valor de movimento financeiro `SUCCESS` por mês em 2026.
- **SQL de referência (SGBD relacional):**

```sql
SELECT MONTH(col_8fc87383) AS mes, SUM(col_7f404833) AS total
FROM tbl_c066178a
WHERE col_adc4200c = 'SUCCESS'
  AND YEAR(col_8fc87383) = 2026
GROUP BY MONTH(col_8fc87383)
ORDER BY mes;
```

- **Tolerância:** literal enum `SUCCESS` obrigatório (`tbl_c066178a.col_adc4200c`: `WAITING_PAYMENT`, `SUCCESS`,
  `NO_PAY`, `SCHEDULED`, `ERROR`); agrupamento mensal; col_05651e63 sem movimento financeiro podem não aparecer.
- **Validação estrutural:** `tbl_c066178a`.

### Q09

- **Gabarito ($G_i$):** cidades por UF, com sigla da UF e col_c0d85479 da col_6b0bb26b.
- **SQL de referência (SGBD relacional):**

```sql
SELECT col_f0b8ae65.col_f0b8ae65, c.col_903c5b86 AS col_6b0bb26b
FROM tbl_c78eb7ee col_f0b8ae65
JOIN tbl_2c1fc4f7 c ON c.col_7e317139 = col_f0b8ae65.col_d7247819
WHERE c.col_2af3538d = 1
ORDER BY col_f0b8ae65.col_f0b8ae65, c.col_903c5b86;
```

- **Tolerância:** junção por `col_7e317139`; filtro de ativo aceitável.
- **Validação estrutural:** `tbl_c78eb7ee`, `tbl_2c1fc4f7`.

### Q10

- **Gabarito ($G_i$):** contagem de cidades por UF.
- **SQL de referência (SGBD relacional):**

```sql
SELECT col_f0b8ae65.col_f0b8ae65, COUNT(c.col_d7247819) AS total_cidades
FROM tbl_c78eb7ee col_f0b8ae65
JOIN tbl_2c1fc4f7 c ON c.col_7e317139 = col_f0b8ae65.col_d7247819
GROUP BY col_f0b8ae65.col_d7247819, col_f0b8ae65.col_f0b8ae65
ORDER BY total_cidades DESC;
```

- **Tolerância:** agregação por UF; ordem livre.
- **Validação estrutural:** `tbl_c78eb7ee`, `tbl_2c1fc4f7`.

### Q11

- **Gabarito ($G_i$):** por item de entrega operacional, o entrega operacional, o item de catálogo e o responsável do domínio de identidade.
- **SQL de referência (SGBD relacional):**

```sql
SELECT p.col_903c5b86 AS entrega_operacional, prod.col_903c5b86 AS item_catalogo, fr.col_903c5b86 AS responsavel
FROM tbl_3a2c56ff pi
JOIN tbl_363ae7e9 p ON pi.col_170f453c = p.col_d7247819
JOIN tbl_891b1fc9 prod ON pi.col_1d6a5428 = prod.col_d7247819
JOIN tbl_f193a446 fr ON pi.col_4fb11656 = fr.col_d7247819
WHERE pi.col_2af3538d = 1
ORDER BY p.col_903c5b86;
```

- **Tolerância:** cadeia de 3 junções; itens sem catálogo ou responsável podem ser omitidos.
- **Validação estrutural:** `tbl_3a2c56ff`, `tbl_363ae7e9`, `tbl_891b1fc9`, `tbl_f193a446`.

### Q12

- **Gabarito ($G_i$):** eventos de timeline com `col_4aff6102 = 'APPROVED'`, com entrega operacional e etapa.
- **SQL de referência (SGBD relacional):**

```sql
SELECT p.col_903c5b86 AS entrega_operacional, ps.col_903c5b86 AS etapa, te.col_6e485550 AS evento, te.col_e79ef7f2
FROM tbl_0bd88855 te
JOIN tbl_e9e0d929 ps ON te.col_8eb927db = ps.col_d7247819
JOIN tbl_363ae7e9 p ON ps.col_170f453c = p.col_d7247819
WHERE te.col_4aff6102 = 'APPROVED'
ORDER BY te.col_e79ef7f2 DESC;
```

- **Tolerância:** literal enum `APPROVED` obrigatório (`tbl_0bd88855.col_4aff6102`: `TOPIC`, `PARTIAL`,
  `COMMIT`, `APPROVED`, `SOLVED`, `REQUEST`); cadeia via `tbl_e9e0d929`.
- **Validação estrutural:** `tbl_0bd88855`, `tbl_e9e0d929`, `tbl_363ae7e9`.

### Q13

- **Gabarito ($G_i$):** entrega operacional cujo total de pagamentos supera a média do total por entrega operacional.
- **SQL de referência (SGBD relacional):**

```sql
SELECT pr.col_903c5b86 AS entrega_operacional, SUM(pp.col_cb78b495) AS total_pago
FROM tbl_363ae7e9 pr
JOIN tbl_6696932f pp ON pp.col_170f453c = pr.col_d7247819
WHERE pp.col_2af3538d = 1
GROUP BY pr.col_d7247819, pr.col_903c5b86
HAVING SUM(pp.col_cb78b495) > (
    SELECT AVG(soma)
    FROM (
        SELECT SUM(col_cb78b495) AS soma
        FROM tbl_6696932f
        WHERE col_2af3538d = 1
        GROUP BY col_170f453c
    ) AS medias
)
ORDER BY total_pago DESC;
```

- **Tolerância:** a média é sobre o total por entrega operacional (não sobre linhas de pagamento).
- **Validação estrutural:** `tbl_363ae7e9`, `tbl_6696932f`.

### Q14

- **Gabarito ($G_i$):** contagem de movimento financeiro `SUCCESS` por semestre de 2026. Aceita até 2 SQLs (ex.: uma
  por semestre, ou uma única com `CASE`).
- **SQL de referência (SGBD relacional):**

```sql
SELECT
    CASE
        WHEN MONTH(col_8fc87383) <= 6 THEN 'S1'
        ELSE 'S2'
    END AS semestre,
    COUNT(*) AS total
FROM tbl_c066178a
WHERE col_adc4200c = 'SUCCESS'
  AND YEAR(col_8fc87383) = 2026
GROUP BY semestre
ORDER BY semestre
LIMIT 0, 25;
```

- **Tolerância:** literal enum `SUCCESS` obrigatório; divisão semestral por mês; rótulos `S1`/`S2` livres.
- **Validação estrutural:** `tbl_c066178a`.

### Q15

- **Gabarito ($G_i$):** soma de movimento financeiro `SUCCESS` por UF do parte do domínio de identidade (via `tbl_f193a446.col_d4194569`).
- **SQL de referência (SGBD relacional):**

```sql
SELECT col_f0b8ae65.col_f0b8ae65, col_f0b8ae65.col_8875b9ea, SUM(t.col_7f404833) AS total
FROM tbl_c066178a t
JOIN tbl_f193a446 pe ON t.col_3e19be2e = pe.col_d7247819
JOIN tbl_c78eb7ee col_f0b8ae65 ON pe.col_d4194569 = col_f0b8ae65.col_f0b8ae65
WHERE t.col_adc4200c = 'SUCCESS'
GROUP BY col_f0b8ae65.col_d7247819, col_f0b8ae65.col_f0b8ae65, col_f0b8ae65.col_8875b9ea
ORDER BY total DESC;
```

- **Tolerância:** literal enum `SUCCESS` obrigatório; join geográfico usa `col_d4194569 = col_f0b8ae65.col_f0b8ae65`; pressupõe UF
  normalizada na massa.
- **Validação estrutural:** `tbl_c066178a`, `tbl_f193a446`, `tbl_c78eb7ee`.

### Q16

- **Gabarito ($G_i$):** movimento financeiro `SUCCESS` ligadas a itens, com valor, entrega operacional, produto e parte do domínio de identidade.
- **SQL de referência (SGBD relacional):**

```sql
SELECT t.col_7f404833, p.col_903c5b86 AS entrega_operacional, prod.col_903c5b86 AS produto, cli.col_903c5b86 AS parte_identidade
FROM tbl_c066178a t
JOIN tbl_3a2c56ff pi ON t.col_cde4e6eb = pi.col_d7247819
JOIN tbl_363ae7e9 p ON pi.col_170f453c = p.col_d7247819
JOIN tbl_891b1fc9 prod ON pi.col_1d6a5428 = prod.col_d7247819
JOIN tbl_f193a446 cli ON p.col_b8a29b43 = cli.col_d7247819
WHERE t.col_adc4200c = 'SUCCESS'
ORDER BY t.col_7f404833 DESC;
```

- **Tolerância:** literal enum `SUCCESS` obrigatório; cadeia cross-domínio de 5 tabelas; parte do domínio de identidade via
  `tbl_363ae7e9.col_b8a29b43`.
- **Validação estrutural:** `tbl_c066178a`, `tbl_3a2c56ff`, `tbl_363ae7e9`, `tbl_891b1fc9`, `tbl_f193a446`.

### Q17

- **Gabarito ($G_i$):** instrumentos promocionais `USED` por entrega operacional, com col_31729617, col_adc4200c, desconto e usuário do cupom.
- **SQL de referência (SGBD relacional):**

```sql
SELECT p.col_903c5b86 AS entrega_operacional, tc.col_d5bc9bec, tc.col_8d8a975c,
       tc.col_a7feaeca, usr.col_903c5b86 AS usuario_cupom
FROM tbl_6b881dfd tc
JOIN tbl_363ae7e9 p ON tc.col_170f453c = p.col_d7247819
JOIN tbl_f193a446 usr ON tc.col_3e19be2e = usr.col_d7247819
WHERE tc.col_8d8a975c = 'USED'
ORDER BY tc.col_a7feaeca DESC;
```

- **Tolerância:** literal enum `USED` obrigatório (`tbl_6b881dfd.col_8d8a975c`: `AVAILABLE`, `PROMOTIONAL`,
  `WAITING_PAYMENT`, `USED`, `GIFT_CODE`, `EXPIRED`, `WAITING_VIDEO`, `OTHER`); usuário via
  `tbl_6b881dfd.col_3e19be2e`.
- **Validação estrutural:** `tbl_6b881dfd`, `tbl_363ae7e9`, `tbl_f193a446`.

### Q18

- **Gabarito ($G_i$):** por parte do domínio de identidade, contagem de entrega operacional distintos e total movimentado em `SUCCESS`.
- **SQL de referência (SGBD relacional):**

```sql
SELECT pe.col_903c5b86 AS parte_identidade, COUNT(DISTINCT t.col_170f453c) AS entrega_operacional,
       SUM(t.col_7f404833) AS total
FROM tbl_c066178a t
JOIN tbl_f193a446 pe ON t.col_3e19be2e = pe.col_d7247819
WHERE t.col_adc4200c = 'SUCCESS'
GROUP BY pe.col_d7247819, pe.col_903c5b86
ORDER BY total DESC;
```

- **Tolerância:** literal enum `SUCCESS` obrigatório; agregação por parte do domínio de identidade; `COUNT(DISTINCT col_170f453c)`
  aceitável como complemento.
- **Validação estrutural:** `tbl_c066178a`, `tbl_f193a446`.

### Q19

- **Gabarito ($G_i$):** por tipo de item de catálogo, contagem de itens de entrega operacional e soma do `col_d044dcda`. Aceita
  até 2 SQLs (ex.: contagem e soma separadas).
- **SQL de referência (SGBD relacional):**

```sql
SELECT pt.col_903c5b86 AS tipo_catalogo, COUNT(pi.col_d7247819) AS total_itens,
       SUM(pi.col_d044dcda) AS soma_valor_base
FROM tbl_3a2c56ff pi
JOIN tbl_891b1fc9 prod ON pi.col_1d6a5428 = prod.col_d7247819
JOIN tbl_ed8b2873 pt ON prod.col_b80b7e90 = pt.col_d7247819
WHERE pi.col_2af3538d = 1
GROUP BY pt.col_d7247819, pt.col_903c5b86
ORDER BY soma_valor_base DESC;
```

- **Tolerância:** cadeia `tbl_3a2c56ff`->`tbl_891b1fc9`->`tbl_ed8b2873`; agregações por col_31729617.
- **Validação estrutural:** `tbl_3a2c56ff`, `tbl_891b1fc9`, `tbl_ed8b2873`.

### Q20

- **Gabarito ($G_i$):** assinaturas `ACTIVE` com plano, col_cefbea9f e valor da movimento financeiro de pagamento.
- **SQL de referência (SGBD relacional):**

```sql
SELECT s.col_d7247819, sp.col_164112fc, sp.col_b6b8ebeb, t.col_7f404833 AS valor_movimento,
       s.col_61ceb0a8
FROM tbl_6cf5e405 s
JOIN tbl_6cc6cc99 sp ON s.col_40f9020a = sp.col_d7247819
LEFT JOIN tbl_c066178a t ON s.col_d6dfb874 = t.col_d7247819
WHERE s.col_61ceb0a8 = "ACTIVE"
ORDER BY t.col_7f404833 DESC;
```

- **Tolerância:** literal enum `ACTIVE` obrigatório (`tbl_6cf5e405.col_61ceb0a8`: `PENDING`, `ACTIVE`,
  `EXPIRED`, `CANCELED`); `LEFT JOIN` na movimento financeiro preserva assinaturas sem pagamento.
- **Validação estrutural:** `tbl_6cf5e405`, `tbl_6cc6cc99`, `tbl_c066178a`.

### Q21

- **Gabarito ($G_i$):** por item de ativo ativo, a col_cefbea9f e a col_cefbea9f-raiz correspondente.
- **SQL de referência (SGBD relacional):**

```sql
SELECT ai.col_903c5b86 AS item, c.col_903c5b86 AS col_cefbea9f, raiz.col_903c5b86 AS categoria_raiz
FROM tbl_a6e2174e ai
JOIN tbl_c311310d aic ON aic.col_00b5fea0 = ai.col_d7247819
JOIN tbl_d58bb5a4 c ON aic.col_d75580b3 = c.col_d7247819
LEFT JOIN tbl_d58bb5a4 raiz ON c.col_7c65d453 = raiz.col_d7247819
WHERE ai.col_2af3538d = 1
ORDER BY raiz.col_903c5b86, c.col_903c5b86, ai.col_903c5b86;
```

- **Tolerância:** M:N via `tbl_c311310d`; raiz por auto-junção `col_7c65d453`; categorias-raiz
  sem pai podem ter `categoria_raiz` nula.
- **Validação estrutural:** `tbl_a6e2174e`, `tbl_c311310d`, `tbl_d58bb5a4`.

### Q22

- **Gabarito ($G_i$):** itens de ativo `IMAGE` com col_cefbea9f, raiz e col_31729617, só categorias públicas.
- **SQL de referência (SGBD relacional):**

```sql
SELECT ai.col_903c5b86 AS item, c.col_903c5b86 AS col_cefbea9f, c.col_77639ef1 AS tipo_categoria,
       raiz.col_903c5b86 AS categoria_raiz
FROM tbl_a6e2174e ai
JOIN tbl_c311310d aic ON aic.col_00b5fea0 = ai.col_d7247819
JOIN tbl_d58bb5a4 c ON aic.col_d75580b3 = c.col_d7247819
LEFT JOIN tbl_d58bb5a4 raiz ON c.col_7c65d453 = raiz.col_d7247819
WHERE ai.col_f846cd6e = 'IMAGE'
  AND c.col_ced61dd5 = 1
ORDER BY raiz.col_903c5b86, c.col_903c5b86, ai.col_903c5b86;
```

- **Tolerância:** literal enum `IMAGE` obrigatório (`tbl_a6e2174e.col_f846cd6e`: `LETTERING`, `VIDEO`, `AUDIO`,
  `IMAGE`, `COMPANY`); filtro `col_ced61dd5 = 1`; raiz por auto-junção.
- **Validação estrutural:** `tbl_a6e2174e`, `tbl_c311310d`, `tbl_d58bb5a4`.

### Q23

- **Gabarito ($G_i$):** contagem de itens ativos por col_cefbea9f-raiz pública e a raiz com mais itens. Aceita
  até 2 SQLs (ex.: a contagem por raiz e uma consulta auxiliar do topo).
- **SQL de referência (SGBD relacional):**

```sql
SELECT raiz.col_903c5b86 AS categoria_raiz, COUNT(ai.col_d7247819) AS total_itens
FROM tbl_d58bb5a4 raiz
JOIN tbl_d58bb5a4 c ON c.col_7c65d453 = raiz.col_d7247819
JOIN tbl_c311310d aic ON aic.col_d75580b3 = c.col_d7247819
JOIN tbl_a6e2174e ai ON aic.col_00b5fea0 = ai.col_d7247819
WHERE raiz.col_ced61dd5 = 1 AND ai.col_2af3538d = 1
GROUP BY raiz.col_d7247819, raiz.col_903c5b86
ORDER BY total_itens DESC;
```

- **Tolerância:** cadeia raiz->col_cefbea9f->item via M:N; topo pode vir por `LIMIT 1` em SQL auxiliar.
- **Validação estrutural:** `tbl_d58bb5a4`, `tbl_c311310d`, `tbl_a6e2174e`.

### Q24

- **Gabarito ($G_i$):** por autoridade, contagem de usuários e a descrição da autoridade. Sem PII.
- **SQL de referência (SGBD relacional):**

```sql
SELECT a.col_903c5b86 AS autoridade, a.col_d0971202, COUNT(ua.col_a0feb70e) AS total_usuarios
FROM tbl_d1556a76 a
LEFT JOIN tbl_54cf92bb ua ON ua.col_3d8dba03 = a.col_903c5b86
GROUP BY a.col_903c5b86, a.col_d0971202
ORDER BY total_usuarios DESC;
```

- **Tolerância:** `LEFT JOIN` preserva autoridades sem usuário; só contagens, nunca dados do usuário.
- **Validação estrutural:** `tbl_d1556a76`, `tbl_54cf92bb`.

### Q25

- **Gabarito ($G_i$):** por col_cefbea9f de ativo, contagem de usuários com acesso e a col_cefbea9f-raiz.
- **SQL de referência (SGBD relacional):**

```sql
SELECT c.col_903c5b86 AS col_cefbea9f, raiz.col_903c5b86 AS categoria_raiz,
       COUNT(acu.col_3e19be2e) AS total_usuarios
FROM tbl_d58bb5a4 c
LEFT JOIN tbl_d58bb5a4 raiz ON c.col_7c65d453 = raiz.col_d7247819
LEFT JOIN tbl_cca22dd2 acu ON acu.col_a4e129cb = c.col_d7247819
GROUP BY c.col_d7247819, c.col_903c5b86, raiz.col_903c5b86
ORDER BY total_usuarios DESC;
```

- **Tolerância:** `tbl_cca22dd2.col_3e19be2e` referencia `tbl_c127eea9`; só contagens, sem PII.
- **Validação estrutural:** `tbl_d58bb5a4`, `tbl_cca22dd2`.

### Q26

- **Gabarito ($G_i$):** por autoridade, usuários distintos com acesso a categorias de ativo públicas.
- **SQL de referência (SGBD relacional):**

```sql
SELECT ua.col_3d8dba03 AS autoridade, COUNT(DISTINCT u.col_d7247819) AS usuarios_com_acesso
FROM tbl_54cf92bb ua
JOIN tbl_c127eea9 u ON ua.col_a0feb70e = u.col_d7247819
JOIN tbl_cca22dd2 acu ON acu.col_3e19be2e = u.col_d7247819
JOIN tbl_d58bb5a4 c ON acu.col_a4e129cb = c.col_d7247819
WHERE c.col_ced61dd5 = 1
GROUP BY ua.col_3d8dba03
ORDER BY usuarios_com_acesso DESC;
```

- **Tolerância:** cadeia permissão->usuário->acesso->col_cefbea9f; `tbl_c127eea9` só em junção, sem PII no
  `SELECT`.
- **Validação estrutural:** `tbl_54cf92bb`, `tbl_c127eea9`, `tbl_cca22dd2`, `tbl_d58bb5a4`.

### Q27

- **Gabarito ($G_i$):** itens de render no painel, separando solicitações sem conta e com conta. Aceita até
  2 SQLs (ex.: um por situação, ou um único com `CASE`).
- **SQL de referência (SGBD relacional):**

```sql
SELECT
    CASE
        WHEN pu.col_208355af IS NULL THEN 'SEM_CONTA'
        ELSE 'COM_CONTA'
    END AS situacao,
    COUNT(DISTINCT pri.col_d7247819) AS total_itens_render
FROM tbl_06d78b0c pu
JOIN tbl_e019dc9e pri ON pu.col_0c0112b1 = pri.col_d7247819
JOIN tbl_21eee00c pr ON pri.col_a9bacc85 = pr.col_d7247819
GROUP BY situacao
ORDER BY situacao;
```

- **Tolerância:** rótulos `SEM_CONTA`/`COM_CONTA` livres; `col_208355af IS NULL` = pediu sem conta;
  `col_208355af IS NOT NULL` = criou conta depois.
- **Validação estrutural:** `tbl_06d78b0c`, `tbl_e019dc9e`, `tbl_21eee00c`.

### Q28

- **Gabarito ($G_i$):** solicitações com render e publicação, com col_adc4200c, render e situação de conta.
- **SQL de referência (SGBD relacional):**

```sql
SELECT
    pu.col_adc4200c,
    pr.col_903c5b86 AS render,
    pub.col_ec6ed4ec,
    CASE
        WHEN pu.col_208355af IS NULL THEN 'SEM_CONTA'
        ELSE 'COM_CONTA'
    END AS situacao
FROM tbl_06d78b0c pu
JOIN tbl_e019dc9e pri ON pu.col_0c0112b1 = pri.col_d7247819
JOIN tbl_21eee00c pr ON pri.col_a9bacc85 = pr.col_d7247819
JOIN tbl_4e5786c9 pub ON pu.col_cd1bfaa5 = pub.col_d7247819
ORDER BY pu.col_adc4200c;
```

- **Tolerância:** rótulos `SEM_CONTA`/`COM_CONTA` livres; `INNER JOIN` exige render e publicação presentes;
  situação por `col_208355af`.
- **Validação estrutural:** `tbl_06d78b0c`, `tbl_e019dc9e`, `tbl_21eee00c`, `tbl_4e5786c9`.

### Q29

- **Gabarito ($G_i$):** solicitações criadas por mês em 2026, separando com e sem conta.
- **SQL de referência (SGBD relacional):**

```sql
SELECT MONTH(pu.col_8fc87383) AS mes,
       SUM(CASE WHEN pu.col_208355af IS NULL THEN 1 ELSE 0 END) AS sem_conta,
       SUM(CASE WHEN pu.col_208355af IS NOT NULL THEN 1 ELSE 0 END) AS com_conta
FROM tbl_06d78b0c pu
JOIN tbl_e019dc9e pri ON pu.col_0c0112b1 = pri.col_d7247819
JOIN tbl_21eee00c pr ON pri.col_a9bacc85 = pr.col_d7247819
WHERE YEAR(pu.col_8fc87383) = 2026
GROUP BY MONTH(pu.col_8fc87383)
ORDER BY mes;
```

- **Tolerância:** agrupamento mensal por `col_8fc87383`; col_05651e63 sem solicitação podem não aparecer.
- **Validação estrutural:** `tbl_06d78b0c`, `tbl_e019dc9e`, `tbl_21eee00c`.

### Q30

- **Gabarito ($G_i$):** itens de render solicitados por parte do domínio de identidade de cada UF, com a região.
- **SQL de referência (SGBD relacional):**

```sql
SELECT col_f0b8ae65.col_f0b8ae65, col_f0b8ae65.col_8875b9ea, COUNT(pri.col_d7247819) AS total_itens_render
FROM tbl_e019dc9e pri
JOIN tbl_f193a446 pe ON pri.col_3e19be2e = pe.col_d7247819
JOIN tbl_c78eb7ee col_f0b8ae65 ON pe.col_d4194569 = col_f0b8ae65.col_f0b8ae65
JOIN tbl_21eee00c pr ON pri.col_a9bacc85 = pr.col_d7247819
GROUP BY col_f0b8ae65.col_d7247819, col_f0b8ae65.col_f0b8ae65, col_f0b8ae65.col_8875b9ea
ORDER BY total_itens_render DESC;
```

- **Tolerância:** join geográfico por `tbl_f193a446.col_d4194569 = col_f0b8ae65.col_f0b8ae65`; pressupõe UF normalizada na massa.
- **Validação estrutural:** `tbl_e019dc9e`, `tbl_f193a446`, `tbl_c78eb7ee`, `tbl_21eee00c`.
