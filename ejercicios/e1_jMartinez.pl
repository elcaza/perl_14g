#!/usr/bin/perl
# Script perl que genere un lorem ipsum
# 1. Detectar el número que se le pasa
# 2. Generar un lorem con esa cantidad de palabras

@list = ("John Paul", "Lisa", "Kumar", "lala", "palabras", "en", "un", "madrigal", "para", "porque", "Siempre", "quiso");

# foreach loop execution
for (my $i=1; $i <= $ARGV[0]; $i++){
   print $list[int(rand(scalar(@list)))]." ";
}
print "\n";