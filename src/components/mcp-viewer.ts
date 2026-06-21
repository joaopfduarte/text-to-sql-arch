import { css, html, LitElement, unsafeCSS } from 'lit';
import { customElement, property, state } from 'lit/decorators.js';
import tailwindStyles from '../styles/tailwind.css?inline';

interface FlowStep {
  label: string;
  detail: string;
}

const FLOW: FlowStep[] = [
  {
    label: 'Consulta NL',
    detail: 'Pergunta em linguagem natural sobre o domínio laboratorial.',
  },
  {
    label: 'Agente LLM',
    detail: 'Planeja tool calls e gera SQL sob orçamento de chamadas.',
  },
  {
    label: 'Servidor MCP',
    detail: 'Expõe tools tipadas: catálogo, schema, validação e execução.',
  },
  {
    label: 'Apache Atlas',
    detail: 'Catálogo canônico governa entidades, linhagem e metadados.',
  },
  {
    label: 'Validação SQL',
    detail: 'Parse Calcite, aderência estrutural e execução Hive controlada.',
  },
  {
    label: 'Hive / HDFS',
    detail: 'Dados massivos consultados sob ambiente laboratorial.',
  },
];

const STEP_INTERVAL_MS = 5000;

@customElement('mcp-architecture-viewer')
export class McpArchitectureViewer extends LitElement {
  @property({ type: String }) heading = 'Fluxo arquitetural interativo';

  @state() private activeIndex = 0;

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

      .step-number {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 2rem;
        height: 2rem;
        border-radius: 9999px;
        font-size: 0.875rem;
        font-weight: 700;
        font-variant-numeric: tabular-nums;
        line-height: 1;
        border: 2px solid color-mix(in srgb, var(--md-primary-fg-color, #546e7a) 25%, transparent);
        color: var(--md-default-fg-color--light, #757575);
        background: color-mix(in srgb, var(--md-default-fg-color, #333) 4%, transparent);
        transition:
          color 0.25s ease,
          border-color 0.25s ease,
          background 0.25s ease,
          box-shadow 0.25s ease;
      }

      .step-number.is-active {
        color: var(--md-primary-bg-color, #fff);
        border-color: var(--md-primary-fg-color, #546e7a);
        background: var(--md-primary-fg-color, #546e7a);
        box-shadow: 0 0 0 4px color-mix(in srgb, var(--md-primary-fg-color, #546e7a) 20%, transparent);
      }

      .step-number.is-past {
        color: var(--md-primary-fg-color, #546e7a);
        border-color: color-mix(in srgb, var(--md-primary-fg-color, #546e7a) 55%, transparent);
        background: color-mix(in srgb, var(--md-primary-fg-color, #546e7a) 12%, transparent);
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
    this.startAutoAdvance();
  }

  disconnectedCallback() {
    super.disconnectedCallback();
    this.stopAutoAdvance();
  }

  private startAutoAdvance() {
    this.stopAutoAdvance();
    this.timer = setInterval(() => {
      this.activeIndex = (this.activeIndex + 1) % FLOW.length;
    }, STEP_INTERVAL_MS);
  }

  private stopAutoAdvance() {
    if (this.timer) {
      clearInterval(this.timer);
      this.timer = undefined;
    }
  }

  private selectStep(index: number) {
    this.activeIndex = index;
    this.startAutoAdvance();
  }

  private renderStepNumber(stepNumber: number, isActive: boolean, isPast: boolean) {
    const numberClass = [
      'step-number',
      isActive ? 'is-active' : '',
      isPast ? 'is-past' : '',
    ]
      .filter(Boolean)
      .join(' ');

    return html`
      <span class=${numberClass} aria-hidden="true">${stepNumber}</span>
    `;
  }

  render() {
    const active = FLOW[this.activeIndex];

    return html`
      <section
        class="dc-rounded-xl dc-border dc-border-md-primary/20 dc-bg-md-surface dc-p-6"
        aria-label=${this.heading}
      >
        <h2
          class="dc-m-0 dc-mb-6 dc-text-lg dc-font-semibold"
          style="color: var(--md-default-fg-color);"
        >
          ${this.heading}
        </h2>

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
                  class="dc-flex dc-min-w-[5.5rem] dc-flex-col dc-items-center dc-gap-1.5 dc-rounded-lg dc-border dc-p-3 dc-text-center dc-transition dc-cursor-pointer
                    ${isActive ? 'node-active dc-border-md-primary dc-bg-md-primary/10' : ''}
                    ${!isActive ? 'dc-border-md-primary/20 hover:dc-border-md-primary/40' : ''}"
                  style="color: var(--md-default-fg-color);"
                  @click=${() => this.selectStep(index)}
                >
                  ${this.renderStepNumber(index + 1, isActive, isPast)}
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
          O fluxo avança automaticamente a cada 5 segundos. Selecione uma etapa para focar nela.
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
