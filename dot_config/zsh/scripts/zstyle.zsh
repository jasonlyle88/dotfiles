#!/usr/bin/env zsh
# shellcheck shell=bash

################################################################################
################################################################################
##  zstyle.zsh
##
##  This file sets ZSH zstyle settings to desired values
##
##  ZStyle follows this syntax:
##      zstyle <pattern> <style> <values>
##
##  Useful commands:
##      `zstyle`    Lists all configurations and their values in a human format
##      `zstyle -L` Lists all configurations and their values in command format
##          Can filter the list by providing a pattern
##
##
################################################################################
################################################################################

##
##  Completion
##
##  Completion ZStyle pattern definition:
##      :completion:<function>:<completer>:<command>:<argument>:<tag>
# Tab completion should be case-insensitive and search on substrings
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|=*' 'l:|=* r:|=*'
