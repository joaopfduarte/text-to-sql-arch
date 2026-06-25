#!/usr/bin/env bash
# Falha se o site MkDocs anonimizado contiver URLs ou termos identificáveis.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

SITE_DIR="${1:-public-anonymous}"

if [[ ! -d "$SITE_DIR" ]]; then
  echo "check-anonymous-build: diretório ausente: $SITE_DIR" >&2
  exit 1
fi

FAIL=0

IDENTITY_PATTERNS=(
  'joaopfduarte'
  'github\.com/joaopfduarte'
  'github\.io/text-to-sql-arch'
  'edit/main/docs'
)

SENSITIVE_PATTERNS=(
  'putz'
  'franquias'
  'alessio'
  'Pedrinho'
  'monografia'
  'legacy-infra'
  'db-reference'
  'phpMyAdmin'
  'banco-putz'
  'carga-cluster-putz'
  'putz_db'
  'ingestao-putz'
  'banco-xpto'
  'carga-cluster-xpto'
  'ingestao-xpto'
)

scan() {
  local label="$1"
  shift
  local hits
  hits="$(rg -i -n --glob '!*.map' "$@" "$SITE_DIR" 2>/dev/null || true)"
  if [[ -n "$hits" ]]; then
    echo "== $label =="
    echo "$hits"
    echo
    FAIL=1
  fi
}

scan_html() {
  local label="$1"
  shift
  local hits
  hits="$(rg -i -n "$@" "$SITE_DIR" --glob '*.html' 2>/dev/null || true)"
  if [[ -n "$hits" ]]; then
    echo "== $label =="
    echo "$hits"
    echo
    FAIL=1
  fi
}

for pat in "${IDENTITY_PATTERNS[@]}"; do
  scan "identidade: $pat" "$pat"
done

for pat in "${SENSITIVE_PATTERNS[@]}"; do
  scan "termo sensível: $pat" "$pat"
done

# Links de repositório no HTML (Material injeta md-source quando repo_url está definido)
scan_html "link de repositório" 'md-source|Ir para repositório|Exibir fonte desta página'

if [[ "$FAIL" -ne 0 ]]; then
  echo "check-anonymous-build: FALHOU ($SITE_DIR)"
  exit 1
fi

echo "check-anonymous-build: OK ($SITE_DIR)"
