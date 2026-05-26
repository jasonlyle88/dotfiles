# shellcheck shell=bash

################################################################################
# Setup ZSH Execute After Each Command
################################################################################

if command -v zsh-execute-after-command-add-functions 1>/dev/null 2>&1; then
    zstyle ':execute-after-command:user-setting:*' 'check-active-window'                    'yes'
    zstyle ':execute-after-command:user-setting:*' 'suppress-unable-check-active-window'    'yes'
fi
