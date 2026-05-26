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

# Set up aliases for easier navigation
alias cd='z'
alias cdi='zi'
