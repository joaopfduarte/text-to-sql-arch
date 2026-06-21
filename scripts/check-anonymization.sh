#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

FAIL=0

PATTERNS=(
  'putz'
  'franquias'
  'alessio'
  'Pedrinho'
  'monografia'
  'legacy-infra'
  'db-reference'
  'phpMyAdmin'
  'LYTEX'
  'TWILIO'
  'DINAMIZE'
  'content/cap'
  'banco-putz'
  'carga-cluster-putz'
  'putz_db'
  'ingestao-putz'
  'banco-xpto'
  'carga-cluster-xpto'
  'ingestao-xpto'
  '\bxpto\b'
  '\bXPTO\b'
)

scan() {
  local label="$1"
  shift
  local hits
  hits="$(rg -i -n --hidden \
    --glob '!.git/**' \
    --glob '!site/**' \
    --glob '!public/**' \
    --glob '!.venv/**' \
    --glob '!venv/**' \
    --glob '!.cursor/**' \
    --glob '!.cache/**' \
    --glob '!.gitignore' \
    --glob '!scripts/check-anonymization.sh' \
    "$@" 2>/dev/null || true)"
  if [[ -n "$hits" ]]; then
    echo "== $label =="
    echo "$hits"
    echo
    FAIL=1
  fi
}

for pat in "${PATTERNS[@]}"; do
  scan "padrão: $pat" "$pat" .
done

while IFS= read -r f; do
  echo "== arquivo banido: $f =="
  FAIL=1
done < <(find . -type f \
  ! -path './.git/*' \
  ! -path './site/*' \
  ! -path './public/*' \
  ! -path './.venv/*' \
  ! -path './.cache/*' \
  \( -iname '*putz*' -o -iname '*monografia*' -o -iname '*xpto*' \) \
  2>/dev/null)

if [[ "$FAIL" -ne 0 ]]; then
  echo "check-anonymization: FALHOU"
  exit 1
fi

echo "check-anonymization: OK"
