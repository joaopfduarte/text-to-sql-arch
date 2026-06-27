# ADR-0004: Política somente SELECT no passo 5 do protocolo

- **Status:** Aceito
- **Data:** 2026-06-20

## Contexto

O protocolo experimental descrevia o passo 5 como *validação estrutural contra catálogo canônico*. Essa
atribuição confundia duas preocupações distintas:

1. **Segurança operacional:** impedir que *prompt injection* ou deriva do modelo produza DML/DDL
   (`INSERT`, `UPDATE`, `DELETE`, `DROP`, etc.) em um artefato Text-to-SQL de leitura.
2. **Aderência ao catálogo:** verificar se tabelas, colunas e junções existem no catálogo Atlas
   (erro estrutural de alucinação de esquema).

A camada de política SELECT-only pertence à aplicação (pós-parse Calcite), não ao MCP nem ao Atlas.

## Decisão

1. **Passo 5:** validar política **somente SELECT** via `SqlStatementPolicyPort.validateSelectOnly`
   sobre o AST do passo 4.
2. **Falha no passo 5:**
   - API REST: `InvalidSqlOperationException` com código `INVALID_OPERATION` e mensagem PT-BR
     *operação inválida*;
   - experimento: desfecho `invalid_operation` (nova classe na taxonomia MCP).
3. **Passo 6:** manter validação estrutural contra catálogo (`StructuralAdherenceService`) →
   `structural_error` e métrica $A_{\mathrm{est}}$.
4. **Taxonomia MCP:** passar de **6 para 7 classes**; `invalid_operation` precede `structural_error`.
5. **Baseline:** aplicar a mesma política SELECT-only antes de comparar resposta ao gabarito.

### Algoritmo do passo 5 (referência)

Entrada: AST já obtida no passo 4 (`CalciteSqlParseAdapter`).

1. Rejeitar lote com mais de um *statement* ou *statement* vazio.
2. Rejeitar se a raiz do AST não for consulta (`SqlSelect` ou equivalente Calcite Hive).
3. Rejeitar nós proibidos: `INSERT`, `UPDATE`, `DELETE`, `MERGE`, `CREATE`, `DROP`, `ALTER`,
   `TRUNCATE`, `CALL`, `EXEC`, etc.
4. Aceitar `SELECT` e `WITH`/CTE cujo resultado final seja `SELECT`.
5. Em falha: não invocar catálogo nem Hive; registrar trilha e retornar erro ao usuário.

Implementação sugerida: *visitor* Calcite sobre o AST (reutilizar parse; evitar regex).

## Consequências

### Positivas

- Separa defesa contra *prompt injection* da métrica de alucinação estrutural (catálogo).
- Resposta explícita ao usuário sem mascarar violação de política como erro de execução.
- Taxonomia experimental mais diagnosticável (`invalid_operation` vs `structural_error`).

### Negativas

- Taxonomia e documentação em dezenas de arquivos devem ser sincronizadas (7 classes).
- Baseline passa a expor também `invalid_operation` se o modelo gerar DML/DDL.

## Alternativas avaliadas

- **Manter passo 5 como validação de catálogo:** rejeitada — não endereça *prompt injection*.
- **Substituir `structural_error` por operação inválida:** rejeitada — perde métrica $A_{\mathrm{est}}$
  para alucinação de esquema.
- **Confiar só em prompts:** rejeitada — política determinística na aplicação é defesa em profundidade.

## Referências

- [Protocolo de avaliação](../experimento/protocolo-avaliacao.md)
- [Métricas e fórmulas](../experimento/metricas-formulas.md)
- [Ports e adapters](../implementacao/ports-adapters.md)
