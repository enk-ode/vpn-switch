# Debugging Guide

**Audience:** Users and AI assistants working with vpn-switch.

Debugging vpn-switch follows three pillars, in order:

1. **Environment inspection** — check configuration first (most issues live here)
2. **Command inspection** — examine the rewrite chain without executing it
3. **Log and trace inspection** — review actual execution flow

Investigate with the built-in tools; gather evidence rather than guessing.

---

## Pillar 1: Environment Inspection

Most bugs are environment misconfiguration. Check the environment before reading code.

### `vpn-switch printenv`

Shows the effective environment for a database.

```bash
# All effective variables
vpn-switch printenv

# A specific variable (with its source)
vpn-switch printenv VPN_SWITCH_TERMINAL_INTERPRETER

# Compare two databases
diff <(env VPN_SWITCH_BASE=/data/vpn   vpn-switch printenv) \
     <(env VPN_SWITCH_BASE=/tmp/test-db vpn-switch printenv)
```

### Common environment issues

| Symptom | Likely cause | Check |
|---------|--------------|-------|
| Terminal command executes when you expected dry-run | `VPN_SWITCH_TERMINAL_INTERPRETER=sh` | Default is `cat` (inspect-before-execute) |
| Command prints output but nothing happens | An interpreter is `cat` | Set the relevant interpreter to `sh` / combinator interpreter |
| Wrong interface used | Interface override | Check `VPN_SWITCH_INTERFACE_wireguard`, `VPN_SWITCH_INTERFACE_openvpn` |
| Stale behavior after a change | Environment cache | `vpn-switch environment cache off`, then retry |

### When to check the environment

- Before investigating any issue.
- After `bootstrap` — confirm the profile loaded.
- After `setenv` / `unsetenv` — confirm the change took effect.
- When tests fail — compare test vs. working environments.
- Before asking for help — include `printenv` output.

---

## Pillar 2: Command Inspection

The shell has no stepwise debugger. Command inspection replaces it: set a function's
interpreter to `cat` to see what a command **would** do without running it.

```bash
# Inspect what 'start' resolves to (don't execute)
vpn-switch setenv VPN_SWITCH_INTERPRETER_start0 cat
vpn-switch start
#   "$VPN_SWITCH_CONTEXT_SCRIPT" wireguard start wg-privacy.conf
```

### Rewrite chains

A command rewrites through one or more steps until it reaches normal form (shell code):

```
vpn-switch start
  → vpn-switch wireguard start wg-privacy.conf   [combinator: single-step rewrite]
  → vpn-switch wireguard connect 12345           [combinator: single-step rewrite]
  → wg-quick up /path/to/wg0.conf                [terminal: normal form]
```

Inspect any step by setting that function's interpreter to `cat`:

```bash
vpn-switch setenv VPN_SWITCH_INTERPRETER_start0 cat            # generic start
vpn-switch setenv VPN_SWITCH_INTERPRETER_wireguard_start0 cat  # protocol start
vpn-switch setenv VPN_SWITCH_INTERPRETER_wireguard_connect1 cat # connect → shell
```

Interpreter variables resolve most-specific first: `VPN_SWITCH_INTERPRETER_<func><arity>`
(e.g. `_wireguard_connect1`), then the family `VPN_SWITCH_INTERPRETER_<func>`
(e.g. `_wireguard_connect`), then the class default.

### Function classes and interpreter defaults

| Class | Prefix | Outputs | Default interpreter |
|-------|--------|---------|---------------------|
| Terminal | `_f` | shell commands | `VPN_SWITCH_TERMINAL_INTERPRETER` = `cat` |
| Combinator | `__f` | one vpn-switch command | `VPN_SWITCH_COMBINATOR_INTERPRETER` |
| Batch combinator | `___f` | N vpn-switch commands | `VPN_SWITCH_BATCH_COMBINATOR_INTERPRETER` |

The combinator default takes the first output line and re-dispatches it through the script
(`head -n1 | xargs sh -c '…' --`, portable across FreeBSD sh and Debian dash). The class
defaults exist so terminal output can be inspected before execution and combinator output can
recurse through the dispatcher. See [ARCHITECTURE.md](ARCHITECTURE.md) for the full rationale.

