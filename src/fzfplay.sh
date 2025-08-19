#!/bin/sh
# Script that allows a music file or directory to be selected via `fzf` to be enqueued with `umpv`

media_directory="$HOME/media/music"

fd  --base-directory "$media_directory" \
    --exclude "*.jpg" --exclude "*.png" --exclude "*.lrc" \
    --absolute-path |
    fzf |
    xargs -I{} sh -c 'umpv "{}" &'
