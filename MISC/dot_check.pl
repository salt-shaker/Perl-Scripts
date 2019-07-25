#!/usr/bin/perl

# NOTES:
# This progrom is for removing unwanted charaters from txt files
# I mainly used it for converting a text copy of email address to a CSV for import into a web email client.

###############################################
############## Sub Routines ###################
###############################################

#Open File then append contents of text area to the files
# Read <
# Write > ,                creates if not existing and truncates(deletes original content so file is like new)
# Write/Append >> ,        creates if not existing
# Read/Write +<
# Read/Write +> ,          creates if not existing and truncates(deletes original content so file is like new)
# Read/Write +> ,          creates if not existing

my $file = "contacts.txt";
open (my $outfile,"<",$file) or die "Could not open file '$file' $!";
my @lines = <$outfile>;
close $outfile;

my @temp;

foreach (@lines) { 
#$_ =~ s/ //g;
#$_ =~ s/"/:/g;
#$_ =~ s/</:/g;
#$_ =~ s/>/:/g;
#$_ =~ s/::/:/g;
#$_ =~ s/:/","/g;
#$_ =~ s/com","/com"/gi;
#$_ =~ s/net","/net"/gi;
#$_ =~ s/org","/org"/gi;
#$_ =~ s/edu","/edu"/gi;
push @temp, $_;
}

#perl -pne 's/\s+/,/g' < contacts.txt > contacts.modified.txt

open ($outfile,">",$file) or die "Could not open file '$file' $!";
print $outfile @temp;
close($outfile);