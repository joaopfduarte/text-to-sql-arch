#!/usr/bin/env bash
# Falha se links internos usarem path/filename como texto visível.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

FAIL=0

# Padrão antigo: [`path`](path)
backtick="$(rg -n '\[`[^`]+\`\]\(' docs evidence README.md 2>/dev/null || true)"
if [[ -n "$backtick" ]]; then
  echo "== links com path em backticks =="
  echo "$backtick"
  echo
  FAIL=1
fi

# Rótulo contém extensão de ficheiro interno
ext_links="$(python3 <<'PY'
import re
from pathlib import Path

root = Path(".")
pat = re.compile(r"\[([^\]]+)\]\(([^)]+)\)")
bad = []
for base in [root / "docs", root / "evidence", root / "templates", root / "README.md"]:
    files = [base] if base.is_file() else base.rglob("*.md")
    for path in files:
        text = path.read_text(encoding="utf-8")
        in_fence = False
        for i, line in enumerate(text.splitlines(), 1):
            if line.strip().startswith("```"):
                in_fence = not in_fence
                continue
            if in_fence:
                continue
            for m in pat.finditer(line):
                label, href = m.group(1), m.group(2)
                if href.startswith(("http://", "https://", "mailto:")):
                    continue
                clean = label.strip("*").strip("`").strip()
                base_h = href.split("#")[0].split("?")[0]
                fname = base_h.rsplit("/", 1)[-1]
                if "`" in label and clean not in (base_h, fname):
                    continue
                if clean == base_h or clean == fname:
                    bad.append(f"{path}:{i}:{line.strip()}")
                elif any(clean.endswith(x) for x in (".md", ".puml", ".svg", ".xml", ".json", ".csv")):
                    bad.append(f"{path}:{i}:{line.strip()}")
                elif clean.endswith("/") and "/" in base_h:
                    bad.append(f"{path}:{i}:{line.strip()}")
for line in bad:
    print(line)
PY
)"

if [[ -n "$ext_links" ]]; then
  echo "== links com rótulo = path =="
  echo "$ext_links"
  echo
  FAIL=1
fi

if [[ "$FAIL" -ne 0 ]]; then
  echo "check-doc-links: FALHOU"
  exit 1
fi

echo "check-doc-links: OK"
