#!/usr/bin/perl
use warnings
use WWW::Mechanize ();

$crawler = WWW::Mechanize->new();
$the_file = 'sites.txt';
%damains;
open(INPUT_FILE,'<',$the_file) or die("Error\n");

foreach $url (<INPUT_FILE>) {   
	@refs = [];
	$crawler->get( $url );
	@links = $crawler->links();
	for $link ( @links )
	{
   		$tmp = $link->url;
   		push @{ $damains{$url} }, $tmp;
	}
}
close(INPUT_FILE);

foreach $link (%damains) {
	@values = @{ $damains{$link} };
	print "$link: @values\n";
}