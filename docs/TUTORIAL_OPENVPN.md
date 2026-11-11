# OpenVPN Tutorial: the credentials file

This tutorial covers OpenVPN providers that authenticate with a username and
a password: how vpn-switch feeds them to `openvpn` without a prompt, where the
secret lives, what happens when the provider reissues it, and what travels
with the database.

**Prerequisites:** Complete [TUTORIAL_QUICKSTART.md](TUTORIAL_QUICKSTART.md)
first; the OpenVPN binary installed (`openvpn` package).

## What OpenVPN asks for

A provider's `.ovpn` file usually carries the line

```
auth-user-pass
```

Bare like this, `openvpn` stops at start and prompts for a username and a
password on the terminal. That works once, at a shell; it does not work for
an rc service, a timer, or `session start` from a script, which have no
terminal to answer on.

The same directive takes a file:

```
auth-user-pass /path/to/credentials.txt
```

vpn-switch makes that rewrite for you at connect time, from one pinned
variable.

## Step 1: Write the file

Two lines, username first, password second, nothing else. Keep it outside
the database and readable only by you:

```console
$ printf '%s\n' 'alice+pmp' 'the-vpn-password' > ~/.vpn-switch/credentials.txt
$ chmod 0600 ~/.vpn-switch/credentials.txt
```

The username and password are what the provider issues **for OpenVPN**. They
are usually not your account password: Proton, for one, shows a separate
OpenVPN/IKEv2 username and password on the account page, and lets you reset
them independently. Suffixes such as `+pmp` or `+f1` are provider feature
flags appended to the username; copy the username exactly as the provider
shows it.

## Step 2: Pin the path

```console
$ vpn-switch setenv VPN_SWITCH_CREDENTIALS_openvpn /home/alice/.vpn-switch/credentials.txt
# Set VPN_SWITCH_CREDENTIALS_openvpn (effective next command)
```

An absolute path. The pin lives in the database's `.env/local/` like every
other `setenv`; `vpn-switch helpenv VPN_SWITCH_CREDENTIALS_openvpn` shows
its documentation and current value.

## Step 3: Import and preview

```console
$ vpn-switch openvpn import ~/Downloads/provider-ch-12.ovpn
# Imported: openvpn/provider-ch-12.ovpn
$ vpn-switch openvpn patch provider-ch-12 | grep auth-user-pass
auth-user-pass /home/alice/.vpn-switch/credentials.txt
```

`openvpn patch` prints the configuration exactly as `openvpn start` will use
it. Three cases:

- a bare `auth-user-pass` line becomes `auth-user-pass <the pinned file>`;
- a line that already names a file is left alone (the config's choice wins);
- with the variable unset, the line stays bare and `openvpn` prompts.

## Step 4: Connect

```console
$ vpn-switch openvpn start provider-ch-12
```

No prompt. The session directory (`.session/<pid>/`) holds the patched
configuration, which names the file; the secret itself stays in the file.

## When the provider reissues the credentials

Resetting the OpenVPN credentials at the provider (after a leak, as part of
a password rotation, or because the provider forces it) invalidates the old
pair at the server. Nothing in vpn-switch changes: rewrite the two lines,
then reconnect.

```console
$ printf '%s\n' 'alice+pmp' 'the-new-vpn-password' > ~/.vpn-switch/credentials.txt
$ vpn-switch stop
$ vpn-switch session start work
```

`openvpn` reads the file when it starts and keeps the pair in memory; a
running tunnel is not disturbed by the rewrite, the next start uses the new
pair. Saved sessions keep only the path, so they need no refresh.

Changing the **account** password at the provider does not touch the OpenVPN
pair unless you reset that too; check the provider's account page after a
rotation rather than assuming either way.

## What travels, what stays

`export` never carries the credentials file: it is outside the database by
design, and a `redacted` export leaves even the `.ovpn` files at home. The
dump does carry the pin, as a `setenv` line, whatever the strategy: it
names a path on the machine it came from. On a second machine, write the
file at that path (or pin a new one) before the first `openvpn start`.

## Troubleshooting

- **`AUTH_FAILED` in the log** -- the file is wrong: two lines, no blank
  line first, no trailing spaces, the username with its suffix exactly as the
  provider shows it, the OpenVPN password (not the account password). Check
  with `cat -A` for stray characters.
- **A prompt appears, or a service hangs at start** -- the variable is not
  pinned where the service runs: `vpn-switch getenv
  VPN_SWITCH_CREDENTIALS_openvpn` in that user's database, and
  `vpn-switch openvpn patch <config>` to see the line `openvpn` would get.
- **`openvpn` cannot read the file** -- the file must be readable by the
  user that starts `openvpn`, usually root via the connect interpreter
  (`openvpn` reads it before it drops privileges to
  `VPN_SWITCH_USER_openvpn`, if you set one). Mode 0600 and the right
  owner, not 0644.

## See also

- `vpn-switch helpenv VPN_SWITCH_CREDENTIALS_openvpn`
- [TUTORIAL_SESSIONS.md](TUTORIAL_SESSIONS.md) -- what a session keeps
- [TUTORIAL_MIGRATION.md](TUTORIAL_MIGRATION.md) -- what an export carries
- [TUTORIAL_SUDO.md](TUTORIAL_SUDO.md) -- the connect interpreter and privileges
