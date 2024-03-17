#!/bin/sh

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
