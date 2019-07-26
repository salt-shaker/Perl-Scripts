#!perl
print "What is the name of the file you want to remove dots from? \nPlease include the extension. \n";
chomp(my $rem_name = <STDIN>);
my @array = do {
    open my $fh, "<", $rem_name or die "could not open $filename: $!";
    <$fh>;
};
open (my $outfile,">","rm.dot.outputfile.txt") or die $!;
foreach (@array)
{
$_ =~ s/\.+$//;
print $outfile $_;
}
print @array;
close $fh;
close $outfile;
#
#
#
#Remove trailing commas at the end of the string using Perl
#http://stackoverflow.com/questions/10566539/remove-trailing-commas-at-the-end-of-the-string-using-perl

