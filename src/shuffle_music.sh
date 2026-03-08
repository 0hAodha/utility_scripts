#!/bin/sh
# Script to enqueue all the music in a library in a random order

media_directory="$HOME/media/music"

fd  --base-directory "$media_directory" \
    --type file \
    --exclude "*.jpg" --exclude "*.png" --exclude "*.lrc" \
    --absolute-path \
    --print0 |
    shuf --zero-terminated |
    xargs --null umpv
