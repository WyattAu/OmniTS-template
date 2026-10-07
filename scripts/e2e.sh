#!/usr/bin/env bash
# E2E: playwright against the built app. Browser install lives here (not in
# CI) so local runs get the same setup. The retry absorbs CDN flakiness;
# the fallback drops --with-deps for environments without passwordless sudo
# (system deps are already present on devcontainers and CI runners).
set -euo pipefail
cd "$(dirname "$0")/../apps/web"
if ! bunx playwright install --with-deps chromium; then
  echo "e2e: --with-deps failed; installing browsers without system deps"
  bunx playwright install chromium
fi
exec bunx playwright test
