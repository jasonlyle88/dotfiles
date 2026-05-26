# shellcheck shell=bash

################################################################################
# Setup ZSH Hooks
################################################################################

# Setup a preexec hook to set the terminal title to the full command if it contains "sql"
jml_preexec() {
    local originalCommand="${1}"
    local expandedCommandShort="${2}"
    local expandedCommandFull="${3}"

    # If command contains SQL somewhere in it, then print the whole command
    # string in the title
    if
        [[ "${expandedCommandFull}" =~ ^sql$ ]] ||
        [[ "${expandedCommandFull}" =~ ^sql[^a-zA-Z0-9_] ]] ||
        [[ "${expandedCommandFull}" =~ [^a-zA-Z0-9_]sql[^a-zA-Z0-9_] ]] ||
        [[ "${expandedCommandFull}" =~ [^a-zA-Z0-9_]sql$ ]]
    then
        title "${expandedCommandFull}"
    fi
}

# Add the preexec hook to the list of preexec functions
preexec_functions+=(jml_preexec)
