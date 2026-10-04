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
