#!/bin/sh 
# Simple stopwatch script that simply counts the elapsed time in seconds. 
# I believe that I stole this code from somewhere many years ago and adapted it to my liking, but I unfortunately do not recall from where. 

start=$(date +%s)

while true; do
    time="$(($(date +%s) - $start))"
    printf '%s\r' "$(date -u -d "@$time" +%H:%M:%S)"
    sleep 1s;
done
