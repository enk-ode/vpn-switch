# Command Inspection: Working with the Combinator/Interpreter Architecture

This document shows how to inspect vpn-switch commands before they run, using
the combinator/interpreter architecture. The core technique is to override a
function's interpreter — most often setting it to `cat` — so the command prints
what it *would* do instead of doing it. The same mechanism powers the
walkthrough generator (`scripts/vpn-switch-walkthrough.sh`).

For the architecture itself, see [ARCHITECTURE.md](ARCHITECTURE.md). For a
debugging methodology, see [DEBUGGING_GUIDE.md](DEBUGGING_GUIDE.md).

## Function Classes

Functions are classified intrinsically by the number of leading underscores:

| Class | Prefix | Output | Default interpreter |
|-------|--------|--------|---------------------|
| Terminal | `_f` | Shell commands | `cat` |
| Combinator | `__f` | One vpn-switch command | `head -n1 \| xargs sh -c '…'` |
| Batch combinator | `___f` | N vpn-switch commands | captures stdin, runs `batch` |

Dispatch resolves a command to a function and selects its interpreter from this
class, unless an override variable is set (see below). Resolution and the
metadata it relies on (`ANCHOR_FUNCTIONS`, `FUNCTION_MODULES`) are described in
[ARCHITECTURE.md](ARCHITECTURE.md).

## Interpreter Override Variables

`lookup_interpreter()` (vpn-switch.sh) picks an interpreter in this order:

1. Arity-specific override: `VPN_SWITCH_INTERPRETER_<func><arity>`
   (e.g. `VPN_SWITCH_INTERPRETER_openvpn_stop0`)
2. Arity-agnostic family override: `VPN_SWITCH_INTERPRETER_<func>`
   (e.g. `VPN_SWITCH_INTERPRETER_openvpn_stop`)
3. The class default (`VPN_SWITCH_TERMINAL_INTERPRETER`,
   `VPN_SWITCH_COMBINATOR_INTERPRETER`, `VPN_SWITCH_BATCH_COMBINATOR_INTERPRETER`)

The leading underscores are stripped to form the variable name; the trailing
arity digit is kept for the arity-specific form and dropped for the family form.

## Basic Inspection: Set the Interpreter to `cat`

Terminal functions already default to `cat`, so a terminal function's shell
output is visible without any change. To inspect a combinator or batch
combinator without running its children, override its interpreter to `cat`.

### Inspecting `stop`

`stop` (no argument) resolves to `___stop0`, a batch combinator. It discovers
protocols by listing the subdirectories of `$VPN_SWITCH_BASE`, skips
pseudo-protocols (`session`, `environment` by default), and emits one
`<protocol> stop` command per real protocol directory.

```bash
# stop0 is the mangled name of ___stop0 (underscores stripped, arity kept)
$ vpn-switch setenv VPN_SWITCH_INTERPRETER_stop0 cat
$ vpn-switch stop
"$VPN_SWITCH_CONTEXT_SCRIPT" openvpn stop
"$VPN_SWITCH_CONTEXT_SCRIPT" wireguard stop
```

Notes:

1. `___stop0` emits multiple commands — one per discovered protocol.
2. `"$VPN_SWITCH_CONTEXT_SCRIPT"` is printed literally; it is part of the
   function's output, not the interpreter, and is expanded only when executed.
3. The exact lines depend on which protocol directories exist in the database.
   A protocol with no `__<protocol>_stop` function is reported with a
   `# Skipping protocol …` comment instead.

### Drilling Down: `openvpn stop`

`openvpn stop` (no interface) resolves to `___openvpn_stop0` — also a batch
combinator. It scans `$VPN_SWITCH_BASE/.session`, and for each *alive* OpenVPN
session emits a disconnect command for that session's interface. With no active
OpenVPN session it emits a single `log` command instead.

```bash
$ vpn-switch setenv VPN_SWITCH_INTERPRETER_openvpn_stop0 cat
$ vpn-switch openvpn stop
"$VPN_SWITCH_CONTEXT_SCRIPT" openvpn disconnect tun0
```

With no active OpenVPN session:

```bash
$ vpn-switch openvpn stop
"$VPN_SWITCH_CONTEXT_SCRIPT" log "No OpenVPN sessions to stop"
```

### Terminal Output: `openvpn disconnect`

`openvpn disconnect <interface>` resolves to `_openvpn_disconnect1`, a terminal
function. For a phase-based session it prints the session's stored
`disconnect.sh`; the default `cat` interpreter shows that script without running
it.

```bash
$ vpn-switch openvpn disconnect tun0
#!/bin/sh
# ... generated disconnect script (DNS → VPN → firewall phases) ...
```

Notes:

1. Terminal functions output shell commands, not vpn-switch commands.
2. Disconnect is generated as a phase-based script, inspectable before it runs.
3. If no `disconnect.sh` exists (legacy session) the function emits an inline
   cleanup script instead.

## Walkthrough Generation

