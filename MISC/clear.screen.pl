#!perl

#############
# Variables #
#############
$main_lp = 'y';
$sub_lp;

#############
# Main Loop #
#############
while ($main_lp eq 'y'){

# Proper Kudo's
print
"\nI Picked up the clear screen code from: 
\nhttp://stackoverflow.com/questions/4605593/how-do-i-clear-the-screen-in-a-terminal-using-perl
\nIt is supposed to be the shortest OS-independent method to clear a screen
\nNo additional modules installations
\nJust giving credit to the appropriate people.";

# Clear screen loop
print "\n\nWould you like to clear the screen? y or n ===>   ";
$sub_lp = <STDIN>;
chop ($sub_lp);
if ($sub_lp eq 'y') { &cls; }


# Continue or Exit main loop
print "\n\nWould you like to do this again? y or n ===>   ";
$main_lp = <STDIN>;
chop ($main_lp);
}


###############
# Subroutines #
###############
sub cls {
system $^O eq 'MSWin32' ? 'cls' : 'clear';
}
