#!/usr/bin/perl
# Usage: ./p7_jmartinez.pl 'El mensaje a cifrar' KEY

use strict;
use warnings;

my $mensaje;
my $KEY;
my $cifrado;
my $descifrado;

if ($#ARGV != 1) {
    print "\nUsage: ./p7_jmartinez.pl 'El mensaje a cifrar' KEY";
    exit;
}

$mensaje = $ARGV[0];
$KEY = $ARGV[1];

$mensaje = lc($mensaje);
$KEY = lc($KEY);

print "Mensaje: $mensaje\n";
print "Password: $KEY\n";

$cifrado = cifrar_mensaje( $mensaje, $KEY);
$descifrado = descifrar_mensaje( $cifrado, $KEY );

print "Mensaje cifrado: $cifrado\n";
print "Mensaje descifrado: $descifrado\n";

sub cifrar_mensaje{
	# Obtenemos parametros
    my ($mensaje, $KEY) = @_;
    my $cifrado;
   
    $KEY = $KEY x (length($mensaje) / length($KEY) + 1);

    for( my $i=0; $i<length($mensaje); $i++ ){
        $cifrado .= descifrar_vigenere( (substr($mensaje,$i,1)),  (substr($KEY,$i,1)));
    }
    return $cifrado;
}

sub descifrar_mensaje{
	# Obtenemos parametros
    my ($cifrado, $KEY) = @_;
    my $mensaje;

    $KEY = $KEY x (length($cifrado) / length($KEY) + 1); #Hacemos embonar la KEY
    for( my $i=0; $i<length($cifrado); $i++ ){
        $mensaje .= cifrar_vigenere( (substr($cifrado,$i,1)),  (substr($KEY,$i,1)));
    }
    return $mensaje;
}

sub cifrar_vigenere{
    # Obtenemos parametros
    my ($letra, $vertical) = @_;
    my $letra_cifrada;

    $vertical = ord(lc($vertical)) - ord('a');
    $letra  = ord (lc($letra)) - ord('a');
    $letra_cifrada = ($letra + $vertical) % 26;	
    $letra_cifrada = chr($letra_cifrada + ord('a'));
    return uc($letra_cifrada);
}

sub descifrar_vigenere{
    # Obtenemos parametros
    my ($letra_cifrada, $KEY) = @_;
    my $letra;
    
    $KEY = ord(lc($KEY)) - ord('a');
    $letra_cifrada = ord(lc($letra_cifrada)) - ord('a');
    $letra  = ($letra_cifrada - $KEY) % 26;
    $letra = chr($letra + ord('a'));
    return lc($letra);
}