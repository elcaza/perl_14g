$verdadero = 1;

while ($verdadero){
    $input = <STDIN>;
    if ($input eq "salir\n"){
        last;
    }
    print $count;
    $count++;
}