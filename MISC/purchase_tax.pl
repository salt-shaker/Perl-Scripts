#/usr/bin/perl

# This script was used to determine the final price or items or services that were taxable
 
use strict;
use warnings;
 
use vars qw/ $VERSION /;
$VERSION = '1.00';

#############
# Variables #
#############
my $tax_amount = 0;
my $temp_purchase_price = 0;
my $temp_markup = 0;
my $monterey_tax = 0.08625;
my $salinas_tax = 0.08;
my $total_check_counter = 0;
my $markup = 0.10;
my $local_check_1 = 0;
my $markup_amount = 0;
my $markup_price;
my $tax_price;
my $start_price;
my $total_start_price;
my $minimum_purchase_price = 19.99;
my $temp_minimum_purchase_price = $minimum_purchase_price;
my $total_purchase_price;

##############
# User Input #
##############
print "What is the purchase price for parts? eg. 21.54\n";
chomp(my $purchase_price = <>);
$start_price = $purchase_price;

####################
# Select Local Tax #
####################
my $tax_location;
my $monterey = 'm';
my $salinas = 's';
my $loop_okay = 0;
while ($loop_okay == 0) {
print "\nWhat is the location of the sale? \ns for salinas, m for monterey: ";
chomp($tax_location = <>);
&location_iden;
}
 
# Making a copy of purchase price to be used in conditional statements
$temp_purchase_price = $purchase_price;

# add tax amount
if ($temp_purchase_price < $minimum_purchase_price) {
$tax_amount = $purchase_price * 0.15;
$purchase_price = $purchase_price + $tax_amount;
}

print "\n$purchase_price\n";

# set purchase price to minimum
if ($temp_purchase_price < $temp_minimum_purchase_price) {
$purchase_price = $minimum_purchase_price;
$total_check_counter += 1;
}

print "\n$purchase_price\n";

#Processes totals greater than minimum purchase price
if ($total_check_counter == 0) {
&rs_markup;
&add_tax;
}

print "\n$purchase_price\n";

#Processes totals less than minimum purchase price
if ($total_check_counter == 1) {
&add_tax;
}
 
##########
# Output #
##########
$total_start_price = sprintf '%.2f', $start_price;
print "\nYour initial price was: \$$total_start_price \n";
 
if ($total_check_counter == 1) {
print "\nYour markup is: Product marked up to minimum order price of $minimum_purchase_price \n";
} else {
$markup_price = sprintf '%.2f', $markup_amount;
print "\nYour markup is: \$$markup_price \n";
}
 
$tax_price = sprintf '%.2f', $tax_amount ;
print "\nYour tax is: \$$tax_price \n";
 
$total_purchase_price = sprintf '%.2f', $purchase_price ;
print "\nYour total price is: \$$total_purchase_price \n";

################
# Sub Routines #
################

## Caculates tax to add from two locations
sub add_tax {
if ($tax_location eq $monterey) {
$tax_amount = $purchase_price * $monterey_tax;
$purchase_price += $tax_amount;
print "\n$purchase_price\n";
}
if ($tax_location eq $salinas) {
$tax_amount = $purchase_price * $salinas_tax;
$purchase_price += $tax_amount;
}
return()
}

## Determines tax to use from two locations
sub local_check {
if ($tax_location eq $monterey) {$local_check_1 = $monterey_tax;}  
if ($tax_location eq $salinas) {$local_check_1 = $salinas_tax;}
return()
}

## Add markup price to current total
sub rs_markup {
$markup_amount = $purchase_price * $markup;
$purchase_price = $purchase_price + $markup_amount;
print "\n$purchase_price\n";
return()
}

## Determines current location
sub location_iden {
my $if_count = 0;
if ($tax_location eq $monterey) {
$loop_okay = 1;
$if_count += 1;
}
if ($tax_location eq $salinas) {
$loop_okay = 1;
$if_count += 1;
}
if ($if_count == 0) {
print "\nThat is not valid input\n";
}
return()
}
