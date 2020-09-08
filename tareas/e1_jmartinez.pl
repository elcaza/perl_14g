#!/usr/bin/perl
use strict;
use warnings;

# Validate one argument
if ($#ARGV != 0) {
    print "\nUsage: ./t1_jmartinez.pl <number>\n";
    exit;
}

for my $i ( 1 .. $ARGV[0] ) {
    if ( $i % 2 == 0 && $i % 3 == 0 ) { print "$i Fizzbuzz" }
    elsif ( $i % 2 == 0 ) { print "$i Fizz" }
    elsif ( $i % 3 == 0 ) { print "$i Buzz" }
    else { print $i }
    print "\n";
}