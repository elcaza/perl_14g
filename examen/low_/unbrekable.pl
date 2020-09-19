open FILE, "base32 -d enc.pem |" or die "Error\n";

my $file_enc = do { 
    $/; <FILE> 
};

$file_enc =~ s/([0-9a-f]{2})/chr(hex("$1"))/gie;
print "$file_enc\n";
close(FILE);