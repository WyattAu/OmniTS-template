#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
exec bun run --filter '@omni/web' e2e
