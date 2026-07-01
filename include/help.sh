# help.sh - Dynamically loaded help module
#
# Source of truth for the generated help system. The help text is assembled
# mechanically from #@help doc-blocks declared above each anchor function (see
# docs/HELP_TEMPLATE_SPEC.md). This module owns:
#   - the @defgroup taxonomy and @topic entries (below),
#   - the runtime parser + renderers (help_* functions),
#   - the user-facing entry points (_help0 overview, _help1 topic/detail).
# Drift between code and help is caught by the architecture tests A/B/C.

# --- Help taxonomy: overview sections, ordered by @order ---------------------
# Titles mirror the man-page COMMANDS sections 1:1 so terminal help and the man
# page render from the same model.

#@help
# @defgroup setup  Without a database
# @order   10
#   The only commands that run without an existing database. Start here on a
#   fresh install.
#@end

#@help
# @defgroup connection  Connection
# @order   20
#   Bring tunnels up and down, and keep the database in sync with the source.
#@end

#@help
# @defgroup sessions  Sessions
# @order   30
#   A session is one started VPN instance: a process plus its .session/<PID>/
#   metadata. Save, resume, inspect and reconcile them.
#@end

#@help
# @defgroup wireguard  WireGuard
# @order   40
#   Manage WireGuard configurations, categories and tunnels.
#@end

#@help
# @defgroup openvpn  OpenVPN
# @order   50
#   Manage OpenVPN configurations, groups and tunnels.
#@end

#@help
# @defgroup database  Database lifecycle
# @order   60
#   Back up, restore and refresh the database itself.
#@end

#@help
# @defgroup configuration  Configuration
# @order   70
#   Read and change vpn-switch environment variables.
#@end

#@help
# @defgroup diagnostics  Diagnostics
# @order   80
#   Inspect current state and check health.
#@end

#@help
# @topic Reserved Session Keywords
# @group sessions
#   latest   - system-managed ownership pointer, updated on each start
#   default  - user-managed, set via 'session save' with no name
#@end

# Helper functions for centralized help display
# These are called by _help1 for the new pattern: "vpn-switch help <module>"

