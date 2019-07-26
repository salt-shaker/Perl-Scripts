#!perl
print "What is the name of the file you want to remove a word or phrase from? \nPlease include the extension. \n";
chomp(my $rem_name = <STDIN>);
print "Please enter a word or phrase you want to remove: \n";
chomp(my $replacestring = <STDIN>);
open(my $infile,"<","$rem_name") or die $!;
open (my $outfile,">","outputfile.txt") or die $!;
while (<$infile>)
{
    $_=~s/$replacestring//g;
    print $outfile $_;
}
close $infile;
close $outfile;