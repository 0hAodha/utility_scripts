#!/usr/bin/perl -l
# Script that constructs a `dmenu` menu of all search engines defined in the qutebrowser configuration file for searching without first launching qutebrowser
use strict;
use warnings;

my $file_path = "$ENV{HOME}/.config/qutebrowser/config.py";
my @search_engines;

open(my $file_handler, '<', $file_path) or die("Couldn't open $file_path $!");
my $inside = 0;

while (my $line = <$file_handler>) {

    if ($line =~ /^c\.url\.searchengines\s*=\s*{/) {
        $inside = 1;
        next;
    }

    if ($inside) {
        last if ($line =~ /^\s*}/);

        $line =~ s/["':]//g;
        $line =~ s/^\s+|\s+$//g;

        my ($search_engine) = split(/\s+/, $line);

        if ($search_engine && $search_engine !~ /^\s*#/) {
            push(@search_engines, $search_engine);
        }
    }
}

close($file_handler);

my $dmenu_input = join("\n", @search_engines);
my $selection = `echo "$dmenu_input" | dmenu`;

if ($selection) {
    exec("qutebrowser", $selection);
}
