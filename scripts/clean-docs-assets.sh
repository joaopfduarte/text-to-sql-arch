#!/usr/bin/env bash
# Remove output acidental do MkDocs em docs/assets/ (preserva js/, css/, scripts/).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ASSETS="$ROOT/docs/assets"

if [[ ! -d "$ASSETS" ]]; then
  exit 0
fi

bundle_tmp="$(mktemp)"
css_tmp="$(mktemp)"
cp -f "$ASSETS/js/bundle.js" "$bundle_tmp" 2>/dev/null || true
cp -f "$ASSETS/css/style.css" "$css_tmp" 2>/dev/null || true

for entry in "$ASSETS"/*; do
  [[ -e "$entry" ]] || continue
  base="$(basename "$entry")"
  case "$base" in
    js|css|scripts) ;;
    *) rm -rf "$entry" ;;
  esac
done

mkdir -p "$ASSETS/js" "$ASSETS/css"
touch "$ASSETS/js/.gitkeep" "$ASSETS/css/.gitkeep"
cp -f "$bundle_tmp" "$ASSETS/js/bundle.js" 2>/dev/null || true
cp -f "$css_tmp" "$ASSETS/css/style.css" 2>/dev/null || true
rm -f "$bundle_tmp" "$css_tmp"
