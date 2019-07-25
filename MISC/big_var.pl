#!/usr/bin/perl

my $big_var = 4294967295;
my $two_div;
my $counter = 1;

print "\n My big number is $big_var.\n";

while($big_var > 20) {
$counter++;
$big_var = $big_var*0.8125;
$big_var = sprintf("%.2f",$big_var);
print "\n My big number now is $big_var.\n";
$two_div = $big_var/2;
$two_div = sprintf("%.2f",$two_div);
print "and the divide is $two_div \n";
}

print "\nAnd the total loops is $counter. \n";

