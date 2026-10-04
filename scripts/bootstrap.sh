#!/usr/bin/env bash
# Non-nix fallback instructions. Canonical env: flake.nix (bun + node).
set -euo pipefail
cat <<'MSG'
Manual toolchain (no nix):
  1. bun >= 1.1 (https://bun.sh) — installs everything else via `bun install`.
  2. Node 22 (Playwright browsers + astro check prefer a system node).
  3. bun install && bun run --filter '*' build
  4. make ci
Prefer zero setup? Open the repo in a devcontainer, or `nix develop`.
MSG