# --- Generated-help engine ---------------------------------------------------
# help_source_files: the files scanned for #@help doc-blocks at runtime. The
# main script is VPN_SWITCH_CONTEXT_SCRIPT; modules live under LIBDIR/include.
# Named without the anchor pattern (_…digit) so they need no doc-block.
help_source_files() {
  echo "$VPN_SWITCH_CONTEXT_SCRIPT"
  local m
  for m in "$VPN_SWITCH_LIBDIR"/include/*.sh; do
    [ -f "$m" ] || continue
    [ "$m" = "$VPN_SWITCH_CONTEXT_SCRIPT" ] && continue
    echo "$m"
  done
}

# help_render MODE [TARGET]
#   MODE=overview  -> grouped command summaries (vpn-switch help)
#   MODE=detail    -> full block for the command path TARGET (vpn-switch help <path>)
#   MODE=group     -> overview restricted to one @defgroup id TARGET (help wireguard)
# Honours VPN_SWITCH_DISPLAY_ANSI for colour. Pure read of the doc-blocks.
help_render() {
  local mode="$1" target="${2:-}"
  local ch="" cc="" cg="" cr=""
  if [ "${VPN_SWITCH_DISPLAY_ANSI:-0}" = "1" ]; then
    ch="$COLOR_BLUE"; cc="$COLOR_CYAN"; cg="$COLOR_GRAY"; cr="$COLOR_RESET"
  fi
  help_source_files | tr '\n' '\0' | xargs -0 cat 2>>"$LOG_FILE" | awk \
    -v mode="$mode" -v target="$target" \
    -v ch="$ch" -v cc="$cc" -v cg="$cg" -v cr="$cr" '
    function trim(s){ sub(/^[ \t]+/,"",s); sub(/[ \t]+$/,"",s); return s }
    function pathof(u,  p){ p=u; sub(/[ \t]*[<[].*$/,"",p); return trim(p) }
    function mesc(s){ gsub(/</,"\\<",s); gsub(/>/,"\\>",s); gsub(/\|/,"\\|",s); return s }
    BEGIN{ seq=0 }
    /^#@help/ { inblk=1; kind=""; usage=""; summary=""; ret=""; body="";
                gc=0; pc=0; ec=0; sc=0; dgid=""; dgtitle=""; dgord=999; topic="";
                next }
    inblk && /^#@end$/ {
      inblk=0
      if (kind=="command") {
        p=pathof(usage); cu[p]=usage; cs[p]=summary; cr_[p]=ret; cord[p]=(++seq)
        cnp[p]=pc; for(i=1;i<=pc;i++) cp[p,i]=prm[i]
        cne[p]=ec; for(i=1;i<=ec;i++) cex[p,i]=exs[i]
        cns[p]=sc; for(i=1;i<=sc;i++) cse[p,i]=seer[i]
        for(i=1;i<=gc;i++){ g=grp[i]; gmn[g]++; gm[g,gmn[g]]=p }
      } else if (kind=="defgroup") {
        dgt[dgid]=dgtitle; dgo[dgid]=dgord; dgb[dgid]=body; dgall[++ndg]=dgid
      } else if (kind=="topic") {
        for(i=1;i<=gc;i++){ g=grp[i]; tpn[g]++; tpt[g,tpn[g]]=topic; tpb[g,tpn[g]]=body }
      }
      next
    }
    inblk {
      line=$0
      if (match(line,/^#[ \t]*@[a-z]+/)) {
        rest=line; sub(/^#[ \t]*@/,"",rest)
        name=rest; sub(/[ \t].*$/,"",name)
        val=rest; sub(/^[a-z]+[ \t]*/,"",val); val=trim(val)
        if(name=="command"){kind="command"; usage=val}
        else if(name=="summary"){summary=val}
        else if(name=="group"){grp[++gc]=val}
        else if(name=="param"){prm[++pc]=val}
        else if(name=="option"){prm[++pc]="--" val}
        else if(name=="returns"){ret=val}
        else if(name=="example"){exs[++ec]=val}
        else if(name=="see"){seer[++sc]=val}
        else if(name=="defgroup"){kind="defgroup"; dgid=val; sub(/[ \t].*$/,"",dgid); dgtitle=val; sub(/^[^ \t]+[ \t]+/,"",dgtitle)}
        else if(name=="order"){dgord=val+0}
        else if(name=="topic"){kind="topic"; topic=val}
        else if(name=="internal"){kind="internal"}
        next
      }
      if (match(line,/^#[ \t][ \t]/)) { t=line; sub(/^#[ \t]+/,"",t); body=(body==""?t:body "\n" t) }
      next
    }
    END{
      # query mode: pick detail (exact command), group (group id), or prefix
      if (mode=="query") {
        if (target in cu) mode="detail"
        else { isg=0; for(a=1;a<=ndg;a++) if(dgall[a]==target) isg=1
               if (isg) mode="group"; else mode="prefix" }
      }
      # width for alignment (measured on the printed usage, not the path)
      w=0; for(p in cu){ if(length("vpn-switch " cu[p]) > w) w=length("vpn-switch " cu[p]) }
      w+=2
      if (mode=="detail") {
        if (!(target in cu)) { print "Unknown command: " target; exit 1 }
        print ch "vpn-switch " cu[target] cr
        print "  " cs[target]
        if (cnp[target]>0){ print ""; print ch "Arguments:" cr; for(i=1;i<=cnp[target];i++) print "  " cp[target,i] }
        if (cr_[target]!=""){ print ""; print ch "Output:" cr "  " cr_[target] }
        if (cne[target]>0){ print ""; print ch "Examples:" cr; for(i=1;i<=cne[target];i++) print "  " cc cex[target,i] cr }
        if (cns[target]>0){ print ""; print ch "See also:" cr; for(i=1;i<=cns[target];i++) print "  " cc "vpn-switch " cse[target,i] cr }
        exit 0
      }
      if (mode=="prefix") {
        n=0; for(p in cu) if (index(p, target)==1) n++
        if (n==0) { print "No help for: " target; exit 1 }
        for(p in cu) if (index(p, target)==1) { pad=w-length("vpn-switch " cu[p]); s=sprintf("%-"pad"s",""); print "  " cc "vpn-switch " cu[p] cr s cg cs[p] cr }
        exit 0
      }
      # order groups
      for(a=1;a<=ndg;a++) ord[a]=dgall[a]
      for(a=2;a<=ndg;a++){ k=ord[a]; b=a-1; while(b>=1 && dgo[ord[b]]>dgo[k]){ ord[b+1]=ord[b]; b-- } ord[b+1]=k }
      if (mode=="manpage") {
        for(a=1;a<=ndg;a++){
          g=ord[a]
          if (g=="openvpn") continue            # collapsed into the wireguard section
          if (gmn[g]==0 && tpn[g]==0) continue
          title=dgt[g]; proto=0
          if (g=="wireguard"){ title="Protocol-specific (wireguard, openvpn)"; proto=1 }
          print "## " title; print ""
          if (proto){
            print "Manage configurations, groups and tunnels for both **wireguard** and **openvpn**. The two subcommands share the same shape; substitute either where *\\<proto\\>* appears."; print ""
          } else if (dgb[g]!=""){ nn=split(dgb[g],bl,"\n"); for(i=1;i<=nn;i++) print mesc(bl[i]); print "" }
          for(i=1;i<=gmn[g];i++){ p=gm[g,i]; u=cu[p]; if(proto) sub(/^wireguard /,"<proto> ",u)
            print "**" mesc(u) "**"; print ":   " mesc(cs[p]); print "" }
          for(i=1;i<=tpn[g];i++){ print "**" mesc(tpt[g,i]) "**"; print ":   "; m=split(tpb[g,i],tl,"\n"); for(j=1;j<=m;j++) print "    " mesc(tl[j]); print "" }
        }
        exit 0
      }
      first=1
      for(a=1;a<=ndg;a++){
        g=ord[a]
        if (mode=="group" && g!=target) continue
        if (gmn[g]==0 && tpn[g]==0) continue
        if (!first) print ""
        first=0
        print ch dgt[g] cr
        print ""
        if (dgb[g]!="") { intro=dgb[g]; gsub(/\n/," ",intro); print "  " cg intro cr; print "" }
        for(i=1;i<=gmn[g];i++){ p=gm[g,i]; pad=w-length("vpn-switch " cu[p]); s=sprintf("%-"pad"s",""); print "  " cc "vpn-switch " cu[p] cr s cg cs[p] cr }
        for(i=1;i<=tpn[g];i++){ print "  " ch tpt[g,i] cr; m=split(tpb[g,i],tl,"\n"); for(j=1;j<=m;j++) print "    " cg tl[j] cr }
      }
    }
  '
}

