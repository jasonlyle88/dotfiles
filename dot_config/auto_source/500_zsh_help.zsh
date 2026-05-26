# shellcheck shell=bash

################################################################################
# Setup ZSH Help
################################################################################

autoload run-help
export HELPDIR=/usr/share/zsh/"${ZSH_VERSION}"/help
alias help=run-help
