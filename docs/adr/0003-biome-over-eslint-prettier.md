# 0003 — Biome over ESLint + Prettier

Date: 2026-10-04

## Status

Accepted

## Context

Two tools (ESLint, Prettier) with overlapping configs, plugins, and resolve
order is the largest source of JS toolchain drift. Biome covers lint +
format + import organization in one binary with one config.

## Decision

Biome is the only linter/formatter. Strict subset: `noExplicitAny`,
`noNonNullAssertion`, unused variables/imports are errors. Import
organization runs on save and in CI.

## Consequences

- No Prettier/ESLint config files anywhere in the template.
- Genuinely needed ESLint-only plugins (e.g. accessibility beyond biome's)
  require an ADR before adoption.
