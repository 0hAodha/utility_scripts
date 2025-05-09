#!/bin/sh
# File preview handler for lf using the Perl `mimetype` utility.

preview_image="/tmp/lf_preview_image.png"

file=$1
width="${2:-$(tput cols)}"
height="${3:-$(tput lines)}"
x=$4
y=$5

mimetype="$(mimetype --brief -- "$file")"

if [ "$mimetype" = "inode/symlink" ]; then
    file="$(readlink "$file")"
    mimetype="$(mimetype --brief -- "$file")"
fi

case "$mimetype" in
    application/gzip | application/msword | application/x-iso9660-image | application/vnd.openxmlformats-officedocument.wordprocessingml.document | application/vnd.openxmlformats-officedocument.presentationml.presentation | application/vnd.openxmlformats-officedocument.spreadsheetml.sheet)
        exiftool "$file" | bat --theme='base16' --terminal-width "$(($width-4))" --force-colorization;;

    application/json) 
        jq --color-output . "$file" | bat --theme='base16' --terminal-width "$(($width-4))" --force-colorization;;

    application/pdf)
        pdftoppm -jpeg "$file" -singlefile | chafa --size "$(($width-4))"x"$height"
        pdfinfo "$file" | bat --theme='base16' --terminal-width "$(($width-4))" --force-colorization;;

    application/vnd.rar)
        unrar l "$file" | bat --language=java --theme='base16' --terminal-width "$(($width-4))" --force-colorization;;

    application/vnd.sqlite3)
        sqlite3 "$file" "SELECT * FROM sqlite_master WHERE type = 'table';" | bat --theme='base16' --terminal-width "$(($width-4))" --force-colorization;;

    application/x-compressed-tar)
        tar --list --ungzip --file "$file" | bat --language=java --theme='base16' --terminal-width "$(($width-4))" --force-colorization;;

    application/x-java)
        javap "$file" | bat --language=java --theme='base16' --terminal-width "$(($width-4))" --force-colorization;;

    application/x-pcapng)
        tshark -r "$file" | bat --theme='base16' --terminal-width "$(($width-4))" --force-colorization;;   # the --read-file option does not seem to work

    application/x-zstd-compressed-tar)
        tar --list --use-compress-program zstd --file "$file" | bat --language=java --theme='base16' --terminal-width "$(($width-4))" --force-colorization;;

    application/zip)
        unzip -lv "$file" | bat --theme='base16' --terminal-width "$(($width-4))" --force-colorization;;

    audio/*)
        # attempt to preview the audio file's embedded image
        ## if no embedded image, attempt to preview a file named 'cover.*' in the same directory
             # else, generate a waveform image and display it
        # exiftool -Picture -b "$file" | chafa --size "$(($width-4))"x"$height" || chafa cover.* --size "$(($width-4))"x"$height" || ffmpeg -i "$file" -filter_complex "showwavespic=s=1280x720:colors=white" -frames:v 1 -f image2pipe -vcodec png - | chafa --size "$(($width-4))"x"$height"
        exiftool -Picture -b "$file" | chafa --size "$(($width-4))"x"$height" || chafa cover.* --size "$(($width-4))"x"$height" || ffmpeg -i "$file" -filter_complex "showwavespic=s=1280x720:colors=pink" -frames:v 1 -f image2pipe -vcodec png - | chafa --size "$(($width-4))"x"$height"
        exiftool "$file" | bat --theme='base16' --terminal-width "$(($width-4))" --force-colorization;;

    image/*)
        chafa "$file" --size "$(($width-4))"x"$height" --animate off
        exiftool "$file" | bat --theme='base16' --terminal-width "$(($width-4))" --force-colorization;;

    text/csv)
        column --separator "," --table "$file" | bat --theme='base16' --terminal-width "$(($width-4))" --force-colorization --wrap=never;;

    text/html)
        lynx -width="$width" -display_charset=utf-8 -dump "$file";;

    text/tab-separated-values)
        column --separator $'\t' --table "$file" | bat --theme='base16' --terminal-width "$(($width-4))" --force-colorization --wrap=never;;

    video/*)
        ffmpeg -ss 00:00:00 -i "$file" -frames:v 1 -q:v 2 "$preview_image"
        chafa "$preview_image" --size "$(($width-4))"x"$height"
        rm "$preview_image"  # removing preview file so that lf looks for a new preview image instead of going for an old one
        exiftool "$file" | bat --theme='base16' --terminal-width "$(($width-4))" --force-colorization;;

    *)
        # check if file is text or binary
        if file "$file" | grep --silent "text"; then
            bat --theme='base16' --terminal-width "$(($width-4))" --force-colorization "$file"
        else
            exiftool "$file" | bat --theme='base16' --terminal-width "$(($width-4))" --force-colorization
        fi
        ;;

esac
