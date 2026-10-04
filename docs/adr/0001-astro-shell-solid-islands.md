# 0001 — Astro shell with Solid islands

Date: 2026-10-04

## Status

Accepted

## Context

The estate's web work spans content sites (Starlight), apps, and interactive
components. A single-framework choice either under-serves content or
under-serves interactivity.

## Decision

Astro is the shell (`apps/web`): static-first, islands architecture, MDX-ready.
SolidJS is the interactivity layer (`packages/ui`, `@astrojs/solid-js`
integration, `client:*` directives). Components are source-exported from
`packages/ui` — Astro compiles the TSX; flip to compiled output when a
package is consumed outside the workspace.

## Consequences

- Zero-JS pages by default; islands hydrate independently.
- Two mental models (`.astro` vs `.tsx`) — documented, not hidden.
