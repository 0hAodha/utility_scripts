#!/bin/sh
# one-liner to list just the names of packages manually-installed with xbps-install, with no version numbers etc
xbps-query --list-manual-pkgs | sed "s/-[0-9].*//g"

# i originally wrote this using awk, but i realised that sed would allow for a more elegant implementation, although there was no meaningful speed difference during my tests
# alternative awk version:
# xbps-query --list-manual-pkgs | awk '{gsub(/-[0-9]+.*$/, ""); print $0}'
