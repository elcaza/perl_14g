#!/usr/bin/perl

use strict;
use warnings;

use WWW::Mechanize;

my $mech = WWW::Mechanize->new;
$mech->get('https://google.com');

foreach my $link ($mech->links) {
    my $text  = $link->text;
    my $url   = $link->url;
    my $title = $link->attrs->{title};

    print "$text, $url, $title\n"
}


# use URI;
# use Web::Scraper;
# use Encode;

# $expresion = 'https://www.google.com/search?q=sin(2)-2';
 
# # First, create your scraper block
# my $authors = scraper {
#     process "#cwos", date => 'TEXT';
# };

# print "$authors->date"; 

# # my $res = $authors->scrape( URI->new("$expresion") );
# # print $res;
 
# # # iterate the array 'authors'
# # for my $author (@{$res->{authors}}) {
# #     # output is like:
# #     # Andy Adler      http://search.cpan.org/~aadler/
# #     # Aaron K Dancygier       http://search.cpan.org/~aakd/
# #     # Aamer Akhter    http://search.cpan.org/~aakhter/
# #     print Encode::encode("utf8", "$author->{fullname}\t$author->{uri}\n");
# # }