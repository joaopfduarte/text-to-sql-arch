import { css, html, LitElement, unsafeCSS } from 'lit';
import { customElement, property, state } from 'lit/decorators.js';
import tailwindStyles from '../styles/tailwind.css?inline';

interface FlowStep {
  id: string;
  label: string;
  detail: string;
  icon: string;
}

const FLOW: FlowStep[] = [
  {
    id: 'query',
    label: 'Consulta NL',
    detail: 'Pergunta em linguagem natural sobre o domínio laboratorial.',
    icon: '💬',
  },
  {
    id: 'llm',
    label: 'Agente LLM',
    detail: 'Planeja tool calls e gera SQL sob orçamento de chamadas.',
    icon: '🤖',
  },
  {
    id: 'mcp',
    label: 'Servidor MCP',
    detail: 'Expõe tools tipadas: catálogo, schema, validação e execução.',
    icon: '🔌',
  },
  {
    id: 'atlas',
    label: 'Apache Atlas',
    detail: 'Catálogo canónico governa entidades, linhagem e metadados.',
    icon: '🗂️',
  },
  {
    id: 'validate',
    label: 'Validação SQL',
    detail: 'Parse Calcite, aderência estrutural e execução Hive controlada.',
    icon: '✓',
  },
  {
    id: 'storage',
    label: 'Hive / HDFS',
    detail: 'Dados massivos consultados sob ambiente laboratorial.',
    icon: '🗄️',
  },
];

@customElement('mcp-architecture-viewer')
export class McpArchitectureViewer extends LitElement {
  @property({ type: String }) heading = 'Fluxo arquitectural interactivo';

  @state() private activeIndex = 0;

  @state() private autoPlay = false;

  private timer: ReturnType<typeof setInterval> | undefined;

  static styles = [
    css`
      ${unsafeCSS(tailwindStyles)}
    `,
    css`
      :host {
        display: block;
        font-family: var(--md-text-font, system-ui, sans-serif);
      }

      @keyframes pulse-line {
        0%,
        100% {
          opacity: 0.35;
        }
        50% {
          opacity: 1;
        }
      }

      @keyframes pulse-node {
        0%,
        100% {
          box-shadow: 0 0 0 0 color-mix(in srgb, var(--md-primary-fg-color, #546e7a) 0%, transparent);
        }
        50% {
          box-shadow: 0 0 0 6px color-mix(in srgb, var(--md-primary-fg-color, #546e7a) 25%, transparent);
        }
      }

      .node-active {
        animation: pulse-node 1.6s ease-in-out infinite;
      }

      .line-active {
        animation: pulse-line 1.2s ease-in-out infinite;
      }
    `,
  ];

  connectedCallback() {
    super.connectedCallback();
    this.startAutoPlay();
  }

  disconnectedCallback() {
    super.disconnectedCallback();
    this.stopAutoPlay();
  }

  updated(changed: Map<string, unknown>) {
    if (changed.has('autoPlay')) {
      this.autoPlay ? this.startAutoPlay() : this.stopAutoPlay();
    }
  }

  private startAutoPlay() {
    this.stopAutoPlay();
    if (!this.autoPlay) return;
    this.timer = setInterval(() => {
      this.activeIndex = (this.activeIndex + 1) % FLOW.length;
    }, 2200);
  }

  private stopAutoPlay() {
    if (this.timer) {
      clearInterval(this.timer);
      this.timer = undefined;
    }
  }

  private selectStep(index: number) {
    this.activeIndex = index;
    if (this.autoPlay) this.startAutoPlay();
  }

  private toggleAutoPlay() {
    this.autoPlay = !this.autoPlay;
  }

