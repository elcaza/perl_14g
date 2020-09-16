#!/usr/bin/perl
use warnings;
use IO::Socket;

$server = '127.0.0.1';
$port = '6667';

$con = IO::Socket::INET->new(PeerAddr=>$server,
    PeerPort=>$port,
    Proto=>'tcp',
    Timeout=>'30') || print "shecdoma! $!\n";

print $con "user\r\n";
print $con "NICK user\r\n";
print $con "JOIN #random\r\n";

while($answer = <$con>) {
    print $answer;

    if($answer =~ m/^hola (.*?)$/gi){
        print $con "Respuesta 1 ".$1."\r\n";
    }elsif($answer =~ m/^hey (.*?)$/gi){
        print $con "Respuesta 2".$1."\r\n"; 
    }elsif($answer =~ m/^saluditos (.*?)$/gi){
        print $con "Respuesta 3".$1."\r\n";
    }else{
        print $con "No hubo coincidencias".$1."\r\n"; 
    }
}