# Help Doc-Block Template — Specification (DRAFT)

Status: **draft for review** — no code yet. This defines the structured comment
block from which `vpn-switch help` (overview + per-command reference + cross
references) is generated, and the validation rules that the architecture tests
enforce.

Goal: make the help text a **single source of truth that lives next to the code**
and cannot silently drift. Every fact about a command (purpose, args, grouping,
related commands) is declared once, in a tagged comment above the function, and
the help output is assembled mechanically. Drift becomes a **build/test error**,
not a stale paragraph.

Precedent: this is the Doxygen `@defgroup`/`@ingroup`/`@see` model and the
man-page `SEE ALSO` model, adapted to POSIX-greppable comments.

---

## 1. Block shape

A help block is a run of **pure comment lines** delimited by sentinels, sitting
either **immediately above an anchor-function definition** or **free-floating**
(for group definitions and concept topics). The opening sentinel carries the
**function name**, so the block is inseparably bound to its function and a single
extraction yields both the tags and the name they document.

```sh
#@help _session_refresh0
# @command session refresh
# @summary Reconcile interface ownership with the loaded peers
# @group   session-maintenance
# @returns shell commands (re-point / remove ownership symlinks)
# @example vpn-switch session refresh
# @see     session list
# @see     session clean
#@end
_session_refresh0() {
  ...
```

Rules:

- Start sentinel:
  - **function block:** `#@help <fnname>` — `<fnname>` is the function the block
    documents and **must equal** the function defined on the line directly below
    `#@end` (enforced by test A1, so a block can never drift to the wrong
    function or survive a rename).
  - **free-floating block** (group/topic): `#@help` with no name.
- End sentinel: a line that is exactly `#@end`.
- Every line between the sentinels begins with `#` (the block stays pure
  comments; no code line is ever captured inside it).
- A function block's `#@end` is on the line directly above `funcname() {`
  (no blank line between).
- Free-floating blocks may sit anywhere a comment is legal, conventionally at the
  top of a module file.

Extraction is a single `sed` pass (note `/^#@help/` matches both the named and
bare forms):

```sh
sed -n '/^#@help/,/^#@end$/p' file.sh     # all blocks in a file
```

---

## 2. Tag grammar

Each content line is one of:

- **Tag line:** `# @<tag> <value>` — tag name, one space, value (value may be
  empty for flag tags like `@internal`).
- **Continuation line:** `#   <text>` (a `#` followed by ≥2 spaces and text, no
  `@`) — appends to the previous multi-line field, or to the block body if no
  field is open.
- **Blank comment:** `#` alone — paragraph break inside a body.

Tag names are lowercase `[a-z]+`. Unknown tags are a **conformance error** (B4),
which is what catches typos like `@parm`.

---

## 3. Block kinds and their tags

A block's kind is determined by which of three mutually exclusive anchor tags it
carries: `@command`, `@defgroup`, or `@topic`. A function block may instead carry
`@internal`.

### 3.1 Command block (documents one user-facing command)

| Tag | Req | Card | Meaning |
|-----|-----|------|---------|
| `@command <usage>` | ✅ | 1 | User invocation with placeholders, e.g. `wireguard start <category>`. The command **path** is the leading words before the first `<`/`[`; this is the lookup key and decouples help from the internal function name. |
| `@summary <line>` | ✅ | 1 | One line. Used in the grouped overview and as the detail header. |
| `@group <id>` | ✅ | 1..n | Membership: which overview section(s) this command appears under. |
| `@param <name> <desc>` | ◻ | 0..n | One per positional argument, in order. |
| `@option <flag> <desc>` | ◻ | 0..n | One per flag/option, if any. |
| `@returns <desc>` | ◻ | 0..1 | What it emits (terminal data / combinator commands / side effects). |
| `@example <cmd>` | ◻ | 0..n | A runnable example line. |
| `@see <ref>` | ◻ | 0..n | Cross-reference: a command path or a group id. |
| `@since <ver>` | ◻ | 0..1 | First version (optional changelog hook). |

### 3.2 Group-definition block (defines an overview section)

| Tag | Req | Card | Meaning |
|-----|-----|------|---------|
| `@defgroup <id> <Title>` | ✅ | 1 | Declares section `<id>` with display `<Title>`. |
| `@order <int>` | ◻ | 0..1 | Sort weight in the overview (default: 999). |
| `@parent <group-id>` | ◻ | 0..1 | Nesting under another group (v2 — see §7). |
| *body lines* | ◻ | — | Free prose rendered as the section's intro. |

### 3.3 Topic block (prose-only entry, no command)

For curated concept text that belongs in the overview but isn't a command
("Reserved Keywords", "Directory Structure", conceptual notes).

