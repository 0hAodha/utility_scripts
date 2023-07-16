#!/bin/sh 
# Simple screenshot script with selection.

maim --select --hidecursor                                  |                                              
tee /home/andrew/media/images/screenshots/"$(date +%Y-%m-%d\ %H:%M:%S)".png | xclip -selection clipboard -target image/png  
