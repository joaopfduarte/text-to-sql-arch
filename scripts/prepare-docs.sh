#!/usr/bin/env bash
# Expõe árvores fora de docs/ como alvos válidos para MkDocs (--strict).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DOCS="$ROOT/docs"
ASSETS="$DOCS/assets"
BUNDLE="$ASSETS/js/bundle.js"

bash "$ROOT/scripts/clean-docs-assets.sh"

if [[ ! -f "$BUNDLE" ]] && [[ -f "$ROOT/package.json" ]] && command -v npm &>/dev/null; then
  (cd "$ROOT" && npm run build)
fi

link_dir() {
  local target="$1"
  local link_path="$2"
  rm -f "$link_path"
  ln -sfn "$target" "$link_path"
}

link_dir "$ROOT/evidence" "$DOCS/evidence"
link_dir "$ROOT/templates" "$DOCS/templates"

bash "$ROOT/scripts/render-diagrams.sh"

mkdir -p "$DOCS/diagrams"
# Remove symlinks órfãos (diagramas renomeados ou apagados)
find "$DOCS/diagrams" -maxdepth 1 -type l ! -exec test -e {} \; -delete 2>/dev/null || true
for f in "$ROOT/diagrams"/*.{puml,svg}; do
  [[ -e "$f" ]] || continue
  base="$(basename "$f")"
  link_dir "$ROOT/diagrams/$base" "$DOCS/diagrams/$base"
done

mkdir -p "$DOCS/assets/scripts"
if [[ -f "$ROOT/assets/scripts/ODP-VDF.xml" ]]; then
  link_dir "$ROOT/assets/scripts/ODP-VDF.xml" "$DOCS/assets/scripts/ODP-VDF.xml"
fi
