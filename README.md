# Arquitetura MCP para Text-to-SQL Orientado a Metadados

**Interfaces Conversacionais Confiáveis**

Documentação da pesquisa sobre engenharia do artefato Text-to-SQL com MCP, camada semântica e catálogo canônico (Apache Atlas). A documentação acadêmica completa permanece **fora** deste repositório.

## Por onde começar

| Papel | Leitura inicial |
|-------|-----------------|
| Qualquer pessoa nova | [Leitura rápida](docs/guias/leitura-rapida.md) |
| Dev Java | [Visão lógica](docs/arquitetura/aplicacao/visao-logica.md) → [Módulos Spring](docs/implementacao/modulos-spring.md) → [Contratos MCP v1](docs/arquitetura/contratos-mcp/contracts-v1.md) |
| Engenheiro de infra/dados | [Visão AWS](docs/infraestrutura/visao-aws.md) → [Cluster Hadoop](docs/infraestrutura/cluster-hadoop.md) → [Carga no cluster](docs/arquitetura/dados/carga-cluster-laboratorio.md) |
| Operador de corridas | [Runbook de reprodutibilidade](docs/experimento/runbook-reprodutibilidade.md) → [Operação](docs/operacao/index.md) |
| Pesquisador | [Rastreabilidade acadêmica](docs/pesquisa/rastreabilidade-academica.md) |

## Mapa do repositório

```text
documentation/
  README.md
  mkdocs.yml
  package.json             # toolchain Web Components (Lit + Vite + Tailwind)
  src/                     # código interativo (Feature-Sliced Design)
    main.ts                # registro central de Custom Elements
    shared/                # base reutilizável
      lib/                 # utilitários (access-date)
      ui/                  # átomos/ícones (flow-icons)
      styles/              # global.css, tailwind.css
    features/              # uma pasta por componente
      mcp-architecture-viewer/
        index.ts           # import side-effect
        ui/                # <mcp-architecture-viewer>
  docs/                    # site MkDocs (anonimizado), por domínio
    assets/scripts/ODP-VDF.xml
    index.md
    guias/                 # leitura-rapida
    produto/               # escopo
    arquitetura/           # negocio, aplicacao/, dados/, contratos-mcp/
    infraestrutura/
    implementacao/
    experimento/
    operacao/
    pesquisa/              # rastreabilidade-academica, roadmap
    adr/
  evidence/                # bateria, gabarito, schemas JSON
  templates/               # prompts e templates operacionais
  diagrams/                # PlantUML
  scripts/                 # prepare-docs, check-anonymization, migrate-doc-paths
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

- Validação: `bash scripts/check-anonymization.sh`
- **Não versionar:** export relacional completo, documentação acadêmica externa PDF, infra legada identificável

### Histórico git

Commits anteriores podem conter dados sensíveis. Para repositório público, considerar `git filter-repo` ou novo repositório limpo.

## Build de produção

```bash
npm ci && npm run build
bash scripts/prepare-docs.sh
mkdocs build --strict --site-dir public
```

> O site é gerado em `public/` (ou `site/` no `mkdocs serve`). **Nunca** use `--site-dir docs/assets`: `docs/assets/` é fonte versionada (só `js/`, `css/`, `scripts/`). Valide com `bash scripts/check-docs-assets.sh`.

## Publicação (GitHub Pages)

O deploy é feito pelo [workflow GitHub Pages](.github/workflows/pages.yml):

- **Pull requests:** validação completa (build de componentes, checks e MkDocs strict) — sem deploy.
- **Push em `main`:** build + deploy para [https://joaopfduarte.github.io/text-to-sql-arch/](https://joaopfduarte.github.io/text-to-sql-arch/).

Configuração inicial (uma vez no repositório GitHub):

1. **Settings → Pages → Build and deployment → Source:** `GitHub Actions`
2. Após o primeiro push em `main`, o environment `github-pages` é criado automaticamente.

## Adicionar um Web Component

A camada interativa segue Feature-Sliced Design em `src/`, com aliases `@shared/*` e `@features/*` (Vite + TypeScript). Para criar um novo componente:

1. Crie `src/features/<nome>/ui/<tag>.ts` com um elemento Lit registrado:

   ```ts
   import { html, LitElement } from 'lit';
   import { customElement } from 'lit/decorators.js';

   @customElement('minha-tag')
   export class MinhaTag extends LitElement {
     render() {
       return html`<div class="dc-p-4">Olá</div>`;
     }
   }
   ```

2. Crie `src/features/<nome>/index.ts` com o import side-effect:

   ```ts
   import './ui/minha-tag';
   ```

3. Registre o componente em `src/main.ts`:

   ```ts
   import '@features/<nome>';
   ```

4. Gere o bundle: `npm run build` (Vite grava em `.vite-out/`; o sync copia para `docs/assets/js/bundle.js` e `docs/assets/css/style.css`, ambos gitignored).

5. Use no Markdown, isolando do parser do MkDocs:

   ```html
   <div markdown="0">
     <minha-tag attr="valor"></minha-tag>
   </div>
   ```

Estilos: utilitários Tailwind com prefixo `dc-` mais variáveis CSS do Material (`--md-primary-fg-color`, `--md-default-fg-color`, etc.). Componentes em `features/` podem importar de `shared/`, nunca o contrário.
