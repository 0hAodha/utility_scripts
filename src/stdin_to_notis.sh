#!/bin/sh 
# small script to turn the stdout output of a program into notifications line-by-line
# intended for use when a script is not being called from a terminal, but from a GUI application so that output can still be seen

while read line
do
    if [ -z "$1" ]
    then
        notify-send "$line"
    else
        notify-send "$1" "$line"
    fi
done