#@help _status0
# @command status
# @summary Show a brief status of the active VPN and its interfaces
# @group   diagnostics
# @returns VPN status and network interface state
# @example vpn-switch status
# @see     session list
#@end
_status0() {
  # Use variable substitution in heredoc (no quotes on EOF)
  cat <<EOF
echo "=== VPN Status ==="
# Report only connections owned by THIS database. The session/latest-<iface>
# ownership symlink is created on connect and removed on disconnect, so it is
# both DB-scoped (an unrelated wg0/tun0 from another tool or database does not
# count) and persistent — unlike a wg-quick process, which exits once the kernel
# interface is up. We confirm the owned interface actually exists. Both checks
# are non-root-readable and avoid busybox-incompatible flags (e.g. pgrep -q).
if [ -L "$VPN_SWITCH_BASE/session/latest-$VPN_SWITCH_INTERFACE_wireguard" ] && $EXAMINE_NETWORK_INTERFACE_EXISTS "$VPN_SWITCH_INTERFACE_wireguard" >/dev/null 2>>"$LOG_FILE"; then
  echo "WireGuard: Connected ($VPN_SWITCH_INTERFACE_wireguard)"
  $EXAMINE_VPN_WIREGUARD_INTERFACE "$VPN_SWITCH_INTERFACE_wireguard" 2>>"$LOG_FILE" || true
elif [ -L "$VPN_SWITCH_BASE/session/latest-$VPN_SWITCH_INTERFACE_openvpn" ] && $EXAMINE_NETWORK_INTERFACE_EXISTS "$VPN_SWITCH_INTERFACE_openvpn" >/dev/null 2>>"$LOG_FILE"; then
  echo "OpenVPN: Connected ($VPN_SWITCH_INTERFACE_openvpn)"
else
  echo "Status: Disconnected"
fi
echo ""
echo "=== Network Interfaces ==="
$EXAMINE_NETWORK_INTERFACES "$VPN_SWITCH_INTERFACE_wireguard" 2>>"$LOG_FILE" || echo "$VPN_SWITCH_INTERFACE_wireguard: not found"
EOF
}

