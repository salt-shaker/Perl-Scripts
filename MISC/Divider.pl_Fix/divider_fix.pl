#!perl

# I have no idea what I was originally tyring to do but the code was just bad, so I fixed it.
# Could set it to Auto-Factor with a series of If-statements and prime numbers but, who's got time for that.
# Seriously, just a proof of concept.

use bignum;
system $^O eq 'MSWin32' ? 'cls' : 'clear';

while (true)    # To keep core element repeating till exit
{
    print "Please enter a number you would like to factor ";
    $int1 = <STDIN>;
    chop($int1);

    print "Please enter the factor ";
    $int2 = <STDIN>;
    chop($int2);

    $factor = $int1;
    $cur_base = $factor;

    print "Factoring... current value is $factor\n";
    while ( $factor > $int2 ) {
        $factor = $factor / $int2;
        print "Factoring... $cur_base / $int2 is $factor\n";
         if ($factor % $int2 > 0){
            last;
        }
        $cur_base = $factor;
    }

    print "now printing the reverse. \n";
    print "Factoring... current value is $factor\n";
    while ( $factor < $int1 ) {
        $factor = $factor * $int2;
        print "Factoring... $cur_base * $int2 is $factor\n";
        $cur_base = $factor;
    }

    print "\n would you like to do this again? y or n ===>   ";
    $lpp = <STDIN>;
    chop($lpp);

    if ( $lpp eq 'n' ) {
        last;
    }
}
