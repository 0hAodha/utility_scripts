#!/bin/sh
# Loops over files in a directory, setting each the as the desktop wallpaper, and prompts the user to save the file to the wallpapers directory or delete it.

wallpapers_directory="$HOME/media/images/wallpapers/"

for file in *; do
    wal -i "$file"
    read -p "Keep wallpaper? [y/N]: " ans

    if [ $ans = "y" ]; then
        mv "$file"  "$wallpapers_directory"
    elif [ $ans = "n" ]; then
        rm "$file"
    fi
done

