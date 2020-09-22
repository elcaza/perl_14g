#!/usr/bin/perl
use LWP::Simple;
use LWP::UserAgent ();
 
$user_agent = LWP::UserAgent->new(timeout => 3);
$user_agent->env_proxy;

$the_file='sites.txt';
$contador = 1;
open(INPUT_FILE,'<', $the_file) or die("Error\n");

$limit=`wc -l $the_file`;
while ($contador < 6) {
	$rand = int(rand($limit));
	$. = $rand; 
	$url = <INPUT_FILE>;
	$response = $user_agent->get($url);
	if ($response->is_success) {
		$outfile = "site${contador}.html";
		getstore($url, $outfile);
	    $contador ++;
	}else{
        die $response;
    }
}
close(INPUT_FILE);