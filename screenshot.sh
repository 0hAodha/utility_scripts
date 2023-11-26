#!/bin/sh 
# Simple screenshot script with selection using maim.
filepath="/home/andrew/media/images/screenshots/$(date +%Y-%m-%d\ %H:%M:%S).png"

maim --select --hidecursor | tee "$filepath" | xclip -selection clipboard -target image/png  
notify-send "$0" "Screenshot saved to: $filepath"
