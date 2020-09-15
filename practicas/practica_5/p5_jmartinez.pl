#!/usr/bin/perl
# Calculadora cientifica .-.
use strict;
use warnings;
use Data::Dumper;
use Mojo::DOM;
# Raw HTML string
my $htmlStr = " ";
# Convert html into DOM tree
my $dom = Mojo::DOM->new($htmlStr);
# Find all nodes which have image tag
my $imageNodes = $dom->find('img');
# Extract the src attribute from all image nodes
my @images = $imageNodes->map(attr => 'src')->each;
print Dumper @images;
# prints 'image1.png', 'image2.png'