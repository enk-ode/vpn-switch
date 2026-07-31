# vpn-switch Design Decisions

Each entry records a decision, its rationale, and the rejected alternatives.
For the current architecture (verified against the code) see
[ARCHITECTURE.md](ARCHITECTURE.md); this file explains *why* it is shaped that way.

---

## Database Initialization: bootstrap, not an install script

**Decision:** Initialization is a built-in command, `vpn-switch bootstrap <dir>
<profile>`, not a separate `install.sh`. Installation of the program itself is
handled by the `GNUmakefile` (`gmake install`); creating and populating a
database is a vpn-switch command.

**Commands** (all in `include/database.sh`):

```bash
vpn-switch bootstrap ~/.vpn-switch/db minimal   # create + populate a new database
vpn-switch dump > backup.sh                     # export current state as a replayable script
vpn-switch restore backup.sh                    # replay a dump into a bootstrapped database
vpn-switch sync                                 # refresh DB against source templates after upgrade
```

A `dump` is a sequence of `vpn-switch` commands; `restore` replays them through
the normal dispatch path. The database is therefore declarative and
reproducible, and the dump doubles as readable documentation of current state.

**Rationale:**
- Self-contained — no second file to keep in sync with the main script.
- `dump | restore` gives backup, migration, and schema upgrade for free
  (dump from old version, restore into a freshly bootstrapped new one).
- Testable — the whole lifecycle runs in the test suite via the public API.

**Rejected alternative — external `install.sh` for the database:** it could not
back up or migrate a database, was not exercised by the test suite, and required
manual steps for any schema change. Program installation (copying files, FHS
layout, platform selection) genuinely is install-time work and lives in the
`GNUmakefile`; database lifecycle is a runtime concern and belongs in the tool.

---

## Session Resumption: explicit `session start`, not implicit reconnect

**Decision:** Resuming a cached session is an explicit command
(`vpn-switch session start [name|pid]`), not implicit behaviour folded into
`wireguard start` / `openvpn start`.

Sessions are PID-based and created automatically by a `start` command, which
caches the generated `connect.sh` under `.session/<pid>/`. A saved session is a
named symlink into that storage:

```
$VPN_SWITCH_BASE/
├── session/            # named session links (pseudo-protocol, peer of wireguard/, openvpn/)
│   └── work -> ../.session/12345/
└── .session/12345/     # actual PID-based storage (connect.sh + metadata)
```

Relevant anchor functions (`include/session.sh`): `__session_start0` /
`__session_start1` (resume default / named-or-PID), `_session_save0` /
`_session_save1` (save current session under a name), plus inspection commands
`_session_list0`, `__session_show0` / `_session_show1`, `_session_remove1`.

```bash
vpn-switch wireguard start privacy   # create new session at .session/<pid>/
vpn-switch session save work         # session/work -> ../.session/<pid>/
vpn-switch session start work        # re-run that session's cached connect.sh
```

**Rationale:**
- Explicit intent — `start` always means "create new", `session start` always
  means "resume". No command silently changes behaviour based on hidden state.
- Fits the combinator model — `session` is a protocol-level entity alongside
  `wireguard`/`openvpn`, so resumption needs no special case inside a `start`
  function.
- Protocol-agnostic — the same mechanism resumes WireGuard and OpenVPN, and
  supports multiple named sessions.

**Rejected alternative — implicit resumption** (have `wireguard start` detect a
cached session and re-run it): same command with two behaviours, hard to force a
fresh session, and protocol-specific logic embedded in each `start` function.

---

## Function Classification: intrinsic (naming convention), not extrinsic config

**Context:** A function's *type* (terminal vs combinator) determines which
interpreter its stdout is piped to. The question was where that type lives.

**Decision:** Encode the type in the function name via underscore-prefix count,
and select the interpreter from the name alone.

```
_name   → terminal          outputs final shell commands         (default: cat)
__name  → combinator        outputs one vpn-switch command        (default: head|xargs sh -c …)
___name → batch combinator  outputs N vpn-switch commands         (default: sh -c … batch …)
```

`lookup_interpreter()` (`vpn-switch.sh:692`) resolves most-specific-first:

1. arity override — `VPN_SWITCH_INTERPRETER_wireguard_add2`
2. family override (arity stripped) — `VPN_SWITCH_INTERPRETER_wireguard_add`
3. type default by underscore count — `VPN_SWITCH_{TERMINAL,COMBINATOR,BATCH_COMBINATOR}_INTERPRETER`

So three type-default variables cover the common case; per-function overrides
remain available but are rarely needed. The defaults live in
`template/environment/` and install into `.env/default/`. (See ARCHITECTURE.md
for the exact interpreter strings and why each is shaped the way it is.)

**Rationale:**
- Self-documenting — the prefix tells you the type; no external table to consult.
- Fail-fast — a misnamed function won't appear in the build-time anchor lists, so
  it fails to dispatch immediately rather than running with the wrong interpreter.
- Fewer moving parts — adding a protocol means following the naming convention,
  not registering a per-function interpreter variable.

**Rejected alternative — extrinsic classification:** one underscore for every
anchor function, with a per-function `VPN_SWITCH_INTERPRETER_*` variable deciding
its type. Adding a protocol meant remembering to add several interpreter
variables; forgetting one (e.g. an `openvpn stop` interpreter) produced a silent
wrong-interpreter bug. This was the original design and the reason for the change.

### Build-time metadata, not runtime scanning

The anchor lists are not recomputed at runtime. `gmake metadata`
(`scripts/generate-metadata.sh`) scans the sources and injects, near the top of
`vpn-switch.sh`, the build-time variables:

