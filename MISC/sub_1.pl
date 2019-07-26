#/usr/bin/perl

use warnings;
use strict;

#line break gloable variable
my $line_break = "\n----------------------done----------------------\n";

#global variable for &gober subroutine
our ($global1, $global2); #Explicitly define $global1 and $global2 to be variables in the current package. will cause error with strict pragma if not used
$global1 = 5;
$global2 = 10;

#Declared subroutines
sub indo {
print "\n";
foreach (@_) {
print "$_\n";
}
print $line_break;
}

#use global values in subroutines
sub gober {
local($global1, $global2) = (20, 40);
print "\n$global1\n$global2\n";
print $line_break;
}

#read the contents of all values passed to subroutine **not necessary in perl 5.6 and newer**
sub shifter {
foreach (@_) {
print $_;
}
}

#Limit Test
sub limit_test {
print "\n$_[0];\n";
print "$_[1]\n";
print "$_[2]\n";
print "$_[3]\n";
print "$_[4]\n";
print "$_[5]\n";
print "$_[6]\n";
print "$_[7]\n";
print "$_[8]\n";
print "$_[9]\n";
}

#return test
sub ret_test {
if ($_[0] == 1) {
print "they are equal\n";
} else {
return $_[0];
}
}

#subroutine passing values
my $val1 = 25;
my $val2 = 50;
my $val3 = &indo ($val1,$val2);
print "\n$val1, \n$val2, \n$val3.$line_break";
my $val4 = 100;
my $val5 = 200;
my $val6 = &indo ($val1,$val2,$val3,$val4,$val5);
my @arr1 = ("rock","my","socks","off","!!!");
&indo (@arr1,@arr1);

#subroutine using local to make global values usable without having to first save the value to another variable
$global1 = 5;
$global2 = 10;
print "\n$global1\n$global2$line_break";
&gober;
print "\n$global1\n$global1$line_break";

#Variable-length Parameter Lists
&shifter (1,2,3,4,5,6,7,8,9,10);
print "\n";
&shifter (@arr1,"\n",@arr1,"\n",@arr1,"\n",@arr1,);

#Limit Test
&limit_test (1,2,3,4,5,6,7,8,9,10);

#return test
my $ret_value = &ret_test (5);
if ($ret_value != 1) {
print "the return value was not 1, but was $ret_value\n";
}



