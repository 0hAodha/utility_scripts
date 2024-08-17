#!/bin/sh
# Script to connect to an available WiFi network with a dmenu prompt. 

script_name="$(basename "$0")"
notify-send "$script_name" "Scanning for available networks..."

# cutting the first 9 characters of the nmcli output as it will contain empty fields which will mess up awk parsing
notify-send "$script_name" "$(nmcli connection up $( nmcli device wifi list | cut --characters=9- | awk '(NR > 1){ print $2}' | sort | uniq | dmenu -p "Connect to network: "))"
