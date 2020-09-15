# cvt.pl. Convert helloworld.pl into a camel shape.
use Acme::EyeDrops qw(sightly);
print sightly( { Shape       => 'camel',
                 SourceFile  => 'e17_jmartinez.pl',
                 Regex       => 1 } );