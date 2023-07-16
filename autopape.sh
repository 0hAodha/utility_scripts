#!/bin/sh
# simple script to loop through each image in a directory and set said image as wallpaper for 1 minute

while [ true ]
do
    for img in *
    do
        feh --bg-fill "$img"
        sleep 1m
    done
done
