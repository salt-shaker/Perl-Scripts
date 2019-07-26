#!perl
print "What is the name of the file you where want to replace spaces with dots? \nPlease include the extension. \n";
chomp(my $rem_name = <STDIN>);
my @array = do {
    open my $fh, "<", $rem_name or die "could not open $filename: $!";
    <$fh>;
};
open (my $outfile,">","add.p.outputfile.txt") or die $!;
foreach (@array)
{
$_ =~ s/\s+/./g;
$_ .= "\n";
print $outfile $_;
}
print @array;
close $fh;
close $outfile;
#
#
#Re: Replace all . with _ in a string
#http://www.perlmonks.org/?node_id=316690
