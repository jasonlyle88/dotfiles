# shellcheck shell=bash
################################################################################
# Setup mise
################################################################################
if ! command -v mise 1>/dev/null 2>&1; then
    return 0
fi

# Activate mise
eval "$(mise activate zsh)"
