# shellcheck shell=bash

################################################################################
# Setup tmux
################################################################################

if ! command -v 'tmux' 1>/dev/null 2>&1; then
    return 0
fi

alias tl='tmux list-sessions'
alias tls='tmux list-sessions'
alias tns='tmux new-session -s'
alias tas='tmux attach-session -t'
alias ts='tmux new-session -A -s'
alias tksv='tmux kill-server'

if ! tmux has-session -t 'jlyle' 1>/dev/null 2>&1; then
    tmux new-session -ds 'jlyle'
fi

if [[ -n "${TMUX}" ]]; then
    alias exit='tmux detach'
fi
