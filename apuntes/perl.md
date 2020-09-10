# Apuntes sobre perl

## Estructura básica de un programa
```perl
#!bin/perl
use warnings; # Advertencia de errores inesperados
use strict; # Obliga a que la declaración de variables sea con "my"

# Declaración e inicialización de variables

# Programa principal main

# subrutinas (Funciones)
```

## Tipos de datos
Existen 3 tipos de datos en perl
1. **Escalares ($) :** Representa el tipo básico de Perl:
	+ Enteros
	+ Reales
	+ Cadenas de caracteres
2. **Arrays (@) :** Lista de datos de tipo escalar
	+ Cada elemento de la lista es una variable escalar
3. **Hashes o listas asociadas (%) :**
	+ Lista asociativa que está indexada por cadenas (o valores escalares)
	+ en lugar de números, formando parejas de tipo (llave, valor)

## Variables
```perl
#!bin/perl
$escalar; # Variable de tipo escalar
$lista; # Variable de tipo lista
$lista_asociada; # Variable de tipo lista asociada
```
+ Case sensitive
+ Alfanumericos y guión bajo

## Variables especiales
```perl
#!bin/perl
$_  # Variable por defecto de operaciones y funciones
@_ o @ARGV # Arreglo que almacena los argumentos recibidos
$#ARGV; # Obtiene el número de elementos recibidos -1
		# O el indice del último elemento
$! # Variable que almacena los errores de ejecución
$| # Si no es cero, obliga a vaciar el búfer después de cada operación de escritura
```
+ Son variables que tienen un funcionamiento predefinido

## Manejo de cadenas
Concatenación de cadenas
```perl
#!bin/perl
$cadena_uno = "Hola ";
$cadena_dos = "Mundo!";

# Interpolación de cadenas
print "Hola $cadena_dos"; # Hola Mundo!

print 'Hola $cadena_dos'; # Hola $cadena_dos

# Concatenación de cadenas
print $cadena_uno . $cadena_dos; # Hola Mundo!
```

Concatenación de cadenas
```perl
#!bin/perl
$cadena_uno = "Hola ";
$cadena_dos = "Mundo!";

# Interpolación de cadenas
print "Hola $cadena_dos"; # Hola Mundo!

print 'Hola $cadena_dos'; # Hola $cadena_dos

# Concatenación de cadenas
print $cadena_uno . $cadena_dos; # Hola Mundo!
```

Cadenas con multiples saltos de línea
```perl
#!bin/perl
$cadena_uno = "Hola ";
$cadena_dos = "Mundo!";

# Interpolación de cadenas
# variable <<ETIQUETA;
# ETIQUETA

$string = <<FINAL;
hola,
mundo,
!,
FINAL
print $string;
```

## Booleanos
No existe en perl, sin embargo se emula de la siguiente manera:
```perl
$bool = 1; 	 # true
$bool = "a"; # true
$bool = 0;   # false
$bool = "";  # false
```

## Arrays
```perl
@array = ("palabra", 23, "palabrita", 3.1415); # Forma normal
@mezcla = qw(palabra 23 palabrita 3.1415); # Separación por espacio
@alfabeto = (a..z); # Define un rango
```
+ Su acceso es por indice `array[0]`
+ Generando y retornando otro array especificando un rango de indices
+ Otros

Ejemplo:
```perl
@alfabeto = qw(a..z);

print $alfabeto[2]; # c
@rango = @alfabeto[1..3]; # @rango = ("b", "c", "d")
@valores = @alfabeto[4, 5] # @valores = ("e", "f")

# Otro
@alfabeto = qw(a..z);
($primero, $segundo) = @alfabeto; # (@primero = 1, @segundo = 2;)
```

Aplanar arrays
```perl
@a (1,2,3);
@b (4,5,6);
@c (@a,"a",@b,"c");
# @c = (1,2,3,"a",4,5,6,"c");
```

Manipular arrays
```perl
push(@array, 5); # Añade al final
pop(@array); # Extrae el último elemento
shift(@array); # Extrae el primer elemento
unshift(@array); # Añade al inicio
```

## Hashes (Diccionarios)
```perl
# Primera forma
%usuarios = ("root",1000,"user",1001,"other",1002);

# Segunda forma
%usuarios =(
	"root"=>1000,
	"user"=>1001,
	"other"=>1002
)
```

Acceso y modificación
```perl
$id = $usuarios{"root"}; # $id = 1000
$usuarios{"user"} = 500;
print $usuarios{"user"}; # 500
```

Funciones con hashes
```perl
keys(%hash); # Devuelve un array con todas las llaves
values(%hash); # Devuelve un array con todos los valores
delete %hash{'val'}; # Elimina el elemento del hash de la llave dada
# Elimina la llave
```

## Referencias
+ Equivalente a punteros
+ Son tratados como escalar
+ La definición de referencia se usa con el operador (\)
+ Implementa su garbage collector
+ Hay referencias anonimas

## Operadores
```perl
# Comparaciones Numericos & Cadenas
==		eq
!=		ne
<		lt
>		gt
<=		le
>=		ge

# Lógicos a nivel de bits
&		AND
|		OR
~		NOT
^		XOR

# Comparar cadenas
print 'abc' cmp 'abc', "\n"; # 0
print 'abc' cmp 'cbc', "\n"; # -1
print 'aac' cmp 'abc', "\n"; # 1

# Comparar dos números
print 10 <=> 10;  # 0
print 10 <=> 100; # -1
print 10 <=> 9;   # 1

# Ternarios
# Condición ? valor_si : valor_no
$res = ( 100 < 200 ? "Si" : "No" ); # $res = Sí

# Evalua varias expresiones
$i = (10+2, 5*2, 1+1);
print $i; # 2 (Sobreescribe en el último)
```

## Estructuras de control
```perl
# Normal
if (condiciones){
	# coso
} elsif (condicion){
	# Coso
} else {
	# Coso
}

# Unless
unless(condicion){
	# Codigo a ejecutar si no se cumple la condición
} else {
	# Codigo a ejecutar si se cumple la condición
} 

# Combinado
unless(condicion_1){
	# Codigo a ejecutar si no se cumple la condición
} elsif (condicion_n) {
	# Codigo a ejecutar si se cumple la condición_n
} else {
	# Código a ejecutar si se cumple la condición_1 y no se cumple la condiciones_n
}
```

## Ciclos
```perl
# while
while (condicion) {
	# Si se cumple la condición
}

# until
until (condicion) {
	# Si NO se cumple la condición
}

# while continue
while (condicion) {
	# Si se cumple la condición
} continue {
	# Instrucciones a ejecutar antes de la siguiente instrucción
}

# do while
do {
	# Cosas a hacer si se comple la condición
} while ();

# For
for (inicia; condicion; incremento/decremento){
	# Instrucciones
}

# Foreach
foreach $variable (@lista) {
	# Instrucciones
}
```
+ next => continue
+ last => break

## Lectura de datos
```perl
$entrada = <STDIN>;

```

# Funciones
```perl
sub funcion(){

}
funcion("argumento", 2, @array); # se envian los argumentos por referencia

```

