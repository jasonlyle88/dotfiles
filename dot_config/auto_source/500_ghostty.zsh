# shellcheck shell=bash

################################################################################
# Setup GhosTTY Shell integrations
################################################################################

# GhosTTY Shell integrations
if [[ -n $GHOSTTY_RESOURCES_DIR ]]; then
    source "$GHOSTTY_RESOURCES_DIR"/shell-integration/zsh/ghostty-integration
fi
