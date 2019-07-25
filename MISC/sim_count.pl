#!/usr/bin/perl

my $big_var = 4294967295;
my $big_var_temp;
my $two_div;
my $counter = 0;

while($counter < 8){
$big_var = $big_var / 2;
$big_var_temp = sprintf("%.2f",$big_var);
print "\n My number is $big_var_temp\n";
$counter ++;
}