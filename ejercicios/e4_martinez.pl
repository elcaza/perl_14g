#!/usr/bin/perl
    # 1 Con un script de perl obtener el archivo perteneciente a la siguiente referencia https://openphish.com/feed.txt y actualizar este archivo descargándolo cada 5 min.


use strict;
use warnings;
use LWP::Simple;
use File::Fetch;

my $url = "https://openphish.com/feed.txt";
my $file = 'sites.tmx';

sub main(){
    getstore($url, $file);
}

main();
