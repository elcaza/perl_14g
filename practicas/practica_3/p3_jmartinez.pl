#!/usr/bin/perl
# Grafica resultados
use Chart::Gnuplot;
use warnings

sub main{
	@x = ();
	@y = ();

	$infile = "report.txt" ;

	open(INPUT_FILE,'<',$infile) or die("Error.\n");
	foreach $line (<INPUT_FILE>)
	{   
		chomp($line);
		if ($line =~ m/^Port/){
			@temporal = split(" ",$line);
			$port = $temporal[1];
			if ( grep( /^$port$/, @param ) ) {
				$count += $temporal[3];
				push(@x,"Port $port");
				push(@y,$count);
			}else{
				push(@param,$port);
				$count = $temporal[3];
			}

			if (@x){
				
				my $chart = Chart::Gnuplot->new(
					output => "users by port.png",
					title  => "users by port",
					xlabel => "Categorias",
					ylabel => "Datos"
				);
				my $dataSet = Chart::Gnuplot::DataSet->new(
					xdata => \@x,
					ydata => \@y,
					title  => "users by port",
					style => 'histogramas'
				);
				$chart->plot2d($dataSet);

				@x = ();
				@y = ();
			}
		}elsif($line =~ m/:/){
			@temporal = split(": ",$line);
			if ($temporal[0]=~ m/Windows$/)
			{
				push(@x,"Hosts con Windows");
				push(@y,$temporal[1]);

				my $chart = Chart::Gnuplot->new(
					output => "Hosts con Windows.png",
					title  => "Hosts con Windows",
					xlabel => "Categorias",
					ylabel => "Datos"
				);
				my $dataSet = Chart::Gnuplot::DataSet->new(
					xdata => \@x,
					ydata => \@y,
					title  => "Hosts con Windows",
					style => 'histograms'
				);
				$chart->plot2d($dataSet);
				@x = ();
				@y = ();			
			}elsif ($temporal[0]=~ m/Linux$/)
			{
				push(@x,"Hosts con Linux");
				push(@y,$temporal[1]);

				my $chart = Chart::Gnuplot->new(
					output => "Hosts con Linux.png",
					title  => "Hosts con Linux",
					xlabel => "Categorias",
					ylabel => "Datos"
				);

				my $dataSet = Chart::Gnuplot::DataSet->new(
					xdata => \@x,
					ydata => \@y,
					title  => "Hosts con Linux",
					style => 'histograms'
				);

				$chart->plot2d($dataSet);

				@x = ();
				@y = ();
			}else{
				push(@x,$temporal[0]);
				push(@y,$temporal[1]);
				my $chart = Chart::Gnuplot->new(
					output => "$temporal[0].png",
					title  => "$temporal[0]",
					xlabel => "Categorias",
					ylabel => "Datos"
				);
				my $dataSet = Chart::Gnuplot::DataSet->new(
					xdata => \@x,
					ydata => \@y,
					title  => "$temporal[0]",
					style => 'histograms'
				);
				$chart->plot2d($dataSet);
				@x = ();
				@y = ();
			}
		}elsif (not $line =~ m/-+/){
			@temporal = split(" con ",$line);
			$temporal[0] = lc($temporal[0]);
			push(@x,"Puertos en $temporal[0]");
			@new_temporal = split(" ",$temporal[1]);
			push(@y,$new_temporal[0]);

			my $chart = Chart::Gnuplot->new(
				output => "Puertos en $temporal[0].png",
				title  => "Puertos en $temporal[0]",
				xlabel => "Categorias",
				ylabel => "Datos"
			);

			my $dataSet = Chart::Gnuplot::DataSet->new(
				xdata => \@x,
				ydata => \@y,
				title  => "Puertos en $temporal[0]",
				style => 'histograms'
			);
			$chart->plot2d($dataSet);
			@x = ();
			@y = ();
		}
	}
	close(INPUT_FILE);
}
main();