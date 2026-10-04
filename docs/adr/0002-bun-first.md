# 0002 — bun-first package management

Date: 2026-10-04

## Status

Accepted

## Context

The estate already standardizes on bun for Node CI (node-ci.yml default) and
tooling sites. pnpm and npm remain viable; three package managers across one
workspace family is two too many.

## Decision

bun is the only supported runner: `bun install --frozen-lockfile` is the CI
install, `bun.lock` is committed and authoritative, workspaces are bun
workspaces. pnpm may be used locally for read-only experiments; CI never
runs it.

## Consequences

- One lockfile, one install command, fastest cold installs.
- Rare npm-only packages need an explicit override + ADR.
