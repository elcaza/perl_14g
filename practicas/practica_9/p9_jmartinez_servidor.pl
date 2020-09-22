#!/bin/perl
# Servidor
use IO::Socket;

sub main{
    my $socket = new IO::Socket::INET (
        LocalPort => '5555',
        Proto => 'tcp',
        Listen => 5,
        Reuse => 1,
    ) or die "Error al crear el socket: $!\n";

    my $socket_server = $socket->accept();

    while (1){
        my $length = 1024;
        my $buff = "";

        print "Ingresa el comando a ejecutar: ";
        my $command = <STDIN>;
        chomp($command);
        
        if ($command eq "exit"){
            my $data = "$command";
            print $socket_server "$data";
            close($socket);
            close($socket_server);
            exit 1;
        } else {
            print "Ingresa la llave: ";
            my $llave = <STDIN>;
            chomp($llave);
            my $data = "$command-$llave";
            print $socket_server "$data";
        }

        $socket_server-> recv($buff, $length);
        print "$buff\n";
    }
    close($socket);
}

main();