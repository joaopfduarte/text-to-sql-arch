/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{ts,html,css}'],
  prefix: 'dc-',
  darkMode: ['selector', '[data-md-color-scheme="slate"]'],
  corePlugins: {
    preflight: false,
  },
  theme: {
    extend: {},
  },
};
