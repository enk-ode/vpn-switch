# Structure of vpn-switch via Signatures — Domain-First (WORKING DOC)

Purpose: work out the structure of vpn-switch **precisely**, using type
signatures as the tool — but in **our own domain words first**. We are *not* using
FP library vocabulary yet (no "functor", no Greek-letter morphisms); we map to
those standard names later (§Later) and only then check Hoogle. Staying in the
domain keeps it honest and readable while the shape is still settling.

How to read a signature. `f :: A -> B` means *"`f` takes an `A` and gives back a
`B`"*. A longer one, `f :: A -> B -> C`, means *"`f` takes an `A` and a `B` and
gives back a `C`"*. `[A]` means *"a list of `A`s"* (zero or more). A trailing
prime, `System'`, means *"the same kind of thing, but changed"*.

---

## §0 The two worlds we touch

Everything vpn-switch does is to move one world by way of another:

```
Db      -- OUR bookkeeping, on disk:  sessions, .env, the latest-* symlinks
System  -- the REAL machine:          wg interfaces, routes, firewall, DNS
```

- `Db` is the **means** — where the program keeps its notes.
- `System` is the **end** — the thing the user actually wants changed.

So, in one sentence, the whole tool is: *read `Db` (and the current `System`),
and from that produce a shell script that, once run, moves `System` to a new
`System'`.*

Keeping these two apart is what makes the design legible — without it, "manage
some files" and "reconfigure the network" blur together.

---

## §0.1 The text that flows

Everything travels as text. Three kinds, named for their role:

```
Arg  -- one argument the user typed,   e.g.  privacy
Cmd  -- one vpn-switch call,           e.g.  session refresh
Sh   -- one shell script  (the thing the operating system actually runs)
```

They are all "just strings". The interesting part is **how we produce and consume
them**, which the rest of this document is about.

---

## §1 First design decision — *decide what to do* vs. *do it*

This is the founding split. Two separate steps:

- **Generation** — work out *what should happen*. It **reads** `Db` and `System`
  and **changes nothing**; it hands back a description.
- **Interpretation** — *make it happen*. It takes that description, runs it, and
  is the **only** step that moves the world.

```
generate   :: [Arg] -> Db -> System -> <a description>
                                  -- reads both worlds, changes neither

interpret  :: Interpreter -> Sh -> (Db, System) -> (Db', System', Output, ExitCode)
                                  -- this one really runs; the worlds move to Db'/System'
```

(`Output` is just whatever the script printed — stdout/stderr; see §4.)

Why the split is the whole game:

- **Testable.** `generate` changes nothing, so a test can hand it a pretend
  `Db`/`System`, look at the script it returns, and check it — with no real
  network, no `sudo`, no mocking the operating system.
- **Inspectable.** Because the script *exists as text* before anything runs, you
  can look at it first (§5, dry-run).

---

## §2 Three kinds of function — told apart by what they hand back

A vpn-switch function is one of three kinds, and the kind is decided by **what it
produces**:

```
Terminal         :: [Arg] -> Db -> System -> Sh      -- ONE shell script
Combinator       :: [Arg] -> Db -> System -> Cmd     -- ONE new vpn-switch call
BatchCombinator  :: [Arg] -> Db -> System -> [Cmd]   -- SEVERAL new vpn-switch calls
```

- A **terminal** is the *only* way out to the shell: it produces a script.
- A **combinator** produces *another* vpn-switch call.
- A **batch combinator** produces *several* of them.

The naming convention in the code — `_f`, `__f`, `___f` — is literally just the
number of leading underscores announcing which of these three a function is,
because the shell has no type for us to read it off any other way. (One day we
will say this more formally; for now: underscores = which row of the table
above.)

---

## §3 Resolve, then evaluate — and the recursion

A combinator/batch hands back a `Cmd` (or `[Cmd]`) — **the very same thing we
started from.** So the output goes *back to be resolved again*. That loop is the
recursion. But — and this is the point — **resolving is not running.** We keep
the two apart, exactly as §1 demands.

The kind-specific generators (args still to be supplied; read both worlds, change
nothing):

