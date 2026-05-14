# shellcheck shell=bash

################################################################################
# Setup starship
################################################################################

# Attempt to install starship
if ! command -v starship 1>/dev/null 2>&1; then
    printf '################################################################################\n'
    printf '# Install starship\n'
    printf '################################################################################\n'
    curl -sS https://starship.rs/install.sh | sh -s -- --yes --bin-dir "${HOME}/.local/bin"
fi

# Exit if starship still not available
if ! command -v starship 1>/dev/null 2>&1; then
    return 0
fi

# Initialize starship theme
eval "$(starship init zsh)"
