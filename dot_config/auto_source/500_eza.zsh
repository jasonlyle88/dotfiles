# shellcheck shell=bash

################################################################################
# Setup eza
################################################################################

if ! command -v eza 1>/dev/null 2>&1; then
    return 0
fi

# Alias rls back to the real built-in ls
alias rls='command ls'

# l=ls, la=lsa where lsa is nearly equivalent to built-in ls -a
alias l='eza --hyperlink --git'
alias la='eza -aa --hyperlink --git'
alias ls='eza --hyperlink --git'
alias lsa='eza -aa --hyperlink --git'

# Long listing with eza
alias ll='eza -lg --hyperlink --git --time-style long-iso'
alias lla='eza -laag --hyperlink --git --time-style long-iso'

# Tree listing with eza
# lltn allows for limiting depth, ie `lltn 2 /foo` does a tree list listing of /foo to a max depth of 2
alias llt="eza -lagT --hyperlink --git --time-style long-iso"
alias lltn="eza -lagT --hyperlink --git --time-style long-iso -L"
