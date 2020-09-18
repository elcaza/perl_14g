#!/usr/bin/perl
# Calculadora 2

sub SUMAR{
	print "Ingrese primer operando: \n";
	$uno = <STDIN>;
	chomp($uno);
	print "Ingrese segundo operando: \n";
	$dos = <STDIN>;
	chomp($dos);
	print "Resultado: ",$uno+$dos,"\n";
	#Guardar en historial
	$historial{$count} = $uno+$dos;
	$count ++;
}

sub RESTAR{
	print "Ingrese primer operando: \n";
	$uno = <STDIN>;
	chomp($uno);
	print "Ingrese segundo operando: \n";
	$dos = <STDIN>;
	chomp($dos);
	print "Resultado: ",$uno-$dos,"\n";
	#Guardar en historial
	$historial{$count} = $uno-$dos;
	$count ++;
}

sub MULTIPLICAR{
	print "Ingrese primer operando: \n";
	$uno = <STDIN>;
	chomp($uno);
	print "Ingrese segundo operando: \n";
	$dos = <STDIN>;
	chomp($dos);
	print "Resultado: ",$uno*$dos,"\n";
	#Guardar en historial
	$historial{$count} = $uno*$dos;
	$count ++;	
}

sub DIVIDIR{
	print "Ingrese primer operando: \n";
	$uno = <STDIN>;
	chomp($uno);
	print "Ingrese segundo operando: \n";
	$dos = <STDIN>;
	chomp($dos);
	print "Resultado: ",$uno/$dos,"\n";
	#Guardar en historial
	$historial{$count} = $uno/$dos;
	$count ++;
}

sub HISTORIAL{
	foreach $key (sort keys %historial) 
	{
	    print "$key => $historial{$key}\n";
	}
}

$count = 1;
%historial = {};
do{
	#Se imprime el menú
	print "..::Calculadora simple::..\n"," -------- Opciones: --------\n";
	print "---------------------------\n- SUMAR\n- RESTAR\n- MULTIPLICAR\n- DIVIDIR\n- HISTORIAL\n- SALIR\n---------------------------\n";
	$line = <STDIN>;
	chomp($line);
	if (uc($line) eq "SUMAR"){
		SUMAR();
	}elsif (uc($line) eq "RESTAR"){
		RESTAR();
	}
	elsif (uc($line) eq "MULTIPLICAR"){
		MULTIPLICAR();
	}
	elsif (uc($line) eq "DIVIDIR"){
		DIVIDIR();
	}
	elsif (uc($line) eq "HISTORIAL"){
		HISTORIAL();
	}
	elsif (uc($line) ne "SALIR"){
		print "Operación no válida\n";
	}
}while(uc($line) ne "SALIR");