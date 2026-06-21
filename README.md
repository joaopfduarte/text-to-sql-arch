# Arquitetura MCP para Text-to-SQL Orientado a Metadados

**Interfaces Conversacionais Confiáveis**

Documentação da pesquisa sobre engenharia do artefato Text-to-SQL com MCP, camada semântica e catálogo canônico (Apache Atlas). A documentação académica completa permanece **fora** deste repositório.

## Por onde começar

| Papel | Leitura inicial |
|-------|-----------------|
| Qualquer pessoa nova | [Glossário de anonimização](docs/00-glossario-anonimizacao.md) → [Leitura rápida](docs/00-leitura-rapida.md) |
| Dev Java | [Visão lógica](docs/03-arquitetura-aplicacao/visao-logica.md) → [Módulos Spring](docs/06-implementacao-java/modulos-spring.md) → [Contratos MCP v1](docs/07-contratos-mcp/contracts-v1.md) |
| Engenheiro de infra/dados | [Visão AWS](docs/05-infraestrutura/visao-aws.md) → [Cluster Hadoop](docs/05-infraestrutura/cluster-hadoop.md) → [Carga no cluster](docs/04-arquitetura-dados/carga-cluster-laboratorio.md) |
| Operador de corridas | [Runbook de reprodutibilidade](docs/08-experimento-avaliacao/runbook-reprodutibilidade.md) → [Operação](docs/09-operacao.md) |
| Pesquisador | [Rastreabilidade académica](docs/10-rastreabilidade-academica.md) |

## Mapa do repositório

```text
documentation/
  README.md
  mkdocs.yml
  package.json           # toolchain Web Components (Lit + Vite + Tailwind)
  src/components/        # Web Components TypeScript
  assets/scripts/ODP-VDF.xml
  docs/                    # site MkDocs (anonimizado)
  evidence/                # bateria, gabarito, schemas JSON
  templates/               # prompts e templates operacionais
  diagrams/                # PlantUML
  scripts/                 # prepare-docs, check-anonymization
```

## Desenvolvimento local

```bash
npm ci && npm run build
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
bash scripts/prepare-docs.sh
mkdocs serve
```

Abrir `http://127.0.0.1:8000`.

## Política de anonimização

- Vocabulário canónico: [Glossário de anonimização](docs/00-glossario-anonimizacao.md)
- Validação: `bash scripts/check-anonymization.sh`
- **Não versionar:** export relacional completo, documentação académica externa PDF, infra legada identificável

### Histórico git

Commits anteriores podem conter dados sensíveis. Para repositório público, considerar `git filter-repo` ou novo repositório limpo.

## Build de produção

```bash
npm ci && npm run build
bash scripts/prepare-docs.sh
mkdocs build --strict --site-dir public
```
