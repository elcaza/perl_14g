#!/usr/bin/perl 
use lib './';
use e15_jmartinez;

use warnings;
use strict;
use feature 'say';
use IO::Socket qw(AF_INET AF_UNIX SOCK_STREAM SHUT_WR);

my $data = "";

my $server = IO::Socket->new(
    Domain => AF_INET,
    Type => SOCK_STREAM,
    Proto => 'tcp',
    LocalHost => '0.0.0.0',
    LocalPort => 5555,
    ReusePort => 1,
    Listen => 5,
) || die "No se pudo abrir socket: $@";
say "Sirviendo en 5555";

my $client = $server->accept();
my $client_address = $client->peerhost();
my $client_port = $client->peerport();

while (1) {
    say "Conexion lista $client_address:$client_port";

    # Menu
    $data = e15_jmartinez::principal();
    $client->send($data);
    $data = "";
    $client->recv($data, 1024);
    
    say "$data\n";

    if (lc($data) eq "1"){
    	$data = "Ingrese el primer valor: ";
    	$client->send($data);
	    
	    my $operando_1 = "";
	    $client->recv($operando_1, 1024);
	
		$data = "Ingrese el segundo valor: ";
    	$client->send($data);

	    my $operando_2 = "";
	    $client->recv($operando_2, 1024);

	    $data = e15_jmartinez::suma($operando_1,$operando_2);
	    $client->send($data);
    }elsif (lc($data) eq "2"){
    	$data = "Ingrese el primer valor: ";
    	$client->send($data);
	    
	    my $operando_1 = "";
	    $client->recv($operando_1, 1024);
	
		$data = "Ingrese el segundo valor: ";
    	$client->send($data);

	    my $operando_2 = "";
	    $client->recv($operando_2, 1024);

	    $data = e15_jmartinez::resta($operando_1,$operando_2);
	    $client->send($data);    	
    }elsif (lc($data) eq "4"){
    	$data = "Ingrese el primer valor: ";
    	$client->send($data);
	    
	    my $operando_1 = "";
	    $client->recv($operando_1, 1024);
	
		$data = "Ingrese el segundo valor: ";
    	$client->send($data);

	    my $operando_2 = "";
	    $client->recv($operando_2, 1024);

	    $data = e15_jmartinez::multiplicacion($operando_1,$operando_2);

	    $client->send($data);
    }elsif (lc($data) eq "3"){
    	$data = "Ingrese el primer valor: ";
    	$client->send($data);
	    
	    my $operando_1 = "";
	    $client->recv($operando_1, 1024);
	
		$data = "Ingrese el segundo valor: ";
    	$client->send($data);

	    my $operando_2 = "";
	    $client->recv($operando_2, 1024);

	    $data = e15_jmartinez::division($operando_1,$operando_2);
	    $client->send($data);
    }else{
    	last;
    }
}
$server->close();