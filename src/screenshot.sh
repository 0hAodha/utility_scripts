#!/bin/sh 
# Script to take a selection screenshot on both Xorg and Wayland

filepath="$HOME/media/images/screenshots/$(date +%Y-%m-%d\ %H:%M:%S).png"

if [ $(pgrep -x "Xorg") ]; then
    maim --select --hidecursor | tee "$filepath" | xclip -selection clipboard -target image/png
else
    grim -g "$(slurp)" - | tee "$filepath" | wl-copy
fi

# if screenshot is cancelled, tee will create an empty file, so checking if the file is empty
if [ -s "$filepath" ]; then
    # send notification with a thumbnail of the screenshot taken, the name of the script, and the filepath
    notify-send --icon "$filepath" "$(basename "$0")" "Screenshot saved to: $filepath"
else
    rm "$filepath"
fi
