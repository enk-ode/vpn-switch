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

**Pair**
:   How a database moves to another machine: **export** *strategy* (redacted | full | minimized) writes a *dump* (the
    database as a script of its own commands) and a *bundle* (the files the
    dump names: configurations, keys, receipts) that travel apart. The bundle
    carries an attested *MANIFEST*, the dump carries a *seal* naming the
    bundle, and one OpenPGP key (**openpgp add**, pinned as
    *VPN_SWITCH_ARCHIVE_ATTEST_KEY*) signs both. **import** checks the pinned
    signer, the seal and the MANIFEST before anything lands, files a receipt
    (**provenance list**) and refuses a serial below the signer's last one
    (no downgrade). A dump without a signature by the pinned key is refused
    by **restore** too.

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

**complete [\<words\>]**
:   Print completion candidates for a partially typed command line (bash-completion back-end)

## Connection

Bring tunnels up and down, and keep the database in sync with the source.

**sync**
:   Refresh the database from installed source templates: the layout (database init), the phases, the environment defaults, the version stamp

**version**
:   Report the database and source SHAs (drift means run 'sync')

**stop**
:   Stop every active VPN session (idempotent)

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

**session switch \<name\>\|\<PID\> [\<from\>]**
:   Stop active sessions (all, or only \<from\>), then resume the target session

**session save [\<name\>]**
:   Save the most-recent session under a name for later resumption

**session clean**
:   Remove stale session symlinks and orphaned sessions

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

Back up, restore and refresh the database itself; export and import the
signed pair (dump + bundle) that moves it to another machine.

**export \<strategy\> \<dump\> \<bundle\>**
:   Write the two artifacts that travel apart, bound and signed: the DUMP to a path of your choosing (commit it), the BUNDLE to its store. The strategy is the first word: redacted (no credentials, for sending) \| full (own machines, disaster recovery) \| minimized (rescue: the configurations and the key, no receipts). Every strategy describes the database completely and governs the payload only

**restore \<dump\> [\<base\>]**
:   Replay a dump into the current database -- only a dump signed by the PINNED attest key, at or above the lineage's serial; \<base\> binds where its base elements come from (default: this database). The dump's format (its '# Version:' header) selects the restore that speaks it: 'restore v\<format\> \<dump\> \<base\>', which reads the serial, the pinned key, the signer and the signer's floor once and hands them down -- into a database that does not yet hold the records (an identical import is refused as 'already exists', the rest replays)

**filter \<collection\> \<filtered\>**
:   Apply the default strategy to a collection (delegates: default -\> redacted)

