#!/bin/sh
# Script to take a wait a few seconds before taking a screenshot to the filepath in the clipboard.
# For use as part of my LaTeX note-taking workflow in Vim: create the figure environment, copy the file name, invoke this script, and select the region in the source material to be screenshotted.

basename=$(basename "$0")

if [ $(pgrep -x "Xorg") ]; then 
    filepath=$(xclip -selection clipboard -out)
else
    filepath=$(wl-paste)
fi

# check if the filepath is absolute or relative, and if relative, make absolute
if [ "${filepath#\/}" = "$filepath" ] || [ "${filepath#\~}" = "$filepath" ]; then
    filepath="$(pwd)/$filepath"
fi

notify-send "$basename" "Taking screenshot to $filepath"

sleep 5

if [ $(pgrep -x "Xorg") ]; then 
    maim --select --hidecursor "$filepath" && notify-send --icon "$filepath" "$basename" "Screenshot saved to: $filepath"
else
    grim -g "$(slurp)" "$filepath"  && notify-send --icon "$filepath" "$basename" "Screenshot saved to: $filepath"
fi
