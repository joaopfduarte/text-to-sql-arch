# Documentação operacional do artefato TCC

Pacote operacional para a engenharia do artefato Text-to-SQL com MCP, camada semântica e de
metadados e catálogo canônico (Apache Atlas). Complementa a monografia em [`../content/`](../content/)
com documentação técnica orientada a execução, reprodutibilidade experimental e governança
arquitetural.

Este diretório fica na **raiz do repositório**, em paridade com [`../apresentacao/`](../apresentacao/):
entrega paralela à monografia, fora do PDF do caderno LaTeX.

## Por onde começar

| Papel | Leitura inicial |
|-------|-----------------|
| Qualquer pessoa nova no projeto | [`docs/00-leitura-rapida.md`](docs/00-leitura-rapida.md) |
| Dev Java | [`docs/03-arquitetura-aplicacao/visao-logica.md`](docs/03-arquitetura-aplicacao/visao-logica.md) → [`docs/06-implementacao-java/modulos-spring.md`](docs/06-implementacao-java/modulos-spring.md) → [`docs/07-contratos-mcp/contracts-v1.md`](docs/07-contratos-mcp/contracts-v1.md) |
| Engenheiro de infra/dados | [`docs/05-infraestrutura/visao-aws.md`](docs/05-infraestrutura/visao-aws.md) → [`docs/05-infraestrutura/cluster-hadoop.md`](docs/05-infraestrutura/cluster-hadoop.md) → [`docs/04-arquitetura-dados/carga-cluster-putz.md`](docs/04-arquitetura-dados/carga-cluster-putz.md) |
| Operador de corridas | [`docs/08-experimento-avaliacao/runbook-reprodutibilidade.md`](docs/08-experimento-avaliacao/runbook-reprodutibilidade.md) → [`docs/08-experimento-avaliacao/llm-inferencia-e-prompts.md`](docs/08-experimento-avaliacao/llm-inferencia-e-prompts.md) → [`docs/09-operacao.md`](docs/09-operacao.md) |
| Pessoa que escreve o TCC | [`docs/10-rastreabilidade-academica.md`](docs/10-rastreabilidade-academica.md) |

## Mapa do repositório

```text
artifact-docs/
  README.md                      (este arquivo)
  db-reference/
    putz_db.md                   (export do banco PS, ~6640 linhas)
    putz_db.pdf                  (mesmo export para leitura humana)
  docs/
    00-leitura-rapida.md
    01-produto-e-escopo.md
    02-arquitetura-negocio.md
    03-arquitetura-aplicacao/
      visao-logica.md
      camadas-mcp.md
      modelo-dominio.md
    04-arquitetura-dados/
      catalogo-atlas.md
      banco-putz-dominio.md
      schema-massa-teste.md
      carga-cluster-putz.md
    05-infraestrutura/
      visao-aws.md
      cluster-hadoop.md
      delta-oci-para-aws.md
      vdf-odp-x86.md
    06-implementacao-java/
      modulos-spring.md
      ports-adapters.md
    07-contratos-mcp/
      contracts-v1.md
    08-experimento-avaliacao/
      protocolo-avaliacao.md
      runbook-reprodutibilidade.md
      llm-inferencia-e-prompts.md
      metricas-formulas.md
    09-operacao.md
    10-rastreabilidade-academica.md
    roadmap-5a6-meses.md
  diagrams/
    diagrama-mestre.puml
    rede-implantacao.puml
    cluster-topologia-aws.puml
    rede-aws.puml
    ingestao-putz.puml
  adr/
    README.md
    ADR-0001-fundacao-arquitetural.md
    ADR-0002-topologia-aws-cluster-minimo.md
    ADR-0003-inferencia-llm-deterministica.md
  legacy-infra/                  (legado OCI; ver delta em docs/05-infraestrutura/delta-oci-para-aws.md)
  evidence/
    context-schema-v1.json
    examples/
  templates/
    prompts/
      prompts-manifest-v1.json
      system-shared-v1.md
      system-mcp-v1.md
      system-baseline-v1.md
      user-template-v1.md
```

