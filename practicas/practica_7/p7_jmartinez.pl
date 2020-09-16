#!/usr/bin/perl
# usage: perl p7_jmartinez.pl

use Crypt::Vigenere;

$keyword = "HOLA";
$plain_text = "papalote";
print $keyword;
$vigenere = Crypt::Vigenere->new($keyword);
 

# # Encode the plaintext
# $cipher_text = $vigenere->encodeMessage( $plain_text );
 
# # Decode the ciphertext 
# $plain_text = $vigenere->decodeMessage( $cipher_text );

# print "$vigenere\n";
# print "$cipher_text\n";
# print "$plain_text\n";