#/usr/bin/perl

# Script used to compare 2 scalar values

use warnings;

# Get user input
print "What would you like to compare.\nPlease enter first item: ";
chomp (my $first_var = <STDIN>);
print "\nPlease enter second item: ";
chomp (my $second_var = <STDIN>);

# test values if equal
if ($first_var eq $second_var) {
print "\nThey are equal";
} else {
print "\nThey are not equal";
}

#End
print "\n----done----";
