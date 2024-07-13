#!/usr/bin/perl -l
# Perl script to display information about connected bluetooth devices. Designed to be used with polybar

use strict;
use warnings;

my $output = `bluetoothctl info` or die("disconnected\n");

my $mac_address = ($output =~ /^Device\s+(\S+)/) ? "$1" : die("disconnected\n");
my $device_name = ($output =~ /Name:\s+(.*)/) ? "$1" : "unknown";
my $icon = ($output =~ /Icon:\s+(.*)/) ? "$1" : "";
my $battery_percentage = ($output =~ /Battery Percentage:\s+\S+\s\(([0-9]+)\)/) ? "$1" : "";

if ($icon eq "audio-headphones") {
    printf("  ");
}
printf("$device_name $battery_percentage%%");