### Heterogeneous command families

Some families mix function classes. `wireguard add` is one:

```
_wireguard_add1   (terminal)
__wireguard_add2  (combinator)   ← different class
_wireguard_add3   (terminal)
```

Setting a single **family** interpreter (`VPN_SWITCH_INTERPRETER_wireguard_add=sh`) breaks the
combinator member: `sh` would try to execute its `"$VPN_SWITCH_CONTEXT_SCRIPT" …` output as a
literal command. Each member already ships an arity-specific interpreter in
`template/environment/` (`_wireguard_add1`/`_add3` = `sh`, `_add2` = the portable combinator
interpreter), so prefer arity-specific overrides for these families and leave the family
variable unset.

Detect a heterogeneous family by underscore count:

```bash
grep -nE '^_+wireguard_add[0-9]' include/wireguard.sh
```

If a family command gives mysterious "command not found" errors, check whether a family-level
interpreter has been set (`printenv VPN_SWITCH_INTERPRETER_wireguard_add`) and switch to
arity-specific overrides.

### When to use command inspection

- Understanding a new command before running it.
- Verifying a combinator outputs a vpn-switch command (not shell code or an error string).
- Checking `$VPN_SWITCH_CONTEXT_SCRIPT` is passed through literally, not pre-expanded.
- Test development — confirming command output matches expectations.

---

## Pillar 3: Log and Trace Inspection

After environment and command inspection, logs and traces show what actually ran.

- **Logs** (`.log`) — stderr captured from external commands.
- **Traces** (`.trace`) — vpn-switch's own structured execution flow: dispatch, interpreter
  resolution, run_env subprocess entry/exit, and pipeline output, indented by call depth.
  This is **not** shell `set -x` output — entries are written by `trace_log()` in the form
  `<depth><marker> <caller>: <message>`.

### Enabling capture

Both are governed by retention-in-days variables. The default for each is **1** (capture
enabled, kept one day); set to `0` to disable.

```bash
vpn-switch setenv VPN_SWITCH_RETENTION_DAYS_LOG 1     # keep logs 1 day
vpn-switch setenv VPN_SWITCH_RETENTION_DAYS_TRACE 1   # keep traces 1 day

vpn-switch setenv VPN_SWITCH_RETENTION_DAYS_LOG 0     # disable logs
vpn-switch setenv VPN_SWITCH_RETENTION_DAYS_TRACE 0   # disable traces

vpn-switch setenv VPN_SWITCH_RETENTION_DAYS_TRACE 7   # keep longer
```

To send a one-off trace to an explicit path instead, set `VPN_SWITCH_TRACE_FILE`:

```bash
VPN_SWITCH_TRACE_FILE=/tmp/trace.log vpn-switch wireguard start privacy
```

### File layout

Both log and trace files are written under `$VPN_SWITCH_BASE/.log/<date>/`:

```
${VPN_SWITCH_BASE}/.log/
└── 2026-06-19/
    ├── 140523.12345_wireguard_start1.log
    ├── 140523.12345_wireguard_start1.trace
    └── 140524.12346_wireguard_connect1.log
```

Filename format: `HHMMSS.PID_functionname.{log,trace}`.

### Reading them

```bash
# Today's files, newest first
ls -lt "$VPN_SWITCH_BASE/.log/$(date +%Y-%m-%d)/"

# A specific command's stderr / trace
cat "$VPN_SWITCH_BASE/.log/2026-06-19/140523.12345_wireguard_start1.log"
cat "$VPN_SWITCH_BASE/.log/2026-06-19/140523.12345_wireguard_start1.trace"

# Search all logs for errors
grep -ri error "$VPN_SWITCH_BASE/.log/"

# Follow live (from another terminal)
tail -f "$VPN_SWITCH_BASE/.log/$(date +%Y-%m-%d)/"*.log
```

### Cleanup

`logs clean` emits `rm` commands for log directories older than the retention window; review,
then pipe to a shell:

```bash
vpn-switch logs clean        # review the generated commands
vpn-switch logs clean | sh   # execute
```

### When to use logs/traces

