#!/usr/bin/perl
use POSIX qw(strftime);

my $date = strftime "%A %d de %B de %Y, %H:%M:%S\n", localtime;
print $date;