`scripts/vpn-switch-walkthrough.sh` automates the inspection above: it resolves
a command, recurses into the child commands, and renders the resolution chain.
It reuses the same interpreter-override mechanism rather than reimplementing
resolution. Two formats are supported: `tree` (default) and `markdown`.

```
Usage: vpn-switch-walkthrough.sh [options] <command> [args...]
  --database <path>    VPN_SWITCH_BASE directory to use
  --format <type>      tree (default) or markdown
  --depth <n>          maximum depth to traverse
```

### The `tee` Pattern (markdown format)

For markdown, each function's interpreter is set to a pipeline that both formats
the output for the document and writes the raw output to a temp file:

```sh
tee "$raw_file" | scripts/markdown-formatter.sh section depth=2 title='Command: stop'
```

The formatted markdown goes to stdout (building the document); the raw copy in
`$raw_file` is parsed to find child commands (lines beginning with
`"$VPN_SWITCH_CONTEXT_SCRIPT"`), which are then walked recursively. Because the
interpreter is an ordinary shell pipeline, swapping `markdown-formatter.sh` for
another formatter changes the output format without touching any function.

### Example: Tree Format

```bash
$ scripts/vpn-switch-walkthrough.sh --database "$HOME/.vpn-switch/db" stop
=========================================
vpn-switch Command Walkthrough
=========================================
Database: /home/user/.vpn-switch/db
Command: stop
Format: tree

├─ BATCH COMBINATOR: stop
│  Exit: 0
│  Commands generated: 2
  ├─ BATCH COMBINATOR: openvpn stop
  │  Exit: 0
  │  Commands generated: 1
      └─ TERMINAL: openvpn disconnect tun0
         Exit: 0
         Output lines: 42
  ├─ BATCH COMBINATOR: wireguard stop
  │  Exit: 0
  │  Commands generated: 1
      └─ TERMINAL: wireguard disconnect wg0
         Exit: 0
         Output lines: 38

=========================================
Walkthrough complete
=========================================
```

The tree nodes report the resolved class (combinators show `Next:`, batch
combinators show `Commands generated:`, terminals show `Output lines:`). Exact
counts depend on the database state.

### Example: Markdown Format

```bash
$ scripts/vpn-switch-walkthrough.sh --database "$HOME/.vpn-switch/db" \
    --format markdown stop
```

Produces a document headed:

```markdown
# vpn-switch Command Walkthrough

**Command:** `stop`

**Database:** /home/user/.vpn-switch/db
```

followed by a section per command in the resolution chain, each containing the
emitted lines in a fenced code block.

## Practical Applications

### Dry-run inspection

Terminal functions default to `cat`, so a bare `vpn-switch` command prints the
shell it would run rather than running it. To see the *vpn-switch* commands a
combinator or batch combinator would emit, override that function's interpreter
to `cat` (as in the examples above), or use the walkthrough tool. Note that
overriding only `VPN_SWITCH_TERMINAL_INTERPRETER` does not stop combinators from
executing — they have their own class default.

### Debugging a failed command

Enable tracing, run the command, then read the trace to see the resolution and
interpreter flow (see [DEBUGGING_GUIDE.md](DEBUGGING_GUIDE.md)):

```bash
$ vpn-switch setenv VPN_SWITCH_RETENTION_DAYS_TRACE 1
$ vpn-switch start
$ cat "$VPN_SWITCH_BASE"/.log/<date>/HHMMSS.PID_function.trace
```

### Generating documentation

```bash
$ for cmd in start stop validate inspect; do
    scripts/vpn-switch-walkthrough.sh --database "$HOME/.vpn-switch/db" \
      --format markdown "$cmd" > "docs/walkthrough-$cmd.md"
  done
```

### Logging commands as they execute

Set a terminal interpreter that both logs and executes (opt-in; the default is
the safer `cat`):

```bash
$ vpn-switch setenv VPN_SWITCH_TERMINAL_INTERPRETER "tee /tmp/vpn-commands.log | sh"
```

## Why It Works

- Functions only *emit* output; interpreters decide how to process it. The same
  function output can be inspected (`cat`), executed (`sh` / the class default),
  documented (`tee … | markdown-formatter.sh`), or logged.
- Classification is intrinsic to the function name, so resolution needs no
  registry or type annotations.
- Each layer composes: functions delegate to functions, interpreters are shell
  pipelines, and tools like `tee` chain cleanly. The walkthrough generator is
  small precisely because it reuses these existing pieces.

---

*See also:*
- *[ARCHITECTURE.md](ARCHITECTURE.md) — combinator/interpreter design*
- *[DEBUGGING_GUIDE.md](DEBUGGING_GUIDE.md) — debugging methodology*
- *[../scripts/vpn-switch-walkthrough.sh](../scripts/vpn-switch-walkthrough.sh) — walkthrough generator*
- *[../scripts/markdown-formatter.sh](../scripts/markdown-formatter.sh) — example formatter*
