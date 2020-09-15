#!/usr/bin/perl

$archivo_analizar = "mails.txt";
open(input_file,'<',$archivo_analizar) or die("Error al leer archivo.\n");
foreach $email (<input_file>)
{   
	chomp($email);
    if ( $email =~ /([a-zA-Z]+)\@([a-zA-Z]+)+(\.([a-zA-Z]+))*\.(com/mx|org)/)
	{
	    print "$email\n";
	    
	}
}
close(input_file);