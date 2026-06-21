/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{ts,html,css}', './docs/**/*.md'],
  prefix: 'dc-',
  darkMode: ['selector', '[data-md-color-scheme="slate"]'],
  corePlugins: {
    preflight: false,
  },
  theme: {
    extend: {
      colors: {
        md: {
          primary: 'var(--md-primary-fg-color, #90a4ae)',
          accent: 'var(--md-accent-fg-color, #b0bec5)',
          default: 'var(--md-default-fg-color, #212121)',
          muted: 'var(--md-default-fg-color--light, #757575)',
          surface: 'var(--md-default-bg-color, #ffffff)',
          code: 'var(--md-code-bg-color, #f5f5f5)',
        },
      },
      fontFamily: {
        sans: ['var(--md-text-font, system-ui, sans-serif)'],
        mono: ['var(--md-code-font, ui-monospace, monospace)'],
      },
      maxWidth: {
        lp: '72rem',
      },
    },
  },
};
