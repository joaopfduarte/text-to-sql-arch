#!/usr/bin/env bash
# Gera SVG a partir das fontes PlantUML canônicas em diagrams/.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DIAGRAMS="$ROOT/diagrams"

if ! command -v plantuml >/dev/null 2>&1; then
  echo "plantuml não encontrado — instale com: apt-get install -y plantuml" >&2
  exit 1
fi

if ! command -v dot >/dev/null 2>&1; then
  echo "Graphviz (dot) não encontrado — instale com: apt-get install -y graphviz" >&2
  exit 1
fi

DOT_BIN="$(command -v dot)"

shopt -s nullglob
puml_files=("$DIAGRAMS"/*.puml)
if ((${#puml_files[@]} == 0)); then
  echo "Nenhum arquivo .puml em $DIAGRAMS" >&2
  exit 1
fi

export JAVA_TOOL_OPTIONS="${JAVA_TOOL_OPTIONS:-} -Djava.awt.headless=true"

plantuml -graphvizdot "$DOT_BIN" -tsvg -o "$DIAGRAMS" "${puml_files[@]}"

for svg in "$DIAGRAMS"/*.svg; do
  if grep -q "Cannot find Graphviz" "$svg"; then
    echo "Falha ao renderizar $(basename "${svg%.svg}").puml — Graphviz indisponível ou inválido." >&2
    exit 1
  fi
done

echo "SVG gerados em $DIAGRAMS/ (${#puml_files[@]} fontes, dot=$DOT_BIN)"
