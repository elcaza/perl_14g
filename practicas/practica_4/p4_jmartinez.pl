#!/usr/bin/perl
use WWW::Mechanize ();

%urls;
$sites_file = 'sites.txt';
$crawler = WWW::Mechanize->new();

open(INPUT_FILE,'<',$sites_file) or die("Error.\n");

foreach $url (<INPUT_FILE>)
{   
	chomp($url);
	@refs = [];
	$crawler->get( $url );
	@links = $crawler->links();
	
    for $link ( @links )
	{
   		$tmp = $link->url;
   		$tmp = (split / /, $tmp)[0];
   		push @{ $urls{$url} }, $tmp;
	}
}
close(INPUT_FILE);

`touch "report.txt"`;

open(OUTPUT_FILE,'>',"report.txt") or die("Error.\n");
foreach $link (%urls) {
	if (not $link =~ m/ARRAY.*/){
		print OUTPUT_FILE "$link\n";
		@values = @{ $urls{$link} };
		
        foreach my $value (@values) {
			print OUTPUT_FILE "\t$value\n";
			if (not $value =~ m/^[\/|#]/){
				$crawler = WWW::Mechanize->new();
				@links = ();
				@sublinks = ();
				$crawler->get( $value );
				@links = $crawler->links();
				
                for my $link ( @links )
				{
			   		$tmp = $link->url;
			   		$tmp = (split / /, $tmp)[0];
			   		push @sublinks, $tmp;
				}	

				foreach my $value (@sublinks) {
					if (not $value =~ m/^data:text.*/){
						print OUTPUT_FILE "\t\t$value\n";
					}
				}
			}
		}
	}
}

close(OUTPUT_FILE);