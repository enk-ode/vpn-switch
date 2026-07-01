# vpn-switch Requirements

Technical requirements for `vpn-switch`. For architecture and rationale, see
[ARCHITECTURE.md](ARCHITECTURE.md) and [DESIGN_DECISIONS.md](DESIGN_DECISIONS.md).
For current status, see [CLAUDE.md](CLAUDE.md).

## Table of Contents

- [General Principles](#general-principles)
- [Privacy and Security](#privacy-and-security)
- [Directory Structure](#directory-structure)
- [API Specification](#api-specification)
- [Session Management](#session-management)
- [Management Operations](#management-operations)

---

## General Principles

- POSIX shell compliance (no bashisms)
- Single-file deployment (`vpn-switch.sh`) plus modular includes (`include/*.sh`)
- Combinator dispatch is metadata-driven: build-time `ANCHOR_FUNCTIONS` and
  `FUNCTION_MODULES` tables (`vpn-switch.sh`, near lines 8–14), not runtime
  function scanning
- Testable in isolation; debuggable via dry-run interpreters
- Extensible without modifying core dispatch

Functions are classified by underscore prefix (see ARCHITECTURE.md):

- `_f` terminal — outputs final data, default interpreter `cat`
- `__f` combinator — outputs exactly one `vpn-switch` command
- `___f` batch combinator — outputs N `vpn-switch` commands

---

## Privacy and Security

Configuration files from a VPN provider contain secrets (private keys,
preshared keys). The database hierarchy is private by default.

### Permissions

Directory modes are defined by `VPN_SWITCH_INIT_DIR_CONFIG`
(`vpn-switch.sh:80`) and applied by `_database_init0`:

| Path                  | Mode   |
|-----------------------|--------|
| `wireguard/`          | `0700` |
| `openvpn/`            | `0700` |
| `session/`            | `0700` |
| `.session/`           | `0700` |
| `.env/`, `.env/default/`, `.env/local/` | `0700` |
| `.include/`, `.include/phase/` | `0700` |
| `.tmp/`, `.tmp/batch-exits/`, `.log/`  | `0750` |

File modes set by the management/connect code:

- Imported config files (`.conf`, `.ovpn`): `0400`
  (`include/wireguard.sh:33`, `include/openvpn.sh`)
- Category directories created by `add`: `0755`
  (`include/wireguard.sh`, `_wireguard_add1`)
- Session directory: `0750`; session metadata files (`pid`, `protocol`,
  `interface`, `started`, `original`) and the patched config: `0640`
  (`_session_create1` at `vpn-switch.sh:1336`, `_session_populate3` at
  `vpn-switch.sh:1512`, `_wireguard_patch2` at `include/wireguard.sh:152–169`)
- Generated `connect.sh` / `disconnect.sh`: `0700`

Ownership: the database is owned by the invoking user; only the connect and
disconnect phases require elevation (`sudo`/`doas`). No group/world write.

---

## Directory Structure

The protocol directory is a **uniform namespace**: files, symlinks, and
directories coexist, and the filesystem entity type determines how an argument
resolves. No syntactic markers are needed in the user interface.

### Filesystem Layout

```
$VPN_SWITCH_BASE/
├── conf -> wireguard/                  # Extension alias (created by init)
├── ovpn -> openvpn/                    # Extension alias (created by init)
├── openvpn/
│   ├── default -> privacy/             # Default category (optional symlink)
│   ├── de-194.example.udp.ovpn         # Original config file
│   ├── ch-123.example.tcp.ovpn         # Original config file
│   ├── germany5 -> de-194.example.udp.ovpn   # Alias (no extension required)
│   ├── germany5-dup -> de-194.example.udp.ovpn  # Weight (2x selection)
│   ├── swiss1 -> ch-123.example.tcp.ovpn
│   └── privacy/                        # Category (group) directory
│       └── swiss1 -> ../swiss1
├── wireguard/
│   ├── default -> privacy/             # Default category (optional symlink)
│   ├── wg-RS-43.conf                   # Original config file
│   ├── wg-CH-201.conf                  # Original config file
│   ├── serbia1 -> wg-RS-43.conf        # Alias
│   ├── serbia2 -> wg-RS-43.conf        # Weight (2x selection)
│   └── privacy/
│       ├── default -> ../swiss1        # Default config for category (optional)
│       └── swiss1 -> ../swiss1
├── session/                            # Pseudo-protocol: named-session symlinks
│   └── default -> ../.session/12345/   # Saved session (created by 'session save')
├── .session/                           # Runtime session metadata
│   └── 12345/                          # Session directory (process PID)
│       ├── pid
│       ├── protocol                    # wireguard | openvpn
│       ├── interface                   # wg0, tun0, …
│       ├── original                    # Path to original config
│       ├── started                     # Timestamp
│       ├── wg0.conf                    # Patched config (interface-named)
│       └── connect.sh                  # Cached connection script
├── .env/{default,local}/               # Environment files
├── .include/phase/                     # Lifted phase scripts
├── .tmp/, .log/                        # Working dirs
```

### Entity Types

**Regular files** must carry the protocol extension (`.conf` for wireguard,
`.ovpn` for openvpn); these are the imported configs.

**Symlinks** may have any name (extensions optional) and must resolve to a
valid config file. They provide:

- **Readable aliases**: `serbia1 -> wg-RS-43.conf`
- **Weighted selection**: multiple symlinks to one file raise its random-pick
  probability (`serbia1` + `serbia2` → 2x weight for `wg-RS-43.conf`)

**Directories** group related configs (categories; called *groups* for
openvpn), typically holding symlinks back to configs in the parent directory.

The reserved name `default` is used for default resolution. Names must be
unique within a directory (no file/symlink/directory collisions).

### Resolution

When an argument is given, it resolves by entity type:

1. **Symlink** → follow to target, verify target is a valid config
2. **Regular file** → use directly
3. **Directory** → select a config from it (via `default` symlink, else random)
4. **Not found** → error

When an argument is omitted, the same default pattern applies at each level:
check the `default` symlink; if absent, pick randomly.

- **Category level**: `$VPN_SWITCH_BASE/<protocol>/default`, else random from
  the protocol directory (skipping subdirectories)
- **Config level**: `$VPN_SWITCH_BASE/<protocol>/<category>/default`, else
  random from the category

```bash
vpn-switch wireguard start          # wireguard → default/random category → default/random config
vpn-switch wireguard start privacy  # wireguard → privacy → default/random config
vpn-switch start privacy            # default/random protocol → privacy → default/random config
```

Uniqueness is enforced at creation time: `add` and `link` refuse if the name
already exists; `validate` reports naming conflicts; `clean` removes broken
symlinks.

---

## API Specification

The commands below are defined by `@command` annotations in the source. The
user-facing CLI exposes protocol-agnostic verbs (`start`, `stop`, `status`,
`import`, `dump`, …) and protocol-scoped verbs (`wireguard …`, `openvpn …`,
`session …`).

### Connection

#### `start` — resolution + connect

```bash
vpn-switch start [<config>]                 # @command start (vpn-switch.sh:3091)
vpn-switch wireguard start [<category>]     # @command (include/wireguard.sh:27)
vpn-switch openvpn start [<group>]          # @command (include/openvpn.sh:27)
```

`start` resolves the argument (no arg → defaults; directory → category select;
symlink → follow; file → use directly), creates the session, patches the
config, generates `connect.sh`, and runs it. The protocol-agnostic `start`
resolves the protocol first, then delegates to the protocol-specific start.

There is **no** user-facing `connect` command. Connection is performed by the
internal terminal functions `_wireguard_connect1` / `_openvpn_connect1` and the
session-scoped `_session_connect1`, which replay the cached `connect.sh`.

### Disconnection

```bash
vpn-switch stop [<interface>]               # @command stop (vpn-switch.sh:1562)
vpn-switch wireguard stop [<interface>]     # @command (include/wireguard.sh:556)
vpn-switch openvpn stop [<interface>]       # @command (include/openvpn.sh:405)
vpn-switch session disconnect <PID>         # @command (include/session.sh:42)
```

`stop` with no argument tears down all active sessions; with an interface it
stops that one. Teardown is split between the protocol layer (interface
destruction) and the session layer (metadata removal). There is no user-facing
`disconnect` verb other than `session disconnect`.

### Function mapping

Commands map to functions by name and arity: protocol-agnostic
`_(operation)(arity)` and protocol-scoped `_(protocol)_(operation)(arity)`,
with the underscore prefix giving the function class. Examples (verified
against `ANCHOR_FUNCTIONS` / `FUNCTION_MODULES`):

```
vpn-switch start                       → __start0    (combinator)
vpn-switch start privacy               → __start1
vpn-switch stop                        → ___stop0    (batch combinator)
vpn-switch stop wg0                    → __stop1
vpn-switch status                      → _status0    (terminal)
vpn-switch wireguard start             → __wireguard_start0
vpn-switch wireguard start privacy     → __wireguard_start1
vpn-switch wireguard import f.conf     → _wireguard_import1
vpn-switch wireguard add cat           → _wireguard_add1
vpn-switch wireguard add cat tgt       → __wireguard_add2  (combinator → add3)
vpn-switch wireguard add cat tgt alias → _wireguard_add3
vpn-switch wireguard link alias cfg    → _wireguard_link2
vpn-switch wireguard remove name       → _wireguard_remove1
vpn-switch wireguard remove cat name   → _wireguard_remove2
vpn-switch wireguard list              → _wireguard_list0
vpn-switch wireguard validate          → _wireguard_validate0
vpn-switch wireguard clean             → ___wireguard_clean0  (batch combinator)
vpn-switch wireguard clean cat         → ___wireguard_clean1
vpn-switch list                        → ___list0
vpn-switch validate                    → ___validate0
vpn-switch dump                        → ___dump0
vpn-switch batch <file>                → __batch1 → _batch2
vpn-switch restore <file>              → __restore1
vpn-switch bootstrap <dir> <profile>   → __bootstrap1 → ___bootstrap2
vpn-switch session list                → _session_list0
vpn-switch session show [name|PID]     → __session_show0 / _session_show1
vpn-switch session remove name|PID     → _session_remove1
```

Notes:

- `add` arity 2 is a **combinator** (`__wireguard_add2` / `__openvpn_add2`): it
  emits an arity-3 `add` command (alias = target). Arity 1 and 3 are terminal.
- `clean`, `stop` (arity 0), `dump`, `list`, `validate` are **batch
  combinators** (`___` prefix).
- There is no `_init0`. Database creation is `bootstrap → ___bootstrap2 →
  ___init1`, which emits `database init`, `environment init`, `phases sync`.

---

## Session Management

Sessions prevent duplicate VPN instances and track active connections via
filesystem session directories. Each `start` process creates
`$VPN_SWITCH_BASE/.session/<PID>/`.

### Session directory contents

```
$VPN_SWITCH_BASE/.session/<PID>/
├── pid          # Process ID of the vpn-switch instance
├── protocol     # "wireguard" or "openvpn"
├── interface    # Interface name (wg0, tun0) — used for duplicate detection
├── original     # Path to the original config (written by 'patch')
├── started      # Creation timestamp
├── <iface>.conf # Patched config, named after the interface (e.g. wg0.conf)
└── connect.sh   # Generated connection script (replayed on resume)
```

The session directory is `0750`; metadata files and the patched config are
`0640`; `connect.sh` is `0700`. The patched config has resolvconf `PostUp`/
`PostDown` hooks stripped (DNS is handled by the DNS phase).

Named sessions are saved by `session save [<name>]`, which creates a symlink
`session/<name> -> ../.session/<PID>/` (no separate copy of the metadata).

### Duplicate prevention and stale cleanup

Before connecting, the start chain checks for an existing session on the target
interface (`__interface_check1`, `__session_exists1`). Liveness is tested with
`kill -0 $pid`; sessions whose process is gone are stale and removed
automatically before each new connection, and orphaned interfaces are
destroyed (`_interface_destroy1`). This keeps the database crash-safe.

If a legacy session lacks the `interface` file, the interface is inferred from
`protocol` (`wireguard → wg0`, `openvpn → tun0`).

### Lifecycle commands

```bash
vpn-switch session list                 # List active and saved sessions
vpn-switch session show [<name>|<PID>]  # Show one session's details
vpn-switch session save [<name>]        # Save current session as a symlink
vpn-switch session start [<name>|<PID>] # Resume a saved/active session
vpn-switch session remove <name>|<PID>  # Remove a session
vpn-switch session clean                # Remove stale/broken sessions
vpn-switch session refresh              # Re-patch from recorded 'original'
vpn-switch session disconnect <PID>     # Tear down the interface for a session
```

---

## Management Operations

### Path resolution and naming

- `import` accepts an absolute path or one relative to the CWD; all other
  operations use names relative to the protocol directory.
- Protocol is detected from the file extension (`.conf` → wireguard,
  `.ovpn` → openvpn).
- Operations fail fast on precondition violations (missing target, existing
  target, bad extension), except `restore`, which keeps going.
- Symlinks may be named freely; config files must keep their extension; the
  name `default` is reserved.

### `import`

```bash
vpn-switch import <path>                # detect protocol from extension
vpn-switch <protocol> import <path>
```

- `_import1` detects the protocol and delegates to `_<protocol>_import1`.
- Validates the file exists and has the right extension; copies it into
  `$VPN_SWITCH_BASE/<protocol>/` with mode `0400`; refuses if a config of that
  name already exists (`include/wireguard.sh:13–33`).

```bash
vpn-switch import /downloads/wg-RS-43.conf       # → wireguard/wg-RS-43.conf
vpn-switch openvpn import /tmp/us-456.ovpn       # → openvpn/us-456.ovpn
```

### `add` — create category (group)

```bash
vpn-switch <protocol> add <category>                  # _<protocol>_add1 (terminal)
vpn-switch <protocol> add <category> <target>         # __<protocol>_add2 (combinator)
vpn-switch <protocol> add <category> <target> <alias> # _<protocol>_add3 (terminal)
```

- Arity 1: creates `<protocol>/<category>/` with mode `0755`; refuses if the
  name exists.
- Arity 2: validates category and target exist, then emits
  `<protocol> add <category> <target> <target>` (delegates to arity 3).
- Arity 3: creates `<category>/<alias> -> ../<target>`; refuses on name
  collision.

```bash
vpn-switch wireguard add privacy
vpn-switch wireguard add privacy wg-RS-43.conf            # privacy/wg-RS-43.conf -> ../wg-RS-43.conf
vpn-switch wireguard add privacy wg-RS-43.conf serbia1    # privacy/serbia1 -> ../wg-RS-43.conf
```

### `link` — create alias in the protocol directory

```bash
vpn-switch <protocol> link <alias> <target>     # _<protocol>_link2 (terminal)
vpn-switch link <alias> <protocol>              # _link2 (protocol-level default)
```

Creates `<protocol>/<alias> -> ./<target>` (relative, same directory); refuses
on collision (`include/wireguard.sh:23`, `_link2` in `vpn-switch.sh`).

```bash
vpn-switch wireguard link serbia1 wg-RS-43.conf  # wireguard/serbia1 -> ./wg-RS-43.conf
vpn-switch wireguard link default privacy        # wireguard/default -> ./privacy/
```

### `remove`

```bash
vpn-switch <protocol> remove <name>             # _<protocol>_remove1
vpn-switch <protocol> remove <category> <name>  # _<protocol>_remove2
```

- Arity 1: if the target is a config file, refuse when symlinks reference it or
  when an active session uses it; if it is a symlink, remove it directly.
- Arity 2: remove the symlink from the category (no reference check).

### `list`

```bash
vpn-switch list                       # ___list0  — all protocols
vpn-switch <protocol> list            # _<protocol>_list0
vpn-switch <protocol> list <category> # _<protocol>_list1
```

Informational; emitted lines are `# `-prefixed comments (terminal, `cat`).

### `info`

```bash
vpn-switch <protocol> info <category>   # _<protocol>_info1
```

Shows category contents with per-config expiry status. Expiry comes from
`get_wireguard_expiry_status` (`include/wireguard.sh:1610`): expired configs
are flagged `[✗ expired]`, those within 30 days `[⚠ expiring: Nd]`.

### `validate`

```bash
vpn-switch validate             # ___validate0  — all protocols + system checks
vpn-switch <protocol> validate  # _<protocol>_validate0
```

Per-protocol checks (`_wireguard_validate0`, `include/wireguard.sh:991+`):

1. Broken symlinks in the protocol directory and in categories
2. Naming conflicts (file and directory sharing a base name)
3. Config readability: unreadable, empty, or missing `[Interface]` section
4. Unsafe names (newline in filename)

The aggregate `___validate0` additionally runs system validators from
`include/validate.sh` (binaries, network, permissions, environment, install,
version, sudo, logs, phases, database). Output is reporting only; findings are
`# [ERROR]` / `# [WARNING]` comment lines.

### `clean`

```bash
vpn-switch <protocol> clean             # ___<protocol>_clean0  (batch combinator)
vpn-switch <protocol> clean <category>  # ___<protocol>_clean1
```

Scans for broken symlinks and emits `vpn-switch <protocol> remove …` commands.
As a batch combinator it does not execute them itself; the default batch
interpreter feeds them back through `vpn-switch batch`.

### `dump`

```bash
vpn-switch dump             # ___dump0  — whole database
vpn-switch <protocol> dump  # ___<protocol>_dump0
```

`___dump0` (`include/database.sh:689+`) emits a replayable command stream, not
a hand-written script. Its structure:

```
# vpn-switch database dump
# Generated: <timestamp>

# Prologue
vpn-switch dumpenv prologue        # safe minimal env subset

# <protocol> protocol dump          (one per real protocol directory)
vpn-switch wireguard dump
vpn-switch openvpn dump

# Session dump
vpn-switch session dump            # named sessions only

# Epilogue
vpn-switch dumpenv epilogue        # full user environment
```

`init`/`bootstrap` is **not** emitted — it is implicit in `restore`. Symlinks
(`conf`, `ovpn`) and pseudo-protocols are skipped. The per-protocol `dump`
produces the actual `import`/`add`/`link` commands with absolute paths.

### `batch` and `restore`

```bash
vpn-switch batch <file>             # __batch1 → _batch2
vpn-switch restore <file>           # __restore1 (batch with keep-going)
```

`batch` reads `vpn-switch` commands from a **file** (one per line), validates
each, and executes them via recursive invocation. It is fail-fast by default;
`VPN_SWITCH_BATCH_KEEP_GOING=1` switches to keep-going. The default batch
combinator interpreter writes its piped stdin to a `0600` temp file under
`.tmp/` and invokes `vpn-switch batch <tmpfile>`, which is how
`clean | …` and `dump | …` pipelines run.

`restore` is a thin wrapper: it validates the file is present and readable,
sets `VPN_SWITCH_BATCH_KEEP_GOING=1`, and runs batch
(`include/database.sh:992+`).

```bash
vpn-switch dump > backup.sh
env VPN_SWITCH_BASE=/new/location vpn-switch restore backup.sh
```

### Database initialization (`bootstrap`)

There is no `init` command in the user CLI. Create a database with:

```bash
vpn-switch bootstrap <dir> <profile>    # profile: minimal | all | custom
```

`bootstrap` (`include/database.sh:6`) sets `VPN_SWITCH_BASE=<dir>` and a minimal
cached environment, then runs the internal `init` chain
(`__bootstrap1 → ___bootstrap2 → ___init1`), which:

- creates the directory hierarchy with the modes in `VPN_SWITCH_INIT_DIR_CONFIG`
  (`_database_init0`)
- creates the `conf -> wireguard/` and `ovpn -> openvpn/` extension symlinks
- copies environment templates from `$VPN_SWITCH_TEMPLATE_DIR/environment/`
  into `.env/default/` at mode `0600`, selecting the variable set for the named
  profile (`environment init`)
- lifts phase scripts (`phases sync`)

Existing directories are validated rather than recreated (init is idempotent;
non-empty non-operational directories are rejected).

---

## Default Interpreters

From `template/environment/` (see ARCHITECTURE.md for the dispatch model):

- `PATH` = `/sbin:/bin:/usr/bin:/usr/local/bin`
- `VPN_SWITCH_TERMINAL_INTERPRETER` = `cat`
- `VPN_SWITCH_COMBINATOR_INTERPRETER` =
  `head -n1 | xargs sh -c '…' --` (runs the single emitted command)
- `VPN_SWITCH_BATCH_COMBINATOR_INTERPRETER` = writes stdin to a `0600` temp file
  and execs `vpn-switch batch <tmpfile>`

Per-function overrides use `VPN_SWITCH_INTERPRETER_<name>` (e.g.
`VPN_SWITCH_INTERPRETER_wireguard_connect1`).

---

## References

- [ARCHITECTURE.md](ARCHITECTURE.md) — combinator architecture and dispatch
- [DESIGN_DECISIONS.md](DESIGN_DECISIONS.md) — key decisions and rationale
- [CLAUDE.md](CLAUDE.md) — current status and project instructions
- [COMMIT_CHECKLIST.md](COMMIT_CHECKLIST.md) — definition of done