```
genTerminal   :: [Arg] -> (Db, System) -> Sh      -- a script
genCombinator :: [Arg] -> (Db, System) -> Cmd     -- one new call
genBatch      :: [Arg] -> (Db, System) -> [Cmd]   -- several new calls
```

**Step 1 — resolve.** Turn a `Cmd` into one of these three, with its arguments
already supplied. **Nothing runs**; this is just a value:

```
resolve :: Cmd -> VpnSwitchFunction

data VpnSwitchFunction
  = Terminal        ((Db, System) -> Sh)      -- hands back ONE script
  | Combinator      ((Db, System) -> Cmd)     -- hands back ONE new call
  | BatchCombinator ((Db, System) -> [Cmd])   -- hands back SEVERAL new calls
```

(Each wrapped `(Db, System) -> …` is just the matching generator above with its
`[Arg]` already applied.)

**Step 2 — evaluate.** The separate step that actually runs. It is the *only*
thing that can move the world, and it moves it at *only* one place — the
`Terminal` leaf:

```
evaluate :: VpnSwitchFunction -> (Db, System) -> (Db', System', Output, ExitCode)
evaluate vf world = case vf of

    Terminal        g -> interpret (runnerFor vf) (g world) world
                         -- a script → hand to the interpreter; the world may move

    Combinator      g -> evaluate (resolve (g world)) world
                         -- ONE new call → resolve it, evaluate it           ⟲

    BatchCombinator g -> evaluateEach (map resolve (g world)) world
                         -- SEVERAL new calls → resolve + evaluate each        ⟲⟲
```

`evaluate` calls `resolve` calls `evaluate` — that is the recursion, and it is
**higher-order**: each step produces *the next computation as a value* (a
`VpnSwitchFunction`) instead of doing it on the spot. A combinator is a function
that yields another function; only the terminal leaf bottoms out in a script the
interpreter applies. (Your `.brj` draft had this `VpnSwitchFunction` shape from
the start — it was right; the earlier all-in-one `dispatch` lost it.)

> Key observation: a combinator **never moves either world** — it only yields
> more calls. Both worlds move at exactly one place in the whole machine: when a
> **terminal's script is interpreted**. *What* moves there splits three ways:
> bookkeeping terminals move `Db` (e.g. `setenv`, `session refresh`'s `latest-*`
> symlinks), network terminals move `System` (e.g. `wg-quick up`, `pfctl`), and
> display-only terminals move **neither** — their runner is `cat`, so the script
> is just data to print. Everything above the leaves reads `Db` and routes.

**The honest twist (one sentence for the article).** POSIX shell has **no
first-class functions** — you cannot return a closure. So the "function" a
combinator yields is **reified as text**: a `Cmd` line, or, at the leaf, an `Sh`
script. `resolve`/`evaluate` plus the interpreter realise higher-order
programming over *reified text and pipes*, because the substrate offers nothing
else. The structure is higher-order; the carrier is strings.

**Why this is what makes dry-run possible.** Because `resolve` produces the
computation as a *value*, before anything runs, the choice at the leaf — *apply*
the script (`sh`) or merely *show* it (`cat`) — is made at evaluation time. A
`dispatch` that ran on the spot (the wrong earlier version) could not offer that
choice. Dry-run is exactly "look at the produced function instead of applying it".

---

## §4 What "run the script" actually gives back

When a terminal's script reaches the shell, the shell becomes **opaque** to us.
We hand it *one* script; afterwards we get back only:

```
interpret :: Interpreter -> Sh -> (Db, System) -> (Db', System', Output, ExitCode)
--                          ^one script^                ^moved worlds^ ^stdout+stderr^
```

One script in; moved worlds (`Db'`, `System'`), whatever it printed, and an exit code out. We
do **not** see *how* the shell did it — that boundary (one script in → an opaque
effect out) is exactly the Unix process boundary.

This is why **one script, not a list, is the honest shape**: the moment the text
crosses into the shell it is a single opaque unit. There is one and only one exit
to the shell — the terminal — and it emits one thing.

---

## §5 Choosing the runner — same script, different meaning