| Tag | Req | Card | Meaning |
|-----|-----|------|---------|
| `@topic <Title>` | ✅ | 1 | Title of the concept entry. |
| `@group <id>` | ✅ | 1..n | Where it appears. |
| `@see <ref>` | ◻ | 0..n | Cross references. |
| *body lines* | ◻ | — | The prose. |

### 3.4 Internal marker (non-command functions)

| Tag | Req | Card | Meaning |
|-----|-----|------|---------|
| `@internal [reason]` | ✅ | 1 | Marks a function as plumbing — excluded from help. Satisfies presence (A) with one line. |

---

## 4. Validation rules = the architecture tests

These map 1:1 to the test layers. They are the executable form of this spec.

### A — Presence (`test_help_blocks_present`)
- **A1** Every anchor function (`^_`, `^__`, `^___` … `[0-9]() {`) is immediately
  preceded by a `#@help <fnname> … #@end` block where:
  - the start sentinel names **this** function (`<fnname>` equals the function on
    the line directly below `#@end`), and
  - the block contains **exactly one** of `@command` or `@internal`.

  → Failure output = the worklist of unclassified / mis-bound functions.

### B — Conformance (`test_help_blocks_conform`)
- **B1** Well-formed: starts `#@help`, ends `#@end`, every inner line starts `#`.
- **B2** Block kind is exactly one of `@command` / `@defgroup` / `@topic` /
  `@internal`. Required tags for that kind are present with correct cardinality
  (§3).
- **B3** Only known tags appear (typo guard).
- **B4** *(recommended, soft at first)* For a command block above a function, the
  number of `<…>`/`[…]` placeholders in `@command` is consistent with the
  function's arity digit. **Nuance:** an optional-arg command (`wireguard stop
  [interface]`) maps to *two* arity functions (`…stop0` and `…stop1`); the
  documented block lives on one, its arity sibling carries `@internal`. So B4 is
  "placeholders ≤ max declared arity", enforced as a warning until the corpus
  stabilises, then hardened.

### C — Graph integrity (`test_help_graph_resolves`)
- **C1** Every `@group <id>` resolves to a defined `@defgroup <id>`.
- **C2** Every `@see <ref>` resolves to an existing `@command` path or
  `@defgroup` id.
- **C3** Every command/topic has ≥1 `@group` (no overview orphans).
- **C4** No duplicate `@command` paths; no duplicate `@defgroup` ids.
- **C5** *(v2)* Every `@parent` resolves; the group tree is acyclic.

---

## 5. Worked example (real commands)

```sh
# ── top of include/wireguard.sh ────────────────────────────────────────────
#@help
# @defgroup wireguard  WireGuard Commands
# @order    20
#   Manage WireGuard configs, categories and tunnels.
#@end

