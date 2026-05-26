# shellcheck shell=bash

################################################################################
# Setup symlink helpers
################################################################################

function symlink.create() {
    local symlink="${1}"
    local target="${2}"

    ln -s "${target}" "${symlink}"
} # symlink.create

function symlink.update() {
    local symlink="${1}"
    local target="${2}"

    ln -vfns "${target}" "${symlink}"
} # symlink.update

function symlink.delete() {
    local symlink="${1}"

    rm "${symlink}"
} # symlink.delete
