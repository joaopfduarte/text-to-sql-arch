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

## Submissão anonimizada (anonymous.4open.science)

Durante a revisão duplo-cega, o site renderizado deve estar **commitado no repositório** (branch `gh-pages`). O deploy via GitHub Actions **não** expõe HTML ao Anonymous GitHub — use o pipeline anonimizado abaixo.

### Pré-requisitos

Mesmos do CI: Node 22, Python 3.12, PlantUML, Graphviz, Java (headless).

### Build local (sem publicar)

```bash
bash scripts/build-anonymous.sh
# ou apenas validar output existente:
bash scripts/check-anonymous-build.sh public-anonymous
```

Gera `public-anonymous/` com [`mkdocs.anonymous.yml`](mkdocs.anonymous.yml) (sem `site_url`, `repo_url`, cards sociais nem botão “Exibir fonte”).

> Ao alterar `nav` ou plugins em `mkdocs.yml`, espelhe as mudanças em `mkdocs.anonymous.yml`.

### Publicar na branch `gh-pages`

```bash
bash scripts/publish-gh-pages.sh
# rebuild forçado:
bash scripts/publish-gh-pages.sh --force
# só build + validação, sem git push:
bash scripts/publish-gh-pages.sh --dry-run
```

Alternativa via GitHub Actions: workflow **Anonymous Pages** (`workflow_dispatch`) em [`.github/workflows/anonymous-pages.yml`](.github/workflows/anonymous-pages.yml).

### Configurar GitHub Pages (período de revisão)

1. **Settings → Pages**
2. Source: **Deploy from a branch**
3. Branch: **`gh-pages`** / **/(root)**
4. Aguardar deploy (~1–2 min)

### Anonimizar em anonymous.4open.science

1. Acesse [anonymous.4open.science](https://anonymous.4open.science/) e faça login
2. **Anonymize** → URL do repositório
3. Branch: **`gh-pages`** (deve coincidir com o branch do Pages)
4. Ative **Github page** (perfil ou na anonimização)
5. Informe termos a substituir, por exemplo:
   ```
   joaopfduarte
   João
   Duarte
   <nome-da-instituicao>
   <sigla-instituicao>
   ```
6. Prefira modo **Download** (site ~6,7 MB, abaixo de 7,3 MiB)

### Validar antes de citar no artigo

- Landing page com `<mcp-architecture-viewer>` funcional
- Navegação entre capítulos, diagramas SVG e MathJax
- Nenhum link para `github.com/joaopfduarte` ou `github.io/joaopfduarte`
- `bash scripts/check-anonymous-build.sh public-anonymous` passa sem erros

**(Opcional)** Segunda anonimização do branch `main` para revisores que queiram Markdown/código fonte — link separado no artigo.

### Após aceitação do artigo

1. **Settings → Pages** → voltar para **GitHub Actions**
2. Push em `main` redeploya o site identificável
3. Branch `gh-pages` pode ser mantida ou removida

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
