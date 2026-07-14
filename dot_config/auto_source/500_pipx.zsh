# shellcheck shell=bash

################################################################################
# Setup PipX
################################################################################

if ! command -v pipx 1>/dev/null 2>&1; then
    return 0
fi

# Allow pipx to use the python interpreter currently configured for use
export PIPX_DEFAULT_PYTHON='python'

# Default to never fetching missing Python versions
export PIPX_FETCH_PYTHON='never'

# Other variables that can be set to control PIPX
export PIPX_HOME="${XDG_DATA_HOME}/pipx"
export PIPX_BIN_DIR="${XDG_BIN_HOME}"
export PIPX_MAN_DIR="${XDG_DATA_HOME}/man"
# export PIPX_GLOBAL_HOME=
# export PIPX_GLOBAL_BIN_DIR=
# export PIPX_GLOBAL_MAN_DIR=
# export PIPX_SHARED_LIBS=
# export USE_EMOJI=
# export PIPX_HOME_ALLOW_SPACE=

export PATH="${PIPX_BIN_DIR}:${PATH}"