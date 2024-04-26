#!/bin/sh
# simple script to loop through each image in a directory and set said image as wallpaper for a specififed interval using feh

command="feh --bg-fill"
interval="1m"

while getopts 'c:i:' flag; do
    case "${flag}" in
        c)
            command="${OPTARG}";;

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
        eval "$command" "$img"
        sleep "$interval"
    done
done
