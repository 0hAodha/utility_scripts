#!/bin/sh
# Script to connect to an available WiFi network with a dmenu prompt. 

notify-send "$(basename "$0")" "Scanning for available networks..."

# cutting the first 9 characters of the nmcli output as it will contain empty fields which will mess up awk parsing
$(nmcli connection up $( nmcli device wifi list | cut --characters=9- | awk '(NR > 1){ print $2}' | sort | uniq | dmenu -p "Connect to network: "))
