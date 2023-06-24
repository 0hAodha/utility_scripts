#!/bin/sh 
# Simple screenshot script with selection.

maim --select --hidecursor                                  |                                              
tee /home/andrew/media/images/screenshots/"$(date +%s)".png | xclip -selection clipboard -target image/png  