#@help _help0
# @command help [<subcommand>]
# @summary Show top-level help, or help for a command group or topic
# @group   setup
# @param   subcommand  command group (wireguard, session, ...) or topic (environment, profile)
# @returns help text (no database required)
# @example vpn-switch help session
#@end
_help0() {
  local c_reset="" c_heading="" c_gray=""
  if [ "${VPN_SWITCH_DISPLAY_ANSI:-0}" = "1" ]; then
    c_reset="$COLOR_RESET"; c_heading="$COLOR_BLUE"; c_gray="$COLOR_GRAY"
  fi
  printf '%b\n' "${c_heading}vpn-switch${c_reset} - POSIX-shell VPN connection manager for FreeBSD and Linux"
  echo ""
  printf '%b\n' "Switch between WireGuard and OpenVPN servers, manage configs, and cache"
  printf '%b\n' "sessions for fast reconnects. Commands are grouped below."
  echo ""
  printf '%b\n' "${c_gray}Usage:${c_reset} vpn-switch <command> [arguments]"
  printf '%b\n' "${c_gray}Detail for any command:${c_reset} vpn-switch help <command>   ${c_gray}(e.g. vpn-switch help session show)${c_reset}"
  echo ""
  echo "----------------------------------------------------------------------"
  echo ""
  help_render overview
  echo ""
  echo "----------------------------------------------------------------------"
  printf '%b\n' "${c_gray}Concept topics:${c_reset} vpn-switch help environment | profile | phases"
  printf '%b\n' "${c_gray}A command group:${c_reset} vpn-switch help wireguard | openvpn | session"
}

#@help _help1
# @internal arity-1 sibling of 'help' (subcommand/topic dispatch)
#@end
_help1() {
  local topic="$1"
  local pager="${PAGER:-cat}"

  case "$topic" in
    wireguard|openvpn|session|sessions)
      help_render query "$topic"
      ;;

    environment)
      cat <<'EOF' | $pager >&2

=========================================================================================
Environment System and Safety-First Design
=========================================================================================

vpn-switch uses a safety-first design philosophy: by default, commands are DISPLAYED
rather than EXECUTED. This prevents accidental system changes and lets you review
commands before running them.

-----------------------------------------------------------------------------------------
Why Am I Seeing Commands Instead of Execution?
-----------------------------------------------------------------------------------------

When you run commands like:
  vpn-switch wireguard start privacy
  vpn-switch wireguard clean

You'll see shell commands printed to your terminal instead of immediate execution.
This is INTENTIONAL and SAFE. It's controlled by the VPN_SWITCH_TERMINAL_INTERPRETER
environment variable.

