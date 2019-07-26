#!perl
use strict;
system $^O eq 'MSWin32' ? 'cls' : 'clear';
# Picked up the above code from: http://stackoverflow.com/questions/4605593/how-do-i-clear-the-screen-in-a-terminal-using-perl
# The shortest OS-independent (and not needing additional modules installations)
# method that worked for me was found in the Perl Monks thread
#(that page also contains some other variations of clearing the screen): 
my $lpp = 'y';
while ( $lpp eq 'y' ) # To keep core element repeating till exit
# "== "is for numbers and "eq" is for strings
# seems like the is an equivalent string version to every float comparison operator
{                                                                      
print "this is awesome \n";
my $pie = 'cherry';
my $mix = 'brownies';
my $leftover = 'pizza';
my @rocks = (' lava',' pine',' cone',' riot',' porse',' nitts');
print @rocks;
print @rocks[5];
print "\n please enter one word here ===> ";
my $userinput = <STDIN>; #creates the variable $userinput and asks for input from the keyboard
chop ($userinput); #removes the return from the end of the input, which is always added to <STDIN>
print $userinput;  #prints the result of that input
print "\n please enter another word here ===> ";
$userinput = <STDIN>;
chop ($userinput);
print "this is the second user input: $userinput";
#the following is a variable and a loop
print "\n would you like to do this again? y or n ===>   ";
$lpp = <STDIN>;
chop ($lpp);
}
print "now on to the next part.\n Do you want to start the sub routine? y or n? ==> ";
$lpp = <STDIN>;
chop ($lpp);
if ($lpp eq 'y')
{
print "You are now calling the sub \"big bang\"\n";
my $bbg = &big_bang; #ultimately the results of &big_bang and &big_bang2
print "Here are the results of \"Big Bang\" here: $bbg\n";
}
else
{
print 'you have not skipped the sub "big bang"';
}
my $drover1 = 10;
my $drover2 = 20;
&at_test($drover1, $drover2);
print "\n";
&mn_test($drover1, $drover2);
print $_;
print "\n";
print $_ + 15;
##################################################################
################# All Sub Routines posted Below.##################
##################################################################

sub big_bang
{
my $bb1_2;
$bb1_2 = &big_bang2 . "hello"; # use a . instead of + because its string concentration
$bb1_2;
}
sub big_bang2
{
'hello 2';
}
sub at_test #at_test is a test of the default array variable in all sub routines. 
            #Any data passed to the sub routine gets stored in the default array
{
print @_[0] . ' ' . @_[1];
}
sub mn_test #$_ is a global variable often times called that default variable.
            #It can be called an any part of the program. I believe it is the only variable that can start with an underscore
			#it is advised to not use the default variable for anything unless it can not be avoided
{
$_ = 25;
print $_ . "\n";
}