#!/usr/bin/perl
# Script that fetches lyrics for music files from the LRCLIB API and saves them to *.lrc files.

use strict;
use warnings;
use JSON;

sub create_tracklist_from_argv {
    my @tracks;

    foreach my $file_path (@ARGV) {
        print("File path: $file_path\n");
        if (!-e $file_path) {
            die("$file_path does not exist");
        }
        elsif (-d $file_path) {
            push(@tracks, list_tracks_in_directory($file_path));
        }
        else {
            my $absolute_path = qx(realpath "$file_path");
            chomp($absolute_path);
            push(@tracks, $absolute_path);
        }
    }

    return(@tracks);
}

sub list_tracks_in_directory {
    my ($directory) = @_;

    my @tracks = qx(
        fd --base-directory "$directory" \\
            --exclude "*.jpg" --exclude "*.png" --exclude "*.lrc" \\
            --absolute-path
    );
    chomp(@tracks);

    if ($? != 0) {
        die("Failed to list tracks in $directory with exit code " . $? >> 8);
    }

    return(@tracks);
}

sub extract_track_metadata {
    my ($track) = @_; 

    my @metadata = qx(exiftool -short3 -Title -Artist -Album "$track");
    chomp(@metadata);

    return(@metadata);
}

sub extract_track_duration {
    my ($track) = @_; 

    my $duration = qx(ffprobe -loglevel quiet -output_format csv=p=0 -show_entries format=duration "$track");
    chomp($duration);

    # remove the digits after the decimal point
    # the LRCLIB API permits the 'duration' field to be within ±2 seconds of LRCLIB's record, so rounding is unnecessary
    $duration =~ s/\..*//;

    return($duration);
}

sub get_synced_lyrics {
    my ($track_name, $artist_name, $album_name, $duration) = @_;
    my $api_url = "https://lrclib.net/api/get";

    my $response = qx(
        curl --get \\
            --data-urlencode "track_name=$track_name" \\
            --data-urlencode "artist_name=$artist_name" \\
            --data-urlencode "album_name=$album_name" \\
            --data-urlencode "duration=$duration" \\
            $api_url
        ) or warn("Failed to fetch lyrics data from the API for: "
            . "track_name=$track_name, artist_name=$artist_name, album_name=$album_name, duration=$duration"
            ) and return;

    my $synced_lyrics = decode_json($response)->{syncedLyrics}
        or warn("Failed to extract 'syncedLyrics' field from JSON API response for:"
            . "track_name=$track_name, artist_name=$artist_name, album_name=$album_name, duration=$duration"
        );

    return($synced_lyrics);
}

sub write_synced_lyrics {
    my ($track, $synced_lyrics) = @_;
    my $lyric_file = $track =~ s/\.[^.]+$/.lrc/r;

    open(my $file_handler, '>', $lyric_file)
        or warn("Cannot open $lyric_file") and return;
    print {$file_handler} ($synced_lyrics);
    close($file_handler);
}

sub main {
    my @tracks = create_tracklist_from_argv();

    foreach my $track (@tracks) {
        my @metadata = extract_track_metadata($track)
            or warn("Failed to extract metadata from $track\n") and next;
        my ($track_name, $artist_name, $album_name) = @metadata;

        my $duration = extract_track_duration($track)
            or warn("Failed to extract duration from $track\n") and next;

        my $synced_lyrics = get_synced_lyrics($track_name, $artist_name, $album_name, $duration)
            or warn("Failed to fetch synced lyrics for $track\n") and next;

        write_synced_lyrics($track, $synced_lyrics);
    }
}

main();
