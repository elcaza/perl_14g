#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use HTTP::Tiny;

# archivo a leer
my $file = 'sites.tmx';
my $Client = HTTP::Tiny->new();


open my $urls, $file or die "Could not open $file: $!";

while( my $line = <$urls>)  {     
    my $response = $Client->get($line);
    if ($response->{status} == 200){
        print "200\n";
    } else {
        print "no";
    }
    say $line, ": ", $response->{status};
}

close $urls;


# my $Client = HTTP::Tiny->new();

# my @urls = (
#     'http://www.yahoo.com',
#     'https://www.google.com',
#     'http://nosuchsiteexists.com',
# );

# for my $url (@urls) {
#     my $response = $Client->get($url);
#     say $url, ": ", $response->{status};
# }