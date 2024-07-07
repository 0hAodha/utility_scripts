#!/bin/sh
# A script that deletes itself

rm "$(echo $0 | awk -F '/' '{print $NF}')"
