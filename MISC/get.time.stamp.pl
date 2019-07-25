#!/usr/bin/perl

use POSIX "strftime";

my $test = strftime('%Y-%m-%d %H:%M:%S',localtime);

print "\nThe Time Is: $test\n";


# The Above will print
#
# The Time Is: 2016-05-16 16:28:48