## Mapa de redirects (antigo → novo)

| Caminho antigo | Caminho novo |
|----------------|--------------|
| `guide-docs/arch-product/` | `artifact-docs/` (raiz do repositório) |
| `docs/01-contexto/escopo-metodologico.md` | [`docs/01-produto-e-escopo.md`](docs/01-produto-e-escopo.md) (fundido com pitch de produto) |
| `docs/02-arquitetura/arquitetura-mestre.md` | [`docs/02-arquitetura-negocio.md`](docs/02-arquitetura-negocio.md) (blocos) + [`docs/03-arquitetura-aplicacao/visao-logica.md`](docs/03-arquitetura-aplicacao/visao-logica.md) (contratos) |
| `docs/02-arquitetura/system-design.md` | [`docs/03-arquitetura-aplicacao/visao-logica.md`](docs/03-arquitetura-aplicacao/visao-logica.md) (camadas) + [`docs/05-infraestrutura/visao-aws.md`](docs/05-infraestrutura/visao-aws.md) (rede física) |
| `docs/02-arquitetura/domain-model.md` | [`docs/03-arquitetura-aplicacao/modelo-dominio.md`](docs/03-arquitetura-aplicacao/modelo-dominio.md) |
| `docs/03-contratos-mcp/contracts-v1.md` | [`docs/07-contratos-mcp/contracts-v1.md`](docs/07-contratos-mcp/contracts-v1.md) (exemplos refeitos com PS) |
| `docs/04-dados-teste/schema-massa-teste.md` | [`docs/04-arquitetura-dados/schema-massa-teste.md`](docs/04-arquitetura-dados/schema-massa-teste.md) (subconjunto PS (92 tabelas) substitui `sales.*`) |
| `docs/05-avaliacao/protocolo-avaliacao.md` | [`docs/08-experimento-avaliacao/protocolo-avaliacao.md`](docs/08-experimento-avaliacao/protocolo-avaliacao.md) |
| `docs/06-operacao-reprodutibilidade/runbook-reprodutibilidade.md` | [`docs/08-experimento-avaliacao/runbook-reprodutibilidade.md`](docs/08-experimento-avaliacao/runbook-reprodutibilidade.md) |
| `docs/07-roadmap/roadmap-5a6-meses.md` | [`docs/roadmap-5a6-meses.md`](docs/roadmap-5a6-meses.md) (com marcos de infra AWS) |
| `docs/adr/README.md` | [`adr/README.md`](adr/README.md) |
| `docs/adr/ADR-0001-fundacao-arquitetural.md` | [`adr/ADR-0001-fundacao-arquitetural.md`](adr/ADR-0001-fundacao-arquitetural.md) |
| `putz_db.md` / `putz_db.pdf` (raiz) | [`db-reference/putz_db.md`](db-reference/putz_db.md), [`db-reference/putz_db.pdf`](db-reference/putz_db.pdf) |

## Princípios de manutenção

- Fonte única da verdade para arquitetura e protocolo experimental.
- Mudança de design relevante exige ADR e atualização do diagrama correspondente.
- Evidência experimental precisa de `runId`, `seed`, `modelVersion`, `provider`, `promptVersion`,
  `inferenceConfig`, `promptArtifactsHash`, `commitHash`, `datasetVersion` e `contractsVersion`.
- Contratos MCP são versionados semanticamente, com política de compatibilidade documentada em
  [`docs/07-contratos-mcp/contracts-v1.md`](docs/07-contratos-mcp/contracts-v1.md).
- Toda alegação técnica sobre cluster precisa ter evidência em [`legacy-infra/`](legacy-infra/) ou no
  VDF canônico [`../assets/scripts/ODP-VDF.xml`](../assets/scripts/ODP-VDF.xml), ou estar marcada
  `TBD`.
- Toda menção a tabelas PS precisa estar no índice de [`db-reference/putz_db.md`](db-reference/putz_db.md)
  (linhas 5–98).
