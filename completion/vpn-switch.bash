# bash completion for vpn-switch
#
# The shell side is deliberately thin: it hands the words typed so far to
# 'vpn-switch complete', which derives the candidates from the #@help corpus
# (command words from the @command usages, placeholder values from the
# database via @completion/@defcompletion). Nothing here needs updating when
# commands are added or renamed.
#
# Install (any one of):
#   /usr/local/share/bash-completion/completions/vpn-switch     (gmake install)
#   ~/.local/share/bash-completion/completions/vpn-switch        (per user)
#   . completion/vpn-switch.bash                                 (ad hoc)
#
# Protocol: one candidate per line; the lines "@files" and "@dirs" ask the
# shell to complete paths itself.

_vpn_switch_complete() {
    local line
    local -a words=("${COMP_WORDS[@]:1:COMP_CWORD}")
    COMPREPLY=()
    while IFS= read -r line; do
        case $line in
            @files) compopt -o default 2>/dev/null ;;
            @dirs)  compopt -o dirnames 2>/dev/null ;;
            '')     ;;
            *)      COMPREPLY+=("$line") ;;
        esac
    done < <(vpn-switch complete "${words[@]}" 2>/dev/null)
}

complete -F _vpn_switch_complete vpn-switch
