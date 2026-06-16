# shellcheck shell=bash

################################################################################
# Setup Python
################################################################################

if ! command -v python 1>/dev/null 2>&1; then
    return 0
fi

export PYTHON_HISTORY="${XDG_STATE_HOME}/python_history"