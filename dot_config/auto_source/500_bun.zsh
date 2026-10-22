# shellcheck shell=bash

################################################################################
# Setup bat
################################################################################

if ! command -v bun 1>/dev/null 2>&1; then
    return 0
fi

# bun installed through mise
export BUN_INSTALL="${HOME}/.cache/.bun"

# Add bun tools to path
path=(
    "${BUN_INSTALL}/bin"
    "${path[@]}"
)
