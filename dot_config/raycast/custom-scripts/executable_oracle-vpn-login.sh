#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Launch Oracle VPN
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 🌐
# @raycast.packageName Raycast Scripts
# @raycast.argument1 { "type": "password", "placeholder": "Hardware token" }

# Documentation:
# @raycast.description Launch Oracle VPN
# @raycast.author Jason Lyle

vpnBinary='/opt/cisco/secureclient/bin/vpn'
vpnProfile='OCNA - US East (v2)'
vpnUsername='jason.lyle'
hardwareToken="$1"

if "${vpnBinary}" status | grep -q 'state: Connected'; then
    printf -- 'VPN is already connected.\n'
    return 0
fi

# Get the hardware token password from keepassxc
kpxc-cli clip 'https://auth-csec.oraclecloud.com/' password 1>/dev/null 2>&1 && sleep 1
hardwareTokenPassword="$(pbpaste)"

printf -- 'Connecting to "%s"\n' "${vpnProfile}"
printf -- '\n'

# Kill Cisco Secure Client if it's running.
# This is necessary because the cli will not connect if the GUI is open.
pkill -x 'Cisco Secure Client'

"${vpnBinary}" -s connect "${vpnProfile}" <<EOF
${vpnUsername}
${hardwareTokenPassword}${hardwareToken}
y
exit
EOF

# Open the Cisco Secure Client GUI in the the background
open -ga 'Cisco Secure Client'
