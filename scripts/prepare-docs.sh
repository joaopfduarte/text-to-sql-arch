#!/usr/bin/env bash
# Expõe árvores fora de docs/ como alvos válidos para MkDocs (--strict).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DOCS="$ROOT/docs"

link_dir() {
  local target="$1"
  local link_path="$2"
  rm -f "$link_path"
  ln -sfn "$target" "$link_path"
}

link_dir "$ROOT/evidence" "$DOCS/evidence"
link_dir "$ROOT/templates" "$DOCS/templates"
link_dir "$ROOT/db-reference" "$DOCS/db-reference"

bash "$ROOT/scripts/render-diagrams.sh"

mkdir -p "$DOCS/diagrams"
for f in "$ROOT/diagrams"/*.{puml,svg}; do
  [[ -e "$f" ]] || continue
  base="$(basename "$f")"
  link_dir "$ROOT/diagrams/$base" "$DOCS/diagrams/$base"
done

mkdir -p "$DOCS/assets/scripts"
link_dir "$ROOT/legacy-infra/assets/ODP-VDF.xml" "$DOCS/assets/scripts/ODP-VDF.xml"

mkdir -p "$DOCS/legacy-infra"
for f in compute.tf network.tf security-list.tf provider.tf variables.tf vpn.tf iam.tf data.tf output.tf schema.yaml; do
  link_dir "$ROOT/legacy-infra/$f" "$DOCS/legacy-infra/$f"
done
link_dir "$ROOT/legacy-infra/assets" "$DOCS/legacy-infra/assets"
link_dir "$ROOT/legacy-infra/cloud-init" "$DOCS/legacy-infra/cloud-init"

if [[ -f "$ROOT/adr/ADR-0003-inferencia-llm-deterministica.md" ]] && \
   [[ ! -f "$DOCS/adr/ADR-0003-inferencia-llm-deterministica.md" ]]; then
  cp "$ROOT/adr/ADR-0003-inferencia-llm-deterministica.md" "$DOCS/adr/"
fi