`interpret` takes an `Interpreter`: *which process consumes the script*. The
**same** script can be handed to different ones:

```
Interpreter   -- which process consumes the script
  Shell       -- "sh"          run it
  PrivShell   -- "sudo sh"     run it with privilege (connect / disconnect)
  Cat         -- "cat"         print it, run NOTHING            (dry-run)
  Cut         -- "cut -b3-"    strip the leading "# " marker
  VpnSwitch   -- "vpn-switch"  feed it back to resolve + evaluate (this IS the loop in §3)
```

> Dry-run is simply `Cat`. It makes `interpret` leave `(Db, System)`
> **unchanged** and print the script instead. You *see* the would-be
> `System -> System'` move, as text, without applying it. Same script — the
> runner decides whether it is *a program* or *just text to read*.

For a user who has broken their own network twice and wants to avoid round three,
that is the entire trust mechanism — and it falls straight out of the
decide-vs-do split of §1. Nothing extra had to be built for it.

---

## §6 Where things change — the whole machine in one picture

```
   resolve (a Cmd)  →  a VpnSwitchFunction      (a value; nothing runs yet)
   evaluate it:
     ├─ Combinator       → yields a Cmd      → resolve + evaluate    (Db read; System untouched)
     ├─ BatchCombinator  → yields [Cmd]      → resolve + evaluate    (Db read; System untouched)
     └─ Terminal         → yields ONE script → interpret
                                                  ├─ Cat        → nothing moves   (dry-run)
                                                  ├─ Shell      → System moves
                                                  └─ PrivShell  → System moves (sudo)
```

- A **world moves only at a terminal's script** — never above it. *Which* world:
  `Db` (bookkeeping terminals), `System` (network terminals, under Shell/PrivShell),
  or neither (display-only terminals, under `cat`).
- `Db` is read during generation everywhere; written only at `Db`-moving leaves.
- Combinators and batches are pure routing: read `Db`, hand back more calls.

That picture is the claim the article will make precise: *a tree of `Db`-reading
routing, whose leaves are the only `System`-moving actions, with the runner chosen
per leaf — so the same description can be inspected or applied.*

---

## §7 The return journey — the exit code folds back up

§3 followed the call *outwards*: a `Cmd` resolves to a function that yields more
`Cmd`s, down to the `Sh` leaf. That direction is all text going **out**. But once
the leaves run, something must come **back**: did it work? That return channel is
the exit code — and it carries more structure than the lone `ExitCode` in the
tuples of §1–§4 admits.

**Every level is a pipe: producer | consumer.** At each node the machine does two
things in order — it *generates* the next text (the **producer**: `resolve`'s
function applied to the worlds), then it *runs* that text (the **consumer**: the
interpreter of §5). Either half can fail on its own:

```
producerExit :: ExitCode      -- did generating the next text succeed?
consumerExit :: ExitCode      -- did running it succeed?
combineExit  :: ExitCode -> ExitCode -> ExitCode   -- fold the two into this level's result
```

So the value a level hands upward is `combineExit producerExit consumerExit`, not
merely "the consumer's code". A generator that dies *before it emits anything* is
therefore not silently lost (precisely the gap the decide/do split of §1 would
otherwise open) — it survives as the producer half.

**A batch folds a list.** A `BatchCombinator` ran *several* children (§3's
`evaluateEach`); their codes must collapse to one:

```
foldBatch :: [ExitCode] -> ExitCode      -- N children → one node result
```

**The exit code is not a flat number — it is the path to the failure.** A scalar
`1` would say *that* something failed, never *where*. Instead the code is a small
structured value, serialised into the single byte the shell gives us back:

```
data ExitCode
  = Ok                          -- 0            : everything succeeded
  | Pipe  Bit Bit               -- 1..3         : one level, (producer<<1)|consumer
  | Nest  Bit Bit ExitCode      -- shift ×2/lvl : an outer pipe wrapping an inner one (≤4 levels)
  | Batch BatchId [ExitCode]    -- ≥128         : a batch node; children kept in a side file
```

