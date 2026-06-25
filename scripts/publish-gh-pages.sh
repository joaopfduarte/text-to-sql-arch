#!/usr/bin/env bash
# Publica public-anonymous/ na branch órfã gh-pages (GitHub Pages from branch).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

SITE_DIR="public-anonymous"
FORCE_BUILD=0
DRY_RUN=0

usage() {
  cat <<'EOF'
Uso: bash scripts/publish-gh-pages.sh [--force] [--dry-run]

  --force    Rebuild mesmo se public-anonymous/ existir
  --dry-run  Build e validação local; não altera git remoto
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --force) FORCE_BUILD=1; shift ;;
    --dry-run) DRY_RUN=1; shift ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Opção desconhecida: $1" >&2; usage; exit 1 ;;
  esac
done

if [[ "$FORCE_BUILD" -eq 1 ]] || [[ ! -d "$SITE_DIR" ]]; then
  bash scripts/build-anonymous.sh
elif [[ ! -f "$SITE_DIR/index.html" ]]; then
  echo "publish-gh-pages: $SITE_DIR/index.html ausente; executando build..." >&2
  bash scripts/build-anonymous.sh
else
  bash scripts/check-anonymous-build.sh "$SITE_DIR"
fi

if [[ "$DRY_RUN" -eq 1 ]]; then
  echo "publish-gh-pages: dry-run concluído ($SITE_DIR pronto; git não alterado)"
  exit 0
fi

if ! git rev-parse --git-dir >/dev/null 2>&1; then
  echo "publish-gh-pages: não é um repositório git" >&2
  exit 1
fi

ORIG_BRANCH="$(git branch --show-current)"
if [[ -z "$ORIG_BRANCH" ]]; then
  echo "publish-gh-pages: branch atual indeterminado" >&2
  exit 1
fi

if [[ -n "$(git status --porcelain --untracked-files=no)" ]]; then
  echo "publish-gh-pages: working tree com alterações commitadas pendentes." >&2
  echo "Commit ou descarte antes de publicar (arquivos gitignored são permitidos)." >&2
  git status --short
  exit 1
fi

WORKTREE="$ROOT/.gh-pages-worktree"
rm -rf "$WORKTREE"

echo "== publish-gh-pages: preparar worktree =="
if git show-ref --verify --quiet refs/heads/gh-pages; then
  git worktree add --force "$WORKTREE" gh-pages
else
  git worktree add --force -b gh-pages "$WORKTREE"
fi

echo "== publish-gh-pages: copiar site =="
find "$WORKTREE" -mindepth 1 -maxdepth 1 ! -name '.git' -exec rm -rf {} +
cp -a "$SITE_DIR/." "$WORKTREE/"
touch "$WORKTREE/.nojekyll"

(
  cd "$WORKTREE"
  git add -A
  if git diff --cached --quiet; then
    echo "publish-gh-pages: sem alterações em gh-pages"
  else
    git commit -m "Publicar site anonimizado para revisão"
  fi
  git push -u origin gh-pages
)

git worktree remove --force "$WORKTREE" 2>/dev/null || rm -rf "$WORKTREE"

if [[ "$(git branch --show-current 2>/dev/null)" != "$ORIG_BRANCH" ]]; then
  git checkout "$ORIG_BRANCH"
fi

cat <<'EOF'

publish-gh-pages: OK

Próximos passos:
  1. GitHub → Settings → Pages
     Source: Deploy from a branch
     Branch: gh-pages / (root)
  2. Aguardar deploy (~1–2 min)
  3. anonymous.4open.science → Anonymize → branch gh-pages
     Ativar "Github page" e informar termos de anonimização

Após aceitação do artigo:
  - Settings → Pages → voltar para GitHub Actions
  - Push em main redeploya o site identificável

EOF
