#!/usr/bin/perl
use strict;
use warnings;

sub main{    
    print("=========================\n\n");
    my $filename = 'history_calc.txt';

    print "1 => Calcular\n";
    print "2 => Mostrar historial\n";
    my $menu = <STDIN>;
    chomp($menu);

    if ($menu == 2){
        print("Muestro historial\n");
        open FICHERO, $filename or die "No existe ".$filename;
        while (<FICHERO>){
            print $_;
        }
        close FICHERO;
    }


    print "Dame el primer número: ";
    my $n_1 = <STDIN>;
    chomp($n_1);
    
    print "Dame el segundo número: ";
    my $n_2 = <STDIN>;
    chomp($n_2);
    
    print "Dame el operacionador: \n";
    print "  +: suma\n";
    print "  -: resta\n";
    print "  *: multiplicacion\n";
    print "  /: division\n";

    my $operacion = <STDIN>;
    chomp($operacion);
    
    my $result;
    if ($operacion eq "+") { $result = $n_1 + $n_2; }
    if ($operacion eq "-") { $result = $n_1 - $n_2; }
    if ($operacion eq "*") { $result = $n_1 * $n_2; }
    if ($operacion eq "/") {
        if ($n_2 == 0) {
            print "\nNo podemos dividir entre 0\n";
            $result = "No podemos dividir entre 0";
        } else {
            $result = $n_1 / $n_2;
        }
    }

    my $str = "\nEl resultado de es $n_1 $operacion $n_2 = $result\n";
    open(FH, '>>', $filename) or die $!;
    print FH $str;
    close(FH);
    print $str;
    main();
}

main();