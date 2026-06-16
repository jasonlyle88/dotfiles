# shellcheck shell=bash

################################################################################
# Setup Gradel
################################################################################

export GRADLE_USER_HOME="${XDG_DATA_HOME}/gradle"

if ! command -v gradle 1>/dev/null 2>&1; then
    return 0
fi
