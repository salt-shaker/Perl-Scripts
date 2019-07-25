#!perl

# Using regular expression to filter a text file
# Subroutines can be added as necessary

# Output File Name
my $file_save = "outputfile.txt";

# Allow user to enter the name of a txt file
print "What is the name of the file you want to remove a white space from? \nPlease include the extension. \n";
chomp(my $rem_name = <STDIN>);

# Allow user to select a word or phrase to remove
print "Please enter a word or phrase you want to remove: \n";
chomp(my $replacestring = <STDIN>);

# Opens users txt document and reads into an array
open my $fh, "<", $rem_name or die "could not open $filename: $!";
my @array = <$fh>;
close $fh;

# Opens output file name
open (my $outfile,">",$file_save) or die "could not open $filename: $!";

# Primary loop to remove/repalce values
foreach (@array)
{
&rm_string($_);
&rm_whitespace($_);
#&rp_space($_);
$_ .= "\n";
print $outfile $_;
}

close $outfile;

###############
# Subroutines #
###############

sub rm_whitespace{
$_ =~ s/\s+$//; # Removes white space at the beginning of a string
$_ =~ s/^\s+//; # Removes white space at the end of a string
return($_);
}

sub rm_string{
$_=~s/$replacestring//gi; # Replaces the $replacestring with nothing, effectivly removing it
return($_);
}

#sub rp_space{
#$_ =~ s/\s+/\./;
#return($_)
#}
