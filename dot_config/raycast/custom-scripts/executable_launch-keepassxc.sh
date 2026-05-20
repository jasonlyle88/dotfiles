#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Launch KeepassXC
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔑
# @raycast.packageName Raycast Scripts

# Documentation:
# @raycast.description Open KeepassXC
# @raycast.author Jason Lyle

if ! kpxc-cli status | grep -q 'Associated: yes'; then
    open -a "KeePassXC"

    while ! kpxc-cli status | grep -q 'Associated: yes'; do
        sleep 1
    done

    osascript -e 'tell application "System Events" to set visible of process "KeePassXC" to false'
fi
