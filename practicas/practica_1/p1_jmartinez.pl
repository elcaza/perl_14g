#!/bin/perl

# Validate one argument
if ($#ARGV != 0) {
    print "\nUsage: ./p1_jmartinez.pl 127.0.0.1/24\n";
    exit;
}

sub main(){
    $IP = $ARGV[0];
    $filename = "./report.txt";
    $result = exec("nmap –sP $IP >> $filename");
}

main();