# Exit Code Design - Consolidated Documentation

**Status:** Partially implemented — encoding & propagation are live; human-readable
decoding is not. See "Implementation Status" below.
**Date:** Originally 2025-11-15, consolidated 2025-12-19; reconciled with the code 2026-06-20

---

## Implementation Status (reconciled 2026-06-20)

The **encoding + propagation** half of this design is implemented and in use; the
**decoding/reporting** half is not.

**Implemented** (`vpn-switch.sh` unless noted):

- `produce_with_exit()` — runs the producer (`dispatch`) with stdin closed
  (`</dev/null`, see §5) and captures its exit code.
- `combine_exit_codes(init_bits, producer_exit, consumer_exit)` — folds the
  producer|consumer pair, understands batch codes (≥128), and updates
  `VPN_SWITCH_CONTEXT_EXIT_BITS`. The regular (0–127) case packs one level as
  `(p<<1)|c`; EXIT_BITS carries the readable structure (`p.c`, or `children . c`).
- Batch storage: the live writer is **`_batch2()` in `include/database.sh`**,
  which truncates `.tmp/batch-exits/<id>` and appends one line per child in the
  `EXIT_CODE|function args|BATCH_REF` format of §4 (what `combine_exit_codes`
  reads back). `get_batch_id()` allocates ids via a circular **mod-64** counter
  (`.tmp/batch-counter`).
- Propagation through the `VPN_SWITCH_CONTEXT_EXIT_BITS` environment variable
  (default `0`), carried across the `env -` isolation boundary.

**Not implemented:**

- `decode_exit_code()` / `decode_batch_exit()` / `decode_nested_exit()` and the
  `vpn-switch debug-exit <code>` command (Phase 3 below). Codes propagate and
  reach the shell, but there is no built-in human-readable decoder yet.

**Defined but currently unused (drift to clean up):**

- `store_batch_exits()` and `free_batch_id()` exist but are *not* on the live
  batch path — `_batch2` writes the file directly, and batch files are
  **retained for diagnostics** rather than freed.

**Where the design differs from the code:**

- Batch-counter overflow (§9) is a plain circular `mod 64`, **not** the
  "check active files / error" scheme described there.

---

## Overview

This document consolidates the exit code propagation design for vpn-switch's combinator architecture. The goal is to capture and propagate exit codes through nested pipelines and batch combinators.

---

## 1. Problem Statement

Functions in the combinator architecture output commands (declarative), but when those functions fail during command generation, there's no mechanism to propagate the failure through the pipeline to the user.

**Example:**
```bash
__import1 file.conf   # Combinator function
  → outputs: "$VPN_SWITCH_CONTEXT_SCRIPT" wireguard import file.conf
  → returns: 1 (failure)

Current behavior: Exit code is lost
Desired behavior: Propagate exit code to user
```

---

## 2. Exit Code Encoding Scheme

### Range Allocation

```
0           Complete success (all producers and consumers succeeded)
1-127       Single/nested command failures (bit-pattern encoding)
128-255     Batch combinator failures (128 + batch_id)
```

### Bit Pattern Encoding (Exit 1-127)

Each nesting level uses 2 bits to encode producer/consumer state:

```
8-bit exit code structure:

Level 1 (innermost):   Bit 0: consumer, Bit 1: producer
Level 2:               Bit 2: consumer, Bit 3: producer
Level 3:               Bit 4: consumer, Bit 5: producer
Level 4 (outermost):   Bit 6: consumer, Bit 7: producer

Per-bit values: 0 = success, 1 = failed
```

**State encoding per level:**
```
00 = both succeeded
01 = consumer failed, producer succeeded
10 = producer failed, consumer succeeded
11 = both failed
```

**Formula:**
```
exit = (p << 1) | c

Where p, c ∈ {0, 1}:
  (0 . 0) = 0b00 = 0  (both succeeded)
  (0 . 1) = 0b01 = 1  (consumer failed)
  (1 . 0) = 0b10 = 2  (producer failed)
  (1 . 1) = 0b11 = 3  (both failed)
```

### Batch Combinator Encoding (Exit 128-255)

```
exit = 128 + (p << 6) + batch_id

Where:
  Bit 7:    Always 1 (128 = batch marker)
  Bit 6:    Producer exit (0 or 1)
  Bits 0-5: batch_id (0-63)

Range breakdown:
  128-191: p=0, batch_id 0-63 (generator succeeded)
  192-255: p=1, batch_id 0-63 (generator failed)
```