**filter redacted \<collection\> \<filtered\>**
:   Drop what is a secret: the VPN configurations themselves (wireguard/*.conf, openvpn/*.ovpn carry keys and credentials) -- and always the operational directories. The description still travels complete (categories, links, sessions, keys, receipts); what a bug report or a second machine's skeleton needs, without the credentials. The collection is readable: rewrite to 'filter write redacted ...', else an error line

**filter full \<collection\> \<filtered\>**
:   Keep everything except the operational directories: the configurations with their keys travel. For one's own machines (a rescue medium, a second host), never for sending to strangers. The collection is readable: rewrite to 'filter write full ...', else an error line

**filter minimized \<collection\> \<filtered\>**
:   Keep what connecting needs only: the configurations (wireguard/, openvpn/) and the attest key; no receipts. What a rescue system needs to come online, nothing of the lineage. The collection is readable: rewrite to 'filter write minimized ...', else an error line

**bundle \<collection\> \<archive\>**
:   Pack the collected files with VPN_SWITCH_ARCHIVER: the collection is readable, the archiver set, the archive path absolute, the manifest pair (MANIFEST + MANIFEST.asc) lies beside the collection -- an archive that carries no tamper detection is not an artifact this tool produces -- and the collection lives inside the database (the pair is packed by its database-relative path); then 'bundle pack'

**seal \<dump\> \<bundle\>**
:   Append the bundle's sha256 and size to the dump as its seal line ('# Bundle: sha256=... bytes=...'): both files readable, the dump not yet sealed (a dump names ONE bundle) and not yet attested (sealing after signing would invalidate the signature); then 'seal write'. Attest the dump AFTER sealing so one signature covers both

**seal verify \<dump\> \<bundle\>**
:   Check that the dump's seal line names THIS bundle (sha256 and size): both files readable, the dump sealed, the seal matching -- a mismatch fails the command before anything is extracted

**incoming clear \<directory\>**
:   Empty one scratch directory under $VPN_SWITCH_ROOT/incoming/ -- import's own unpacking area, cleared before each extract so a re-import never trips over the last one. The path lies below incoming/ and carries no '..': rewrite to 'incoming remove', else an error line (only import's own scratch is cleared here, never a database)

**extract \<archive\> \<destination\>**
:   Unpack an archive into a scratch directory with VPN_SWITCH_EXTRACTOR: the archive readable, the extractor set, the destination absolute and empty (or not yet there); then 'extract unpack'

**import \<dump\> \<bundle\>**
:   Replay an exported pair into the current database, checked end to end BEFORE anything lands, cheapest first, every detail read ONCE on the way in and handed down: the dump's serial, the pinned signer, the dump's signature (gpg once), the signer's floor, this database's serial; then 'import \<dump\> \<bundle\> \<serial\> \<key\> \<fpr\> \<floor\> \<cur\>' -- the seal (this bundle is the one the dump names), the bundle unpacked into import's own scratch under incoming/, its MANIFEST (pinned signer, every hash), the receipt filed BEFORE the replay (the replay runs keep-going, so a redacted pair's withheld elements cost no receipt), the replay. ONLY into an EMPTY database (a fresh bootstrap with the attest key pinned): on a database that already holds the configs the replay reports them as existing and goes on

**import bootstrap \<dump\> \<bundle\>**
:   Import into a database that is not there (no .env layer under VPN_SWITCH_BASE): the dump is readable and signed, names its profile ('# Profile:' in its header) and carries the openpgp record of its signer ('openpgp add \<name\> \<keyid\> [\<gnupghome\>]'); the signature is verified against the keyring that record names -- an absolute gnupghome that exists here, else YOUR default keyring (a gnupghome inside the database travels in the bundle and serves after the import, not before); then 'import bootstrap \<dump\> \<bundle\> \<profile\> \<record\> \<fingerprint\> [\<gnupghome\>]'. The trust is the keyring's: the first signer a fresh database meets is one whose public key you hold

**attest \<file\> \<key\>**
:   Sign a file with a registered openpgp key (armored detached signature -\> \<file\>.asc): the file exists, the record exists and carries its keyid; then 'attest sign'

**attest verify \<file\> \<key\>**
:   Check a detached signature at generation time -- signed by the PINNED key, key neither expired nor revoked: the file exists, the record exists and is complete; then 'attest signer pinned' (a finding fails the command)

**dump**
:   Export the database as an executable shell script: the export serial read here, then 'dump \<serial\>' -- the header (version, date, serial), the environment prologue, the keys, every protocol, the sessions, the receipts, the environment epilogue. Import lines reference base elements against "$VPN_SWITCH_ARCHIVE_BASE"; 'export' pairs the dump with the bundle that carries them

**batch \<file\>**
:   Execute a file of vpn-switch commands line by line

**env sync**
:   Refresh environment defaults in .env/default/ from source templates

**version sync**
:   Stamp the database's .version with the source's current SHA

**manifest \<collection\> \<manifest\>**
:   Hash every entry of a collection into a manifest, (LC_ALL=C-sorted 'path sha256=hash', symlinks as 'path symlink=target'): the collection is readable, the manifest is named MANIFEST (import looks for it by name, next to the collection), every entry is hashable; then 'manifest write' -- everything hashed at generation, the emission is one concrete heredoc write

**manifest attest \<collection\> \<key\>**
:   Write the manifest for a collection and sign it, side by side with the collection: manifest + attest

**manifest verify \<manifest\> \<base\> \<key\>**
:   Verify a manifest, both judgments at generation time: the signature (attest verify: signed by the PINNED key, key neither expired nor revoked) and the tree (manifest match: every listed entry present and identical) -- a finding fails the batch before restore replays anything. The key is the RECEIVER's openpgp record naming the signer it expects

**manifest match \<manifest\> \<base\>**
:   Does the tree under \<base\> match the manifest? The manifest is readable and lists entries, the base exists; then 'manifest tree matches' -- every listed file hashes identically, every listed symlink points where recorded (MISSING, CHANGED, RETARGETED fail). Files present but unlisted are not findings: the base is an extraction directory

**phases sync [\<phase\>]**
:   Refresh phase scripts (firewall, vpn, dns) from source templates

**provenance serial**
:   Advance the export serial by one: the number read here, then 'provenance serial \<current\>' -- export does this LAST, once the pair is attested: the dump header already carries current+1, so a failed export leaves the number to the next attempt (serials were once lost to a pinentry that could not open)

**provenance add \<dump\> \<bundle\>**
:   File the receipt of an admitted import. Every detail read ONCE on the way in and handed down -- the dump's serial, the pinned key, the signer (gpg once), the signer's floor, this database's serial -- then 'provenance add \<dump\> \<bundle\> \<serial\> \<key\> \<fpr\> \<floor\> \<cur\>': the bundle readable or '-', the serial not a downgrade, 'provenance receipt' (files it, or says it is filed, or refuses a differing one) and the export serial raised to the imported one

**provenance import \<id\> \<absfile\>**
:   Copy ONE file of a receipt record from another database (dump/restore base element; the record directory is created on first file): the id is a record name, the source exists; then 'provenance import place'

**provenance dump**
:   Emit the provenance portion of a database dump: one 'provenance import' line per receipt file (cat-pinned: dump TEXT, replayed by restore); none is a comment line

**provenance collect**
:   Text terminal: the receipt record files that belong into an archive, by their real path against "$VPN_SWITCH_ARCHIVE_BASE"

**provenance list**
:   The export serial and every receipt: the serial read here, then 'provenance list \<serial\>' renders

## Keys

The attest key: an openpgp record names the GnuPG key that signs what
this database exports and the signer a receiver expects (pinned).

**openpgp add \<name\> \<keyid\> [\<gnupghome\>]**
:   Register a GnuPG attest key; gnupghome for a keyring living elsewhere: the name is a record name, the keyid is hex; then 'openpgp record'

**openpgp dump**
:   Emit the openpgp portion of a database dump: one 'openpgp add' replay line per registered key, in the arity of the record (cat-pinned: dump TEXT, replayed by 'restore'), plus one 'openpgp import' per extra file; none is a comment line

**openpgp import \<name\> \<absfile\>**
:   Copy ONE extra file into the key record -- dump/restore base element (the schema files travel as the 'openpgp add' replay): rewrite to 'key import openpgp \<name\> \<absfile\>'

**openpgp collect**
:   List the files of the openpgp key records that belong into an archive -- public material only; private key material stays a path promise into the world: one 'openpgp collect \<key\>' per record, none is a comment line

## Configuration

Read and change vpn-switch environment variables.

**environment refresh**
:   The environment as a new call finds it: at generation time VPN_SWITCH_CACHE_ENV_ARGS and VPN_SWITCH_CONTEXT_BOOTSTRAPPED are unset and the cache file removed; then 'environment cache off' and 'environment cache on' -- the cache rebuilt from .env/, the calls after it load it afresh. A dump places it after the setenv lines of its prologue and of its epilogue

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

**helpenv [\<name\> [\<location\>]]**
:   Show env-var documentation (value + docs); with no argument, list all

**setintp \<fn\> \<value\>**
:   Set an interpreter (shortcut for setenv of the resolved interpreter var)

**getintp \<fn\>**
:   Show an interpreter (shortcut for getenv of the resolved interpreter var)

**helpintp \<fn\> [\<location\>]**
:   Show docs for an interpreter variable (class default or per-function)

**environment inspect**
:   Show the environment resolution chain (default -\> local -\> cache)

## Diagnostics

Inspect current state and check health.

**status**
:   Show a brief status of the active VPN and its interfaces

**inspect**
:   Full descriptive state dump (sessions, configs, phases, system)

**openpgp prerequisites**
:   Act terminal: the runtime check of the GnuPG attest toolchain. No card requirement here: gpg is card-agnostic (a keyring stub routes to the card transparently), and a pure-keyring key needs no card at all

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

**VPN_SWITCH_KEEPALIVE_wireguard**
:   PersistentKeepalive (seconds) injected into patched WireGuard configs
    that do not set one themselves; an explicit value in the config always
    wins. Keeps tunnels alive across NAT rebinds and link flaps.
    Default: **25**. Set to **0** to disable injection.

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
