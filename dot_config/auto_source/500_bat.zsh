# shellcheck shell=bash

################################################################################
# Setup bat
################################################################################

if ! command -v bat 1>/dev/null 2>&1; then
    return 0
fi

# Replace cat with bat, retaining no lines or pager
alias cat='bat --plain --paging=never'
alias rcat='command cat'

# Replace man with a bat-powered man
alias man='batman'
alias rman='command man'