---

## 3. Environment Variable Propagation

Exit codes propagate through the execution tree via `VPN_SWITCH_CONTEXT_EXIT_BITS`.

**Key principle:** Batch children execute independently with same inherited EXIT_BITS. Results aggregate in batch file. Parent constructs hierarchical structure after batch completes.

### Propagation Flow

```bash
process_arguments() {
    # Read inherited exit bits from environment
    local init_bits="${VPN_SWITCH_CONTEXT_EXIT_BITS:-}"

    # Run producer (dispatch in same process)
    dispatch "$@" > "$temp_file"
    local p_exit=$?

    # Update EXIT_BITS BEFORE running interpreter
    if [ -z "$init_bits" ]; then
        VPN_SWITCH_CONTEXT_EXIT_BITS="$p_exit"
    else
        VPN_SWITCH_CONTEXT_EXIT_BITS="$init_bits,$p_exit"
    fi
    export VPN_SWITCH_CONTEXT_EXIT_BITS

    # Run consumer (interpreter in isolated environment)
    extract_line1 < "$temp_file" | run_env -- $interpreter
    local c_exit=$?

    # Combine exit codes
    return $(combine_exit_codes "$init_bits" "$p_exit" "$c_exit")
}
```

### Example: `vpn-switch inspect`

```
Level 0: User invokes vpn-switch
  EXIT_BITS="" (not set)

Level 1: ___inspect0 (batch combinator)
  P1 reads: EXIT_BITS="" → init_bits=""
  P1 exits: 130 (batch_id=2)
  C1 gets: EXIT_BITS="130"
  C1 spawns 10 subprocesses with EXIT_BITS="130"

Level 2a: prologue inspect (terminal)
  P2 reads: EXIT_BITS="130" → init_bits="130"
  P2 exits: 0
  C2 gets: EXIT_BITS="130,0"
  Final: combine_exit("130", 0, 0)

Level 2b: wireguard inspect (batch combinator)
  P5 reads: EXIT_BITS="130" → init_bits="130"
  P5 exits: 131 (batch_id=3)
  C5 gets: EXIT_BITS="130,131"
  C5 spawns 3 subprocesses with EXIT_BITS="130,131"

Level 3: wireguard list (terminal)
  P6 reads: EXIT_BITS="130,131" → init_bits="130,131"
  P6 exits: 0
  C6 gets: EXIT_BITS="130,131,0"
```

---

## 4. Batch File Storage

**Location:** `$VPN_SWITCH_BASE/.tmp/batch-exits/$batch_id`

**Format:** One line per command executed
```
EXIT_CODE|function args|BATCH_REF
```

**Example batch file:**
```
0|_prologue_inspect0|
130|___wireguard_inspect0|2
0|_session_inspect0|
```

**Nested batch file (batch_id=2):**
```
0|_wireguard_list0|
2|_wireguard_validate0|
0|_wireguard_enumerate0|
```

---

## 5. Critical Implementation Detail: Stdin Handling

### The Problem

When a combinator delegates to another command via `exec`, file descriptors are inherited. If anything in dispatch accidentally reads stdin, it blocks on the wrong pipe → deadlock.

### The Solution

```bash
produce_with_exit() {
    set +e
    dispatch </dev/null > "$tmp_stdout" 2> "$tmp_stderr"
    local dispatch_exit=$?
    set -e
    # ...
}
```

**Why `</dev/null` works:**
- Breaks stdin inheritance from nested pipelines
- Batch combinators don't need user stdin (they read from pipeline stdin)
- If anything tries to read → gets immediate EOF → no blocking

---

## 6. Decoding Algorithm

```bash
decode_exit_code() {
    local exit_code="$1"

    if [ "$exit_code" -eq 0 ]; then
        echo "Success: All operations completed successfully"
        return 0
    fi

    if [ "$exit_code" -ge 128 ]; then
        # Batch combinator
        local batch_id=$((exit_code - 128))
        decode_batch_exit "$batch_id"
    else
        # Single/nested command
        decode_nested_exit "$exit_code"
    fi
}

decode_nested_exit() {
    local exit_code="$1"
    local level=1

    echo "Nested command failure (exit $exit_code = 0b$(printf '%08b' $exit_code))"

    while [ "$exit_code" -gt 0 ] && [ "$level" -le 4 ]; do
        local consumer_bit=$((exit_code & 0x01))
        local producer_bit=$(((exit_code & 0x02) >> 1))

        printf "  Level %d: " "$level"

        if [ "$producer_bit" -eq 1 ]; then
            echo "Producer failed"
        elif [ "$consumer_bit" -eq 1 ]; then
            echo "Consumer failed"
        else
            echo "Both succeeded"
        fi

        exit_code=$((exit_code >> 2))
        level=$((level + 1))
    done
}
```

