#!/bin/sh
# simple script to loop through each image in a directory and set said image as wallpaper for a specified interval

command="feh --bg-fill"
interval="1m"

usage() {
    cat << EOF
Usage: autopape.sh [OPTIONS]... [ARGUMENTS]...
Iterate over the files in a directory and set them as the desktop wallpaper at a regular interval.
Options:
    -c  Specify the command that should be used to set the wallpaper. Defaults to 'feh --bg-fill'
    -h  Print this help message
    -i  Specify the interval between wallpaper changes. Defaults to '1m'
EOF
}

while getopts 'c:i:h' flag; do
    case "${flag}" in
        c)
            command="${OPTARG}";;

        i) 
            interval="${OPTARG}";;

        h)
            usage
            exit 0;;

        *)
            usage
            exit 1;;
    esac
done

while [ true ]
do
    for img in *
    do
        eval "$command '$img'"
        sleep "$interval"
    done
done
