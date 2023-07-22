#!/bin/sh
# Simple script to disable bluetooth on my system. 

echo "Attempting to turn off bluetooth via bluetoothctl"
bluetoothctl power off

echo "Attempting to remove the symlink to the bluetoothd service in the /var/service/ directory"
# sudo rm /var/service/bluetoothd
doas rm /var/service/bluetoothd
