#!/usr/bin/perl
use Data::Validate::ip qw(is_ipv4);		
use List::MoreUtils qw(uniq);
use Data::Dumper;

@host=();
@aux=();	
$ports = 0;

# Validacion de inicio
if ($#ARGV != 0) {    
	print "Usage: ./p2_jmartinez.pl <ip>\n";
	exit;
}

# Validacion de ip
if (is_ipv4($ARGV[0])) {
	print "IPv4 ok\n";
} else {
	exit;
}

print "Escanenado $ARGV[0]...\n";
# Guardamos en array
@simple = `sudo nmap -sP $ARGV[0]/24`;
@simple = `sudo nmap -sP $ARGV[0]/30`;
print "$simple[0]","$simple[scalar @simple -1]";
chomp($simple[0]);				
chomp($simple[scalar @simple -1]);
`echo $simple[0] > "report.txt"`;
`echo $simple[scalar @simple -1] >> "report.txt"`;

for ( $i = 1; $i < scalar @simple -1; $i += 2 ) {
	chomp($simple[$i]);
	@line = split / /, $simple[$i];
	$ip = $line[scalar @line -1];
	$ip =~ s/[()]+//g;
	# Validamos ip
	print "Probando con: $ip\n";
	if ( is_ipv4($ip) )
	{
		if ($ip =~ m/[0-9]+\.[0-9]+\.[0-9]+\.0|255/)
		{
			print "Siguiente...\n"
		}
		else
		{
			# Hacemos ping para encontrar el TTL
			@output = `ping $ip -c 3`; 
			splice(@output,-1,1);splice(@output,-1,1);splice(@output,-1,1);splice(@output,-1,1);splice(@output,0,1);

			foreach my $line (@output) {
				chomp($line);
				@Formato = split (/ /,$line);
				$TTL = $Formato[-3];
				if ($TTL eq "ttl=64")
				{
					$OS = "Linux";
				}elsif ($TTL eq "ttl=128")
				{
					$OS = "Windows";
				}
				else
				{
					$OS = "Linux";
				}
			}
			
			# Guardamos el resultado del S.O.
			if (exists $results{$OS}){
				@host = @{ $results{$OS} };
				@host = uniq(@host);
				if (not exists $host{$ip}){
					push (@host,$ip);
				}
				$results{$OS} = [@host];
			}else{
				push (@aux,$ip);
				$results{$OS} = [@aux];
				$aux=();
			}

			@host=();
			@aux=();
			$ports = 0;
			# Usamos nmap
			@output = `sudo nmap -sV $ip -T4`;
			splice(@output,-1,1);splice(@output,-1,1);splice(@output,-1,1);splice(@output,-1,1);splice(@output,0,1);splice(@output,0,1);splice(@output,0,1);splice(@output,0,1);splice(@output,0,1);

			foreach my $line (@output) {
				chomp($line);
				if ($line){
					@tcp = split (/ /,$line);
					# Response
					$Res = $tcp[0];
					# Estado
					$estado_tcp = $tcp[1];
					# Service
					$servicio = $tcp[2];
					# Para la versión
					$version = join(' ', @all[3..$#all]);
					($puerto_tcp,$proto_tcp)= split (/\//,$Res);
				}
				else{
					$puerto_tcp="";$proto_tcp="";$estado_tcp="";$servicio="";$version="";
					@host=();
					@aux=();
				}

				if (lc($estado_tcp) =~ /open/){
					$estado_tcp = "O";
				}
				if (lc($estado_tcp) =~ /closed/) {
					$estado_tcp = "C";
				}
				if (lc($estado_tcp) =~ /filtered/){
					$estado_tcp = "F";
				}
				if (lc($estado_tcp) =~ /unfiltered/){
					$estado_tcp = "U";
				}
				if (lc($estado_tcp) =~ /open\|filtered/){
					$estado_tcp = "o";
				}
				if (lc($estado_tcp) =~ /closed\|filtered/){
					$estado_tcp = "c";
				}

				@host=();
				@aux=();
				# Salvamos
				if (exists $results{"$puerto_tcp+$estado_tcp"}){
					@host = @{ $results{"$puerto_tcp+$estado_tcp"} };
					@host = uniq(@host);
					if (not exists $host{$ip}){
						push (@host,$ip);
					}
					$results{"$puerto_tcp+$estado_tcp"} = [@host];
				}else{
					push (@aux,$ip);
					$results{"$puerto_tcp+$estado_tcp"} = [@aux];
					$aux=();
					$ports++;
				}
				
				@host=();
				@aux=();
				# Salvamos protocolo
				if (exists $results{$proto_tcp}){
					@host = @{ $results{$proto_tcp} };
					@host = uniq(@host);
					if (not exists $host{$ip}){
						push (@host,$ip);
					}
					$results{$proto_tcp} = [@host];
				}else{
					push (@aux,$ip);
					$results{$proto_tcp} = [@aux];
					$aux=();
				}
				@host=();
				@aux=();
				if (exists $results{$servicio}){
					@host = @{ $results{$servicio} };
					@host = uniq(@host);
					if (not exists $host{$ip}){
						push (@host,$ip);
					}
					$results{$servicio} = [@host];
				}else{
					push (@aux,$ip);
					$results{$servicio} = [@aux];
					$aux=();
				}

				@host=();
				@aux=();

				if (exists $results{$version}){
					@host = @{ $results{$version} };

					@host = uniq(@host);
					if (not exists $host{$ip}){
						push (@host,$ip);
					}
					$results{$version} = [@host];
				}else{
					push (@aux,$ip);
					$results{$version} = [@aux];
					$aux=();
				}


				@host=();
				@aux=();
			}

			@output = `sudo nmap -sU $ip -T4`; 

			splice(@output,-1,1);splice(@output,-1,1);splice(@output,0,1);splice(@output,0,1);splice(@output,0,1);splice(@output,0,1);splice(@output,0,1);splice(@output,0,1);

			foreach my $line (@output) {
				chomp($line);
				if ($line){
					($Res,$estado_udp) = split (/ /,$line);
					($puerto_udp,$proto_udp)= split (/\//,$puerto_proto);
				}
				else{
					$puerto_udp = "";$proto_udp="";$estado_udp="";
					#Limpiamos entre busquedas
					@host=();
					@aux=();
				}

				if (lc($estado_udp) =~ /open/){
					$estado_udp = "O";
				}
				if (lc($estado_udp) =~ /closed/) {
					$estado_udp = "C";
				}
				if (lc($estado_udp) =~ /filtered/){
					$estado_udp = "F";
				}
				if (lc($estado_udp) =~ /unfiltered/){
					$estado_udp = "U";
				}
				if (lc($estado_udp) =~ /open\|filtered/){
					$estado_udp = "o";
				}
				if (lc($estado_udp) =~ /closed\|filtered/){
					$estado_udp = "c";
				}
				
				@host=();
				@aux=();
				# Salvamos ports
				if (exists $results{"$puerto_udp+$estado_udp"}){
					@host = @{ $results{"$puerto_udp+$estado_udp"} };
					@host = uniq(@host);
					if (not exists $host{$ip}){
						push (@host,$ip);
					}
					$results{"$puerto_udp+$estado_udp"} = [@host];
				}else{
					push (@aux,$ip);
					$results{"$puerto_udp+$estado_udp"} = [@aux];
					$aux=();
					$ports++;
				}

				@host=();
				@aux=();
				if (exists $results{$proto_udp}){
					@host = @{ $results{$proto_udp} };
					@host = uniq(@host);
					if (not exists $host{$ip}){
						push (@host,$ip);
					}
					$results{$proto_udp} = [@host];
				}else{
					push (@aux,$ip);
					$results{$proto_udp} = [@aux];
					$aux=();
				}

				@host=();
				@aux=();

				if (exists $results{$estado_udp}){
					@host = @{ $results{$estado_udp} };
					@host = uniq(@host);

					if (not exists $host{$ip}){
						push (@host,$ip);
					}

					$results{$estado_udp} = [@host];
				}else{
					push (@aux,$ip);
					$results{$estado_udp} = [@aux];
					$aux=();
				}
				@host=();
				@aux=();
			}
			$ports = "$ports";
			push (@{$results{$ip}},$ports);
		}
	}
	else{print "Error: :c\n";}
}

delete $results{''};
$puerto_conocido=0;
$puerto_registrado=0;
$PtoGeneral=0;
$puerto_open=0;
$puerto_close=0;
$puerto_filtered=0;
$puerto_unfiltered=0;
$puerto_openF=0;
$puerto_closeF=0;
$puerto_tcp=0;
$puerto_udp=0;
open(OUTPUT_FILE,'>',"report.txt") or die("Archivo no encontrado.\n");
print OUTPUT_FILE "*****************************************************\n";
foreach $key (sort keys %results) {
	@host = @{ $results{$key} };
	@host = uniq(@host);
	$results{$key} = [@host];
	$pto = $key;
	if ($key =~ /[0-9]+\+./){
		chop($pto);			
	}
	chop($pto);			


	if ($pto =~ /([0-9]+)+/){
		if (not $pto =~ /([0-9]+\.)+/) {
			if ( int($key) < 1024){
				$puerto_conocido++;
			}elsif ( int($key) < 65535){
				$puerto_registrado++;
			}else{
				$PtoGeneral++;
			}
			print OUTPUT_FILE "Puerto $pto con ",scalar @{$results{$key}}," host.\n";
		}
	}
	if ($key =~ /[0-9]+\+O?/){
		$puerto_open++;
	}
	if ($key =~ /[0-9]+\+C/) {
		$puerto_close++;
	}
	if ($key =~ /[0-9]+\+F/){
		$puerto_filtered++;
	}
	if ($key =~ /[0-9]+\+U/){
		$puerto_unfiltered++;
	}
	if ($key =~ /[0-9]+\+o/){
		$puerto_openF++;
	}
	if ($key =~ /[0-9]+\+c/){
		$puerto_closeF++;
	}
	if($key =~ /tcp/)
	{
		$puerto_tcp = scalar @{$results{$key}};
	}
	if($key =~ /udp/)
	{
		$puerto_udp = scalar @{$results{$key}};
	}
	if ($key =~ /Linux/){
		print OUTPUT_FILE "No. de host con $key: ",scalar @{$results{$key}},"\n";
	}
	if ($key =~ /Windows/){
		print OUTPUT_FILE "No. de host con $key: ",scalar @{$results{$key}},"\n";
	}
	# Ports by hosts
	if ($key =~ /[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/){
		print OUTPUT_FILE "Host $key con @{$results{$key}} ports\n"    }
}
print OUTPUT_FILE "ports registrados: $puerto_registrado\n";
print OUTPUT_FILE "ports conocidos: $puerto_conocido\n";
print OUTPUT_FILE "ports Opened: $puerto_open\n";
print OUTPUT_FILE "ports Closed: $puerto_close\n";
print OUTPUT_FILE "ports Filtered: $puerto_filtered\n";
print OUTPUT_FILE "Número de ports Opened|Filtered: $puerto_openF\n";
print OUTPUT_FILE "Número de ports Closed|Filtered: $puerto_closeF\n";
print OUTPUT_FILE "Número de ports Unfiltered: $puerto_unfiltered\n";
print OUTPUT_FILE "Número de ports tcp: $puerto_tcp\n";
print OUTPUT_FILE "Número de ports UDP: $puerto_udp\n";
close(OUTPUT_FILE);