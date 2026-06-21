import { defineConfig } from 'vite';
import { resolve } from 'path';

export default defineConfig({
  build: {
    lib: {
      entry: resolve(__dirname, 'src/main.ts'),
      name: 'DocsComponents',
      formats: ['iife'],
      fileName: () => 'js/bundle.js',
    },
    outDir: 'docs/assets',
    emptyOutDir: false,
    cssCodeSplit: false,
    rollupOptions: {
      output: {
        assetFileNames: 'css/style.css',
      },
    },
  },
});
