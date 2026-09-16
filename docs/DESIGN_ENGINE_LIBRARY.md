# Design: the combinator engine as a standalone library

Status: DRAFT for review (JB request 2026-08-30). Extract the engine —
today inlined in `vpn-switch.sh` and copied into elvboot's
`include/engine.sh` — into its OWN repository, separately publishable.
vpn-switch and elvboot consume it as a BUILD dependency. The Haskell/FP
domain model (`FP_SIGNATURES.md`) moves there: it describes the engine,
not the applications.

## 1. What the library contains

- The engine core: dispatch (`to_function_call`, outside-in),
  `process_arguments`/`run_env`/exit-code combination, interpreter
  resolution (arity-specific -> agnostic -> class default),
  `env_resolve_file` cascade, batch machinery, trace/log layer,
  `generate_error`, `install_layout`, `resolve_item`, the dump/restore
  helpers (`rebase_db_path`, `backend_dump_extra_lines`).
- The test FRAMEWORK (today duplicated per suite): sandbox setup,
  pass/fail/summary, `--maxprocs` parallel runner.
- `FP_SIGNATURES.md` (the model) and the engine's own docs
  (DEBUGGING_GUIDE core, EXIT_CODE_DESIGN, COMMAND_INSPECTION).
- The engine's own architecture test suite (the generic conformance
  parts that today live per-application).

## 2. Naming: ONE command names the whole engine

The source is prefix-neutral: a single placeholder (working notation
`@PREFIX@` for variables, `@name@` for the command) everywhere the
engine says ELEBAKE_/VPN_SWITCH_ today. The library ships

```sh
engine instantiate <name>          # e.g.: engine instantiate elvboot
```

which renders the neutral source into a concrete `engine.sh` (and the
matching test-framework include) with `<NAME>_`-variables and
`<name>`-strings. Databases and environment variables carry that
prefix; `vpn-switch` and `elvboot` are simply two instantiations.
(This is exactly the operation the elvboot extraction performed by
hand — mechanized and repeatable.)

## 3. Consumption as build dependency

Consumer repository keeps NO engine copy in git; its Makefile gains

```make
ENGINE_DIR?= ../combinator-engine        # or a pinned checkout/port
include/engine.sh: ${ENGINE_DIR}/engine.in
	${ENGINE_DIR}/instantiate.sh ${NAME} > ${.TARGET}
```

plus a pinned engine VERSION (tag) recorded in the consumer, checked at
instantiation (fail early on mismatch). FreeBSD-port shape later:
`BUILD_DEPENDS= combinator-engine>=X`.

## 4. Migration path (this replaces the postponed back-port)

1. vpn-switch performs its own extraction (engine out of
   `vpn-switch.sh` into `include/engine.sh`) — mechanical, suites as
   the net.
2. Diff the two engines (they have diverged: elvboot carries the
   outside-in dispatcher, the restore pin, the dump helpers; vpn-switch
   carries pieces elvboot dropped). Reconcile into ONE neutral source —
   THIS is where the postponed dispatcher/rename back-port happens,
   once, deliberately, behind both test suites.
3. Move the neutral source + framework + FP_SIGNATURES into the new
   repository; both consumers switch to instantiation.
4. Multi-word command renames in vpn-switch ride on step 2's dispatcher
   (application-level renames stay application decisions).

## 5. Open review questions

1. Name of the library/repository (drives the default install path and
   the port name).
2. Placeholder mechanics: textual rendering at build time (proposed,
   zero runtime cost) vs. runtime indirection (rejected: eval noise,
   slower, harder to read).
3. Does the neutral engine keep a tiny self-test (`engine instantiate
   selftest && run`) so the library is testable WITHOUT a consumer?
4. License/visibility of the engine repo (it precedes any vpn-switch
   publication content-wise).
5. Version pinning: git tag in the consumer Makefile vs. vendored
   tarball under versionctl.
