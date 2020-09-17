use WWW::Sitemap::Simple;
 
my $sm = WWW::Sitemap::Simple->new;
 
# simple way
$sm->add('http://example.com/');
 
# with params
$sm->add(
    'http://example.com/foo' => {
        lastmod    => '2005-01-01',
        changefreq => 'monthly',
        priority   => '0.8',
    },
);
 
# set params later
my $key = $sm->add('http://example.com/foo/bar');
$sm->add_params(
    $key => {
        lastmod    => '2005-01-01',
        changefreq => 'monthly',
        priority   => '0.8',
    },
);
 
$sm->write('sitemap/file/path');