#@help
# @defgroup connection  Connection Management
# @order    10
# @parent   wireguard
#   Start, stop and resume tunnels.
#@end
```

```sh
#@help __wireguard_start1
# @command wireguard start <category>
# @summary Start a WireGuard VPN from a category
# @group   connection
# @param   category  config category (or config / alias) to start
# @returns connect commands (run under the connect interpreter)
# @example vpn-switch wireguard start privacy
# @see     wireguard stop
# @see     session refresh
#@end
__wireguard_start1() {
  ...
```

```sh
#@help _session_refresh0
# @command session refresh
# @summary Reconcile interface ownership with the loaded peers
# @group   session-maintenance
# @returns shell commands (re-point / remove ownership symlinks)
# @example vpn-switch session refresh
# @see     session list
#@end
_session_refresh0() {
  ...
```

```sh
#@help __wireguard_start0
# @internal  combinator chain step for 'wireguard start'
#@end
__wireguard_start0() {
  ...
```

```sh
# ── a curated concept entry ────────────────────────────────────────────────
#@help
# @topic Reserved Session Keywords
# @group session
#   'latest'  - system-managed, updated on each start
#   'default' - user-managed via 'session save' (no args)
#@end
```

### What gets generated

`vpn-switch help` (overview) — sections from `@defgroup` (ordered by `@order`),
each listing its `@group` members' `@command` + `@summary`:

```
WireGuard Commands
  Connection Management
    vpn-switch wireguard start <category>   Start a WireGuard VPN from a category
    vpn-switch wireguard stop [interface]   Stop a WireGuard VPN
    ...
Session
  Reserved Session Keywords
    latest  - system-managed, updated on each start
    ...
```

`vpn-switch help wireguard start` (detail) — the full block for that `@command`
path: summary, params, returns, examples, and a resolved **See Also** list.

---

## 6. Migration

The existing informal headers (`# Args:`, `# Output:`, `# name - desc`) become
tags: `# Args:` → `@param`, `# Output:`/`# Returns:` → `@returns`, the
description line → `@summary`. So most of the corpus is **reformatting**, not
authoring from scratch. Order of work, driven by the tests:

1. Land tests A/B/C (red).
2. One sweep: every anchor function gets `@internal` **or** a `@command` skeleton
   → **A green** quickly.
3. Define the `@defgroup` set + curated `@topic` blocks → **C green**.
4. Flesh out `@command` bodies (params/returns/examples/see) → **B depth**,
   incrementally, test shows what's thin.
5. Only now: write the generator (it may assume conformance) and switch
   `help.sh`'s hand-written sections over to generated output.

---

## 7. Open decisions (for review)

1. **Sentinels:** ✅ resolved — function block `#@help <fnname>`, free-floating
   `#@help`, both closed by `#@end`. The name on the start sentinel binds the
   block to its function (A1 cross-checks it against the definition below).
2. **Group taxonomy:** flat groups first; `@parent` nesting (C5) deferred to v2.
   Agree to defer?
3. **Generation timing:** build-time (inject a generated data file into
   `template/`, like `generate-metadata.sh` does) vs. runtime parse of
   `include/*.sh` in LIBDIR. Build-time is consistent with the existing
   architecture and faster; runtime is simpler but needs sources present.
4. **B4 arity check:** ship as warning first, harden later? (Recommended.)
5. **Scope of first pass:** all anchor functions, or only the user-facing subset
   while leaving internal ones temporarily exempt? (Recommend all, via
   `@internal`, so presence is total.)

---

## 8. Renderers & the man page

The corpus is **one model, many back-ends**. The scan that the tests already use
(`_help_records`) parses every block into a model; format-specific *renderers*
emit from that single model:

```
doc blocks ──► scan / model ──┬─► terminal help   (terse, ANSI)
 (@command,@group,@param,      ├─► man COMMANDS    (Markdown → pandoc → groff)
  @example,@see,@defgroup)      └─► HTML            (same pandoc step)
```

So the man page is **not a second system** — it is a second renderer over the
same data. Terminal help and the man page differ only in *verbosity*: help uses
`@summary` (one-liner), the man page uses the full detail (`@param`, `@example`,
`@returns`). The tag set already carries everything the man page needs, so this
needs **no spec change**.

### 8.1 How it plugs into the existing pipeline

The pipeline stays `docs/vpn-switch.1.md` → `pandoc` → `docs/vpn-switch.1` +
`docs/vpn-switch.html` (the `manpage` make target). Only **who writes the
COMMANDS section** changes:

- `vpn-switch.1.md` gains a **generated region** in its COMMANDS section,
  delimited by markers (`<!-- @generated commands -->` … `<!-- @end -->`) — the
  same splice pattern the codebase already uses for the auto-generated metadata
  block in `vpn-switch.sh`. The generator fills only that region.
- **Curated (hand-written) sections stay curated:** NAME, DESCRIPTION/Concepts,
  ENVIRONMENT (the `VPN_SWITCH_*` variables), FILES, EXIT STATUS, LICENSE,
  AUTHOR — these are not command-derived.
- The `manpage` target gains a pre-step: regenerate the COMMANDS region from the
  corpus, **then** run pandoc. One target, doing fully what it is named for.
  pandoc stays a contributor-only dependency; the `.1`/`.html` outputs stay
  committed.

### 8.2 The mapping is 1:1 with today's hand-written source

`vpn-switch.1.md`'s COMMANDS subsections already mirror the group model:

| man source (today, hand-written) | corpus tag |
|----------------------------------|------------|
| `## Sessions` + intro paragraph  | `@defgroup session  Sessions` + body |
| `**session list**` / `:   Show all…` | `@command session list` + `@summary Show all…` |
| `**session show** [*name* \| *PID*]` | `@command session show [<name>\|<PID>]` + `@param` |

The Markdown emitter is mechanical: `@defgroup → ## <Title>` (+ body as the
section intro); each member `@command → **<usage>**` / `:   <summary>` (+
`@param`/`@example` as indented lines) — exactly the definition-list shape the
source maintains by hand today.

### 8.3 Why it pays off

1. **Shared effort, no double authoring.** Filling the corpus well produces
   terminal help *and* the man COMMANDS section *and* HTML at once.
2. **Drift becomes a test across all three.** Test C extends to: every
   `@command` is dispatchable, and every dispatchable user command has a block
   (so it reaches the man page). "Command in the code but not in the man page"
   stops being a silent bug. (This is live today: `session refresh` exists in the
   code but is absent from `vpn-switch.1.md`.)

### 8.4 Sequencing, effort, open decision

- **Order:** after the terminal-help generator (both are back-ends on the same
  model) — Idea 1 phase 3+. No corpus work beyond what help already requires.
- **Effort:** moderate — a second emitter over the existing scan, plus the splice
  region and the `manpage` pre-step.
- **Open decision:** start with **only COMMANDS generated** (the largest,
  most-drifting part); generate SYNOPSIS and SEE ALSO later (v2), once the corpus
  carries the full `@see` edge set. Agree to start COMMANDS-only?
