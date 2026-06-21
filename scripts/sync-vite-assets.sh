#!/usr/bin/env bash
# Copia bundle Vite de dist/ para docs/assets/ e remove lixo de MkDocs na raiz.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DIST="$ROOT/.vite-out"
ASSETS="$ROOT/docs/assets"

bash "$ROOT/scripts/clean-docs-assets.sh"

for rel in js/bundle.js css/style.css; do
  src="$DIST/$rel"
  dest="$ASSETS/$rel"
  if [[ ! -f "$src" ]]; then
    echo "sync-vite-assets: ausente $src (rode vite build primeiro)" >&2
    exit 1
  fi
  mkdir -p "$(dirname "$dest")"
  cp -f "$src" "$dest"
done

# Watchers locais do MkDocs podem poluir o outDir do Vite; mantém só js/css.
bundle_tmp="$(mktemp)"
css_tmp="$(mktemp)"
cp -f "$DIST/js/bundle.js" "$bundle_tmp"
cp -f "$DIST/css/style.css" "$css_tmp"
rm -rf "$DIST"/*
mkdir -p "$DIST/js" "$DIST/css"
cp -f "$bundle_tmp" "$DIST/js/bundle.js"
cp -f "$css_tmp" "$DIST/css/style.css"
rm -f "$bundle_tmp" "$css_tmp"

echo "sync-vite-assets: OK"
