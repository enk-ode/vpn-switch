% vpn-switch(1) | VPN connection manager
% Dr. Johannes Brügmann
% May 2026

# NAME

vpn-switch — POSIX-shell VPN connection manager for FreeBSD and Linux

# SYNOPSIS

**vpn-switch** [*command*] [*arguments*...]

**vpn-switch** **help** [*subcommand*]\
**vpn-switch** **bootstrap** *path* *profile*\
**vpn-switch** **start** *config*\
**vpn-switch** **stop**\
**vpn-switch** **sync**\
**vpn-switch** **version**\
**vpn-switch** **validate**\
**vpn-switch** **inspect**\
**vpn-switch** **session** *subcommand* [*name* | *PID*]\
**vpn-switch** **wireguard**|**openvpn** *subcommand* [*arguments*...]

# DESCRIPTION

**vpn-switch** is a POSIX-shell-based connection manager for WireGuard and
OpenVPN. It organises VPN configurations as a filesystem database (directories
group configurations by purpose, symlinks express defaults and named sessions)
and automates firewall and DNS integration via composable phase scripts.

The tool follows a combinator architecture: every command is one of three
function types (terminal, combinator, batch combinator), each outputs the
next rewrite step rather than executing side effects directly, and a small
set of interpreters controls execution. The result is dry-run-by-default
behaviour for terminals and a deeply inspectable command pipeline. See
**ARCHITECTURE.md** for the full design rationale.

After installation (see **gmake install**, **INSTALL.md**), initialise a
per-user database with **vpn-switch bootstrap**, then **import**, **add**,
and **start** VPN configurations through the commands documented below.

## Concepts

**Database**
:   A per-user directory (default *$HOME/.vpn-switch/db*) holding imported
    configurations, environment overrides, active and saved sessions, and
    logs. Created once via **bootstrap**, kept in sync with the installed
    source via **sync**.

**Configuration**
:   A static *.conf* (WireGuard) or *.ovpn* (OpenVPN) file imported into
    the database. Lives under *wireguard/* or *openvpn/*, optionally grouped
    in subdirectories via **add** and **link**.

**Patch**
:   Provider configuration files are typically written for Linux — a WireGuard
    *.conf*, for example, embeds *PostUp*/*PostDown* hooks that call Linux's
    *resolvconf*. vpn-switch never runs the imported file as-is: at **start** it
    patches a session copy — stripping those Linux-specific DNS hooks (DNS is
    handled by the *dns* phase instead) and, for OpenVPN, injecting the up/down
    scripts, daemon mode and interface — so one config works on FreeBSD and
    Linux alike. Preview the result with **\<proto\> patch** *config*.

**Session**
:   A runtime instance of a started VPN — one Unix process plus its metadata
    directory under *.session/\<PID\>/* (interface, protocol, cached
    connect/disconnect scripts). Sessions can be saved by **name** for
    later resumption via **session start \<name\>**.

**Phase**
:   A composable step in the connect/disconnect script (typically *firewall*,
    *vpn*, *dns*), run in order on connect and in reverse on disconnect. Each
    phase is generated from a swappable **backend** (firewall:
    *pf*/*ipfw*/*iptables*/*none*; dns:
    *resolvconf*/*unbound*/*djbdns*/*dnsmasq*/*none*), selected per phase via a
    *phase:backend* syntax in **VPN_SWITCH_PHASES_CONNECT** /
    **VPN_SWITCH_PHASES_DISCONNECT**. Custom backends can be added from a
    template, so sophisticated setups can trigger whatever extra actions they
    need. See **vpn-switch help phases**.

**Profile**
:   A predefined set of environment defaults installed by **bootstrap**.
    *minimal* covers the essential interpreters and safe display defaults;
    *all* installs the full interpreter set for broader compatibility.

## Command syntax

The canonical form is **vpn-switch** *\<object\>* *\<verb\>* [*args*],
where *object* is **wireguard**, **openvpn**, **session**, **logs**,
**phases**, **env**, **environment**, **database**, etc.:

    vpn-switch wireguard import ~/server.conf
    vpn-switch session save work
    vpn-switch logs clean

A small set of top-level *\<verb\>*-only shortcuts is provided for the most
common operations. Each delegates to one or more object-verb forms:

    vpn-switch start <config>     ->  wireguard start | openvpn start
    vpn-switch stop               ->  wireguard stop + openvpn stop (batch)
    vpn-switch sync               ->  phases sync + env sync + version sync
    vpn-switch validate           ->  all <object> validate (batch)
    vpn-switch inspect            ->  all <object> inspect (batch)

Use the shortcut when the *object* is obvious or you want the bundled
behaviour; use the explicit *object verb* form when you need protocol- or
subsystem-specific control.

# COMMANDS

<!-- @generated commands (from vpn-switch help corpus) - do not edit by hand -->

## Without a database

The only commands that run without an existing database. Start here on a
fresh install.

**bootstrap \<path\> \<profile\>**
:   Create a new database at \<path\> with the named profile

