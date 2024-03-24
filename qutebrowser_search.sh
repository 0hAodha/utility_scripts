#!/bin/sh
# script to find all the search engines in the qutebrowser configuration file and make them available for searching via dmenu

input="$(
    awk '/^c\.url\.searchengines =/,/^}$/{
        if (!/^c\.url\.searchengines =/ && !/^}$/){
                gsub(/":?/, ""); print $1
        }
    }' ~/.config/qutebrowser/config.py | dmenu
)"

if [ "$input" ]
then
    qutebrowser "$input"
fi
