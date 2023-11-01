#!/bin/sh
# simple script to loop through each image in a directory and set said image as wallpaper for a specififed interval using feh

interval="1m"

while [ true ]
do
    for img in *
    do
        feh --bg-fill "$img"
        sleep "$interval"
    done
done
