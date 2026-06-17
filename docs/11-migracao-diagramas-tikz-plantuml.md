# Inventário de diagramas (LaTeX + artifact-docs)

## Escopo LaTeX (`assets/figures/`)

Convenção: `cap-x-<conteudo>.pdf` na raiz; fontes em `code/{tikz,mmd,drawio}/`.
Dicionário completo: [`assets/figures/README.md`](../../assets/figures/README.md).

| Figura final (`assets/figures/*.pdf`) | Fonte canônica | Usado em |
|---|---|---|
| `cap1-fluxo-logico.pdf` | `assets/figures/code/mmd/cap1-fluxo-logico.mmd` | `content/cap1-introducao.tex`, `apresentacao/sections/02-pergunta-objetivos.tex` |
| `cap4-ingestao-massa.pdf` | `assets/figures/code/tikz/cap4-ingestao-massa.tikz.tex` | `content/cap4-metodologia.tex`, `apresentacao/sections/04-metodologia.tex` |
| `cap4-fluxo-artefato.pdf` | `assets/figures/code/tikz/cap4-fluxo-artefato.tikz.tex` | `content/cap4-metodologia.tex`, `apresentacao/sections/04-metodologia.tex` |

Formatos suportados na pipeline LaTeX:

- **TikZ** (`code/tikz/*.tikz.tex`) — compilado por `pdflatex` (`standalone`).
- **Mermaid** (`code/mmd/*.mmd`) — `mmdc --pdfFit` (+ `pdfcrop` opcional).
- **draw.io** (`code/drawio/*.drawio`) — export PDF manual pelo autor.

## Escopo Markdown (`artifact-docs`, PlantUML)

| Diagrama antigo | Fonte canônica nova |
|---|---|
| `diagrama-mestre.mmd` | `diagrama-mestre.puml` |
| `ingestao-putz.mmd` | `ingestao-putz.puml` |
| `rede-implantacao.mmd` | `rede-implantacao.puml` |
| `cluster-topologia-aws.mmd` | `cluster-topologia-aws.puml` |
| `rede-aws.mmd` | `rede-aws.puml` |

PlantUML permanece a fonte canónica para documentação em `artifact-docs/diagrams/`
(`.puml` → `.svg`); não substitui os PDFs de `assets/figures/` usados no LaTeX.
