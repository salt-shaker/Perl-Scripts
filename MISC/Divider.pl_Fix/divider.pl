#!perl
use bignum;
system $^O eq 'MSWin32' ? 'cls' : 'clear';

# Picked up the above code from: http://stackoverflow.com/questions/4605593/how-do-i-clear-the-screen-in-a-terminal-using-perl
# The shortest OS-independent (and not needing additional modules installations)
# method that worked for me was found in the Perl Monks thread
#(that page also contains some other variations of clearing the screen):
$lpp = 'y';
while ( $lpp eq 'y' )    # To keep core element repeating till exit

# "== "is for numbers and "eq" is for strings
# seems like the is an equivalent string version to every float comparison operator
{
    print "your factoring number is ";
    $factrorinput1 = <STDIN>;

    print "$factorinput1\n";
    chop($factorinput1);

    print "your input is ";
    $userinput1 = <STDIN>;

    chop($userinput1);

    $originalinput = $userinput1;

    while ( $userinput1 > 255 ) {
        $userinput2 = $userinput1 / $factrorinput1;
        print "your input is $userinput2\n";
        $userinput1 = $userinput2;
    }

    print "now printing the reverse. \n";
    print "your input is $userinput2\n";

    while ( $originalinput != $userinput1 ) {
        $userinput2 = $userinput1 * $factrorinput1;
        if ( $originalinput != $userinput2 ) {
            print "your input is $userinput2\n";
        }
        $userinput1 = $userinput2;
    }
    
    print "your input is $userinput2\n";
    print "\n would you like to do this again? y or n ===>   ";
    $lpp = <STDIN>;
    chop($lpp);
}

#for 32 bit image - 32e2 * 8 = 4,294,967,296 possibilities = 274877906944 bits or 34359738368 bytes or 33554432 kilobytes or 32768 megabytes or 32 gigabytes
#100,000,000,000,000,000,000,000,000,000,000
#--
#100 - 100100110 - 1111000111 - 100101000
#or
#4294967296
#18446744073709551616
#--
#for 64 bit image - 32e2 * 8 = 18,446,744,073,709,551,616 possibilities = 7378697629483820608 bits or 922337203685477576 bytes or 900719925474099 kilobytes or 879609302220 megabytes or 858993459 gigabytes or 838860 terabytes or 819 exabytes
#
#your input is 18446744073709551616
#your input is 18446744073709551616
