#!/bin/sh
# script for looping through each image in a directory, displaying it with pqiv, and upon the closing of the image viewer, asking the user whether or not to delete the image, and deleting if "y" received

for file in *
do 
    pqiv "$file" || rm "$file" && read -p "Delete file? [y/n]: " ans && [ "$ans" = "y" ] && rm "$file"
done
