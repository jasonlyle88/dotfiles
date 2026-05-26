# shellcheck shell=bash
################################################################################
# Configure zsh-autosuggestions
################################################################################

if
    ! (( ${+widgets[autosuggest-accept]} )) ||
    ! (( ${+widgets[autosuggest-execute]} )) ||
    ! (( ${+widgets[autosuggest-clear]} )) ||
    ! (( ${+widgets[autosuggest-fetch]} )) ||
    ! (( ${+widgets[autosuggest-disable]} )) ||
    ! (( ${+widgets[autosuggest-enable]} )) ||
    ! (( ${+widgets[autosuggest-toggle]} ));
then
    return 0
fi

# If zoxide is installed, do not use history autosuggestions for cd, z, or zi
if command -v 'zoxide' 1>/dev/null 2>&1; then
    export ZSH_AUTOSUGGEST_HISTORY_IGNORE='cd *|z *|zi *'
fi
