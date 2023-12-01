#!/bin/sh
# Script to list the number of windows on the current desktop (workspace) in bspwm

bspc query --nodes --node .window --desktop focused | wc --lines
