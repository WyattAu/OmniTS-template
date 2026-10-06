# OmniTS-template

Maximalist TypeScript **monorepo** template: **bun** workspaces + **Astro**
shell with **SolidJS** islands + **biome** (lint+format) + vitest + Playwright
+ changesets + knip — full IDE/OS integration (nix flake, dual devcontainers,
VS Code). Part of the [WyattAu Omni template family](https://github.com/WyattAu?tab=repositories&q=omni-).

## Start here (after "Use this template")

1. Rename workspaces: `@omni/ui` / `@omni/web` / `@omni/config` → your scope.
2. Pick a door — all resolve to identical toolchains:

   | Door | Command |
   |---|---|
   | nix + direnv (host) | `direnv allow` |
   | Devcontainer (image) | VS Code → *Reopen in Container* |
   | Devcontainer (nix)  | palette → *Rebuild in Container* → pick `.devcontainer/nix/` |

   No nix, no docker? `./scripts/bootstrap.sh` prints the manual path.
3. `bun install && make ci` — must be green before your first push.

## Make targets

| Target | Gate |
|---|---|
| `make build` | all workspaces build (astro build / tsc) |
| `make test` | vitest per package (solid testing-library) |
| `make lint` / `fmt` | biome check / biome check --write |
| `make typecheck` | tsc --noEmit per package (+ astro check) |
| `make e2e` | Playwright smoke (builds + previews the app first) |
| `make contract` | Omni Core Contract structural checks |
| `make ci` | contract + fmt-check + lint + typecheck + test |

CI adds the estate node gate (`node-ci.yml`, bun), `knip` (dead exports),
and both devcontainer builds.

## What is inside

```
apps/web            Astro shell: static-first, Solid islands via client:* directives
packages/ui         Solid component library (@omni/ui, source-exported, vitest-tested)
packages/config     shared tsconfig presets (@omni/config — one config source)
.changeset/         versioning + changelogs for publishable packages
scripts/ + Makefile the gates (make ci == CI)
docs/adr/           decision log (islands, bun-first, biome)
.github/workflows/  ci (node-ci + e2e + knip + contract), release (changesets), devcontainers
.forgejo/           thin self-hosted mirror (scripts are canonical)
```

## Release flow

Changesets: run `bunx changeset` locally to record intent → the bot PRs
version bumps → merging publishes with npm **provenance**. Requires secret
`NPM_TOKEN` (and trusted publishing on npmjs.com if you enable it).

## Estate pointers

- Gates, policies: [engineering-standards](https://github.com/WyattAu/engineering-standards)
- Omni Core Contract: [OMNI-CORE.md](https://github.com/WyattAu/engineering-standards/blob/main/OMNI-CORE.md)

## License

Apache-2.0 — commercial use expressly permitted.


## Performance budgets

Performance is a gate, not a hope. `make bench` measures, writes
`bench/current.tsv`, and compares it against the committed
`bench/baseline.tsv`; anything more than the threshold worse fails. The
comparator (`scripts/compare-bench.py`) is identical across the whole Omni
estate, so the policy is auditable in one place.

| Verb | What it does |
|---|---|
| `make bench` | measure + compare (advisory job in CI: `perf`) |
| `make bench-update` | deliberately re-baseline; the only way a baseline moves |

The first run on a fresh clone records the baseline instead of failing, so the
gate is meaningful from the second run onwards. Override the budget per run
with `OMNI_BENCH_THRESHOLD_PCT=15 make bench`. Rationale and per-template
metrics: `docs/adr/0006-performance-budget-gate.md`.


## Determinism

`make repro` builds twice from a clean state with a pinned `SOURCE_DATE_EPOCH`
and compares artifact hashes. Toolchains that are deterministic gate the build;
toolchains that embed timestamps or build ids by design report the difference
and explain why, rather than pretending to be reproducible. Rationale and the
per-toolchain split: `docs/adr/0007-determinism-verification.md`.
