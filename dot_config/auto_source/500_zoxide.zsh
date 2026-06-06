# shellcheck shell=bash

################################################################################
# Enable Zoxide
################################################################################

# Check if zoxide is installed, exit if not
if ! command -v 'zoxide' 1>/dev/null 2>&1; then
    return
fi

# Initialize zoxide for ZSH
eval "$(zoxide init zsh)"

# Store what zoxide uses as a default when nothing is set in _ZO_FZF_OPTS
export _ZO_FZF_OPTS_DEFAULT_BASE='--exact --no-sort --bind=ctrl-z:ignore,btab:up,tab:down --cycle --keep-right --border=sharp --height=45% --info=inline --layout=reverse --tabstop=1 --exit-0'

# Set _ZO_FZF_OPTS with the default options and my own options
export _ZO_FZF_OPTS="${_ZO_FZF_OPTS_DEFAULT_BASE} --select-1"

# Set up aliases for easier navigation
alias cd='z'
alias cdi='zi'