---

## 7. Implementation Checklist

> Marks reconciled with the code 2026-06-20: `[x]` done, `[~]` partial/with caveat,
> `[ ]` not done.

### Phase 1: Basic Infrastructure
- [x] Create `.tmp/batch-exits/` directory structure (created by `init`)
- [x] Implement `get_batch_id()` (circular **mod-64** counter; not the active-file check of §9)
- [~] `store_batch_exits()` exists **but is unused** — the live writer is `_batch2()`
- [~] `free_batch_id()` exists **but is unused** — batch files are retained for diagnostics

### Phase 2: Encoding
- [x] `produce_with_exit()` captures/encodes producer failures
- [x] Consumer failures encoded (`combine_exit_codes` consumer side)
- [x] Batch interpreters use the batch_id scheme (`_batch2` + codes ≥128)
- [~] Nested encoding: one level packs `(p<<1)|c`; deeper nesting is tracked in the
      `VPN_SWITCH_CONTEXT_EXIT_BITS` string, not byte-shifted into a single code

### Phase 3: Decoding — NOT IMPLEMENTED
- [ ] `decode_exit_code()`
- [ ] `decode_batch_exit()`
- [ ] User command `vpn-switch debug-exit <code>`

### Phase 4: Testing
- [x] Batch error propagation + keep-going covered by the architecture/integration
      suites (e.g. `test_batch_error_propagation`, `test_recursive_batch_error_propagation`,
      `test_all_batch_keep_going_precise`)
- [ ] Dedicated tests for the (unbuilt) decoder

---

## 8. Open Questions

1. **Nesting level tracking:** How do we know which nesting level we're at when encoding?
   - Option: Track depth in environment variable
   - Option: Reconstruct from trace files
   - Option: Encode incrementally (each level just knows its state)

2. **Exit code inheritance:** When exec replaces process, who sets the final exit code?
   - Need to ensure proper propagation through exec boundary

**Reconciled (2026-06-20):** (1) resolved — the code encodes *incrementally*:
each level computes its own `(p<<1)|c` and updates the readable
`VPN_SWITCH_CONTEXT_EXIT_BITS` string; there is no global depth counter.
(2) resolved — `produce_with_exit()` captures `dispatch`'s exit, `combine_exit_codes`
folds it with the consumer's, and the result propagates via the env var across the
`env -` boundary.

---

## 9. Design Decisions

### Resolved

1. **EXIT_BITS Representation:** Use simplified notation `p . child1 child2 child3`
2. **Batch Producer Bit:** Represents generator function exit (independent of children)
3. **Maximum Nesting:** 4 levels in bit pattern, overflow to batch storage
4. **Batch Independence:** All batch children inherit same EXIT_BITS
5. **Overflow Handling:** Hybrid sequential with cleanup reset at counter=64

### Batch Counter Overflow

Originally designed as:
1. Check if any active batch files exist in `.tmp/batch-exits/`
2. If directory empty: Reset counter to 0 (safe)
3. If files exist: Error with clear message

**Reconciled (2026-06-20):** the shipped `get_batch_id()` uses a simpler plain
**circular `mod 64`** counter (`.tmp/batch-counter`) with no active-file check —
acceptable because batch ids are short-lived within a single invocation.

---

**Document Status:** Encoding + propagation implemented; decoding/reporting not yet.
See "Implementation Status" at the top.
**Consolidated from:** EXIT_CODE_ENCODING_SCHEME.md, EXIT_CODE_PROPAGATION_ANALYSIS.md, EXIT_CODE_PROPAGATION_ENVVAR.md, EXIT_CODE_IMPLEMENTATION_PLAN.md, EXIT_CODE_PROPAGATION_WALKTHROUGH.md, EXIT_BITS_FLOW_ANALYSIS.md
