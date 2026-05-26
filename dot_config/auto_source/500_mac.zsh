# shellcheck shell=bash

################################################################################
# Setup MacOS specific variables and aliases
################################################################################

if [[ "${OSTYPE}" != "darwin"* ]]; then
    return 0
fi

#Make an ISO file
#Intended useage: mac.makeiso [ISO NAME] [FILE/DIR to use for making ISO]
alias mac.makeiso="hdiutil makehybrid -iso -joliet -o"

#Dock utils
alias mac.add-dock-spacer="defaults write com.apple.dock persistent-apps -array-add '{\"tile-type\"=\"small-spacer-tile\";}' && killall Dock"

#Finder shorcuts
alias finder.hidden-show="defaults write com.apple.finder AppleShowAllFiles TRUE && killall Finder"
alias finder.hidden-hide="defaults write com.apple.finder AppleShowAllFiles FALSE && killall Finder"
alias finder.path="pfd"
finder.open() {
    # grab the first arg or default to pwd
    local target="${1:-${PWD}}"

    # Get containing directory if the target is a file
    if [[ -f "${target}" ]]; then
        target="$(dirname "${target}")"
    fi

    open "${target}"
}

# Quick go
alias go.finder="cd \"\$(pfd)\""

# Alias system bash to bash3
alias bash3="/bin/bash"
