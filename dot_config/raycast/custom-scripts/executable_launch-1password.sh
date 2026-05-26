#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Launch 1Password
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 1️⃣
# @raycast.packageName Raycast Scripts

# Documentation:
# @raycast.description Open 1Password
# @raycast.author Jason Lyle

if ! pgrep -x -- '1Password' >/dev/null 2>&1; then
    open -a '1password' --args --silent
fi

OP_SERVICE_ACCOUNT_TOKEN='' op account get >/dev/null 2>&1
