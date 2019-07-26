#!perl
print "What is the name of the file you want to remove a tailing white space from? \nPlease include the extension. \n";
chomp(my $rem_name = <STDIN>);
my @array = do {
    open my $fh, "<", $rem_name or die "could not open $filename: $!";
    <$fh>;
};
open (my $outfile,">","outputfile.txt") or die $!;
foreach (@array)
{
$_ =~ s/\s+$//;
$_ .= "\n";
print $outfile $_;
}
print @array;
close $fh;
close $outfile;
#
#
#
#Easiest way to open a text file and read it into an array with Perl
#http://stackoverflow.com/questions/761392/easiest-way-to-open-a-text-file-and-read-it-into-an-array-with-perl
#and
#Perl: function to trim string leading and trailing whitespace
#http://stackoverflow.com/questions/4597937/perl-function-to-trim-string-leading-and-trailing-whitespace

