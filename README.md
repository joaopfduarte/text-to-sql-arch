# Arquitetura e engenharia do produto TCC

Pacote operacional para a engenharia do artefato Text-to-SQL com MCP e Apache Atlas. Complementa a monografia em [`../../content/`](../../content/) com documentação técnica orientada a execução, reprodutibilidade experimental e governança arquitetural.

## Por onde começar

| Papel | Leitura inicial |
|-------|-----------------|
| Qualquer pessoa nova no projeto | [`docs/00-leitura-rapida.md`](docs/00-leitura-rapida.md) |
| Dev Java | [`docs/03-arquitetura-aplicacao/visao-logica.md`](docs/03-arquitetura-aplicacao/visao-logica.md) → [`docs/06-implementacao-java/modulos-spring.md`](docs/06-implementacao-java/modulos-spring.md) → [`docs/07-contratos-mcp/contracts-v1.md`](docs/07-contratos-mcp/contracts-v1.md) |
| Engenheiro de infra/dados | [`docs/05-infraestrutura/visao-aws.md`](docs/05-infraestrutura/visao-aws.md) → [`docs/05-infraestrutura/cluster-hadoop.md`](docs/05-infraestrutura/cluster-hadoop.md) → [`docs/04-arquitetura-dados/carga-cluster-putz.md`](docs/04-arquitetura-dados/carga-cluster-putz.md) |
| Operador de corridas | [`docs/08-experimento-avaliacao/runbook-reprodutibilidade.md`](docs/08-experimento-avaliacao/runbook-reprodutibilidade.md) → [`docs/09-operacao.md`](docs/09-operacao.md) |
| Pessoa que escreve o TCC | [`docs/10-rastreabilidade-academica.md`](docs/10-rastreabilidade-academica.md) |

## Mapa do repositório

```
guide-docs/arch-product/
  README.md                      (este arquivo)
  db-reference/
    putz_db.md                   (export do banco Putz, ~6640 linhas)
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
    09-operacao.md
    10-rastreabilidade-academica.md
    roadmap-5a6-meses.md
  diagrams/
    diagrama-mestre.mmd
    rede-implantacao.mmd
    cluster-topologia-aws.mmd
    rede-aws.mmd
    ingestao-putz.mmd
  adr/
    README.md
    ADR-0001-fundacao-arquitetural.md
    ADR-0002-topologia-aws-cluster-minimo.md
  legacy-infra/                  (legado OCI de referência; ver delta em docs/05-infraestrutura/delta-oci-para-aws.md)
  evidence/
  templates/
```

## Mapa de redirects (antigo → novo)

| Caminho antigo | Caminho novo |
|----------------|--------------|
| `docs/01-contexto/escopo-metodologico.md` | [`docs/01-produto-e-escopo.md`](docs/01-produto-e-escopo.md) (fundido com pitch de produto) |
| `docs/02-arquitetura/arquitetura-mestre.md` | [`docs/02-arquitetura-negocio.md`](docs/02-arquitetura-negocio.md) (blocos) + [`docs/03-arquitetura-aplicacao/visao-logica.md`](docs/03-arquitetura-aplicacao/visao-logica.md) (contratos) |
| `docs/02-arquitetura/system-design.md` | [`docs/03-arquitetura-aplicacao/visao-logica.md`](docs/03-arquitetura-aplicacao/visao-logica.md) (camadas) + [`docs/05-infraestrutura/visao-aws.md`](docs/05-infraestrutura/visao-aws.md) (rede física) |
| `docs/02-arquitetura/domain-model.md` | [`docs/03-arquitetura-aplicacao/modelo-dominio.md`](docs/03-arquitetura-aplicacao/modelo-dominio.md) |
| `docs/03-contratos-mcp/contracts-v1.md` | [`docs/07-contratos-mcp/contracts-v1.md`](docs/07-contratos-mcp/contracts-v1.md) (exemplos refeitos com Putz) |
| `docs/04-dados-teste/schema-massa-teste.md` | [`docs/04-arquitetura-dados/schema-massa-teste.md`](docs/04-arquitetura-dados/schema-massa-teste.md) (subconjunto Putz substitui `sales.*`) |
| `docs/05-avaliacao/protocolo-avaliacao.md` | [`docs/08-experimento-avaliacao/protocolo-avaliacao.md`](docs/08-experimento-avaliacao/protocolo-avaliacao.md) |
| `docs/06-operacao-reprodutibilidade/runbook-reprodutibilidade.md` | [`docs/08-experimento-avaliacao/runbook-reprodutibilidade.md`](docs/08-experimento-avaliacao/runbook-reprodutibilidade.md) |
| `docs/07-roadmap/roadmap-5a6-meses.md` | [`docs/roadmap-5a6-meses.md`](docs/roadmap-5a6-meses.md) (com marcos de infra AWS) |
| `docs/adr/README.md` | [`adr/README.md`](adr/README.md) |
| `docs/adr/ADR-0001-fundacao-arquitetural.md` | [`adr/ADR-0001-fundacao-arquitetural.md`](adr/ADR-0001-fundacao-arquitetural.md) |
| `putz_db.md` / `putz_db.pdf` (raiz) | [`db-reference/putz_db.md`](db-reference/putz_db.md), [`db-reference/putz_db.pdf`](db-reference/putz_db.pdf) |

## Princípios de manutenção

- Fonte única da verdade para arquitetura e protocolo experimental.
- Mudança de design relevante exige ADR e atualização do diagrama correspondente.
- Evidência experimental precisa de `runId`, `seed`, `modelVersion`, `commitHash`, `datasetVersion` e `contractsVersion`.
- Contratos MCP são versionados semanticamente, com política de compatibilidade documentada em [`docs/07-contratos-mcp/contracts-v1.md`](docs/07-contratos-mcp/contracts-v1.md).
- Toda alegação técnica sobre cluster precisa ter evidência em [`legacy-infra/`](legacy-infra/) ou no VDF canônico [`../../assets/scripts/ODP-VDF.xml`](../../assets/scripts/ODP-VDF.xml), ou estar marcada `TBD`.
- Toda menção a tabelas Putz precisa estar no índice de [`db-reference/putz_db.md`](db-reference/putz_db.md) (linhas 5–98).
