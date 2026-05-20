#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Launch Oracle Unified Login
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 👥
# @raycast.packageName Raycast Scripts

# Documentation:
# @raycast.description Launch Oracle Unified Login
# @raycast.author Jason Lyle

check_app_status() {
    local app_name="$1"
    
    # 1. Fast PID check
    if pgrep -x "$app_name" > /dev/null; then
        # 2. Detailed AppleScript state check
        osascript -e "
        tell application \"System Events\" to tell process \"$app_name\"
            if (count of windows) is 0 then
                error \"Running (No Windows Open)\" number 2
            else if value of attribute \"AXMinimized\" of window 1 is true then
                error \"Minimized to Dock\" number 3
            else if visible is false then
                error \"Hidden (Cmd+H)\" number 4
            else
                return \"Visible and Active\"
            end if
        end tell"
    else
        return 1  # Not running
    fi
}

open -a 'Oracle Unified Login'

while check_app_status "Oracle Unified Login" 1>/dev/null 2>&1; do
    sleep 1
done
