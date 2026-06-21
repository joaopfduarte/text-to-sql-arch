import { css, html, LitElement, unsafeCSS } from 'lit';
import { customElement, property, state } from 'lit/decorators.js';
import tailwindStyles from '../styles/tailwind.css?inline';

@customElement('docs-demo')
export class DocsDemo extends LitElement {
  @property({ type: String }) title = 'Componentes interativos';

  @property({ type: String }) variant: 'default' | 'accent' = 'default';

  @state() private count = 0;

  static styles = [
    css`
      ${unsafeCSS(tailwindStyles)}
    `,
    css`
      :host {
        display: block;
        font-family: var(--md-text-font, system-ui, sans-serif);
      }
    `,
  ];

  private increment() {
    this.count += 1;
  }

  render() {
    const cardClass =
      this.variant === 'accent'
        ? 'dc-border-blue-400 dc-bg-blue-50 dark:dc-bg-slate-800'
        : 'dc-border-slate-200 dc-bg-slate-50 dark:dc-bg-slate-900 dark:dc-border-slate-700';

    return html`
      <div
        class="dc-rounded-lg dc-border dc-p-4 ${cardClass}"
        role="region"
        aria-label=${this.title}
      >
        <h3 class="dc-m-0 dc-mb-2 dc-text-base dc-font-semibold dc-text-slate-800 dark:dc-text-slate-100">
          ${this.title}
        </h3>
        <p class="dc-m-0 dc-mb-3 dc-text-sm dc-text-slate-600 dark:dc-text-slate-300">
          Web Component Lit + Tailwind integrado ao MkDocs Material. Clique para validar
          interatividade.
        </p>
        <div class="dc-flex dc-items-center dc-gap-3">
          <button
            type="button"
            class="dc-rounded dc-px-3 dc-py-1.5 dc-text-sm dc-font-medium dc-text-white dc-border-0 dc-cursor-pointer hover:dc-opacity-90"
            style="background-color: var(--md-primary-fg-color);"
            @click=${this.increment}
          >
            Incrementar
          </button>
          <span class="dc-text-sm dc-font-mono dc-text-slate-700 dark:dc-text-slate-200">
            contador: ${this.count}
          </span>
        </div>
      </div>
    `;
  }
}

declare global {
  interface HTMLElementTagNameMap {
    'docs-demo': DocsDemo;
  }
}
