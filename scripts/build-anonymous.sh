#!/usr/bin/env bash
# Build MkDocs anonimizado para submissão em anonymous.4open.science.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

SITE_DIR="public-anonymous"

echo "== build-anonymous: Web Components =="
if [[ -f package.json ]]; then
  npm ci
  npm run typecheck
  npm run build
fi

echo "== build-anonymous: preparar documentação =="
bash scripts/prepare-docs.sh

echo "== build-anonymous: validações =="
bash scripts/check-anonymization.sh
bash scripts/check-pt-br.sh
bash scripts/check-docs-assets.sh

echo "== build-anonymous: MkDocs (anonimizado) =="
rm -rf "$SITE_DIR"
mkdocs build --strict -f mkdocs.anonymous.yml --site-dir "$SITE_DIR"

echo "== build-anonymous: validar HTML =="
bash scripts/check-anonymous-build.sh "$SITE_DIR"

echo "build-anonymous: OK → $SITE_DIR/"
