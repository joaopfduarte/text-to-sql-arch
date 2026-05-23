# Documentação de TCC

Pacote operacional para a engenharia do artefato Text-to-SQL com MCP e Apache Atlas. A narrativa académica completa está na [monografia](docs/monografia.pdf); este repositório publica a documentação operacional via MkDocs.

## Site da documentação

```bash
pip install -r requirements.txt
mkdocs serve
```

Abrir `http://127.0.0.1:8000`. O site usa [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/) com perfil visual neutro e recursos avançados (navegação instantânea, tabs, busca aprimorada, cópia de código e social cards).

Build de produção (GitLab Pages):

```bash
mkdocs build --strict --site-dir public
```

**PDF de referência:** [`docs/monografia.pdf`](docs/monografia.pdf). Atualizar com `cp monografia.pdf docs/monografia.pdf` quando recompilar a monografia.

## Por onde começar

| Papel | Leitura inicial |
|-------|-----------------|
| Qualquer pessoa nova no projeto | [`docs/00-leitura-rapida.md`](docs/00-leitura-rapida.md) |
| Dev Java | [`docs/03-arquitetura-aplicacao/visao-logica.md`](docs/03-arquitetura-aplicacao/visao-logica.md) → [`modulos-spring.md`](docs/06-implementacao-java/modulos-spring.md) → [`contracts-v1.md`](docs/07-contratos-mcp/contracts-v1.md) |
| Engenheiro de infra/dados | [`visao-aws.md`](docs/05-infraestrutura/visao-aws.md) → [`cluster-hadoop.md`](docs/05-infraestrutura/cluster-hadoop.md) → [`carga-cluster-xpto.md`](docs/04-arquitetura-dados/carga-cluster-xpto.md) |
| Operador de corridas | [`runbook-reprodutibilidade.md`](docs/08-experimento-avaliacao/runbook-reprodutibilidade.md) → [`09-operacao.md`](docs/09-operacao.md) |
| Pessoa que escreve o TCC | [`10-rastreabilidade-academica.md`](docs/10-rastreabilidade-academica.md) |

## Mapa do repositório

```
documentation/
  README.md
  mkdocs.yml
  requirements.txt
  docs/                    # fonte do site MkDocs
    index.md
    monografia.pdf         # PDF da monografia (obrigatório no CI)
    monografia.md
    00-leitura-rapida.md … 10-rastreabilidade-academica.md
    diagrams/              # fontes Mermaid (embutidas nas páginas)
    adr/
    legacy-infra/index.md  # resumo legado OCI (código Terraform na raiz)
  db-reference/            # referência interna offline (não publicada)
  legacy-infra/            # Terraform/Ansible OCI (não publicado)
  templates/
  evidence/
```

## Princípios de manutenção

- Fonte única da verdade para arquitetura e protocolo experimental (site MkDocs).
- Mudança de design relevante exige ADR em `docs/adr/` e atualização do diagrama em `docs/diagrams/`.
- Evidência experimental: `runId`, `seed`, `modelVersion`, `commitHash`, `datasetVersion`, `contractsVersion`.
- Contratos MCP: [`docs/07-contratos-mcp/contracts-v1.md`](docs/07-contratos-mcp/contracts-v1.md).
- Detalhes de cluster, VDF e dicionário de dados completos: [`docs/monografia.md`](docs/monografia.md) (PDF, acesso restrito).
- Nomes físicos de tabelas/colunas do banco **não** são publicados no site; use identificadores opacos `tbl_*` / `col_*` (ver [`banco-xpto-dominio.md`](docs/04-arquitetura-dados/banco-xpto-dominio.md)).
- Recursos visuais do Material (incluindo social cards) dependem de `mkdocs-material`, `Pillow` e `CairoSVG` em `requirements.txt`.
