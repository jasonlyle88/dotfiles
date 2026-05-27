#!/usr/bin/env zsh
# shellcheck shell=bash

################################################################################
################################################################################
##  antidote.zsh
##
##  Install, configure, and run ZSH Antidote
##
################################################################################
################################################################################

##
##  Setup ZSH Antidote related variables
##
export ANTIDOTE_DIR="${ZDOTDIR}/antidote"
export ANTIDOTE_SOURCE="${ANTIDOTE_DIR}/source"
export ANTIDOTE_HOME="${ANTIDOTE_DIR}/plugins"
export ANTIDOTE_BUNDLE_FILE="${ANTIDOTE_DIR}/zsh_plugins_bundle.txt"
export ANTIDOTE_STATIC_FILE="${ANTIDOTE_HOME}/zsh_plugins_static.zsh"

##
##  Install ZSH Antidote if it is not already installed
##
if ! [[ -d "${ANTIDOTE_SOURCE}" ]]; then
    git clone --depth=1 https://github.com/mattmc3/antidote.git "${ANTIDOTE_SOURCE}"

    if ! [[ -f "${ANTIDOTE_BUNDLE_FILE}" ]]; then
        touch "${ANTIDOTE_BUNDLE_FILE}"
    fi
fi

##
##  Create functions that can be used with antidote plugin conditionals
##
function is-macos() {
    [[ $OSTYPE == 'darwin'* ]]
}

function has-tmux() {
    command -v 'tmux' 1>/dev/null 2>&1
}

##
##  Configure and run ZSH Antidote
##
if [[ -d "${ANTIDOTE_SOURCE}" ]]; then
    # Source ZSH Antidote
    source "${ANTIDOTE_SOURCE}/antidote.zsh"

    # Setup ZSH Antidote settings
    zstyle ':antidote:bundle' use-friendly-names 'yes'
    zstyle ':antidote:bundle' file "${ANTIDOTE_BUNDLE_FILE}"
    zstyle ':antidote:static' file "${ANTIDOTE_STATIC_FILE}"

    # Activate ZSH Antidote
    antidote load
fi
