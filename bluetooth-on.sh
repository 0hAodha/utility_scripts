#!/bin/sh
# Simple script to enable bluetooth on Void Linux (using the runit init system)

echo "Attempting to create a symbolic link to the bluetoothd service in /var/service/"
# sudo ln --symbolic /etc/sv/bluetoothd /var/service/ 
doas ln --symbolic /etc/sv/bluetoothd /var/service/ 

echo "Attempting to turn on bluetooth via bluetoothctl"
bluetoothctl power on
bluetoothctl 
