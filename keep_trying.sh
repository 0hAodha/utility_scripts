#!/bin/sh
# simple script to fix my broken wifi 
# it checks if wifi is connected every 5 seconds, and if not, repeatedly attempts to connect

network="<network_name>"
interface="<interface_name>"

while [ true ]; do 
    # if wifi is connected, do nothing for 5 seconds
    if [ -n "$(nmcli connection show | grep '.*'"$network"'.*'"$interface"'.*')" ]; then
        sleep 5
    # else, wifi is not connected so attempt to connect to wifi network, and keep trying until it succeeds
    else 
        nmcli con up "$network" || while [ "$?" != "0" ]; do nmcli con up "$network"; done
    fi
done
