#!/bin/perl
$data_raw = "57e616d636562747b7074334b6f555e6054336b6f50703753327d7";

$string = pack("h*", $data_raw);

print "$string\n";