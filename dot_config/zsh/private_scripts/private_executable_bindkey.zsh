#!/usr/bin/env zsh
# shellcheck shell=bash

################################################################################
################################################################################
##  bindkey.zsh
##
##  This file sets what different keys do in the shell
##
##  Useful commands
##      `bindkey`       Output all the configurations as bindkey parameters
##      `bindkey -L`    Output all the configurations as bindkey commands
##
################################################################################
################################################################################

##
##  Key sequence mapping
##
# Make keystrokes similar between operating systems
bindkey -s  '^[OA'      '^[[A'      # up
bindkey -s  '^[OB'      '^[[B'      # down
bindkey -s  '^[OD'      '^[[D'      # left
bindkey -s  '^[OC'      '^[[C'      # right
bindkey -s  '^[OH'      '^[[H'      # home
bindkey -s  '^[[1~'     '^[[H'      # home
bindkey -s  '^[[7~'     '^[[H'      # home
bindkey -s  '^[OF'      '^[[F'      # end
bindkey -s  '^[[4~'     '^[[F'      # end
bindkey -s  '^[[8~'     '^[[F'      # end
bindkey -s  '^[[3\^'    '^[[3;5~'   # ctrl+delete
bindkey -s  '^[^[[3~'   '^[[3;3~'   # alt+delete
bindkey -s  '^[[1;9D'   '^[[1;3D'   # alt+left
bindkey -s  '^[^[[D'    '^[[1;3D'   # alt+left
bindkey -s  '^[[1;9C'   '^[[1;3C'   # alt+right
bindkey -s  '^[^[[C'    '^[[1;3C'   # alt+right
bindkey -s  '^[Od'      '^[[1;5D'   # ctrl+left
bindkey -s  '^[Oc'      '^[[1;5C'   # ctrl+right

##
##  Key map array for readability
##
# for MacOS:
#   alt=opt
#   cmd is generally not sent to the terminal, need to configure terminal
#       settings manually. When mapping manually, map cmd=ctrl for consistency
typeset -gA keys=(
    'up'                        '^[[A'
    'down'                      '^[[B'
    'left'                      '^[[D'
    'right'                     '^[[C'
    'home'                      '^[[H'
    'end'                       '^[[F'
    'insert'                    '^[[2~'
    'delete'                    '^[[3~'
    'pageup'                    '^[[5~'
    'pagedown'                  '^[[6~'
    'backspace'                 '^?'

    'shift+up'                  '^[[1;2A'
    'shift+down'                '^[[1;2B'
    'shift+left'                '^[[1;2D'
    'shift+right'               '^[[1;2C'
    'shift+home'                '^[[1;2H'
    'shift+end'                 '^[[1;2F'
    'shift+insert'              '^[[2;2~'
    'shift+delete'              '^[[3;2~'
    'shift+pageup'              '^[[5;2~'
    'shift+pagedown'            '^[[6;2~'
    'shift+backspace'           '^?'
    'shift+tab'                 '^[[Z'

    'alt+up'                    '^[[1;3A'
    'alt+down'                  '^[[1;3B'
    'alt+left'                  '^[[1;3D'
    'alt+right'                 '^[[1;3C'
    'alt+home'                  '^[[1;3H'
    'alt+end'                   '^[[1;3F'
    'alt+insert'                '^[[2;3~'
    'alt+delete'                '^[[3;3~'
    'alt+pageup'                '^[[5;3~'
    'alt+pagedown'              '^[[6;3~'
    'alt+backspace'             '^[^?'

    'alt+shift+up'              '^[[1;4A'
    'alt+shift+down'            '^[[1;4B'
    'alt+shift+left'            '^[[1;4D'
    'alt+shift+right'           '^[[1;4C'
    'alt+shift+home'            '^[[1;4H'
    'alt+shift+end'             '^[[1;4F'
    'alt+shift+insert'          '^[[2;4~'
    'alt+shift+delete'          '^[[3;4~'
    'alt+shift+pageup'          '^[[5;4~'
    'alt+shift+pagedown'        '^[[6;4~'
    'alt+shift+backspace'       '^[^H'

    'ctrl+up'                   '^[[1;5A'
    'ctrl+down'                 '^[[1;5B'
    'ctrl+left'                 '^[[1;5D'
    'ctrl+right'                '^[[1;5C'
    'ctrl+home'                 '^[[1;5H'
    'ctrl+end'                  '^[[1;5F'
    'ctrl+insert'               '^[[2;5~'
    'ctrl+delete'               '^[[3;5~'
    'ctrl+pageup'               '^[[5;5~'
    'ctrl+pagedown'             '^[[6;5~'
    'ctrl+backspace'            '^H'

    'ctrl+shift+up'             '^[[1;6A'
    'ctrl+shift+down'           '^[[1;6B'
    'ctrl+shift+left'           '^[[1;6D'
    'ctrl+shift+right'          '^[[1;6C'
    'ctrl+shift+home'           '^[[1;6H'
    'ctrl+shift+end'            '^[[1;6F'
    'ctrl+shift+insert'         '^[[2;6~'
    'ctrl+shift+delete'         '^[[3;6~'
    'ctrl+shift+pageup'         '^[[5;6~'
    'ctrl+shift+pagedown'       '^[[6;6~'
    'ctrl+shift+backspace'      '^?'

    'ctrl+alt+up'               '^[[1;7A'
    'ctrl+alt+down'             '^[[1;7B'
    'ctrl+alt+left'             '^[[1;7D'
    'ctrl+alt+right'            '^[[1;7C'
    'ctrl+alt+home'             '^[[1;7H'
    'ctrl+alt+end'              '^[[1;7F'
    'ctrl+alt+insert'           '^[[2;7~'
    'ctrl+alt+delete'           '^[[3;7~'
    'ctrl+alt+pageup'           '^[[5;7~'
    'ctrl+alt+pagedown'         '^[[6;7~'
    'ctrl+alt+backspace'        '^[^H'

    'ctrl+alt+shift+up'         '^[[1;8A'
    'ctrl+alt+shift+down'       '^[[1;8B'
    'ctrl+alt+shift+left'       '^[[1;8D'
    'ctrl+alt+shift+right'      '^[[1;8C'
    'ctrl+alt+shift+home'       '^[[1;8H'
    'ctrl+alt+shift+end'        '^[[1;8F'
    'ctrl+alt+shift+insert'     '^[[2;8~'
    'ctrl+alt+shift+delete'     '^[[3;8~'
    'ctrl+alt+shift+pageup'     '^[[5;8~'
    'ctrl+alt+shift+pagedown'   '^[[6;8~'
    'ctrl+alt+shift+backspace'  '^?'

    'alt'                       '^['
    'ctrl'                      '^'
    'esc'                       '^['
)

