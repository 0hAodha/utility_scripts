#!/bin/sh
# script to hide the top panel and show the program launcher in its place

# if bar is hidden, don't do anything with the top bar
if [ -f /tmp/polybarhidden ]; then 
    dmenu_run -fn "SauceCodePro Nerd Font-11" -nf "#f0f0f0" -nb "#0f0f0f" -sf "#f0f0f0" -sb "#8f8aac"

# if the bar isn't hidden, hide it, show dmenu, then unhide it
else 
    polybar-msg cmd hide 
    touch /tmp/polybarhidden 
    dmenu_run -fn "SauceCodePro Nerd Font-11" -nf "#f0f0f0" -nb "#0f0f0f" -sf "#f0f0f0" -sb "#8f8aac"
    polybar-msg cmd show 
    rm /tmp/polybarhidden 
fi
