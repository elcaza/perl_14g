use strict;

sub new {
	my $class = shift;
	my $keyword = shift || '';

	if( $keyword !~ /^[a-z]+$/ ) {
		return;
	};

	my $self = {
		'keyword' => $keyword,
	};
	bless $self, $class;

	$self->_init( $keyword );

	return( $self );
};

sub _init {
	my $self = shift;

	foreach ( split('', lc($self->{keyword})) ) {
		my $ks = (ord($_)-97) % 26;
		my $ke = $ks - 1;
 
		my ($s, $S, $e, $E);
 
		$s = chr(ord('a') + $ks);
		$e = chr(ord('a') + $ke);

		push @{$self->{fwdLookupTable}}, "a-z/$s-za-$e";
		push @{$self->{revLookupTable}}, "$s-za-$e/a-z";
	};

	return( $self );
};

sub encodeMessage {
	my $self = shift;
	my $string = shift;
	return( $self->_doTheMath($string, $self->{fwdLookupTable}) );
};

sub decodeMessage {
	my $self = shift;
	my $string = shift;
	return( $self->_doTheMath($string, $self->{revLookupTable}) );
};


sub _doTheMath {
	my $self = shift;
	my $string = shift;
	my $lookupTable = shift;
	my $returnString;

	my $count = 0;
	foreach( split('', lc($string)) ) {
		if( /[a-z]{1}/ ) {
			eval "\$_ =~ tr/$lookupTable->[$count % length($self->{keyword})]/";
			$count++;
			$returnString .= $_;
		}
	};

	return( $returnString );
};

my $keyword = "HOLA";
my $plain_text = "papalote";
print $keyword;
my $vigenere = new vigenere($keyword);