Default behavior:  VPN_SWITCH_TERMINAL_INTERPRETER=cat    (display commands, don't execute)
Convenience mode:  VPN_SWITCH_TERMINAL_INTERPRETER=sh     (execute commands automatically)

-----------------------------------------------------------------------------------------
How to Enable Auto-Execution
-----------------------------------------------------------------------------------------

If you want commands to execute automatically, use the setenv command:

  vpn-switch setenv VPN_SWITCH_TERMINAL_INTERPRETER "sh"

That's it! Now vpn-switch will execute commands automatically instead of displaying them.

To verify the change:
  vpn-switch printenv | grep VPN_SWITCH_TERMINAL_INTERPRETER

To revert back to display-only mode:
  vpn-switch setenv VPN_SWITCH_TERMINAL_INTERPRETER "cat"

-----------------------------------------------------------------------------------------
Environment Variable Structure
-----------------------------------------------------------------------------------------

vpn-switch resolves each variable through a THREE-layer cascade:

  template/environment/   Shipped baseline (read-only, ships with vpn-switch)
  .env/default/           Profile defaults (installed by bootstrap)
  .env/local/             Machine-specific overrides (highest priority, git-ignored)

Each variable is a separate file containing its value on line 1; the lines
below are its documentation.

Priority: local -> default -> template (the first that exists wins).

  vpn-switch getenv  <VAR>            effective value + which layer it came from
  vpn-switch helpenv <VAR>           value + the variable's documentation
  vpn-switch helpenv <VAR> template  inspect one specific layer

-----------------------------------------------------------------------------------------
Key Environment Variables
-----------------------------------------------------------------------------------------

VPN_SWITCH_BASE
  Base directory for vpn-switch database
  Must be set via environment variable (cannot be overridden in .env files)
  Default: /usr/local/etc/vpn-switch

VPN_SWITCH_TERMINAL_INTERPRETER
  Controls whether commands are displayed or executed automatically
  Default: cat (safety-first, display only)
  Convenience: sh (auto-execute)

  This is the main setting most users want to customize.

VPN_SWITCH_COMBINATOR_INTERPRETER
  Internal: Controls command chaining between vpn-switch operations
  Default: xargs-based recursion (required for proper operation)

  Advanced users only - changing this may break functionality.

VPN_SWITCH_BATCH_COMBINATOR_INTERPRETER
  Internal: Controls batch command processing (dump, restore, batch)
  Default: sh wrapper around combinator (required for proper operation)

  Advanced users only - changing this may break functionality.

VPN_SWITCH_DISPLAY_ANSI
  Enable/disable colored output
  Values: 0 (off), 1 (on)

VPN_SWITCH_RETENTION_DAYS_LOG
  Automatic log file retention (stderr output)
  Default: 1 (keep logs for 1 day)
  Set to 0 to disable logging
  Logs stored in: $VPN_SWITCH_BASE/.log/YYYY-MM-DD/

VPN_SWITCH_RETENTION_DAYS_TRACE
  Automatic trace file retention (execution flow)
  Default: 1 (keep traces for 1 day)
  Set to 0 to disable tracing
  Traces stored in: $VPN_SWITCH_BASE/.log/YYYY-MM-DD/

  Example: Enable 7-day retention for debugging:
    vpn-switch setenv VPN_SWITCH_RETENTION_DAYS_LOG 7
    vpn-switch setenv VPN_SWITCH_RETENTION_DAYS_TRACE 7

  Files are automatically cleaned up after retention period expires.
  Each command invocation creates timestamped log/trace files.

-----------------------------------------------------------------------------------------
PATH Variables: Two Distinct Execution Contexts
-----------------------------------------------------------------------------------------

Every external command vpn-switch runs is executed in an ISOLATED environment
(via 'env -'): the environment is cleared and rebuilt from your .env files for
each call, so nothing leaks in from the calling shell. Two PATH variables
control command lookup in the two contexts.

PATH
  Used by: vpn-switch.sh itself (management: inspect, validate, status, list,
           config handling) and the interpreter that runs each function.
  Default: /sbin:/bin:/usr/bin:/usr/local/bin
  Purpose: Resolve the external tools that management invokes BY BARE NAME -
           both coreutils (sh, sed, grep, readlink, stat, ...) and the
           read-only system inspectors (ifconfig, netstat, pfctl, wg, ps, ...).
           Some of these live in /sbin, which is why /sbin is on this PATH.

  Management only READS system state; it never runs the privileged bring-up
  tools (wg-quick, openvpn) - those run from the generated scripts. That is why
  this PATH omits /usr/sbin and /usr/local/sbin: a deliberately narrower lookup
  path than the connect scripts get.

VPN_SWITCH_PATH
  Used by: the generated connect.sh / disconnect.sh scripts ONLY. It is
           hardcoded into them at generation time (see the phase prologue);
           vpn-switch.sh itself never consults it.
  Default: /sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
  Purpose: Resolve the PRIVILEGED VPN operations (wg-quick, openvpn, pfctl,
           route, ifconfig) - hence the full set of sbin directories.

WHY TWO?

  The two contexts have different needs. Management does read-only inspection
  (a moderate PATH, with /sbin). The generated scripts do privileged network
  changes (a broad PATH, with every sbin). Keeping them separate means the
  management process never carries a PATH wider than it needs.

COMMON SCENARIOS:

1. Using sudo for the privileged step:
     vpn-switch setenv VPN_SWITCH_INTERPRETER_wireguard_connect "sudo sh"
   - vpn-switch.sh uses PATH to find 'sudo'.
   - 'sudo sh' runs the generated connect.sh, which uses VPN_SWITCH_PATH
     (the full sbin set) for pfctl, wg-quick, etc.

2. Custom tool locations for management:
     vpn-switch setenv PATH "/sbin:/bin:/usr/bin:/usr/local/bin:/opt/local/bin"
   Keep /sbin so the read-only inspectors (ifconfig, pfctl) are still found.

3. Custom locations for the privileged tools:
     vpn-switch setenv VPN_SWITCH_PATH "/sbin:/usr/sbin:/usr/local/sbin:/opt/sbin:/bin:/usr/bin"
   Affects only the generated connect/disconnect scripts.

IMPORTANT: PATH governs how vpn-switch.sh finds commands; VPN_SWITCH_PATH
governs how the generated scripts find VPN tools. They are independent. Do NOT
strip /sbin from PATH - 'inspect', 'validate' and 'status' rely on it.

For detailed explanation, see:
  docs/ARCHITECTURE.md - PATH Architecture section

-----------------------------------------------------------------------------------------
Interpreter Resolution Mechanism
-----------------------------------------------------------------------------------------

Each function's output is handed to an "interpreter". vpn-switch picks it
through a priority chain (first match wins):

1. Arity-specific override (highest priority - the SECURED setting)
     VPN_SWITCH_INTERPRETER_<function><arity>
     Example: VPN_SWITCH_INTERPRETER_wireguard_start1
     Sits at the very top: it shadows everything below and cannot be changed
     as a side effect of tuning a broader setting.

2. Arity-agnostic override
     VPN_SWITCH_INTERPRETER_<function>
     Example: VPN_SWITCH_INTERPRETER_wireguard_start

3. Intrinsic class default - a FALLBACK, not a foundation:
     _function   → VPN_SWITCH_TERMINAL_INTERPRETER          (default: cat)
     __function  → VPN_SWITCH_COMBINATOR_INTERPRETER        (default: re-dispatch)
     ___function → VPN_SWITCH_BATCH_COMBINATOR_INTERPRETER

IMPORTANT - the class default is a safety net, not where a command should
declare its interpreter. VPN_SWITCH_TERMINAL_INTERPRETER is the broadest,
safety-first setting (cat = show, don't run), and most users flip it to "sh"
for auto-execution. A command that merely RELIES on that default therefore
changes behaviour the moment the user opts into "sh". Commands whose behaviour
must NOT depend on that choice - the help system, for instance - pin their own
arity-specific override (step 1) instead. That is exactly what the specialization
mechanism is for: out of the fallback, into a secured setting.

Why "cat" as the default is safe: terminal functions emit output that is INERT
by default - data lines are written as '# ' comments. Under "cat" you see them;
under "sh" the comments are harmless no-ops; a display interpreter such as
'cut -b3-' strips the leading '# ' for clean output. So flipping the terminal
interpreter to "sh" never executes a terminal's data by accident.

This gives fine-grained control: make one command auto-execute while keeping
others display-only - and pin safety-critical commands so that no global toggle
can reach them.

Inspect and set interpreters with the shortcuts:
  vpn-switch getintp  <function>             show a function's interpreter
  vpn-switch setintp  <function> <interp>    set it (e.g. setintp wireguard_start 'sudo sh')
  vpn-switch helpintp <function>             show the interpreter variable's docs

-----------------------------------------------------------------------------------------
For More Information
-----------------------------------------------------------------------------------------

See also:
  vpn-switch help profile    Profile system and installation

README.md for complete documentation on:
  - Config management workflow
  - Session caching and resumption
  - Protocol-specific features
  - Database management

=========================================================================================
EOF
      ;;

    profile)
      cat <<'EOF' | $pager >&2

=========================================================================================
Profile System - Installation and Configuration
=========================================================================================

Profiles define which environment variables are installed during bootstrap/init.
They provide pre-configured sets of settings for different use cases.

-----------------------------------------------------------------------------------------
What Are Profiles?
-----------------------------------------------------------------------------------------

Each profile is a file in the template directory (VPN_SWITCH_PROFILE_<NAME>) containing
a space-separated list of variable names to install to .env/default/.

When you run bootstrap or init with a profile, vpn-switch:
  1. Reads the profile file (line 1 contains the variable list)
  2. Copies each listed variable from the template directory to .env/default/
  3. Sets proper permissions (0600)

This gives you explicit control over which settings are installed.

-----------------------------------------------------------------------------------------
Built-in Profiles
-----------------------------------------------------------------------------------------

minimal  - Essential settings only (base interpreters + display functions)
           Recommended for most users - fast and secure by default
           ~13 variables installed

           Variables included:
           - VPN_SWITCH_TERMINAL_INTERPRETER (safety-first: cat)
           - VPN_SWITCH_COMBINATOR_INTERPRETER (command chaining)
           - VPN_SWITCH_BATCH_COMBINATOR_INTERPRETER (batch processing)
           - Display function overrides (help, list, status, etc.)

all      - All available environment variables (~65 variables)
           Useful for development, testing, or full customization
           Complete control over every aspect of vpn-switch behavior

           Includes everything: all interpreters, all protocol settings,
           firewall configs, DNS settings, paths, etc.

custom   - User-defined profile (boilerplate provided)
           Create your own by editing template/environment/VPN_SWITCH_PROFILE_CUSTOM
           Example: Start with minimal, add only what you need

-----------------------------------------------------------------------------------------
Which Profile Should I Choose?
-----------------------------------------------------------------------------------------

Start with minimal:
  - Covers 95% of use cases
  - Faster installation (fewer files to copy)
  - Easier to understand (fewer variables to configure)
  - Secure by default (safety-first mode)
  - You can always add individual variables later to .env/local/

Use all when:
  - You want complete control over all settings
  - You're developing or testing vpn-switch itself
  - You need to customize protocol-specific behavior
  - You want to see all available options

Use custom when:
  - You have specific requirements (e.g., production deployment)
  - You want a middle ground between minimal and all
  - You're deploying to multiple machines with same config

-----------------------------------------------------------------------------------------
Using Profiles
-----------------------------------------------------------------------------------------

During initial setup (bootstrap):

  vpn-switch bootstrap /path/to/database minimal   # Recommended
  vpn-switch bootstrap /path/to/database all       # Full control
  vpn-switch bootstrap /path/to/database custom    # Your custom set

-----------------------------------------------------------------------------------------
Creating Custom Profiles
-----------------------------------------------------------------------------------------

1. Copy an existing profile as a starting point:

   cd template/environment
   cat VPN_SWITCH_PROFILE_MINIMAL > VPN_SWITCH_PROFILE_PRODUCTION

2. Edit line 1 to add/remove variables:

   # Add variables you need (space-separated on line 1):
   vi VPN_SWITCH_PROFILE_PRODUCTION

   # Line 1 example:
   VPN_SWITCH_TERMINAL_INTERPRETER VPN_SWITCH_PFCTL VPN_SWITCH_PF_CONF ...

3. Use your new profile:

   vpn-switch bootstrap /path/to/db production

User-defined profiles work automatically - vpn-switch discovers all files matching
VPN_SWITCH_PROFILE_* and makes them available. No code changes needed!

To list available profiles:

  ls -1 template/environment/VPN_SWITCH_PROFILE_* | sed 's/.*PROFILE_//' | tr '[:upper:]' '[:lower:]'

-----------------------------------------------------------------------------------------
Maintaining Profiles
-----------------------------------------------------------------------------------------

After adding new variables to template/environment/, regenerate PROFILE_ALL:

  cd template/environment
  ls -1 | grep -v '^VPN_SWITCH_PROFILE_' | tr '\n' ' ' > /tmp/vars
  # Edit /tmp/vars to replace line 1 of VPN_SWITCH_PROFILE_ALL
  vi VPN_SWITCH_PROFILE_ALL

Or use this one-liner:

  cd template/environment && (head -1 VPN_SWITCH_PROFILE_ALL; ls -1 | grep -v '^VPN_SWITCH_PROFILE_' | tr '\n' ' ') | sponge VPN_SWITCH_PROFILE_ALL

-----------------------------------------------------------------------------------------
For More Information
-----------------------------------------------------------------------------------------

See also:
  vpn-switch help environment    Runtime behavior and customization

=========================================================================================
EOF
      ;;

    phases)
      cat <<'EOF' | $pager >&2

