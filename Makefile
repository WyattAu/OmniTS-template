# Thin wrapper over scripts/ — the same verbs in every Omni template.
.PHONY: bench bench-update build test lint fmt fmt-check typecheck e2e contract ci clean

build:
	bun run --filter '*' build

test:
	./scripts/test.sh

lint:
	./scripts/lint.sh

fmt:
	./scripts/fmt.sh

fmt-check:
	bunx biome check .

typecheck:
	./scripts/typecheck.sh

e2e:
	./scripts/e2e.sh

contract:
	./scripts/check-contract.sh

## What CI gates before merge (mirror of .github/workflows/ci.yml):
ci: contract fmt-check lint typecheck test

bench:
	./scripts/bench-budget.sh

bench-update:
	./scripts/bench-budget.sh --update

clean:
	rm -rf apps/*/dist apps/*/.astro packages/*/dist node_modules
