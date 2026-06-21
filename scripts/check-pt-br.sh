#!/usr/bin/env bash
# Falha se encontrar grafias ou vocabulário de português europeu (PT-PT).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

PT_PT_PATTERN='arquitect|interactiv|canón|ficheiro|secção|registar|académ'

if rg -n "$PT_PT_PATTERN" \
  docs evidence templates scripts src README.md \
  --glob '!docs/assets/**' \
  --glob '!scripts/check-pt-br.sh' 2>/dev/null; then
  echo "check-pt-br: grafias PT-PT encontradas (ver acima)." >&2
  exit 1
fi

echo "check-pt-br: OK"
