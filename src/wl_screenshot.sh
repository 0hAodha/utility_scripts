#!/bin/sh 
# Screenshot script with selection using grim and slurp.
#
filepath="$HOME/media/images/screenshots/$(date +%Y-%m-%d\ %H:%M:%S).png"
grim -g "$(slurp)" - | tee "$filepath" | wl-copy

# if screenshot is cancelled, tee will create an empty file, so checking if the file is empty
if [ -s "$filepath" ]; then
    # send notification with a thumbnail of the screenshot taken, the name of the script, and the filepath
    notify-send --icon "$filepath" "$(basename "$0")" "Screenshot saved to: $filepath"
else
    rm "$filepath"
fi
