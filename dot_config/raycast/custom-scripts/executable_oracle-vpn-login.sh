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

set -euo pipefail

hardwareToken="$1"
source "${HOME}/.config/auto_source/500_oracle_xgbu-ace.zsh"
oracle.vpn.connectOCNA "${hardwareToken}"
