# Design & Task: `help` for environment variables

**Status:** specified, implementation pending
**Owner:** Johannes (with Claude)
**Goal:** Surface the documentation that already lives in `template/environment/*`
(and in the DB-activated copies) to the user via `vpn-switch help <…>`.

---

## Motivation

Every environment variable has a template under `template/environment/<VAR>`:

```
<value/command>              ← line 1: the effective value
# careful documentation      ← line 2+: hand-written docs, '# '-prefixed
# ...
```

There are ~123 such files. The docs are **invisible** to users today: `getenv`
reads only line 1 (`head -1`); lines 2+ are never shown. When a variable is
"activated" (set/bootstrapped) the **full file incl. the doc** is copied into the
DB, so the documentation exists both in the template and in the live DB var.

We want maximum, always-truthful documentation with one command.

---

## Resolution cascade (already used by `_getenv1`)

`_getenv1` resolves a variable's effective file in this order — **this is the
single source of truth** the new help must reuse:

```
.env/local/<VAR>     (user/host override)   ┐
.env/default/<VAR>   (DB default)           ├─ effective value cascade
template/environment/<VAR> (shipped)        ┘
```

`_getenv1` already prints the source label (local/default/template).

---

## Design

### 1. Shared resolver (the linchpin)

Extract the file-resolution logic from `_getenv1` into one helper, e.g.

```
_env_resolve_file <var_name>  →  prints "<location_label>\t<absolute_path>"
                                  (or non-zero / empty if not found)
```

- `getenv` reads **line 1** of that path (value).
- `help` reads **line 1** (value) + **lines 2+** (doc) of that path.

`getenv` and `help` must NOT reimplement the cascade independently — they share
`_env_resolve_file`, so they can never drift.

`<location_label>` ∈ `local | default | template`.

### 2. Engine (does the real work) — uniform for ALL variable families

```
__help_environment1 <fullvar>            (combinator, sh)
    → calls _env_resolve_file to find the EFFECTIVE location
    → emits:  help environment <fullvar> <location>     (delegates to terminal)

_help_environment2 <fullvar> <location>  (terminal, cat)
    → reads template/environment-style file at the GIVEN <location>
    → renders:  value (line 1) + documentation (lines 2+, '# ' stripped)
                + a source line ("Source: .env/local/<fullvar> (override)")
```

`<location>` for the terminal ∈ `local | default | template` — pins exactly one
layer. The doc rendering is **family-agnostic** (value + `#`-doc applies to every
variable), so there is exactly **one** renderer. (Note: a separate
`_help_interpreter2` is NOT needed — it would be identical to
`_help_environment2`.)

Strip the `# ` prefix with the existing defensive-prefix convention
(`cut -b3-`), consistent with terminal functions.

### 3. Sugar (user-facing "Schreibhilfen") — thin prefix combinators

```
help interpreter <x>            → fullvar = VPN_SWITCH_INTERPRETER_<x> → engine
help environment <x>            → name cascade (below)                 → engine
```

Both compute a full variable name, then delegate to the **one** engine.

### 4. Name cascade for `help environment <variable>`

```
1) <variable> literally exists            (e.g. PATH, or full VPN_SWITCH_DNS_wireguard)
2) VPN_SWITCH_<variable>                   (flat vars + segmented: DNS_wireguard, …)
3) VPN_SWITCH_INTERPRETER_<variable>       (long per-function names: wireguard_start)
4) not found → error + hint to the list
```

- Fixed precedence (2 before 3) → deterministic; collisions are practically
  impossible (interpreter suffixes are function names, not flat vars).
