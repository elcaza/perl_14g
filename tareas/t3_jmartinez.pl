#!/usr/bin/perl

if ($#ARGV != 0) {
    print "\nUsage: ./t3_jmartinez.pl 10\n";
    exit;
}

$n_diamantes=$ARGV[$#ARGV];
$mitad_diamantes=($n_diamantes%2==0? ($n_diamantes/2)-1:($n_diamantes/2)-0.5); $inicio=($n_diamantes%2==0? 0 : 1);  
for($i=1;$i<=$mitad_diamantes;$i++){      
    for ($j=$inicio;$j<=$mitad_diamantes;$j++){  
        print(" ");
    }
    for($j=0;$j<$i;$j++){      
        print("");
    }
    print("\n")               
}
for($i=0;$i<=$mitad_diamantes;$i++){        
    for($j=0;$j<$i;$j++){      
        print(" ");
    }
    for($j=0;$j<$n_diamantes-$i*2;$j++){      
        print("*");
    }
    print("\n")        
}