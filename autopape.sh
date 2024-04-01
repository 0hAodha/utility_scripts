#!/bin/sh
# simple script to loop through each image in a directory and set said image as wallpaper for a specififed interval using feh

interval="1m"


while getopts 'i:' flag; do
  case "${flag}" in
        i) 
            interval="${OPTARG}";;
        *)
            echo "Unrecognised option"
            exit 1;;
  esac
done


while [ true ]
do
    for img in *
    do
        feh --bg-fill "$img"
        sleep "$interval"
    done
done
