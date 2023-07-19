#!/bin/sh
# one-liner to list just the names of packages manually-installed with xbps-install, with no version numbers etc
xbps-query --list-manual-pkgs | awk '{gsub(/-[0-9]+.*$/, ""); print $0}'

# alternative sed version:
# xbps-query --list-manual-pkgs | sed "s/-[0-9].*//g"
