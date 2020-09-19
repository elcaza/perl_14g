open (INPUT_FILE, "data.dat");
@lines = <INPUT_FILE>;
$count = 0;

foreach $line (@lines) {
    $c_ceros = () = $line =~ /\Q0/g;
    $c_unos = () = $line =~ /\Q1/g;

    if ($c_ceros % 3 == 0 or $c_unos % 2 == 0) {
        $count++;
    }
}

print("\n$count\n");