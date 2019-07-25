#!/usr/bin/perl

use strict;
use warnings;

######################################################
## Open Directory, Find Matches, Remove and Replace ##
######################################################

#notes
#When placed in the same dir as the other files make sure not to include *.pl
#as to not replace any commands in the script

###############
## Variables ##
###############
my @files = glob("*.html *.htm *.php");
my @file_names = undef;
my @temp = undef;
my $file = undef;
my @lines = undef;
my $outfile = undef;

# Start loop to go through each file name
foreach (@files) {
# Open file
my $file = $_;
open ($outfile,"<",$file) or die "Could not open file '$file' $!";
@lines = <$outfile>;
close $outfile;

#Find matches and replace
foreach (@lines) { 
#$_ =~ s/print/super_print/g;
#$_ =~ s/http:\/\/www.weatherstripspecial.com/https:\/\/www.weatherstripspecial.com/g;
push @temp, $_;
}

#Save edited file
open ($outfile,">",$file) or die "Could not open file '$file' $!";
print $outfile @temp;
#print "\n File $file_handle edit now complete. \n";
@temp = undef;
close($outfile);
}

print "completed \n "; 

#################
## Other Notes ##
#################

# Apparently this can be used for inline file matching
# perl -pne 's/\s+/,/g' < contacts.txt > contacts.modified.txt

# Open File then append contents of text area to the files
# Read <
# Write > ,                creates if not existing and truncates(deletes original content so file is like new)
# Write/Append >> ,        creates if not existing
# Read/Write +<
# Read/Write +> ,          creates if not existing and truncates(deletes original content so file is like new)
# Read/Write +> ,      