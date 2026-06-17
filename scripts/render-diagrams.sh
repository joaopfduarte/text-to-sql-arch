#!/usr/bin/env bash
# Gera SVG a partir das fontes PlantUML canónicas em diagrams/.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DIAGRAMS="$ROOT/diagrams"

if ! command -v plantuml >/dev/null 2>&1; then
  echo "plantuml não encontrado — instale com: apt-get install -y plantuml" >&2
  exit 1
fi

shopt -s nullglob
puml_files=("$DIAGRAMS"/*.puml)
if ((${#puml_files[@]} == 0)); then
  echo "Nenhum ficheiro .puml em $DIAGRAMS" >&2
  exit 1
fi

export JAVA_TOOL_OPTIONS="${JAVA_TOOL_OPTIONS:-} -Djava.awt.headless=true"

plantuml -tsvg -o "$DIAGRAMS" "${puml_files[@]}"
echo "SVG gerados em $DIAGRAMS/ (${#puml_files[@]} fontes)"