  render() {
    const active = FLOW[this.activeIndex];

    return html`
      <section
        class="dc-rounded-xl dc-border dc-border-md-primary/20 dc-bg-md-surface dc-p-6"
        aria-label=${this.heading}
      >
        <div
          class="dc-mb-6 dc-flex dc-flex-wrap dc-items-center dc-justify-between dc-gap-3"
        >
          <h2
            class="dc-m-0 dc-text-lg dc-font-semibold"
            style="color: var(--md-default-fg-color);"
          >
            ${this.heading}
          </h2>
          <button
            type="button"
            class="dc-rounded dc-border dc-border-md-primary/30 dc-px-3 dc-py-1.5 dc-text-xs dc-font-medium dc-cursor-pointer dc-transition hover:dc-opacity-80"
            style="
              background: color-mix(in srgb, var(--md-primary-fg-color) 12%, transparent);
              color: var(--md-primary-fg-color);
            "
            @click=${this.toggleAutoPlay}
            aria-pressed=${this.autoPlay}
          >
            ${this.autoPlay ? 'Pausar animação' : 'Reproduzir fluxo'}
          </button>
        </div>

        <div
          class="dc-mb-6 dc-flex dc-flex-wrap dc-items-stretch dc-justify-center dc-gap-1 md:dc-gap-0"
          role="tablist"
          aria-label="Etapas do pipeline"
        >
          ${FLOW.map((step, index) => {
            const isActive = index === this.activeIndex;
            const isPast = index < this.activeIndex;
            return html`
              <div class="dc-flex dc-items-center">
                <button
                  type="button"
                  role="tab"
                  aria-selected=${isActive}
                  aria-controls="mcp-step-panel"
                  class="dc-flex dc-min-w-[5.5rem] dc-flex-col dc-items-center dc-gap-1 dc-rounded-lg dc-border dc-p-3 dc-text-center dc-transition dc-cursor-pointer
                    ${isActive ? 'node-active dc-border-md-primary dc-bg-md-primary/10' : ''}
                    ${!isActive ? 'dc-border-md-primary/20 hover:dc-border-md-primary/40' : ''}"
                  style="color: var(--md-default-fg-color);"
                  @click=${() => this.selectStep(index)}
                >
                  <span class="dc-text-xl" aria-hidden="true">${step.icon}</span>
                  <span class="dc-text-[0.65rem] dc-font-semibold dc-leading-tight dc-uppercase dc-tracking-wide">
                    ${step.label}
                  </span>
                </button>
                ${index < FLOW.length - 1
                  ? html`
                      <div
                        class="dc-hidden md:dc-block dc-mx-1 dc-h-0.5 dc-w-6 lg:dc-w-10 dc-rounded
                          ${isPast || isActive ? 'line-active dc-bg-md-primary' : 'dc-bg-md-primary/20'}"
                        aria-hidden="true"
                      ></div>
                    `
                  : null}
              </div>
            `;
          })}
        </div>

        <div
          id="mcp-step-panel"
          role="tabpanel"
          class="dc-rounded-lg dc-border dc-border-md-primary/15 dc-p-4"
          style="background: color-mix(in srgb, var(--md-code-bg-color) 60%, transparent);"
        >
          <p
            class="dc-m-0 dc-mb-1 dc-text-xs dc-font-semibold dc-uppercase dc-tracking-widest"
            style="color: var(--md-primary-fg-color);"
          >
            Etapa ${this.activeIndex + 1} de ${FLOW.length}
          </p>
          <p
            class="dc-m-0 dc-mb-2 dc-text-base dc-font-semibold"
            style="color: var(--md-default-fg-color);"
          >
            ${active.label}
          </p>
          <p
            class="dc-m-0 dc-text-sm dc-leading-relaxed"
            style="color: var(--md-default-fg-color--light, var(--md-default-fg-color));"
          >
            ${active.detail}
          </p>
        </div>

        <p
          class="dc-mt-4 dc-mb-0 dc-text-center dc-text-xs"
          style="color: var(--md-default-fg-color--light, #757575);"
        >
          Selecione uma etapa ou reproduza o fluxo para percorrer o pipeline Text-to-SQL orientado
          a metadados.
        </p>
      </section>
    `;
  }
}

declare global {
  interface HTMLElementTagNameMap {
    'mcp-architecture-viewer': McpArchitectureViewer;
  }
}
