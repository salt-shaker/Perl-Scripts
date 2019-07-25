#!/usr/bin/perl

use strict;
use warnings;

my @files = glob("*.txt *.pm");

foreach my $file (@files) {
print "$file\n";
}
exit 0;