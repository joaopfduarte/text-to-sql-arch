#!/usr/bin/env node
/**
 * Copia bundle Vite de .vite-out/ para docs/assets/ e remove lixo de MkDocs.
 * Node puro — compatível com node:22-alpine (sem bash).
 */
import { cpSync, existsSync, mkdirSync, readdirSync, rmSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';

const ROOT = join(dirname(fileURLToPath(import.meta.url)), '..');
const DIST = join(ROOT, '.vite-out');
const ASSETS = join(ROOT, 'docs/assets');

function cleanDocsAssets() {
  if (!existsSync(ASSETS)) return;

  const preserve = new Set(['js', 'css', 'scripts']);
  const bundleSrc = join(ASSETS, 'js/bundle.js');
  const cssSrc = join(ASSETS, 'css/style.css');
  const bundleKeep = join(ROOT, '.sync-bundle.tmp');
  const cssKeep = join(ROOT, '.sync-style.tmp');

  if (existsSync(bundleSrc)) cpSync(bundleSrc, bundleKeep, { force: true });
  if (existsSync(cssSrc)) cpSync(cssSrc, cssKeep, { force: true });

  for (const entry of readdirSync(ASSETS)) {
    if (preserve.has(entry)) continue;
    rmSync(join(ASSETS, entry), { recursive: true, force: true });
  }

  mkdirSync(join(ASSETS, 'js'), { recursive: true });
  mkdirSync(join(ASSETS, 'css'), { recursive: true });

  if (existsSync(bundleKeep)) cpSync(bundleKeep, join(ASSETS, 'js/bundle.js'), { force: true });
  if (existsSync(cssKeep)) cpSync(cssKeep, join(ASSETS, 'css/style.css'), { force: true });
  rmSync(bundleKeep, { force: true });
  rmSync(cssKeep, { force: true });
}

function trimViteOut() {
  if (!existsSync(DIST)) return;

  const bundleTmp = join(ROOT, '.vite-bundle.tmp');
  const cssTmp = join(ROOT, '.vite-style.tmp');
  cpSync(join(DIST, 'js/bundle.js'), bundleTmp, { force: true });
  cpSync(join(DIST, 'css/style.css'), cssTmp, { force: true });

  for (const entry of readdirSync(DIST)) {
    rmSync(join(DIST, entry), { recursive: true, force: true });
  }

  mkdirSync(join(DIST, 'js'), { recursive: true });
  mkdirSync(join(DIST, 'css'), { recursive: true });
  cpSync(bundleTmp, join(DIST, 'js/bundle.js'), { force: true });
  cpSync(cssTmp, join(DIST, 'css/style.css'), { force: true });
  rmSync(bundleTmp, { force: true });
  rmSync(cssTmp, { force: true });
}

function syncViteAssets() {
  cleanDocsAssets();

  for (const rel of ['js/bundle.js', 'css/style.css']) {
    const src = join(DIST, rel);
    const dest = join(ASSETS, rel);
    if (!existsSync(src)) {
      console.error(`sync-vite-assets: ausente ${src} (rode vite build primeiro)`);
      process.exit(1);
    }
    mkdirSync(dirname(dest), { recursive: true });
    cpSync(src, dest, { force: true });
  }

  trimViteOut();
  console.log('sync-vite-assets: OK');
}

syncViteAssets();
