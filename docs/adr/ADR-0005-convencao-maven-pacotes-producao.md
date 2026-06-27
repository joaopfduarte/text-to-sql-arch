---
description: Coordenadas Maven, pacote raiz Java e bounded context identity para produção.
status: Aceito
tags:
  - adr
  - arquitetura
  - implementacao
---

# ADR-0005: Convenção Maven e pacotes Java para produção

- **Status:** Aceito
- **Data:** 2026-06-24

## Contexto

O artefato será implantado em ambiente de produção no domínio `text2sql.com.br`, com API pública em
`api.text2sql.com.br`. A documentação operacional usava o prefixo acadêmico `com.tcc.text2sql`, desalinhado
do domínio de deploy e das coordenadas Maven geradas pelo Spring Initializr.

Era necessário fixar `groupId`, `artifactId` e pacote raiz Java como fonte única para implementação e
documentar o bounded context `identity` (autenticação com PostgreSQL), isolado do experimento Text-to-SQL
em Hive/Atlas.

## Decisão

Adotar as coordenadas e a árvore de pacotes abaixo como canônicas (detalhe em
[Módulos Spring](../implementacao/modulos-spring.md)):

| Elemento | Valor |
|----------|-------|
| `groupId` | `br.com.text2sql` |
| `artifactId` | `api` |
| Pacote raiz Java | `br.com.text2sql.api` |
| Classe principal | `Text2sqlApiApplication` |
| Build | Maven |
| Spring Boot | 4.1.0 |
| URL pública da API | `https://api.text2sql.com.br` |

Subpacotes do núcleo Text-to-SQL sob `br.com.text2sql.api`: `application`, `domain`, `ports`,
`adapters.in`, `adapters.out`, `config`, `observability`.

Bounded context adicional `identity` sob `br.com.text2sql.api.identity` para login e persistência de
usuários em PostgreSQL local (Spring Security + JPA + Flyway), sem misturar com a massa experimental Hive.

## Consequências

### Positivas

- alinhamento entre domínio DNS, Maven e pacotes Java;
- geração reprodutível via [Spring Initializr](https://start.spring.io);
- separação clara entre identidade da aplicação e dados do experimento.

### Negativas

- documentação acadêmica que citava `com.tcc.text2sql` exige revisão pontual no Capítulo de Desenvolvimento;
- dois stores de dados na aplicação (PostgreSQL para identity, Hive para execução SQL).

## Alternativas avaliadas

- **Manter `com.tcc.text2sql`:** rejeitada por não refletir o domínio de produção nem a convenção
  `groupId` + `artifactId` do Initializr.
- **Pacote raiz `br.com.text2sql` sem sufixo `.api`:** válida para monólito único, mas rejeitada em
  favor de espelhar o `artifactId` `api` e permitir módulos futuros sob o mesmo `groupId`.

## Documentos alterados

- [Módulos Spring](../implementacao/modulos-spring.md)
- [Ports e adapters](../implementacao/ports-adapters.md)
- [Modelo de domínio](../arquitetura/aplicacao/modelo-dominio.md)
- [Camadas MCP](../arquitetura/aplicacao/camadas-mcp.md)
- [Rastreabilidade acadêmica](../pesquisa/rastreabilidade-academica.md)
- [Produto e escopo](../produto/escopo.md)
