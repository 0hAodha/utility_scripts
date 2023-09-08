#!/usr/bin/xdotool 

# open qutebrowser to instagram
key super+0
key super+shift+b 
sleep 5
key o 
type instagram.com 
key enter
sleep 5

# navigate to like history page 
mousemove 58 992 
click 1
sleep 1 
mousemove 143 640
click 1
sleep 10 
mousemove 1097 193
click 1
sleep 1
mousemove 977 472
click 1
sleep 1
mousemove 963 735
click 1
sleep 10 

# unlike 100 posts
