# Arquitetura e engenharia do produto TCC

Pacote operacional **anonimizado** para a engenharia do artefato Text-to-SQL com MCP e Apache Atlas. A documentação académica completa permanece fora deste repositório.

## Por onde começar

| Papel | Leitura inicial |
|-------|-----------------|
| Qualquer pessoa nova no projeto | [Glossário](00-glossario-anonimizacao.md) → [Leitura rápida](00-leitura-rapida.md) |
| Dev Java | [Visão lógica](03-arquitetura-aplicacao/visao-logica.md) → [Módulos Spring](06-implementacao-java/modulos-spring.md) → [Contratos MCP](07-contratos-mcp/contracts-v1.md) |
| Engenheiro de infra/dados | [Visão AWS](05-infraestrutura/visao-aws.md) → [Cluster Hadoop](05-infraestrutura/cluster-hadoop.md) → [Carga no cluster](04-arquitetura-dados/carga-cluster-laboratorio.md) |
| Operador de corridas | [Runbook](08-experimento-avaliacao/runbook-reprodutibilidade.md) → [Operação](09-operacao.md) |
| Pesquisador (TCC) | [Rastreabilidade acadêmica](10-rastreabilidade-academica.md) |

## Estrutura do site

- **Glossário + 00–10:** documentação operacional anonimizada.
- **ADRs:** decisões em `docs/adr/`.
- **Diagramas:** Mermaid em `docs/diagrams/` e PlantUML em `diagrams/`.

## Desenvolvimento local

```bash
pip install -r requirements.txt
bash scripts/prepare-docs.sh
mkdocs serve
```

Validação de anonimização: `bash scripts/check-anonymization.sh`

## Princípios de manutenção

- Vocabulário canónico: [Glossário de anonimização](00-glossario-anonimizacao.md).
- Mudança de design relevante exige ADR e atualização de diagramas.
- Evidência experimental: `runId`, `seed`, `modelVersion`, `commitHash`, `datasetVersion`, `contractsVersion`.
- Export relacional completo e documentação académica externa: **offline**, fora do git.
