# shellcheck shell=bash
################################################################################
# Setup starship
################################################################################
if ! command -v starship 1>/dev/null 2>&1; then
    return 0
fi

# Initialize starship theme
eval "$(starship init zsh)"
