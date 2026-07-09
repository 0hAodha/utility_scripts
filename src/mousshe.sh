#!/bin/bash
# Script for controlling the mouse of an Xorg session over SSH

DISPLAY=:0
STEP_SIZE=10

while true; do
    read -rsn1 key

    case "$key" in
        h)      xdotool mousemove_relative -- "-$STEP_SIZE" 0 ;;
        j)      xdotool mousemove_relative -- 0 "$STEP_SIZE" ;;
        k)      xdotool mousemove_relative -- 0 "-$STEP_SIZE" ;;
        l)      xdotool mousemove_relative -- "$STEP_SIZE" 0 ;;
        ' ')    xdotool click 1 ;;
    esac
done
