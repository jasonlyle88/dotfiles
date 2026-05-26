# shellcheck shell=bash

################################################################################
# Enable Key Centralization
################################################################################

export KEY_CENTRALIZATION_HOME="${XDG_DATA_HOME}/key_centralization"

if [[ ! -d "${KEY_CENTRALIZATION_HOME}" ]]; then
    return 0
fi

# Add key centralization functions to fpath for autoloading
fpath=(
    "${KEY_CENTRALIZATION_HOME}/bin"
    "${fpath[@]}"
)

autoload -Uz keyBackup
autoload -Uz keyRestore