- A plain `Pipe` packs two bits, `(p<<1)|c`: `1` = consumer failed, `2` =
  producer failed, `3` = both. Nesting shifts left two bits per level, so up to
  four levels fit in one byte.
- A `Batch` cannot fit its children in a byte, so the code is just a **tag**
  (`128 + batch_id`); the children live in `.tmp/batch-exits/<id>`, and the fold
  reads them back when it needs them.

Because the encoding is invertible, the journey can be *replayed* without
re-running anything:

```
decodeExit :: ExitCode -> [LevelReport]   -- "producer failed at level 2", ...
```

**The symmetry, in one line.** The forward pass of §3 is an **unfold**: from one
`Cmd`, grow the tree of calls. This return pass is the matching **fold**:
collapse the executed tree back into one `ExitCode` (alongside the `Db'`,
`System'`, `Output` of §4). The `… -> (Db', System', Output, ExitCode)` in every
earlier signature is that fold's *result type*; this section is the fold's
*operation*. Build on the way down, combine on the way up — two halves of one
recursion (an unfold-then-fold; the standard name waits in §Later).

> Why encode the *path* at all, not just pass/fail? Same reason as dry-run (§5):
> a tool whose user has broken their network twice should answer *"which step
> failed?"* without a second run. The exit code is the cheapest possible
> post-mortem — one byte that, decoded, names the level and the side that failed.

---

## §8 (draft) Compacting the signatures — the `Std` bundle

The return tuples so far — `(Db', System', Output, ExitCode)` — are wordy, and
they hide that *every* stage in vpn-switch is, at bottom, a **Unix process**:
something that may read **stdin**, and always hands back **stdout**, **stderr**
and an **exit code**. Name those once and the signatures shrink.

**Two bundles** (the only new vocabulary):

```
Std a   = (a, Err, Exit)         -- what a stage YIELDS: a stdout payload of type a,
                                 --   plus stderr and an exit  →  (stdout, stderr, exitno)
Stdio a = (In, Std a)            -- a full process surface, stdin too →  (stdin, stdout, stderr, exitno)
```

- `Std a` is parameterised by what rides on **stdout**. That payload is exactly
  the §2 kind: `Std Sh` (terminal), `Std Cmd` (combinator), `Std [Cmd]` (batch),
  or `Std Out` (raw text, after a script has run). It also *refines* §4's
  `Output`, which lumped stdout+stderr: here the typed stdout payload (`a`) and
  the diagnostics channel (`Err`, the `# `-prefixed comments/warnings) are split.
- `Exit` is the structured `ExitCode` of §7.
- `Stdio a` merely adds the **stdin** a process may consume. Functionally a
  process *is* `In -> Std a`; most anchor functions ignore the `In`, one uses it
  (batch reading commands from stdin).

**What an anchor function takes and yields — precisely.** With `World = (Db, System)`:

```
anchor :: [Arg] -> World -> In -> Std a        -- the general shape (a process)
            ^args   ^read    ^stdin  ^yield        (a = Sh | Cmd | [Cmd])
```

- **Input:** the typed parameters `[Arg]` (validated; §Synopsis `mkArg`), the two
  worlds it may **read**, and `In` (stdin).
- **Result:** `Std a` — *not* just the payload. Generation can fail (a non-zero
  `Exit` — the producer half of §7) and can speak on `Err`; modelling the result
  as `Std a` keeps both, instead of pretending a generator only returns text.

The three kinds are then just `a` chosen (generation never moves `World`, §1 — so
no `World'` on the right):

```
genTerminal   :: [Arg] -> World -> In -> Std Sh
genCombinator :: [Arg] -> World -> In -> Std Cmd
genBatch      :: [Arg] -> World -> In -> Std [Cmd]
```

**Deriving the other result types.** Everything else falls out of `Std`:

```
interpret :: Interpreter -> Sh -> World -> (World', Std Out)   -- the consumer: moves the world, yields raw text
evaluate  :: VpnSwitchFunction  -> World -> (World', Std Out)
```

So the wordy `(Db', System', Output, ExitCode)` becomes `(World', Std Out)`:
`World'` is `(Db', System')`, and `Std Out` names `(Output, ExitCode)` as one
thing. Generator and interpreter now share **one** result vocabulary — the only
difference is that the interpreter also returns `World'` (it is the lone mover, §3).

