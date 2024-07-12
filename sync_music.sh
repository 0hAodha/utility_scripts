#!/bin/sh
# Script to sync my Android phone's music library to the contents of my ~/media/music/ directory

mountpoint="$HOME/mnt"
source="$HOME/media/music/"
destination="$mountpoint/Internal shared storage/Music/"

mkdir "$mountpoint"
aft-mtp-mount "$mountpoint"

rsync --archive --delete --info=progress2 "$source" "$destination"

sync
fusermount -u "$mountpoint"
rmdir "$mountpoint"
