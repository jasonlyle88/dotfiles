# shellcheck shell=bash

################################################################################
# Setup homebrew
################################################################################

if ! command -v brew 1>/dev/null 2>&1; then
    return 0
fi

# Setup homebrew shell environment
eval "$(brew shellenv zsh)"
