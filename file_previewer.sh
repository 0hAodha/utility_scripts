#!/bin/sh
# File preview handler for lf using the Perl `mimetype` utility.

preview_image="/tmp/lf_preview_image.png"

file=$1
width=$2
height=$3
x=$4
y=$5

case "$(mimetype --brief -- "$file")" in
    application/gzip | application/msword | application/x-iso9660-image | application/vnd.openxmlformats-officedocument.wordprocessingml.document | application/vnd.openxmlformats-officedocument.presentationml.presentation | application/vnd.openxmlformats-officedocument.spreadsheetml.sheet)
        exiftool "$file" | bat --theme='base16' --terminal-width "$(($width-4))" --force-colorization;;

    application/json) 
        jq --color-output . "$file" | bat --theme='base16' --terminal-width "$(($width-4))" --force-colorization;;

    application/pdf)
        pdftoppm -jpeg "$file" -singlefile | chafa --size "$(($width-4))"x"$height"
        pdfinfo "$file" | bat --theme='base16' --terminal-width "$(($width-4))" --force-colorization;;

    application/vnd.sqlite3)
        sqlite3 "$file" "SELECT * FROM sqlite_master WHERE type = 'table';" | bat --theme='base16' --terminal-width "$(($width-4))" --force-colorization;;

    application/x-pcapng)
        tshark -r "$file" | bat --theme='base16' --terminal-width "$(($width-4))" --force-colorization;;   # the --read-file option does not seem to work

    application/x-shellscript)
        bat --theme='base16' --terminal-width "$(($width-4))" --force-colorization "$file";;

    application/zip)
        unzip -lv "$file" | bat --theme='base16' --terminal-width "$(($width-4))" --force-colorization;;

    audio/*)
        exiftool -Picture -b "$file" | chafa --size "$(($width-4))"x"$height" || chafa cover.* --size "$(($width-4))"x"$height"
        exiftool "$file" | bat --theme='base16' --terminal-width "$(($width-4))" --force-colorization;;

    image/*)
        chafa "$file" --size "$(($width-4))"x"$height" --animate off
        exiftool "$file" | bat --theme='base16' --terminal-width "$(($width-4))" --force-colorization;;

    text/csv)
        column --separator "," --table "$file" | bat --theme='base16' --terminal-width "$(($width-4))" --force-colorization;;

    text/*)
        bat --theme='base16' --terminal-width "$(($width-4))" --force-colorization "$file";;

    video/*)
        ffmpeg -ss 00:00:00 -i "$file" -frames:v 1 -q:v 2 "$preview_image"
        chafa "$preview_image" --size "$(($width-4))"x"$height"
        rm "$preview_image"  # removing preview file so that lf looks for a new preview image instead of going for an old one
        exiftool "$file" | bat --theme='base16' --terminal-width "$(($width-4))" --force-colorization;;

    *)
        exiftool "$file" | bat --theme='base16' --terminal-width "$(($width-4))" --force-colorization;;
esac
