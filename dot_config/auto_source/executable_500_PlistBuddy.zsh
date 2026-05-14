# shellcheck shell=bash
################################################################################
# Setup PistBuddy
################################################################################
if [[ ! -x '/usr/libexec/PlistBuddy' ]]; then
    return 0
fi

alias PlistBuddy='/usr/libexec/PlistBuddy'
