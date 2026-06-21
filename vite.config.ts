import { execSync } from 'node:child_process';
import { resolve } from 'path';
import { defineConfig, type Plugin } from 'vite';

/** Copia js/css para docs/assets/ após cada build (evita vite escrever dentro de docs/). */
function syncDocsAssets(): Plugin {
  return {
    name: 'sync-docs-assets',
    writeBundle() {
      execSync('bash scripts/sync-vite-assets.sh', {
        cwd: resolve(__dirname),
        stdio: 'inherit',
      });
    },
  };
}

export default defineConfig({
  plugins: [syncDocsAssets()],
  resolve: {
    alias: {
      '@shared': resolve(__dirname, 'src/shared'),
      '@features': resolve(__dirname, 'src/features'),
    },
  },
  build: {
    lib: {
      entry: resolve(__dirname, 'src/main.ts'),
      name: 'DocsComponents',
      formats: ['iife'],
      fileName: () => 'js/bundle.js',
    },
    outDir: '.vite-out',
    emptyOutDir: true,
    cssCodeSplit: false,
    rollupOptions: {
      output: {
        assetFileNames: 'css/style.css',
      },
    },
  },
});
