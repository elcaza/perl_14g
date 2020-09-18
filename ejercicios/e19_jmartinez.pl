use System::Info;
 
my $si = System::Info->new;

printf "Nombre del hosts:              %s\n", $si->host;
printf "Número de procesadores:       %s\n", $si->ncpu;
printf "Tipo de procesador:        %s\n", $si->cpu_type; # short
printf "Descripción del procesador: %s\n", $si->cpu;      # long
printf "Versión del S.O.:        %s\n", $si->os;