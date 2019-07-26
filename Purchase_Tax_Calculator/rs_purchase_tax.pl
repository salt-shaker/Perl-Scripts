#/usr/bin/perl

######### My Variables #########
my $tax_amount          = 0;
my $temp_purchase_price = 0;
my $temp_markup         = 0;
my $monterey_tax        = 0.075;
my $salinas_tax         = 0.08;
my $total_check_counter = 0;
my $markup              = 0.15;
my $local_check_1       = 0;
my $markup_amount       = 0;
my $markup_price;
my $tax_price;
my $start_price;
my $total_start_price;

######### User Input #########
print "What is the purchase price for parts? ";
chomp( my $purchase_price = <STDIN> );
$start_price = $purchase_price;

######### Select Local Tax #########
my $tax_location;
my $monterey  = 'm';
my $salinas   = 's';
my $loop_okay = 0;
while ( $loop_okay == 0 ) {
    print
      "\nWhat is the location of the sale? \ns for salinas, m for monterey: ";
    chomp( $tax_location = <STDIN> );
    &location_iden;
}

######### checking whether or not the total value of the purchase is less or more than $19.99 #########

#important, cant use value in conditional inside loop
$temp_purchase_price = $purchase_price;

if ( $purchase_price < 19.99 ) {
######### add markup amount #########
    $temp_markup         = $temp_purchase_price * $markup;
    $temp_purchase_price = $purchase_price + $temp_markup;
}

if ( $temp_purchase_price < 19.99 ) {
######### add tax amount #########
    $tax_amount          = $temp_purchase_price * 0.15;
    $temp_purchase_price = $temp_purchase_price + $tax_amount;
}
if ( $temp_purchase_price < 19.99 ) {
######### set purchase price to minimum #########
    $purchase_price = 19.99;
    $total_check_counter += 1;
}

if ( $total_check_counter == 0 ) {
    &rs_markup;
    &add_tax;
}

if ( $total_check_counter == 1 ) {
    &add_tax;
}

#start price
#markup
#tax
#final price

$total_start_price = sprintf( "%.2f", $start_price );
print "\nYour initial price was: \$$total_start_price \n";

if ( $total_check_counter == 1 ) {
    print
"\nYour markup is: Product marked up to minimum order price of \$19.99 \n";
}
else {
    $markup_price = sprintf( "%.2f", $markup_amount );
    print "\nYour markup is: \$$markup_price \n";
}

$tax_price = sprintf( "%.2f", $tax_amount );
print "\nYour tax is: \$$tax_price \n";

$total_purchase_price = sprintf( "%.2f", $purchase_price );
print "\nYour total price is: \$$total_purchase_price \n";

sub add_tax {
    if ( $tax_location eq $monterey ) {
        $tax_amount = $purchase_price * $monterey_tax;
        $purchase_price += $tax_amount;
    }
    if ( $tax_location eq $salinas ) {
        $tax_amount = $purchase_price * $salinas_tax;
        $purchase_price += $tax_amount;
    }
}

sub local_check {
    if ( $tax_location eq $monterey ) {
        $local_check_1 = $monterey_tax;
    }
    if ( $tax_location eq $salinas ) {
        $local_check_1 = $salinas_tax;
    }
}

sub rs_markup {
    $markup_amount  = $purchase_price * $markup;
    $purchase_price = $purchase_price + $markup_amount;
}

sub location_iden {
    my $if_count = 0;
    if ( $tax_location eq $monterey ) {
        $loop_okay = 1;
        $if_count += 1;
    }
    if ( $tax_location eq $salinas ) {
        $loop_okay = 1;
        $if_count += 1;
    }
    if ( $if_count == 0 ) {
        print "\nThat is not valid input\n";
    }
}