- After environment and command inspection — not the first step.
- Intermittent issues — capture execution when the bug occurs.
- Production debugging — review after the fact.
- Following a complex rewrite chain end to end.

---

## Systematic Workflow

1. **Observe** — what command ran, what error, expected vs. actual.
2. **Check the environment** — `vpn-switch printenv` (and the specific variable in question).
   If it's wrong, fix it and retry before anything else.
3. **Inspect the command** — set `VPN_SWITCH_INTERPRETER_<func>` to `cat` and re-run to see
   the rewrite output. Watch for: a combinator emitting an error string instead of a
   vpn-switch command; `$VPN_SWITCH_CONTEXT_SCRIPT` pre-expanded to an absolute path; a missing
   step in the chain.
4. **Enable tracing if needed** — set the retention variables, re-run, read the `.log`/`.trace`
   files.
5. **Compare with a working setup** —
   `diff <(env VPN_SWITCH_BASE=/working/db vpn-switch printenv) <(env VPN_SWITCH_BASE=/broken/db vpn-switch printenv)`.
6. **Fix from evidence**, then re-verify with the same tools.
7. **Clean up** — reset retention to `0` if you don't need capture, and `vpn-switch logs clean | sh`.

---

## Common Patterns

### Combinator emits an error string instead of a command

A combinator (`__f`) must output a vpn-switch command. If it prints an error string directly,
the combinator interpreter tries to execute that text and fails:

```bash
vpn-switch setenv VPN_SWITCH_INTERPRETER_start0 cat
vpn-switch start
#   Error: start: no VPN protocols found ...   ← architectural violation
```

Fix: have the combinator emit the error-handling command instead, e.g.
`"$VPN_SWITCH_CONTEXT_SCRIPT" error "start: no VPN protocols found" "..."`.

### `$VPN_SWITCH_CONTEXT_SCRIPT` expanded too early

```bash
vpn-switch setenv VPN_SWITCH_INTERPRETER_import cat
vpn-switch import config.conf
#   "/home/user/git/vpn-switch/vpn-switch.sh" wireguard import "config.conf"
```

The absolute path means the variable was expanded at generation time. This breaks session
portability (cached scripts hard-code a path). The function should emit the literal variable:

```sh
echo '"$VPN_SWITCH_CONTEXT_SCRIPT" wireguard import "config.conf"'
```

### Interpreter misconfiguration

```bash
vpn-switch printenv VPN_SWITCH_INTERPRETER_start
```

Common cases: a terminal interpreter set to `sh` (executes immediately, no inspection); a
combinator interpreter set to `cat` (chain stops, nothing recurses); a forgotten
function-specific override. Fix by unsetting the override or setting the correct value.

---

## Quick Reference

```bash
# Environment
vpn-switch printenv                                 # all variables
vpn-switch printenv VAR                              # one variable + source
vpn-switch setenv VAR value
vpn-switch unsetenv VAR

# Command inspection
vpn-switch setenv VPN_SWITCH_INTERPRETER_<func> cat  # dry-run a function
vpn-switch <command>                                 # see what it would do

# Logs and traces
vpn-switch setenv VPN_SWITCH_RETENTION_DAYS_LOG 1
vpn-switch setenv VPN_SWITCH_RETENTION_DAYS_TRACE 1
ls -lt "$VPN_SWITCH_BASE/.log/$(date +%Y-%m-%d)/"
vpn-switch logs clean | sh

# System state
vpn-switch inspect
```

---

## Notes for AI Assistants

1. Check the environment first; don't skip it.
2. Use command inspection liberally to verify assumptions about output.
3. Never clean up a test database when a test fails — preserve state for inspection.
4. Think in rewrite steps; each command transforms to the next form.
5. Combinators must output vpn-switch commands, not error strings or shell code.

---

## See Also

- [ARCHITECTURE.md](ARCHITECTURE.md) — command-rewriting architecture and interpreter signatures
- [COMMAND_INSPECTION.md](COMMAND_INSPECTION.md) — worked command-inspection examples (set interpreters to `cat` to see what a command would do)
- [../CLAUDE.md](../CLAUDE.md) — project debugging notes
