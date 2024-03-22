#!/bin/sh 
# Screenshot script with selection using maim and notification.
filepath="$HOME/media/images/screenshots/$(date +%Y-%m-%d\ %H:%M:%S).png"
maim --select --hidecursor | tee "$filepath" | xclip -selection clipboard -target image/png  

# send notification with a thumbnail of the screenshot taken, the name of the script, and the filepath
notify-send --icon "$filepath" "$(basename "$0")" "Screenshot saved to: $filepath"
