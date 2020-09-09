#!/usr/bin/perl
use strict;
use warnings;

main();

sub main {
    if ($#ARGV > -1) {
        es_palindromo();
    } else {
        input_palindromo()
    }
    # es_palindromo();
}

sub input_palindromo {
    
    my $salir = es_palindromo();
    
    if ($salir cmp "ya no"){
        input_palindromo();
    } else {
        print "Adiós :3\n";
        exit();
    }
}

sub es_palindromo {
    my $str = "";
    if ($#ARGV > -1) {
        $str = $ARGV[0];
    } else {
        chomp($str = <STDIN>);
    }

    if ( $str eq reverse($str) ) {
        print "$str : es palíndromo\n";
    }
    else {
        print "$str : no es palíndromo\n";
    }
    return $str
}