##
##  MacOS Customizations
##

#
#   MacOS Terminal key bindings
#
# Home              \033[H
# End               \033[F
# alt+backspace     \033\177
# ctrl+backspace    \010
# alt+delete        \033[3;3~
# ctrl+delete       \033[3;5~
# pageup            \033[5~
# pagedown          \033[6~

#
#   iTerm key bindings



##
##  Set emacs mode
##
bindkey -e

##
##  Cursor navigation
##
bindkey -- "${keys[home]}"              beginning-of-line
bindkey -- "${keys[ctrl]}A"             beginning-of-line
bindkey -- "${keys[ctrl+left]}"         beginning-of-line
bindkey -- "${keys[end]}"               end-of-line
bindkey -- "${keys[ctrl]}E"             end-of-line
bindkey -- "${keys[ctrl+right]}"        end-of-line
# bindkey -- "${keys[insert]}"            overwrite-mode
bindkey -- "${keys[left]}"              backward-char
bindkey -- "${keys[alt+left]}"          backward-word
bindkey -- "${keys[right]}"             forward-char
bindkey -- "${keys[alt+right]}"         forward-word

##
##  Deletion
##
bindkey -- "${keys[backspace]}"         backward-delete-char
bindkey -- "${keys[alt+backspace]}"     backward-delete-word                    # Not working on ITERM out of the box
bindkey -- "${keys[ctrl+backspace]}"    backward-kill-line                      # Not working on ITERM out of the box
bindkey -- "${keys[delete]}"            delete-char
bindkey -- "${keys[alt+delete]}"        delete-word                             # Not working on ITERM out of the box
bindkey -- "${keys[ctrl+delete]}"       kill-line                               # Not working on ITERM out of the box

##
##  History search
##
# Up and down key
if
    (( ${+widgets[history-substring-search-up]} )) &&
    (( ${+widgets[history-substring-search-down]} ));
then
    bindkey -- "${keys[up]}"            history-substring-search-up
    bindkey -- "${keys[down]}"          history-substring-search-down
else
    bindkey -- "${keys[up]}"            up-line-or-history
    bindkey -- "${keys[down]}"          down-line-or-history
fi
# bindkey -- "${keys[pageup]}"            beginning-of-buffer-or-history
# bindkey -- "${keys[pagedown]}"          end-of-buffer-or-history

##
##  Completion
##
bindkey -- "${keys[shift+tab]}"         reverse-menu-complete
