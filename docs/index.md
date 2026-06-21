---
description: Interfaces de linguagem natural para bancos de dados via MCP — fundamentação teórica e documentação técnica da pesquisa Text-to-SQL.
hide:
  - navigation
  - toc
tags:
  - onboarding
---

<div class="dc-lp dc-max-w-lp dc-mx-auto dc-px-4 dc-py-8 md:dc-py-12" markdown="0">

<section class="dc-mb-16 dc-text-center" aria-labelledby="lp-hero-title">
  <p
    class="dc-m-0 dc-mb-4 dc-text-xs dc-font-semibold dc-uppercase dc-tracking-[0.2em]"
    style="color: var(--md-primary-fg-color);"
  >
    Pesquisa · Text-to-SQL · MCP · Apache Atlas
  </p>
  <h1
    id="lp-hero-title"
    class="dc-m-0 dc-mb-5 dc-text-3xl md:dc-text-4xl lg:dc-text-5xl dc-font-bold dc-leading-tight dc-tracking-tight"
    style="color: var(--md-default-fg-color);"
  >
    Interfaces de Linguagem Natural para Bancos de Dados via MCP
  </h1>
  <p
    class="dc-mx-auto dc-mb-8 dc-max-w-2xl dc-text-base md:dc-text-lg dc-leading-relaxed"
    style="color: var(--md-default-fg-color--light, var(--md-default-fg-color));"
  >
    Arquitectura em que um agente LLM consulta metadados governados por catálogo canónico,
    invoca tools via Model Context Protocol, valida SQL estruturalmente e executa consultas
    sob ambiente controlado — com trilha completa por corrida.
  </p>
  <div class="dc-flex dc-flex-wrap dc-items-center dc-justify-center dc-gap-3">
    <a href="00-leitura-rapida/" class="md-button md-button--primary">
      Ler a Documentação
    </a>
    <a href="03-arquitetura-aplicacao/visao-logica/" class="md-button">
      Explorar Arquitetura
    </a>
  </div>
</section>

<section class="dc-mb-16" aria-labelledby="lp-pillars-title">
  <h2
    id="lp-pillars-title"
    class="dc-m-0 dc-mb-2 dc-text-center dc-text-xl dc-font-semibold"
    style="color: var(--md-default-fg-color);"
  >
    Fundamentos da pesquisa
  </h2>
  <p
    class="dc-mx-auto dc-mb-8 dc-max-w-xl dc-text-center dc-text-sm"
    style="color: var(--md-default-fg-color--light, #757575);"
  >
    Quatro pilares técnicos que estruturam o artefato e a avaliação experimental.
  </p>
  <div class="dc-grid dc-grid-cols-1 sm:dc-grid-cols-2 lg:dc-grid-cols-4 dc-gap-4">
    <article
      class="dc-rounded-lg dc-border dc-border-md-primary/15 dc-p-5 dc-transition hover:dc-border-md-primary/35"
      style="background: color-mix(in srgb, var(--md-default-bg-color) 92%, var(--md-primary-fg-color));"
    >
      <h3
        class="dc-m-0 dc-mb-2 dc-text-sm dc-font-semibold dc-uppercase dc-tracking-wide"
        style="color: var(--md-primary-fg-color);"
      >
        Pipeline Text-to-SQL
      </h3>
      <p
        class="dc-m-0 dc-text-sm dc-leading-relaxed"
        style="color: var(--md-default-fg-color--light, var(--md-default-fg-color));"
      >
        Geração, validação sintáctica e execução de SQL a partir de perguntas em linguagem natural,
        com desfechos rastreáveis por corrida.
      </p>
    </article>
    <article
      class="dc-rounded-lg dc-border dc-border-md-primary/15 dc-p-5 dc-transition hover:dc-border-md-primary/35"
      style="background: color-mix(in srgb, var(--md-default-bg-color) 92%, var(--md-primary-fg-color));"
    >
      <h3
        class="dc-m-0 dc-mb-2 dc-text-sm dc-font-semibold dc-uppercase dc-tracking-wide"
        style="color: var(--md-primary-fg-color);"
      >
        Model Context Protocol
      </h3>
      <p
        class="dc-m-0 dc-text-sm dc-leading-relaxed"
        style="color: var(--md-default-fg-color--light, var(--md-default-fg-color));"
      >
        Camada de integração tipada entre o agente e o domínio: tools para catálogo, schema,
        validação e execução sob orçamento de chamadas.
      </p>
    </article>
    <article
      class="dc-rounded-lg dc-border dc-border-md-primary/15 dc-p-5 dc-transition hover:dc-border-md-primary/35"
      style="background: color-mix(in srgb, var(--md-default-bg-color) 92%, var(--md-primary-fg-color));"
    >
      <h3
        class="dc-m-0 dc-mb-2 dc-text-sm dc-font-semibold dc-uppercase dc-tracking-wide"
        style="color: var(--md-primary-fg-color);"
      >
        Catálogo e governança
      </h3>
      <p
        class="dc-m-0 dc-text-sm dc-leading-relaxed"
        style="color: var(--md-default-fg-color--light, var(--md-default-fg-color));"
      >
        Apache Atlas como fonte canónica de metadados; HDFS e Hive como substrato de dados
        massivos do ambiente laboratorial.
      </p>
    </article>
    <article
      class="dc-rounded-lg dc-border dc-border-md-primary/15 dc-p-5 dc-transition hover:dc-border-md-primary/35"
      style="background: color-mix(in srgb, var(--md-default-bg-color) 92%, var(--md-primary-fg-color));"
    >
      <h3
        class="dc-m-0 dc-mb-2 dc-text-sm dc-font-semibold dc-uppercase dc-tracking-wide"
        style="color: var(--md-primary-fg-color);"
      >
        Infraestrutura e implantação
      </h3>
      <p
        class="dc-m-0 dc-text-sm dc-leading-relaxed"
        style="color: var(--md-default-fg-color--light, var(--md-default-fg-color));"
      >
        Cluster Hadoop em Oracle Linux 9, topologia AWS mínima e pipeline de carga reprodutível
        para massa de teste e experimentos.
      </p>
    </article>
  </div>
</section>

<section class="dc-mb-16" aria-labelledby="lp-demo-title">
  <h2
    id="lp-demo-title"
    class="dc-m-0 dc-mb-6 dc-text-center dc-text-xl dc-font-semibold"
    style="color: var(--md-default-fg-color);"
  >
    Demonstração interactiva
  </h2>
  <mcp-architecture-viewer heading="Pipeline Text-to-SQL orientado a metadados"></mcp-architecture-viewer>
</section>

<footer
  class="dc-border-t dc-border-md-primary/15 dc-pt-6 dc-text-center dc-text-xs"
  style="color: var(--md-default-fg-color--light, #757575);"
>
  <p class="dc-m-0 dc-mb-1">
    Licença <a href="https://opensource.org/licenses/MIT" class="dc-underline hover:dc-opacity-80" style="color: var(--md-primary-fg-color);">MIT</a>
    · Documentação v1.0
  </p>
  <p class="dc-m-0">
    Conteúdo técnico da pesquisa — sem dados pessoais ou institucionais.
  </p>
</footer>

</div>
