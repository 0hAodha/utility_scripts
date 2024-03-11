#!/bin/sh
# File preview handler for lf using the Perl `mimetype` utility.

preview_filepath="/tmp/lf_preview_image.png"

case "$(mimetype --brief -- "$1")" in
    application/gzip | application/msword | application/x-iso9660-image | application/vnd.openxmlformats-officedocument.wordprocessingml.document)
        exiftool "$1" | bat --theme='base16' --terminal-width "$(($2-4))" --force-colorization;;

    application/json) 
        jq --color-output . "$1" | bat --theme='base16' --terminal-width "$(($2-4))" --force-colorization;;

    application/pdf)
        pdftoppm -jpeg "$1" -singlefile | chafa --size="$(($2-4))"x"$3" --animate off
        pdfinfo "$1" | bat --theme='base16' --terminal-width "$(($2-4))" --force-colorization;;

    application/vnd.sqlite3)
        sqlite3 "$1" "SELECT * FROM sqlite_master WHERE type = 'table';" | bat --theme='base16' --terminal-width "$(($2-4))" --force-colorization;;

    application/x-pcapng)
        tshark -r "$1" | bat --theme='base16' --terminal-width "$(($2-4))" --force-colorization;;   # the --read-file option does not seem to work
    
    application/zip)
        unzip -lv "$1" | bat --theme='base16' --terminal-width "$(($2-4))" --force-colorization;;

    audio/*)
        exiftool -Picture -b "$1" | chafa --size="$(($2-4))"x"$3" --animate off || chafa cover.* --size="$(($2-4))"x"$3" --animate off 
        exiftool "$1" | bat --theme='base16' --terminal-width "$(($2-4))" --force-colorization;;

    video/*)
        ffmpeg -ss 00:00:00 -i "$1" -frames:v 1 "$preview_filepath"    
        chafa "$preview_filepath" --size="$(($2-4))"x"$3"
        rm "$preview_filepath"  # removing preview file so that lf looks for a new preview image instead of going for an old one
        exiftool "$1" | bat --theme='base16' --terminal-width "$(($2-4))" --force-colorization;;

    image/*)
        chafa "$1" --size="$(($2-4))"x"$3" --animate off
        exiftool "$1" | bat --theme='base16' --terminal-width "$(($2-4))" --force-colorization;;

    *)
        bat --theme='base16' --terminal-width "$(($2-4))" --force-colorization "$1"
esac
