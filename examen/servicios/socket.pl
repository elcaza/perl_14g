#!/usr/bin/perl
use IO::Socket;
use warnings;
my @num=();

$socket = new IO::Socket::INET (
        PeerAddr => '164.90.148.203',
        PeerPort=>'9733',
        Proto=> 'tcp',
) or die "ERROR: $!\n";
        my $input="";
        $socket->recv($input,1024);
        print "$input\n";
        if($input =~ /^\d+\s+[-\+\*\/x]{1}\s+[-]?\d+/){
                @operation=split /\s+/,$input;
                @num=();
                $res=0;
                push @num,$operation[0];
                push @num,$operation[2];
                if($operation[1] eq "+"){
                        $res= suma(@num);
                        print "$res \n";
                        $socket->send($res);
                }
                elsif($operation[1] eq "-"){
                        $res= resta(@num);
                        print "$res \n";
                        $socket->send($res);
                }
                elsif($operation[1] eq "x" || $operation[1] eq "\*"){
                        $res= resta(@num);
                        print "$res \n";
                        $socket->send($res);
                        $res= mul(@num);
                        print "$res \n";
                        $socket->send($res);
                }
                elsif($operation[1] eq "\/"){
                        $res= div(@num);
                        print "$res \n";
                        $socket->send($res);
                }
                else{
                }

        $socket->recv($resp,1024);
        print "$resp\n";
        }
        else{
        }
close($socket);

sub suma{
	print $_[0]+$_[1];
	return $_[0]+$_[1];	
}

sub resta{
	print $_[0]-$_[1];
	return $_[0]+$_[1];
}

#validar div entre 0
sub division{
	if($_[1]==0){
		print "\nNo puedes dividir entre 0";
	}else{
		print $_[0]/$_[1];
		return $_[0]/$_[1];
	}
}

sub multi{
	print $_[0]*$_[1];
	return $_[0]*$_[1];
}