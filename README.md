# Documentação operacional do artefato TCC

Pacote operacional **anonimizado** para a engenharia do artefato Text-to-SQL com MCP, camada semântica e catálogo canônico (Apache Atlas). A documentação académica completa permanece **fora** deste repositório.

## Por onde começar

| Papel | Leitura inicial |
|-------|-----------------|
| Qualquer pessoa nova | [`docs/00-glossario-anonimizacao.md`](docs/00-glossario-anonimizacao.md) → [`docs/00-leitura-rapida.md`](docs/00-leitura-rapida.md) |
| Dev Java | [`docs/03-arquitetura-aplicacao/visao-logica.md`](docs/03-arquitetura-aplicacao/visao-logica.md) → [`docs/06-implementacao-java/modulos-spring.md`](docs/06-implementacao-java/modulos-spring.md) → [`docs/07-contratos-mcp/contracts-v1.md`](docs/07-contratos-mcp/contracts-v1.md) |
| Engenheiro de infra/dados | [`docs/05-infraestrutura/visao-aws.md`](docs/05-infraestrutura/visao-aws.md) → [`docs/05-infraestrutura/cluster-hadoop.md`](docs/05-infraestrutura/cluster-hadoop.md) → [`docs/04-arquitetura-dados/carga-cluster-laboratorio.md`](docs/04-arquitetura-dados/carga-cluster-laboratorio.md) |
| Operador de corridas | [`docs/08-experimento-avaliacao/runbook-reprodutibilidade.md`](docs/08-experimento-avaliacao/runbook-reprodutibilidade.md) → [`docs/09-operacao.md`](docs/09-operacao.md) |
| Pesquisador (TCC) | [`docs/10-rastreabilidade-academica.md`](docs/10-rastreabilidade-academica.md) |

## Mapa do repositório

```text
documentation/
  README.md
  mkdocs.yml
  assets/scripts/ODP-VDF.xml
  docs/                    # site MkDocs (anonimizado)
  evidence/                # bateria, gabarito, schemas JSON
  templates/               # prompts e templates operacionais
  diagrams/                # PlantUML
  scripts/                 # prepare-docs, check-anonymization
```

## Desenvolvimento local

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
bash scripts/prepare-docs.sh
mkdocs serve
```

Abrir `http://127.0.0.1:8000`.

## Política de anonimização

- Vocabulário canónico: [`docs/00-glossario-anonimizacao.md`](docs/00-glossario-anonimizacao.md)
- Validação: `bash scripts/check-anonymization.sh`
- **Não versionar:** export relacional completo, documentação académica externa PDF, infra legada identificável

### Histórico git

Commits anteriores podem conter dados sensíveis. Para repositório público, considerar `git filter-repo` ou novo repositório limpo.

## Build de produção

```bash
bash scripts/prepare-docs.sh
mkdocs build --strict --site-dir public
```
