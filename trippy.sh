#!/bin/sh 
# script to display random data to the screen. to be ran from a tty, as a user who has write privileges to the fb0 device

while [ true ]
do
    cat /dev/urandom > /dev/fb0
done
