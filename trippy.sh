#!/bin/sh 
# script to display random data to the screen. to be ran from a tty 

while [ true ]; do cat /dev/urandom > /dev/fb0; done
