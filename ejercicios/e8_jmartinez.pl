#!/usr/bin/perl
use warnings;
use WWW::Mechanize ();


$crawler = WWW::Mechanize->new();
$the_file = 'sites.txt';
%domains;
open(INPUT_FILE,'<',$the_file) or die("Error\n");

foreach $url (<INPUT_FILE>) {   
	@refs = [];
	$crawler->get( $url );
	@links = $crawler->links();
	for $link ( @links ) {
   		$tmp = $link->url;
   		push @{ $domains{$url} }, $tmp;
	}
}
close(INPUT_FILE);

foreach $link (sort {scalar($domains{$a}) cmp scalar($domains{$b})} keys %domains) {
   	@values = @{ $domains{$link} };
	print "$link: @values\n\n";
}