#!/usr/bin/env zsh
# shellcheck shell=bash

################################################################################
################################################################################
##  fonts.zsh
##
##  Install fonts according to operating system
##
################################################################################
################################################################################


##
##  Setup font related variables
##
export FONT_HOME="${XDG_CONFIG_HOME}/fonts"
if [[ "${OSTYPE}" == "darwin"* ]]; then
    export FONT_INSTALL_DIR="${HOME:?}/Library/Fonts"
else
    export FONT_INSTALL_DIR="${XDG_DATA_HOME}/fonts"
fi

##
##  Immediately invoked function to do the actual font setup
##
function () {
    mkdir -p "${FONT_INSTALL_DIR}"

    # Get length of the path string to FONT_HOME so it can easily be used
    # to make relative paths from there
    local startPos="${#FONT_HOME}"
    local fontFileName
    local installedFontFile

    startPos="$(( startPos + 1 ))"

    while IFS= read -r -u3 -d $'\0' fontFile; do
        fontFileName="${fontFile:${startPos}}"
        installedFontFile="${FONT_INSTALL_DIR}/${fontFileName}"
        if [[ ! -f "${installedFontFile}" ]] ; then
            cp -a "${fontFile}" "${installedFontFile}"
        fi
    done 3< <(find "${FONT_HOME}" -type f -print0)

    if command -v 'fc-cache' 1>/dev/null 2>&1; then
        'fc-cache' "${FONT_INSTALL_DIR}"
    fi
}