- When step 3 matches, **echo the resolved full name** ("→
  VPN_SWITCH_INTERPRETER_wireguard_start") so the match is transparent.
- Only INTERPRETER gets a fallback (its names are long/per-function). Other
  families are reached via step 2 by typing the segment
  (`help environment DNS_wireguard`). No fuzzy all-family search.

`help interpreter <x>` is the explicit shortcut straight into step 3's namespace.

### 5. Arity = auto vs. forced location (public surface, no underscores typed)

```
help environment <x>            (arity 1) → effective location (local→default→template)
help environment <x> template   (arity 2) → exactly that layer (template|default|local)
help interpreter <x> [location]           → same, prefix VPN_SWITCH_INTERPRETER_
```

The arity-1 form (combinator) auto-resolves; the arity-2 form (terminal) pins a
layer. The "force template" use case falls out for free, and `help` doubles as a
config-debugger ("wireguard_start = sh from local; default/template say cat").

### 5a. Variable help-template format (light, optional, additive)

Mirror the anchor-function help *in spirit* with a small, OPTIONAL tag layer in
the `template/environment/<VAR>` files — NOT the source `#@help` block parser, and
NOT a rigid schema. Line 1 stays the raw value. In the doc region (lines 2+):

```
# @summary <one-liner>        — short description (also used in the listing)
# @default <value>            — the shipped default (line 1 is the effective value)
# @values <a | b | c | …>     — allowed/expected values
# @example <text>
# @see VPN_SWITCH_X           — cross-reference (related-variable navigation)
# @internal                   — cutoff: dev notes below, never shown by helpenv
<then: free-form prose>
```

`_helpenv2` renders present tags as labelled sections, then the prose; with no
tags it just shows the prose. So all 123 existing free-form docs render
immediately — **no migration required** — and we enrich incrementally. Opens the
door to manpage generation + completeness linting (every var has `@summary`).
Vocabulary is variable-shaped (`@summary/@default/@values/@example/@see/@internal`),
not command-shaped (`@command/@param`).

### 6. `@internal` marker

The existing docs contain internal dev notes (e.g. "Phase 2.7: …") not meant for
users. Convention: a line `# @internal` (or `# --`) marks the cut-off — `help`
stops rendering doc lines at/after that marker. One file remains the source for
both user help and developer notes.

### 7. Listing (no argument)

```
help environment        → list all documented variables (grouped by family)
help interpreter        → list the VPN_SWITCH_INTERPRETER_* variables
```

Closes the discoverability loop with `printenv` (which shows values): add a hint
"→ vpn-switch help <VAR>" to `printenv` output.

---

## Implementation steps

1. **Resolver:** extract `_env_resolve_file` from `_getenv1` in
   `include/database.sh`; refactor `_getenv1` to use it (no behaviour change).
2. **Engine:** add `_help_environment2` (terminal, `cat`) + `__help_environment1`
   (combinator) — likely in `include/help.sh`.
3. **Sugar:** add `help interpreter` / `help environment` dispatch + the name
   cascade (prefix logic).
4. **Marker:** implement `# @internal` cut-off in the renderer.
5. **Listing:** no-arg forms enumerate `template/environment` (+ DB scopes).
6. **Metadata:** `gmake metadata` to register the new functions
   (ANCHOR_FUNCTIONS / FUNCTION_MODULES / interpreter defaults).
7. **Interpreter defaults:** ensure `_help_environment2` uses `cat`,
   `__help_environment1` uses `sh` (combinator).
8. **Docs/help text:** wire into the top-level `help` overview.
9. **Tests:** unit tests for resolver precedence, name cascade, marker cut-off,
   forced-location, not-found.
10. **Curation (incremental):** light editorial pass + `# @internal` markers on
    the existing 123 docs (also re-check anonymization, since these become
    user-visible in the public repo).

## The `intp` shortcut family (interpreter sugar)

Investigation (2026-06-27): `setintp` / `getintp` were intended but **never
implemented** — no occurrence in the working tree, git history (`-S`/`-G`),
stash, reflog, or dangling objects. Building fresh.

They are the same prefix-sugar pattern as `helpenv`, fixed to
`VPN_SWITCH_INTERPRETER_`:

```
setintp <fn> <value>   →  setenv  VPN_SWITCH_INTERPRETER_<fn> <value>
getintp <fn>           →  getenv  VPN_SWITCH_INTERPRETER_<fn>
helpintp <fn>          →  helpenv VPN_SWITCH_INTERPRETER_<fn>   (or helpenv's cascade)
```

`helpintp` is introduced together with / right after `setintp`+`getintp`, so the
trio is consistent. Naming convention: `<verb>intp` (single token, no dispatch
shadowing — same reason as `helpenv`).

## Phased plan (agreed 2026-06-27)

1. **`helpenv`** — implement first, get it solid (shared resolver + engine +
   name cascade + `# @internal` marker + listing).
2. **`intp` family** — `setintp` / `getintp` / `helpintp` (interpreter-prefix
   sugar over setenv/getenv/helpenv). Update docs + help.
3. **Dispatch reversal + readable forms** — once helpenv is solid: reverse the
   dispatch to long-stem-first (empirically 0/148 incompatibilities; run the FULL
   suite to confirm) and offer `help environment <x>` / `help interpreter <x>`
   as the readable surface. `helpenv`/`helpintp` remain as terse aliases.
4. Update all documentation + the `#@help` overview throughout.

### Why dispatch reversal is safe (empirical, 2026-06-27)
A reversed resolver (try the concatenated long stem first, short stem as
fallback) was run against the canonical command of every existing function:
**checked=148, changed=0** — zero behavioural change today. It only changes
`help <X> …` where `_help_<X>*` exists (the new sub-commands), turning `_help2`
into a fallback for non-subcommand args. Trade-off captured: short-first keeps
trailing tokens as *arguments* (protects free-text args of catch-all terminals
like `_help1/_help2`); long-first enables sub-commands but reserves their names.
Caveat: the 148-command check covered canonical valid commands, not exhaustive
typo/over-arity error paths — re-run the full unit+architecture suite before
flipping it for real.

## Decisions locked
- Shared resolver between `getenv` and `help` (no duplicate cascade).
- One family-agnostic renderer (`_help_environment2`); families are sugar.
- Name cascade: literal → `VPN_SWITCH_` → `VPN_SWITCH_INTERPRETER_` → not found.
- Arity dispatch: 1 = auto location, 2 = forced location.
- `# @internal` marker to hide developer notes.

## Open / later
- Exact marker spelling (`# @internal` vs `# --`).
- Grouping/format of the listing output.
- Whether `printenv` gains the per-var "see help" hint now or later.
