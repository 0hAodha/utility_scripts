#!/usr/bin/perl
use strict;
use warnings;

my $script_name = $1 if ($0 =~ /.*\/(.*)$/);
my $output = `bluetoothctl devices`;
my %devices;

# assumes devices have unique names
foreach my $device (split(/\n/, $output)) {
    if ($device =~ /Device\s(\S+)\s(.+)/) {
        my $mac_address = $1;
        my $name = $2;
        $devices{$name} = $mac_address;
    }
}

my $device_list = "";
foreach my $name (keys %devices) {
    $device_list .= $name . "\n";

}

my $selection = `echo "$device_list" | dmenu`;
chomp($selection);
`notify-send "$script_name" "Attempting to connect to $selection"`;
`bluetoothctl connect $devices{$selection}`;

if ($? == 0) {
    `notify-send "$script_name" "Successfully connected to $selection"`;
}
else {

    `notify-send "$script_name" "Failed to connect to $selection"`;
}
