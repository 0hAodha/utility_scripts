#!/bin/sh
# script for looping through each file in a directory, opening it with mimeopen, and upon the closing of the file viewer, asking the user whether or not to delete the image, and deleting if "y" received

for file in *
do 
    mimeopen "$file" && read -p "Delete file? [y/n]: " ans && [ "$ans" = "y" ] && rm "$file"
done
