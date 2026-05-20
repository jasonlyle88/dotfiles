#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Launch Oracle VPN
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🌐
# @raycast.packageName Raycast Scripts

# Documentation:
# @raycast.description Launch Oracle VPN
# @raycast.author Jason Lyle

vpn='/opt/cisco/secureclient/bin/vpn'

if ! $vpn status | grep -q 'state: Connected'; then
    open -a 'Cisco Secure Client'

    while ! $vpn status | grep -q 'state: Connected'; do
        sleep 1
    done
fi
