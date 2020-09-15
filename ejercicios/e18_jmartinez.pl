#!/usr/bin/perl
# Cifrado de archivos

use Crypt::OpenSSL::AES;
use warnings;

$out_file = "cifrado.enc";

open (input_file, '<:raw', $ARGV[0]) or die $!;
open (output_file, '>>', $out_file) or die $!;
$key = "123456789ABCDF12";

# Cifrado
my $cipher = new Crypt::OpenSSL::AES($key);
while ( read (input_file, $bytes, 16) ) {
    $bytes = ( length($bytes) < 16 ) ? $bytes . " "x( 16 - length($bytes) ):$bytes;
    $encrypted = $cipher->encrypt($bytes);
    print output_file $encrypted;
}
close (output_file);
close (input_file);

# Descifrado
$infile = $out_file;
open (input_file, '<', $infile) or die $!;
while ( read (input_file, $bytes, 16) ) {
    $bytes = ( length($bytes) < 16 ) ? $bytes . " "x(16 - length($bytes)) : $bytes;
    $decrypted .= $cipher->decrypt($bytes);
}
close (input_file);
print $decrypted;