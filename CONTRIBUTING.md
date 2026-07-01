# Contributing

vpn-switch is a personal project by Dr. Johannes Brügmann, shared in the hope
that it is useful and developed primarily to fit the author's own needs. That
shapes how contributions are handled — please read this before opening an
issue or a pull request.

## Issues

Bug reports and questions are welcome via GitHub issues. Please include:

- your OS and version (FreeBSD release, or Linux distribution),
- the output of `vpn-switch validate`, and `vpn-switch inspect` if relevant,
- the exact command you ran, and what you expected versus what happened.

Start with [docs/TUTORIAL_TROUBLESHOOTING.md](docs/TUTORIAL_TROUBLESHOOTING.md):
most problems are environment-related, and `vpn-switch validate` usually points
straight at them.

## Pull requests

PRs are read and appreciated, but **not guaranteed to be merged**. This is a
personal project with a deliberate, opinionated design; a change that doesn't
fit that design won't land, however well-made. For anything non-trivial, please
open an issue to discuss it first so you don't invest effort in vain.

If you do send a PR:

- Keep the code **pure POSIX `/bin/sh`** — no bashisms.
- Run `gmake check` (syntax), `gmake shellcheck`, and the relevant tests before
  submitting; see [COMMIT_CHECKLIST.md](COMMIT_CHECKLIST.md) for the definition
  of done.
- Follow the combinator conventions and naming rules in
  [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md), and match the surrounding style.
- User-facing commands carry an in-source `#@help` doc-block; see
  [docs/HELP_TEMPLATE_SPEC.md](docs/HELP_TEMPLATE_SPEC.md). The architecture
  tests fail if a command is missing or malformed.

## Code of conduct

There is none, by design. This is one individual's project, not a
thousand-developer community — interaction here runs on ordinary courtesy and
applicable law, nothing more.

## Licensing

By contributing, you agree that your contribution is licensed under the
project's terms: the [BSD 2-Clause license](LICENSE).
