#!/usr/bin/perl
use LWP::UserAgent ();
use strict;
use warnings;
 
$navegador = LWP::UserAgent->new(timeout => 10);
$navegador->env_proxy;

$input_file='sites.tmx';
$output_file='active_sites.txt';
open(INPUT_FILE,'<',$input_file) or die("Error\n");

foreach $url (<INPUT_FILE>)
{   
	chomp($url);
	$response = $navegador->get($url);
	if ($response->is_success) 
	{
		open(OUT_FILE,'>>',$output_file) or die("Error\n");
		print $url,"\n";
		print OUT_FILE $url,"\n";
		close(OUT_FILE);
	}
	else {die $response;}
}
close(INPUT_FILE);