#!/bin/sh 

start=$(date +%s)

while true; do
    time="$(($(date +%s) - $start))"
    printf '%s\r' "$(date -u -d "@$time" +%H:%M:%S)"
    sleep 1s;
done