=========================================================================================
Phases and the Patch Step - Adapting and Acting on VPN Configs
=========================================================================================

Connecting a VPN is more than "bring the tunnel up". It usually also means:
adjust the firewall, set DNS, sometimes more. vpn-switch expresses all of that as
a short, ordered list of PHASES - and it first PATCHES the provider's config so
the same file works regardless of which OS it was downloaded for.

-----------------------------------------------------------------------------------------
The patch step - why your provider's .conf "just works"
-----------------------------------------------------------------------------------------

Provider configs are almost always written for Linux. A VPN provider WireGuard file,
for instance, carries Linux-specific DNS hooks:

  PostUp   = resolvconf -a %i -m 0 -x
  PostDown = resolvconf -d %i

Those assume Linux's resolvconf and break or misbehave elsewhere (e.g. FreeBSD).
vpn-switch does NOT run the provider file as-is. At start time it PATCHES a
session copy of it:

  - strips the embedded Linux DNS hooks (PostUp/PostDown ... resolvconf),
  - hands DNS to the configurable DNS phase instead,
  - (OpenVPN) injects the up/down scripts, daemon mode and the interface.

So one downloaded config works on FreeBSD and Linux alike. Preview exactly what
would be used, without connecting:

  vpn-switch wireguard patch <config>
  vpn-switch openvpn   patch <config>