**help [\<subcommand\>]**
:   Show top-level help, or help for a command group or topic

## Connection

Bring tunnels up and down, and keep the database in sync with the source.

**stop**
:   Stop every active VPN session (idempotent)

**sync**
:   Refresh the database from installed source templates

**version**
:   Report the database and source SHAs (drift means run 'sync')

**start [\<config\>]**
:   Connect using a config; with no argument, resume the default session or pick at random

## Sessions

A session is one started VPN instance: a process plus its .session/\<PID\>/
metadata. Save, resume, inspect and reconcile them.

**session disconnect \<PID\>**
:   Lower-level disconnect of a session by PID (no name resolution)

**session stop [\<name\>\|\<PID\>]**
:   Stop an active session; with no argument, stop all active sessions

**session list**
:   Show all active and saved sessions

**session show [\<name\>\|\<PID\>]**
:   Show a session's cached connect script and metadata

**session remove \<name\>\|\<PID\>**
:   Remove a stopped session from the database

**session start [\<name\>\|\<PID\>]**
:   Resume a saved session by replaying its cached connect script

**session save [\<name\>]**
:   Save the most-recent session under a name for later resumption

**session clean**
:   Generate cleanup commands for stale/orphaned sessions

**session refresh**
:   Reconcile interface ownership with the loaded peers

**session help**
:   Show session-management command help

**Reserved Session Keywords**
:   
    latest   - system-managed ownership pointer, updated on each start
    default  - user-managed, set via 'session save' with no name

## Protocol-specific (wireguard, openvpn)

Manage configurations, groups and tunnels for both **wireguard** and **openvpn**. The two subcommands share the same shape; substitute either where *\<proto\>* appears.

**\<proto\> start [\<category\>]**
:   Start a WireGuard tunnel; with no argument, use the default or a random config

**\<proto\> stop [\<interface\>]**
:   Stop WireGuard sessions, or one specific interface

**\<proto\> import \<file\>**
:   Import a WireGuard .conf file into the database

**\<proto\> list [\<category\>]**
:   List WireGuard configs and categories

**\<proto\> add \<category\> [\<config\> [\<alias\>]]**
:   Create a category, or link a config into one

**\<proto\> link \<alias\> \<target\>**
:   Create a protocol-level alias to a config

**\<proto\> remove \<name\>**
:   Remove a config, link or category (with safety checks)

**\<proto\> validate**
:   Check WireGuard symlink integrity in the database

**\<proto\> clean [\<category\>]**
:   Generate cleanup commands for broken links

**\<proto\> patch \<config\>**
:   Preview the patched config that would be used to connect

**\<proto\> info \<category\>**
:   Show category details, including config expiry dates

**\<proto\> dump**
:   Generate restorable shell commands for all WireGuard configs

**\<proto\> help**
:   Show WireGuard command help

## Database lifecycle

Back up, restore and refresh the database itself.

**phases sync [\<phase\>]**
:   Refresh phase scripts (firewall, vpn, dns) from source templates

**env sync**
:   Refresh environment defaults in .env/default/ from source templates

**version sync**
:   Stamp the database's .version with the source's current SHA

**dump**
:   Export the database as an executable shell script

**batch \<file\>**
:   Execute a file of vpn-switch commands line by line

**restore \<file\>**
:   Restore the database from a previously-generated dump file

## Configuration

Read and change vpn-switch environment variables.

**environment cache [on\|off\|status]**
:   Manage the cached-environment optimisation

**setenv \<VAR\> \<VALUE\>**
:   Set a vpn-switch environment variable (writes to .env/local/)

**getenv \<VAR\>**
:   Print the effective value of a variable with its source

**unsetenv \<VAR\>**
:   Remove a variable from .env/local/

**printenv [\<VAR\>]**
:   Show all effective environment variables, or just one

**environment inspect**
:   Show the environment resolution chain (default -\> local -\> cache)

## Diagnostics

Inspect current state and check health.

**status**
:   Show a brief status of the active VPN and its interfaces

**inspect**
:   Full descriptive state dump (sessions, configs, phases, system)

**logs validate**
:   Check for old log files beyond the retention period

**logs clean**
:   Generate rm commands for old logs (review, then pipe to sh)

**validate**
:   Health check: run all sub-checks; non-zero exit on critical issues

**Individual validate sub-checks**
:   
    Each check of 'validate' is also runnable alone for focused output, e.g.:
    install validate, version validate, sudo validate, network validate,
    database validate, binaries validate, permissions validate,
    environment validate, phases validate.

<!-- @end generated commands -->

# ENVIRONMENT

**VPN_SWITCH_BASE**
:   Path to the database directory. Default: *$HOME/.vpn-switch/db*. Each
    user typically has their own database.

**VPN_SWITCH_LIBDIR**
:   Path to the installed library directory (include/, template/). Set by
    the installer (sed-patched into the script). Default if unset:
    */usr/local/lib/vpn-switch*.

