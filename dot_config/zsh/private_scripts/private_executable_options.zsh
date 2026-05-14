#!/usr/bin/env zsh
# shellcheck shell=bash

################################################################################
################################################################################
##  options.zsh
##
##  This file sets and unsets ZSH options to configure desired shell behavior.
##
##  The list of options can be listed with the following:
##      set -o
##      set +o
##
##  To see the list of only enabled options, use the following:
##      setopt
##
##  NOTE:   Running any of the above commands through a pipe or in a subshell
##          changes their output because they consider themselves to be running
##          in a non-interactive shell (which changes some default options).
##
##  To turn options ON  : set -o [option]
##  To turn options OFF : set +o [option]
##
##  Option documentation:
##      https://zsh.sourceforge.io/Doc/Release/Options-Index.html
##
##  NOTE:   Option names are case insensitive and underscores (_) do not matter.
##
################################################################################
################################################################################

##
##  Completion
##
set -o always_to_end            # Move cursor to end of completion
set -o complete_in_word         # Completion from in word, not end of word

##
##  Changing Directories
##
set -o auto_cd                  # Dont need to type CD to change directories
set -o auto_pushd               # CD pushes directory onto directory stack
set -o pushd_ignore_dups        # Dont add duplicates to push stack
set -o pushd_minus              # Set + and - to logical meaning with PUSHD

##
##  History
##
set -o extended_history         # Save begin timestamp and duration to history
set -o hist_expire_dups_first   # Remove duplicates from history first when full
set -o hist_ignore_dups         # Do not add duplicates of previous history entry
set -o hist_ignore_space        # Do not add to history when command starts with a space
set -o hist_verify              # Do not execute history expansion immediately, verify it on command line first
set -o share_history            # Let history be shared between terminals

##
##  Input/Output
##
set -o no_flow_control          # Output flow control via stop/start characters
set -o interactive_comments     # Allow comments in interactive shell sessions

##
##  Job Control
##
set -o long_list_jobs           # Print job notifications in the long format
set -o monitor                  # Allow job control

##
##  Prompting
##
set -o prompt_subst             # Allow expansion and substitution in the prompt

##
##  Shell state
##
# set -o interactive            # Automatic, cannot be manually configured
# set -o login                  # Automatic, cannot be manually configured
# set -o shin_stdin             # Automatic, cannot by manually configured

##
##  ZLE
##
set -o combining_chars          # Assume terminal displays combining characters
# set -o zle                    # Automatic, cannot by manually configured