-----------------------------------------------------------------------------------------
Phases - the ordered actions of connect / disconnect
-----------------------------------------------------------------------------------------

Each operation is a list of phases, run in order. Defaults:

  VPN_SWITCH_PHASES_CONNECT    = firewall vpn dns
  VPN_SWITCH_PHASES_DISCONNECT = dns vpn firewall      (the reverse - tear down safely)
  VPN_SWITCH_PHASES_INSPECT    = firewall vpn dns

Each phase is generated from a BACKEND script, so you pick the tool that fits the
machine:

  firewall:  pf | ipfw | iptables | none
  dns:       resolvconf | unbound | djbdns | dnsmasq | none

Full phase grammar:  phase[:backend][@profile]

  vpn-switch setenv VPN_SWITCH_PHASES_CONNECT    "firewall:pf vpn dns:unbound"
  vpn-switch setenv VPN_SWITCH_PHASES_DISCONNECT "dns:unbound vpn firewall:pf"

- :backend  picks the tool for that phase (lists above).
- @profile  picks a profile directory of backend scripts. Without @profile the
            'default' profile is used (default -> base). A profile can hold
            platform-specific variants, e.g. firewall:pf@openbsd resolves to
            .include/phase/openbsd/firewall/pf.sh.

Resolution is STRICT (least surprise): every phase in the list must resolve to a
script, or generation aborts with a clear error — phases are never silently
dropped. To skip a phase on purpose, use the 'none' backend (e.g.
"firewall:none").