**Where the pipe lives (ties back to §7).** A pipe is a producer whose `Std`'s
stdout becomes the consumer's `In`:

```
producer :: ... -> Std Cmd                      -- its Out is a Cmd
consumer :: In  -> World -> (World', Std Out)    -- In = producer's Out
combineExit :: Exit -> Exit -> Exit             -- fold producer.Exit with consumer.Exit  (§7)
```

`Stdio` is exactly that junction as one value: `(In, Std a)`. And §7's
`combineExit`/`foldBatch` operate on the `Exit` field of these `Std`s — the return
channel is "fold the `Exit`s as the `Std`s travel back up".

**Open (for you to sharpen):**

- Names: `Std`/`Stdio`, or `Yield`/`Process`, or keep `Output` + `ExitCode`?
- Make `In` explicit in every anchor signature (honest: all are processes) or
  elide it except for batch (compact: only batch reads stdin)?
- `Std Out` for "raw stdout after a run" — or `Std Text`?

If this lands, §1–§4 and the synopsis below collapse onto `World` + `Std a`, which
is the compact form you are after.

---

## §Synopsis — every signature, no prose

```
-- worlds and text
Db, System              -- the two worlds: our bookkeeping, and the real machine
Arg, Cmd, Sh, Output    -- one argument · one vpn-switch call · one script · stdout+stderr

mkArg :: String -> Maybe Arg                  -- validated, not raw (reject, don't filter)

-- DECIDE: read both worlds, change nothing
genTerminal   :: [Arg] -> (Db, System) -> Sh
genCombinator :: [Arg] -> (Db, System) -> Cmd
genBatch      :: [Arg] -> (Db, System) -> [Cmd]

resolve :: Cmd -> VpnSwitchFunction
data VpnSwitchFunction
  = Terminal        ((Db, System) -> Sh)
  | Combinator      ((Db, System) -> Cmd)
  | BatchCombinator ((Db, System) -> [Cmd])

-- DO: the only mover; moves the world only at the Terminal leaf
evaluate  :: VpnSwitchFunction -> (Db, System) -> (Db', System', Output, ExitCode)
interpret :: Interpreter -> Sh -> (Db, System) -> (Db', System', Output, ExitCode)
runnerFor :: VpnSwitchFunction -> Interpreter

-- RETURN CHANNEL: exit codes fold back up (§7) — the way down is an unfold, this is the fold
combineExit :: ExitCode -> ExitCode -> ExitCode   -- producer ⊕ consumer, one pipe level
foldBatch   :: [ExitCode] -> ExitCode             -- N batch children → one
decodeExit  :: ExitCode -> [LevelReport]          -- invert it: which level/side failed?
data ExitCode = Ok | Pipe Bit Bit | Nest Bit Bit ExitCode | Batch BatchId [ExitCode]

-- RUNNERS: which process consumes the script
data Interpreter = Shell | PrivShell | Cat | Cut | VpnSwitch
command :: Interpreter -> String
```

---

## §9 — The standard names, mapped: vpn-switch as a (free) monad

The domain picture (§1–§8) is now settled enough to give the established names.
This section does that **and** develops the consequence we keep circling: replace
the batch `;`-script with a proper monadic fold. Everything here is a *renaming*
of structure already in §1–§8 — nothing new is added to the machine; we only say
what it already is in the borrowed vocabulary, and then read off one refactor.

### §9.1 The type — what `V a` is

Every stage in §8 has the same shape: given the worlds (which it may read) and a
stdin, it yields a typed stdout payload plus stderr plus a structured exit, and —
only at a leaf — a moved world. Name that shape `V`:

```
V a  ≈  World -> In -> (World', Std a)        -- one vpn-switch computation yielding an `a`
```

