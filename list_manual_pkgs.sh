#!/bin/sh
# one-liner to list just the names of packages manually-installed with xbps-install, with no version numbers etc
xbps-query --list-manual-pkgs | awk -F '{gsub(/-[0-9]+.*$/, ""); print $0}'
