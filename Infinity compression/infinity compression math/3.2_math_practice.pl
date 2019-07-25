#!/usr/bin/perl

#####################
#     My Formula    #
# a*d*e-e = f+e = g #
#####################

$core = 8388610;

$multiple_10 = 10; # Variable A
$multiple_100 = 100; # Variable B
$multiple_1000 = 1000; # Variable C
$core_256 = 256; # 1-256 - Variable D
$core_32768 = 32768; # 1- 32,768 - Variable E
$ic_af = 0; # Variable F
$ic_ag = 0; # Variable G
my @lines;

# My formula


my $found1 = 'no';

while($found1 eq 'no'){
$c_check = $core%$core_32768;
if ($c_check = 0) {
push @line, "\n we found one core:$core_32768 \n";
}
if ($core_32768 == 1) {
print " \n Thats all folks. \n";
$found1 = 'yes';
}
$core_32768--;
print " \n $core_32768 \n ";
}

foreach (@lines) { print $_ ;}


#$ic_ag = $core;
#$ic_ag = $ic_ag - $core_32768;
#$ic_ade = $multiple_10 * $core_256;
#$ic_ade = $ic_ade * $core_32768;
#$ic_af = $ic_ag/$ic_ade;
#$ic_ag = $ic_af + $core_32768;
#$ic_af = $multiple_10 * $core_256 * $core_32768;
#$ic_ag = $ic_af + $core_32768;
#print "\n $multiple_10 * $core_256 * $core_32768 = $ic_af + $core_32768 = $ic_ag vs $core \n";

#871020
