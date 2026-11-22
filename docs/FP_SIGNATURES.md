# The structure of vpn-switch in signatures

**Work in progress.** A model of vpn-switch in type signatures is being
worked out. This page holds its top level as it stands and stays this
short until the model is settled; everything here may change.

How to read a signature: `f :: A -> B` means "`f` takes an `A` and gives
back a `B`"; `[A]` is a list of `A`s.

## The two worlds

    Db      -- the bookkeeping on disk: sessions, the environment, the links
    System  -- the machine: interfaces, routes, firewall, DNS
    World   -- both

## Three kinds of function

A function of vpn-switch reads the world and changes nothing. What it
hands back tells the three kinds apart:

    data VpnSwitchFunction
      = Terminal        (World -> Sh)             -- one script
      | Combinator      (World -> VpnSwitchCmd)   -- one new call
      | BatchCombinator (World -> [VpnSwitchCmd]) -- several new calls

    genTerminal   :: [Arg] -> World -> Sh
    genCombinator :: [Arg] -> World -> Cmd
    genBatch      :: [Arg] -> World -> [Cmd]

## Resolving a call

    resolveFunction    :: VpnSwitch -> VpnSwitchCmd -> Maybe VpnSwitchFunction
    resolveInterpreter :: Env -> VpnSwitch -> VpnSwitchCmd -> Maybe Interpreter

## The run

A run rewrites a queue of calls until only text is left:

    data Machine = Machine
      { machineWorld :: World
      , machineQueue :: [Cmd]
      }

    step :: VpnSwitch -> Machine -> Either String Machine
    run  :: VpnSwitch -> Machine -> Either String Machine

## The system and the exit code

    execute :: Sh -> System -> System

    combineExit :: ExitCode -> ExitCode -> ExitCode
    foldBatch   :: [ExitCode] -> ExitCode

The architecture as it is built is described in
[ARCHITECTURE.md](ARCHITECTURE.md).
