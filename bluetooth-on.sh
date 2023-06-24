#!/bin/sh
# Simple script to enable bluetooth on my system

echo "Attempting to create a symbolic link to the bluetoothd service in /var/service/"
sudo ln -s /etc/sv/bluetoothd /var/service/ 

echo "Attempting to turn on bluetooth via bluetoothctl"
bluetoothctl power on
bluetoothctl 
