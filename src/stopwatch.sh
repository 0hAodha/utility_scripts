#!/bin/sh 
# Simple stopwatch script that simply counts the elapsed time in seconds. 

start=$(date +%s)

stty -echo  # hide keyboard input 

while [ true ]
do
    time="$(($(date +%s) - $start))"
    printf '%s\r' "$(date -u -d "@$time" +%H:%M:%S)"
    sleep 1s
done
