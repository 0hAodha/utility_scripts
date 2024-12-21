#!/bin/sh
# Simple script to play music albums based off the supplied artist & album name
artist="$1"
album="$2"

setsid umpv "$HOME/media/music/$artist/$album/" &
