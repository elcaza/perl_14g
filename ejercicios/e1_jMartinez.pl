#!/usr/bin/perl
# Script perl que reciba arugmentos por consola.
# 1. Detectar cuántos argv se pasaron 
# 2. imprimir el úlitmo

print @ARGV . "\n";
print "@ARGV[-1]" . "\n";