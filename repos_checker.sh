#!/bin/sh
# script to find all the git repositories in the current directory (& sub-directories) and display their git statuses

find . -name ".git" -type d -not -path "./.cache/*" -not -path "./.local/*" -exec sh -c '(cd {}/../; echo -e "\n\033[1m$(pwd)\033[0m"; git status)' \;
