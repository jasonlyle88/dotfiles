#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Oracle SSO Login
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔒
# @raycast.packageName Raycast Scripts

# Documentation:
# @raycast.description Oracle SSO login
# @raycast.author Jason Lyle

# open -n 'https://signon-int-stage.oracle.com/'
# sleep 0.5
# open 'https://signon-int.oracle.com/'

set -euo pipefail

url='https://signon-int.oracle.com/'
bundle_id="$(duti -d https)"

case "${bundle_id}" in
    com.google.Chrome|com.google.Chrome.canary|com.brave.Browser|com.microsoft.edgemac)
        osascript \
            -e "tell application id \"${bundle_id}\"" \
            -e "make new window" \
            -e "set URL of active tab of front window to \"${url}\"" \
            -e "activate" \
            -e "end tell"
        ;;

    org.mozilla.firefox)
        /Applications/Firefox.app/Contents/MacOS/firefox --new-window "${url}"
        ;;

    com.apple.Safari)
        osascript \
            -e "tell application id \"com.apple.Safari\"" \
            -e "make new document with properties {URL:\"${url}\"}" \
            -e "activate" \
            -e "end tell"
        ;;

    *)
        # Fallback: opens in default browser, but may be a tab
        open "${url}"
        ;;
esac
