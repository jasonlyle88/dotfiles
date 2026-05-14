# shellcheck shell=bash

################################################################################
# Setup mise
################################################################################

# Attempt to install mise
if ! command -v mise 1>/dev/null 2>&1; then
    printf '################################################################################\n'
    printf '# Install mise\n'
    printf '################################################################################\n'
    curl -sS https://mise.run | sh
fi

# Exit if mise still not available
if ! command -v mise 1>/dev/null 2>&1; then
    return 0
fi

# Activate mise
eval "$(mise activate zsh)"
