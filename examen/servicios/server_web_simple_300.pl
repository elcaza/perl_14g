#!/usr/bin/perl -w
 use IO::Socket;
 use Net::hostent;
 $PORT = $ARGV[0];
 $server = IO::Socket::INET->new( Proto     => 'tcp',
                                  LocalPort => $PORT,
                                  Listen    => SOMAXCONN,
                                  Reuse     => 1);
 die "can't setup server" unless $server;
 while ($client = $server->accept()) {
   $client->autoflush(1);
   my $request = <$client>;
   if ($request =~ m|^GET /(.+) HTTP/1.[01]|) {
      if (-e "bandera.txt") {
       print $client "HTTP/1.0 200 OK\nContent-Type: text/html\n\n";
       open(<FLAG>,"<bandera.txt");
       while(<FLAG>) { print $client $_ };
      }else {
     print $client "HTTP/1.0 404 FILE NOT FOUND\n";
     print $client "Content-Type: text/plain\n\n";
     print $client "No encontramos ese archivo\n";
    } 
   } else {
     print $client "HTTP/1.0 400 BAD REQUEST\n";
     print $client "Content-Type: text/plain\n\n";
     print $client "BAD REQUEST\n";
   }
   close $client;
 }