#!/bin/sh
# Wrapper POSIX — delega para Node (node:22-alpine não inclui bash).
set -eu
ROOT="$(CDPATH= cd "$(dirname "$0")/.." && pwd)"
exec node "$ROOT/scripts/sync-vite-assets.mjs"
