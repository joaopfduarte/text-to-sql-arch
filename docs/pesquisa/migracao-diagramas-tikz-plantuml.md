# Inventário de diagramas (LaTeX + artifact-docs)

## Escopo LaTeX (`assets/figures/`)

Convenção: `cap-x-<conteudo>.pdf` na raiz; fontes em `code/{tikz,mmd,d2,drawio}/`.
Dicionário completo: repositório LaTeX externo (`assets/figures/README.md`).

| Figura final (`assets/figures/*.pdf`) | Fonte canônica | Usado em |
|---|---|---|
| `cap1-fluxo-logico.pdf` | `assets/figures/code/mmd/cap1-fluxo-logico.mmd` | Entrega LaTeX e slides (repositório acadêmico externo) |
| `cap4-ingestao-massa.pdf` | `assets/figures/code/tikz/cap4-ingestao-massa.tikz.tex` | Entrega LaTeX e slides (repositório acadêmico externo) |
| `cap4-fluxo-artefato.pdf` | `assets/figures/code/tikz/cap4-fluxo-artefato.tikz.tex` | Entrega LaTeX e slides (repositório acadêmico externo) |

Formatos suportados na pipeline LaTeX:

- **TikZ** (`code/tikz/*.tikz.tex`) — compilado por `pdflatex` (`standalone`).
- **Mermaid** (`code/mmd/*.mmd`) — `mmdc --pdfFit` (+ `pdfcrop` opcional).
- **D2** (`code/d2/*.d2`) — `d2` CLI (+ `pdfcrop` opcional).
- **draw.io** (`code/drawio/*.drawio`) — export PDF manual pelo autor.

## Escopo Markdown (`artifact-docs`, PlantUML)

| Diagrama antigo | Fonte canônica nova |
|---|---|
| `diagrama-mestre.mmd` | `diagrama-mestre.puml` |
| `ingestao-laboratorio.mmd` | `ingestao-laboratorio.puml` |
| `rede-implantacao.mmd` | `rede-implantacao.puml` |
| `cluster-topologia-aws.mmd` | `cluster-topologia-aws.puml` |
| `rede-aws.mmd` | `rede-aws.puml` |

PlantUML permanece a fonte canônica para documentação em `diagrams/`
(`.puml` → `.svg`); não substitui os PDFs de `assets/figures/` usados no LaTeX.
