# shellcheck shell=bash

################################################################################
# Setup Node and NPM settings
################################################################################

export NODE_REPL_HISTORY="${XDG_DATA_HOME}/node/repl_history"
# export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/config"

# Set the user-specific NPM configuration file location
# Set this here so that other tools like bun also know where to look for the
# NPM configuration file even if they do not look at NPM_CONFIG_USERCONFIG.
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/.npmrc"