# shellcheck shell=bash
################################################################################
# Enable Key Centralization
################################################################################
export KEY_CENTRALIZATION_HOME="${XDG_DATA_HOME}/key_centralization"

if [[ ! -d "${KEY_CENTRALIZATION_HOME}" ]]; then
    return 0
fi

pathmunge -f "${KEY_CENTRALIZATION_HOME}/bin"

autoload -Uz keyBackup
autoload -Uz keyRestore
