#!/bin/sh
# Script to play a specific artist, album, or track selected with dmenu

music_dir="$HOME/media/music"

answer="$(printf "Artist\nAlbum\nTrack" | dmenu -p "Play music by:")"

artist="$(ls "$music_dir" | dmenu -p "Artist:")"

if [ "$answer" = "Artist" ]; then
    setsid umpv "$music_dir/$artist" &
else
    album="$(ls "$music_dir/$artist" | dmenu -p "Album:")"

    if [ "$answer" = "Album" ]; then
        setsid umpv "$music_dir/$artist/$album" &
    else
        track="$(ls "$music_dir/$artist/$album" | dmenu -p "Track:")"
        setsid umpv "$music_dir/$artist/$album/$track" &
    fi
fi