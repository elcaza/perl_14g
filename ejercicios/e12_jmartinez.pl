#!/usr/bin/perl
use POSIX qw(strftime);

my $date = strftime "%Y-%m-%d %H:%M:%S\n", localtime;
print $date;