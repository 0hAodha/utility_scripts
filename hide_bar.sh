#!/bin/sh
# Simple script to hide Polybar on bspwm 

if [ -f /tmp/polybarhidden ]; then 
    bspc config top_padding 38 
    polybar-msg cmd show 
    rm /tmp/polybarhidden 
else 
    polybar-msg cmd hide 
    bspc config top_padding 0 
    touch /tmp/polybarhidden 
fi