That is exactly §8's `anchor :: [Arg] -> World -> In -> Std a` once the arguments
are applied (`resolve` of §3 applies them) and §8's `evaluate :: … -> (World', Std a)`
for the world-moving half. So `V` is not a new construct — **it is the type the
whole machine already speaks in.** The payload `a` is the §2 row:

```
V Sh      -- a terminal computation (yields one script)
V Cmd     -- a combinator computation (yields one new call)
V [Cmd]   -- a batch computation (yields several)
V Out     -- a computation after a script has run (yields raw stdout)
```

Two honest readings of `V`, both useful in the article:

- **Transformer-stack reading.** `V` threads a read-only `World`, writes a
  `World'` only at the leaf, accumulates a structured exit on the way up, and may
  short-circuit. That is, in standard names:
  ```
  V a  =  Reader World         -- §1: generation READS both worlds, writes neither
          ( State System       -- §3/§6: System moves at exactly one place (the leaf)
          ( Writer ExitCode    -- §7: the structured exit folds up the tree (the log)
          ( Except ⟂ )))  a    -- §9.5: failure may stop the chain
  ```
- **Free-monad reading (the more faithful one).** Because `resolve` produces the
  next computation **as a value before anything runs** (§3), `V` is really the
  *free monad over a "next vpn-switch call" functor*: a program is a **tree of
  emissions** — terminals are leaves, combinators are one-child nodes, batches are
  N-child nodes — and the interpreter (§5) is a *fold over that tree*. The whole
  of §5 ("same script, different meaning") is precisely the free monad's selling
  point: one program, many interpretations.

We lead with the free-monad reading because it explains §5 and §3 at once; the
transformer stack is the same thing unrolled.

### §9.2 `pure` and `>>=` — the leaf and the combinator

```
pure :: a -> V a          -- emit this payload; move no world, fail not
(>>=) :: V a -> (a -> V b) -> V b
```

- **`pure`** is the world-*neutral* leaf: a `V` that yields a value and moves
  nothing. The display-only terminals (runner `cat`, §5) are exactly this — they
  emit text and touch neither `Db` nor `System`. `pure` is "describe, don't do".