- `TERMINAL_FUNCTIONS`, `COMBINATOR_FUNCTIONS`, `BATCH_COMBINATOR_FUNCTIONS`,
  and their union `ANCHOR_FUNCTIONS` (vpn-switch.sh lines 8–11);
- `FUNCTION_MODULES` (line 14) — the `func:module.sh` map used for module loading
  (see the next decision).

`to_function_call()` (`vpn-switch.sh:510`) resolves a command line against
`$ANCHOR_FUNCTIONS` by progressive prefix filtering — it does **not** `grep` the
script on each invocation. Dispatch then reads the resolved call from
`$VPN_SWITCH_CONTEXT_CALL` (set by `process_arguments()`), not from stdin, so
batch combinators can still read piped input.

**Rationale:** pay the scan cost once at build time; runtime resolution is a list
lookup. The trade-off is a required `gmake metadata` step after adding, renaming,
or moving an anchor function — enforced by the test suite, which fails on a stale
map.

---

## PATH Separation: `PATH` for management, `VPN_SWITCH_PATH` for generated scripts

**Decision:** Use two PATH environments for two execution contexts.

| Variable | Used by | Default | Purpose |
|----------|---------|---------|---------|
| `PATH` | `vpn-switch.sh` itself | `/sbin:/bin:/usr/bin:/usr/local/bin` | Read-only management & inspection tools (ifconfig, netstat, pfctl, wg, ps, sed, grep). |
| `VPN_SWITCH_PATH` | generated `connect.sh` / `disconnect.sh` | `/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin` | Privileged bring-up tools (wg-quick, openvpn, route, pfctl). |

Both are configured in `$VPN_SWITCH_BASE/.env/{default,local}/`, from the
templates `template/environment/PATH` and `template/environment/VPN_SWITCH_PATH`.

`run_env()` runs interpreters with `PATH`, never `VPN_SWITCH_PATH`
(`vpn-switch.sh:473`). `VPN_SWITCH_PATH` is consulted only inside the generated
phase scripts, into which it is baked.

**Rationale:**
- Least privilege for management — `vpn-switch.sh` does not need the privileged
  `sbin` bring-up tools, only the read-only inspection subset.
- Bootstrap safety — `run_env()` cannot depend on `VPN_SWITCH_PATH`, which is not
  set before `.env` exists; using `PATH` keeps bootstrap working.
- Privilege escalation is explicit — e.g. an interpreter override
  `VPN_SWITCH_INTERPRETER_wireguard_connect="sudo sh"`. `vpn-switch.sh` finds
  `sudo` via `PATH`; the resulting `connect.sh` finds `wg-quick`/`pfctl` via
  `VPN_SWITCH_PATH`.

**Rejected alternatives:**
- *Single PATH for everything* — couldn't bootstrap (chicken-and-egg with
  `VPN_SWITCH_PATH`) and mixed management with privileged operations.
- *Inherit the system PATH* — unpredictable across hosts, not under database control.
- *Hardcode PATH values* — not portable across FreeBSD/Linux or custom installs.

**Cost accepted:** two variables to understand instead of one. The two contexts
have genuinely different needs, so the distinction is real rather than incidental.

See also: [ARCHITECTURE.md](ARCHITECTURE.md) (PATH Architecture) and
`vpn-switch help environment` for the full environment-variable reference.

---

## Modular Architecture: build-time function-to-module map, not a monolith

**Context:** As the codebase grew, a single file became hard to navigate and was
fully parsed on every invocation. The constraint was to split it without breaking
the combinator dispatch model.

**Decision:** Split protocol/feature code into `include/*.sh` modules and load the
single module a command needs via a build-time `FUNCTION_MODULES` map.

`scripts/generate-metadata.sh` scans the modules and emits
`FUNCTION_MODULES="<func>:<module.sh> …"` into `vpn-switch.sh` (line 14).
At runtime, `process_arguments()` (`vpn-switch.sh:2849`) resolves the function
name, looks it up in that map, and sources
`$VPN_SWITCH_LIBDIR/include/<module.sh>`:

```sh
for mapping in $FUNCTION_MODULES; do
  case "$mapping" in
    "$func_name":*) . "$VPN_SWITCH_LIBDIR/include/${mapping#*:}"; break ;;
  esac
done
```

Current modules: `database.sh`, `help.sh`, `inspect.sh`, `openvpn.sh`,
`session.sh`, `validate.sh`, `wireguard.sh`. Functions defined directly in
`vpn-switch.sh` (dispatch, `run_env`, helpers) need no loading.

**Rationale:**
- Deterministic — the function name maps directly to its module; no guessing.
- Maintainable — move a function between modules freely, then re-run
  `gmake metadata`; the map regenerates from the sources.
- Build-time cost paid once — runtime is a linear scan of the map (sub-millisecond).

**Rejected alternative — argument-based dynamic loading:** infer the module from
the command-line arguments (`case "$1" in wireguard|openvpn|session) …`). This was
tried first and broke whenever a function moved (e.g. `wireguard validate`
matching `validate.sh` instead of `wireguard.sh`), requiring fragile priority
rules. The function name is a unique identifier; inferring from arguments
discards that and reconstructs it unreliably.

**Generalizable principle:** when you already have a unique identifier (the
function name), map from it directly at build time rather than re-deriving it from
secondary data (arguments) at runtime.

**Costs accepted:** requires `gmake metadata` after adding or moving a function
(the test suite fails on a stale map). Module loading is per-invocation, not
cached across commands — consistent with the stateless, isolated execution model.
