use warnings;
use strict;

my $num1;
my $num2;
my $option;

principal();
sub principal{
	print "Menu:\n";
	print "1 Suma \n";
	print "2 Resta \n";
	print "3 Division \n";
	print "4 Multiplicación\n";

	chomp ($option = <STDIN>);
	chomp ($num1 = <STDIN>);
	chomp ($num2 = <STDIN>);
	
	if($option == 1){
		suma();
	}
	if($option == 2){
		resta();
	}
	if($option == 3){
		division();
	}
	if($option == 4){
		multiplicacion();
	}else{
		print "no valido";
	}
}

sub suma{
	print $num1+$num2;
}

sub resta{
	print $num1-$num2;
}

sub division{
	if($num2==0){
		print "\nNo puedes dividir entre 0";
	}else{
		print $num1/$num2;
	}
}

sub multiplicacion{
	print $num1*$num2;
}