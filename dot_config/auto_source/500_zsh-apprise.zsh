# shellcheck shell=bash

################################################################################
# Setup ZSH Apprise
################################################################################

if command -v zsh-apprise-notify 1>/dev/null 2>&1; then
    zstyle ':apprise:user-setting:*'    'notify-always-on-failure'          'yes'
    zstyle ':apprise:user-setting:*'    'notify-only-unfocused'             'no'
    zstyle ':apprise:user-setting:*'    'notify-unknown-focus'              'yes'
    zstyle ':apprise:user-setting:*'    'notify-command-minimum-seconds'    20
    zstyle ':apprise:user-setting:*'    'notify-command-ignore-regex'       'ssh|sleep|tmux|screen|emacs|vim|vi|nano|bat|less|more'
    zstyle ':apprise:user-setting:*'    'notify-apprise-tag'                'shell-notify'

    if [[ "${OSTYPE}" == "darwin"* ]]; then
        zstyle ':apprise:user-setting:*'    'notify-apprise-notifier'           'macosx://_/?sound=default'
    else
        zstyle ':apprise:user-setting:*'    'notify-apprise-notifier'           'dbus://'
    fi
fi