After changing phases - or after upgrading vpn-switch - refresh the generated
scripts:

  vpn-switch phases sync
  vpn-switch phases inspect              # active phase scripts + the default profile

-----------------------------------------------------------------------------------------
Why this flexibility - sophisticated setups need different actions
-----------------------------------------------------------------------------------------

A laptop on pf + local_unbound, a server on iptables + dnsmasq, and a box that
must also flush a cache or poke a service all need DIFFERENT actions at connect
time. Rather than hard-code one way, vpn-switch makes each action a small phase
script you can swap or extend. To add your own backend, copy the template:

  $VPN_SWITCH_LIBDIR/template/phase/base/user-template.sh

It documents the context variables expanded at generation time ($dns_server,
$remote_ips, $interface, $session_dir, $config_file), so you write plain shell
and it is "lifted" into the connect/disconnect scripts automatically.

-----------------------------------------------------------------------------------------
See also
-----------------------------------------------------------------------------------------

  vpn-switch help environment      Interpreters, PATH, environment isolation
  vpn-switch <proto> patch <cfg>   Preview the patched config
  vpn-switch phases inspect        Show the generated phase scripts

=========================================================================================
EOF
      ;;

    *)
      help_render query "$topic"
      ;;
  esac
}

#@help _help2
# @internal arity-2 sibling of 'help' (detail for two-word command paths)
#@end
_help2() {
  help_render query "$1 $2"
}