- **`>>=` is the combinator plus re-dispatch.** §3's `evaluate (Combinator g)`
  did: take the emitted `Cmd` (`g world`), `resolve` it, `evaluate` it. That is
  bind: run the first computation, feed its emitted payload to a continuation that
  produces the next computation. The combinator *is* the Kleisli arrow
  `Cmd -> V b`, reified (§3's honest twist) as "emit a `Cmd` line, re-dispatch it".

  ```
  evaluate (Combinator g) world  ==  (g world).stdout  >>=  (resolve >>> evaluate)
  ```

So the underscore count of §2 reads, in the borrowed names, as *how many binds
this node performs*: `_` = none (a leaf, `pure`-shaped), `__` = one (`>>=`),
`___` = many (a fold of binds, §9.4).

> One sentence for the article: **a combinator is `>>=` written in shell — it
> hands the rest of the computation back as a line of text, and the interpreter
> is what applies it.**

### §9.3 The pipe is Kleisli composition

§8 located the pipe: a producer whose `Std`'s stdout becomes the consumer's `In`.
That junction, composed, is Kleisli composition `>=>`:

```
(>=>) :: (a -> V b) -> (b -> V c) -> (a -> V c)
producer >=> consumer    -- producer's stdout payload becomes consumer's stdin
```

The Unix pipe `|` is the *operational* form of `>=>`; §8's `Stdio a = (In, Std a)`
is that junction as one value. The whole rewrite chain of §3 is one long Kleisli
arrow, executed left to right by the interpreter loop (`Interpreter = VpnSwitch`,
§5).

### §9.4 Batch is `sequence` / `foldM` — the fold you wanted

A `BatchCombinator` yields `[Cmd]` and §3's `evaluateEach` resolves+evaluates each.
In borrowed names that is `traverse` (a.k.a. `mapM`) of the Kleisli arrow over the
list, and §7's `foldBatch :: [ExitCode] -> ExitCode` is the monadic fold of the
results:

```
evaluateBatch :: [Cmd] -> V [Out]
evaluateBatch = traverse (resolve >>> evaluate)         -- run each child in V
                                                        -- foldBatch = how their Exits combine (§7)
```

**This is the place the `;`-script should become `foldM`.** Today the batch
interpreter joins the N emitted lines into one script and lets the shell run them
with `;` (the batch-exits side file, §7, then reconstructs *where* it failed).
That is an *ad-hoc* sequencing: the children run in one shell, and the only thing
threaded between them is whatever they leave in the shell's own state. The
principled form threads the **world and the exit** explicitly, child by child:

```
foldM :: (World -> Cmd -> (World', Std Out)) -> World -> [Cmd] -> (World', Std [Out])
--        ^ run one child, returning the world it leaves         ^ next child sees that world
```

Each child is generated and run against the world the previous child *left*
(§3's note: a child is generated against the current, possibly-already-changed
worlds — `foldM` is the name for "thread the world through the list"). The fold's
combining step is `combineExit`/`foldBatch` from §7. Concretely this turns
`___batch0`/`__batch1`/`_batch2` + the batch-exits infrastructure from "emit a
`;`-script and post-mortem the byte" into "`foldM` the children, accumulating the
`ExitCode` tree as you go" — same observable behaviour, but the data flow is now
*in* the structure instead of *beside* it in a temp file.

### §9.5 The two effect types are one env var — `KEEP_GOING`

This is the centrepiece for an FP audience, because the same fold gives two
different, named effects depending on one setting:

```
VPN_SWITCH_BATCH_KEEP_GOING = 0   →  Either / ExceptT      (short-circuit on first failure)
VPN_SWITCH_BATCH_KEEP_GOING = 1   →  Validation            (run all; accumulate every failure)
```

- With `KEEP_GOING=0`, `>>=` stops at the first non-`Ok` `ExitCode`: the monad is
  `Either e` — the rest of the fold is never run. Bind *is* the short-circuit.
- With `KEEP_GOING=1`, every child runs and their `ExitCode`s are *combined*
  rather than aborted on: that is the **applicative** `Validation e`, whose whole
  point is "don't stop, collect". §7's structured `ExitCode` (the `Batch BatchId
  [ExitCode]` node) is exactly the accumulated error log a `Validation` carries.

> One sentence for the article: **`KEEP_GOING` is not a flag bolted onto a loop —
> it selects the monad. `0` is `Either` (stop), `1` is `Validation` (accumulate);
> the fold is the same, the effect type is the choice.** The structured exit code
> of §7 is the `Validation`'s error accumulator, serialised into one byte plus a
> side file.

### §9.6 The interpreter is the algebra; the run is a hylomorphism

§3 named the way down an **unfold** (anamorphism): from one `Cmd`, grow the tree
of calls. §7 named the way up a **fold** (catamorphism): collapse the executed
tree into one `ExitCode` (with `World'`, `Std Out`). Together — build a structure
on the way down and consume it on the way up, without ever materialising the whole
tree — that is a **hylomorphism**:

```
run :: Cmd -> (World', Std Out)
run = cata interpret . ana resolve        -- unfold to the call-tree, fold by interpreting
```

And the *choice* of `cata`'s algebra is §5's `Interpreter`: `Cat` folds the tree
to *printed text* (dry-run — the `Show` algebra), `Shell`/`PrivShell` fold it to
*effects on `System`*, `VpnSwitch` is the recursive algebra that keeps the
hylomorphism going. **"Interpreter polymorphism" (the article's term) is exactly
"a free monad with a choice of algebra for its catamorphism."** That the algebra
is selected per node by an environment variable (§5, and the per-function
`VPN_SWITCH_INTERPRETER_*` overrides) is the shell-native realisation of it.

### §9.7 Reader and the single write

The `Db`/`System` worlds are a `Reader`: §1's law ("generation reads both worlds,
changes nothing") is precisely "the generators live in `Reader World`, with no
`World` on the right of the arrow". Execution adds the one write — `State System`
— and §6's invariant ("a world moves only at a terminal's script") is the
statement that the `State` effect is discharged at exactly one place in the whole
fold: the leaf. The `env -` isolation and the `.env` `local → default → template`
cascade (see `help environment`) are how the `Reader`'s environment is actually
provisioned per process — a fresh, reproducible `Reader` for every call.

### §9.8 The honest twist, in FP terms (what we do *not* prove)

POSIX shell has no first-class functions (§3), so this monad is **reified as
strings and pipes**: the free monad's nodes are `Cmd` lines, its leaves are `Sh`
scripts, its `>>=` is re-dispatch through the OS, and its interpreter is a process
in a pipeline. The structure is a free monad; the carrier is text; the runtime is
the Unix process model. That is the striking claim — *a free monad realised with
primitives that predate algebraic data types by decades* — and it must be made
**without overclaiming**:

- We do **not** prove the monad laws hold; we observe they *should*. Informally:
  left identity (`pure x >>= f = f x`) is "emit a `Cmd`, then resolve it = just
  resolve it"; right identity (`m >>= pure = m`) is "emit, then re-emit unchanged";
  associativity is "re-dispatch composes regardless of grouping". These are
  arguments, not proofs — shell gives us no type checker to enforce them, and a
  malformed combinator that emits two lines instead of one *breaks* the law (which
  is exactly what `test_no_terminal_output_vpnswitch_commands` and
  `combinator_syntax_validation` guard at the architecture-test level — the law is
  enforced by tests, not by the language).
- `V` is therefore **a monad by construction and convention, checked by tests**,
  not a monad certified by a compiler. For the FP audience that *is* the
  interesting tension: the same algebraic structure, held together by discipline
  and a test harness instead of a type system — which is the article's larger
  thesis (quality without types, via architecture) in one concrete instance.

### §9.9 What the mapping buys (and the one refactor it asks for)

- **Naming, not rebuilding.** §9.1–§9.7 add zero behaviour: they are the
  established names for §1–§8. Do *not* build a monad library in `sh`; the genius
  (and the article's point) is that dispatch + interpreter + pipes *are* the
  monad, with no library.
- **The one concrete change worth making:** turn the batch path (§9.4) from a
  `;`-script + post-mortem byte into an explicit `foldM` that threads `World` and
  `ExitCode` through the children, with `KEEP_GOING` selecting `Either` vs
  `Validation` (§9.5). The exit-folding infrastructure of §7 already *is* the
  accumulator; this only moves the fold from "beside the data, in a temp file" to
  "in the structure". It is the smallest change that makes §9 true in the code and
  not only on paper — and it is the article's worked example.

> The shape of the article's FP section, in one breath: terminals are `pure`,
> combinators are `>>=`, pipes are `>=>`, batches are `traverse`/`foldM`,
> `KEEP_GOING` chooses `Either` vs `Validation`, the way down is an `ana` and the
> way up a `cata` (together a hylomorphism), and the interpreter is the algebra you
> fold with — all of it reified in text and pipes because the shell offers nothing
> else, and all of it kept honest by a test harness rather than a type checker.

---

## §Later — still parked

Now mapped in §9. What remains parked: confirming each name against Hoogle by its
exact signature, and deciding how much of §9 belongs in the article versus this
working doc. (The article likely wants §9.5, §9.6 and §9.8; the rest is scaffolding.)

---

## §Your draft (semantic view — kept as-is)

Your competing sketch, preserved. It takes the *direct* view (a combinator hands
back the next function itself), where §3 above takes the *string* view (a
combinator hands back a `Cmd` that is re-resolved later). Both are valid; we use
the string view above because it matches "emit text → re-dispatch", and because a
child is then generated against the *current* (possibly already-changed) worlds.

```haskell .brj
newtype Alnum = Alnum String
isAlnum :: String -> Boolean
isAlnum s = true -- TODO: exercise
toAlnum :: String -> Alnum
toAlnum s = s |> List.filter isAlnum       -- note: a validator should REJECT, not filter
type Arg = Alnum
data Interpreter = VpnSwitch "vpn-switch" | Shell "sh" | Cat "cat" | Cut "cut" | PrivShell "sudo sh"
type VpnSwitchFunction = Terminal Arg [Arg] -> State -> (State, [String]) | Combinator Arg [Arg] -> State -> VpnSwitchFunction | BatchCombinator Arg [Arg] -> State -> [VpnSwitchFunction]
```
