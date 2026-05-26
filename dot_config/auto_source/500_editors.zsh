# shellcheck shell=bash

################################################################################
# Setup editors
################################################################################

# Setup emacs to be the default editor if it is installed.
if command -v 'emacs' 1>/dev/null 2>&1; then
    export EDITOR='emacs -nw'
    export VISUAL='emacs'
else
    export EDITOR='nano'
    export VISUAL='nano'
fi

# Setup code to be the default visual editor if it is installed.
if command -v 'code' 1>/dev/null 2>&1; then
    export VISUAL='code -w'
fi
