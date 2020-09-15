#!/usr/bin/perl
use WWW::Mechanize();

$sitios = 'sites.tmx';
$crawler = WWW::Mechanize->new();
%dominios;

# Crear archivo
open(input_file,'<',$sitios) or die("Archivo no encontrado.\n");
foreach $url (<input_file>)
{
    @refs = [];
    $crawler->get( $url );
    @links = $crawler->links();
    for $link ( @links ) {
           $tmp = $link->url;
           push @{ $dominios{$url} }, $tmp;
    }
}
close(input_file);

# Mostrar diccionario
foreach $link (%dominios) {
    @values = @{ $dominios{$link} };
    print "$link: @values\n\n";
}