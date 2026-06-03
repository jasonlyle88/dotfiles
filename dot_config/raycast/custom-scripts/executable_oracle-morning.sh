#!/bin/bash

# Raycast Script Command Template
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Oracle Morning Actions
# @raycast.mode fullOutput
#
# Optional parameters:
# @raycast.icon ☀️
# @raycast.packageName Raycast Scripts
# @raycast.argument1 { "type": "password", "placeholder": "Hardware token" }

printf -- '%s\n\n' 'Starting Oracle morning actions'

printf -- '%s\n' 'Launch 1Password and sign in if necessary'
./launch-1password.sh
printf -- '%s\n\n' '1Password launched'

printf -- '%s\n' 'Launch KeepassXC and sign in if necessary'
./launch-keepassxc.sh
printf -- '%s\n\n' 'KeepassXC launched'

printf -- '%s\n' 'Launch Oracle VPN and connect if necessary'
./oracle-vpn-login.sh "$1"
printf -- '%s\n\n' 'Oracle VPN launched'

printf -- '%s\n' 'Launch Oracle Unified Login'
./oracle-unified-login.sh
printf -- '%s\n\n' 'Oracle Unified Login launched'

printf -- '%s\n' 'Launch Oracle SSO Login'
./oracle-sso-login.sh
printf -- '%s\n\n' 'Oracle SSO Login launched'
