#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Oracle SSO Login
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔒
# @raycast.packageName Raycast Scripts
# @raycast.argument1 { "type": "password", "placeholder": "VPN Password" }

# Documentation:
# @raycast.description Oracle SSO login
# @raycast.author Jason Lyle

open -n 'https://signon-int-stage.oracle.com/'
sleep 0.5
open 'https://signon-int.oracle.com/'
