use HTML::Element;
$a = HTML::Element->new('span', href => 'http://www.perl.com/');
$a->push_content("The Perl Homepage");
 
$tag = $a->tag;
print "$tag starts out as:",  $a->starttag, "\n";
print "$tag ends as:",  $a->endtag, "\n";
print "$tag\'s href attribute is: ", $a->attr('href'), "\n";
 
$links_r = $a->extract_links();
print "Hey, I found ", scalar(@$links_r), " links.\n";
 
print "And that, as HTML, is: ", $a->as_HTML, "\n";
$a = $a->delete;