#!/usr/bin/env bash
# Falha se docs/assets/ contiver output acidental do MkDocs ou arquivos fora do layout permitido.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ASSETS="$ROOT/docs/assets"
FAILED=0

report() {
  echo "check-docs-assets: $1" >&2
  FAILED=1
}

if [[ ! -d "$ASSETS" ]]; then
  echo "check-docs-assets: OK (docs/assets ausente)"
  exit 0
fi

while IFS= read -r entry; do
  base="$(basename "$entry")"
  case "$base" in
    js|css|scripts) ;;
    *) report "entrada não permitida na raiz de docs/assets/: $base" ;;
  esac
done < <(find "$ASSETS" -mindepth 1 -maxdepth 1)

while IFS= read -r extra; do
  report "arquivo extra em docs/assets/js/: $(basename "$extra")"
done < <(find "$ASSETS/js" -mindepth 1 ! -name .gitkeep ! -name bundle.js 2>/dev/null)

while IFS= read -r extra; do
  report "arquivo extra em docs/assets/css/: $(basename "$extra")"
done < <(find "$ASSETS/css" -mindepth 1 ! -name .gitkeep ! -name style.css 2>/dev/null)

if find "$ASSETS" -name 'index.html' -print -quit 2>/dev/null | grep -q .; then
  report "index.html encontrado em docs/assets/ (output MkDocs indevido)"
fi

if [[ -d "$ASSETS/assets" ]]; then
  report "docs/assets/assets/ presente (output MkDocs aninhado)"
fi

if [[ "$FAILED" -eq 1 ]]; then
  echo "Remova o lixo de build e use: mkdocs build --strict --site-dir public" >&2
  exit 1
fi

echo "check-docs-assets: OK"
