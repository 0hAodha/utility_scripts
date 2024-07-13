#!/usr/bin/perl -l
# Perl script to display information about connected bluetooth devices. Designed to be used with polybar

use strict;
use warnings;

my $output = `bluetoothctl info` or die;

my $mac_address = $1 if ($output =~ /^Device\s+(\S+)/) or die("N/A\n");
my $device_name = $1 if ($output =~ /Name:\s+(.*)/);
my $icon = $1 if ($output =~ /Icon:\s+(.*)/);
my $battery_percentage = $1 if ($output =~ /Battery Percentage:\s+\S+\s\(([0-9]+)\)/);

if ($icon eq "audio-headphones") {
    printf("  ");
}
printf("$device_name $battery_percentage%%");