**VPN_SWITCH_TERMINAL_INTERPRETER**
:   How terminal functions' output is processed. Default: **cat** (display
    without executing — safe by default). Set to **sh** to auto-execute.

**VPN_SWITCH_COMBINATOR_INTERPRETER**, **VPN_SWITCH_BATCH_COMBINATOR_INTERPRETER**
:   Interpreters for combinator and batch-combinator output. Defaults
    recurse through the dispatcher; rarely need overriding.

**VPN_SWITCH_INTERPRETER_***\<function\>*
:   Per-function interpreter overrides. Highest priority in the resolution
    chain. Used for dry-run inspection (set to **cat**), logging, or
    privilege escalation (set to **sudo sh**). See **TUTORIAL_SUDO.md**.

**VPN_SWITCH_PHASES_CONNECT**, **VPN_SWITCH_PHASES_DISCONNECT**
:   Ordered list of phases to run on connect/disconnect. Defaults:
    "firewall vpn dns" and "dns vpn firewall" respectively. Set to omit
    phases (e.g. "vpn" alone skips firewall and DNS integration).

**VPN_SWITCH_INTERFACE_wireguard**, **VPN_SWITCH_INTERFACE_openvpn**
:   Interface names for each protocol. Defaults: **wg0** and **tun0**.

**VPN_SWITCH_RETENTION_DAYS_LOG**, **VPN_SWITCH_RETENTION_DAYS_TRACE**
:   Days to retain log/trace files. Default: 1. Set to 0 to disable logging.
    Higher values useful during debugging.

**VPN_SWITCH_FUNCTION_OVERRIDE**
:   Path to a shell file sourced after core modules. Allows replacing any
    function (test mocks, local customisations). See **ARCHITECTURE.md**.

# FILES

**/usr/local/bin/vpn-switch**
:   The main script (location varies with install **PREFIX**).

**/usr/local/sbin/{wg,ovpn}-resolvconf-{up,down}**
:   DNS helper scripts (FreeBSD-specific; path hardcoded by phase scripts).

**/usr/local/lib/vpn-switch/include/\*.sh**
:   Shell module library (sourced at runtime via *VPN_SWITCH_LIBDIR*).

**/usr/local/lib/vpn-switch/template/**
:   Templates: environment defaults, phase scripts, platform variables,
    *VERSION* marker.

**/usr/local/share/doc/vpn-switch/**
:   Installed documentation (*README.md*, *LICENSE*, *QUICK_REFERENCE.md*).

**$VPN_SWITCH_BASE/**
:   Per-user database (sessions, configurations, environment overrides, logs).
    Default: *$HOME/.vpn-switch/db*.

**$VPN_SWITCH_BASE/.env/local/**
:   Per-user environment overrides. Highest priority. Edit via **setenv**
    rather than directly.

**$VPN_SWITCH_BASE/.session/\<PID\>/**
:   Active VPN session metadata (interface, protocol, original config,
    cached connect/disconnect scripts).

**$VPN_SWITCH_BASE/session/\<name\>**
:   Symlinks naming saved sessions for resumption.

**$VPN_SWITCH_BASE/.log/YYYY-MM-DD/**
:   Per-day log and trace files. Subject to retention via the
    *RETENTION_DAYS_** variables.

# EXIT STATUS

**0**
:   Success, no findings.

**non-zero**
:   For **validate**: critical findings detected (count of issues, capped).
    For other commands: command-specific failure.

# EXAMPLES

Bootstrap a per-user database and verify the install:

    vpn-switch bootstrap ~/.vpn-switch/db minimal
    vpn-switch validate

Import a config, group it, and connect:

    vpn-switch wireguard import ~/Downloads/wg-CH-12.conf
    vpn-switch wireguard add privacy wg-CH-12 switzerland
    vpn-switch start switzerland

Save the live session by name, then resume later:

    vpn-switch session save work
    vpn-switch stop
    vpn-switch session start work

Inspect what a command would do, without executing:

    vpn-switch setenv VPN_SWITCH_INTERPRETER_start cat
    vpn-switch start switzerland
    # Output: the next-rewrite-step command, not its result.

After upgrading vpn-switch source, refresh the database:

    sudo gmake install
    vpn-switch sync
    vpn-switch version

# SEE ALSO

**INSTALL.md**(7), **TUTORIAL_QUICKSTART.md**(7),
**TUTORIAL_SESSIONS.md**(7), **TUTORIAL_SUDO.md**(7),
**TUTORIAL_MIGRATION.md**(7), **TUTORIAL_TROUBLESHOOTING.md**(7),
**ARCHITECTURE.md**(7), **DEBUGGING_GUIDE.md**(7)

**wg-quick**(8), **openvpn**(8), **pf.conf**(5), **resolvconf**(8)

# REPOSITORY

Source, issues and releases: <https://github.com/enk-ode/vpn-switch>

# LICENSE

BSD 2-Clause License. See **LICENSE** in the source distribution.

# AUTHOR

Dr. Johannes Brügmann, with assistance from Claude (Anthropic), 2024–2026.
