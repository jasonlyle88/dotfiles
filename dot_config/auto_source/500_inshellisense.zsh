# shellcheck shell=bash

################################################################################
# Setup inshellisense
################################################################################

if ! command -v inshellisense 1>/dev/null 2>&1; then
    return 0
fi

inshellisense_home="${HOME}/.inshellisense"

# Setup inshellisense shell environment
[[ -f "${inshellisense_home}/init/zsh/init.zsh" ]] && source "${inshellisense_home}/init/zsh/init.zsh"
