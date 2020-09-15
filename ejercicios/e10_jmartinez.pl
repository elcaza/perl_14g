#!/usr/bin/perl

my @passwd = `cat /etc/passwd`;

print "USER UID GID HOME SHELL\n";
foreach my $line (@passwd)
{
	chomp ($line);
	($user,$pass,$uid,$gid,$descr,$home,$shell) = split (/:/,$line);
	if ($shell =~ /bash/)
	{
		print "$user $uid $gid $home $shell\n";
	}
}