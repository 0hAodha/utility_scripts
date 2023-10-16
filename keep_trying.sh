#!/bin/sh
# one-lienr to attempt to connect to wifi network, and keep trying until it succeeds
nmcli con up <insert_network_name_here> || while [ "$?" != "0" ]; do nmcli con up <insert_network_name_here>; done
