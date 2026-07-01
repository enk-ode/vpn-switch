# Security Policy

vpn-switch generates and runs shell commands that configure VPNs, firewalls,
and DNS — frequently with elevated privileges — so security reports are taken
seriously.

## Reporting a vulnerability

Please report vulnerabilities **privately**. Do not open a public issue for a
security problem.

Preferred channel: GitHub's private vulnerability reporting — the **Security**
tab → **Report a vulnerability** on
<https://github.com/enk-ode/vpn-switch>. This keeps the report
private until a fix is available.

Please include enough detail to reproduce: the affected command(s), your OS and
version, the relevant configuration shape (with keys and credentials redacted),
and the impact you observed.

## Areas of particular interest

- Command or argument injection via configuration filenames, aliases, group
  names, or environment values.
- Privilege boundaries in the connect / disconnect phase scripts.
- Leakage of keys or credentials into logs, traces, or generated scripts.

## Supported versions

Before 1.0, only the latest `main` is supported. From 1.0 onward, security
fixes target the most recent released version.
