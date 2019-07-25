#!/usr/bin/perl
use Time::HiRes qw(time);

###################
#    My Formula   #
# a*d*e = f+e = g #
###################

$multiple_10 = 10; # Variable A
$multiple_100 = 100; # Variable B
$multiple_1000 = 1000; # Variable C
$core_256 = 1; # 1-256 - Variable D
$core_32768 = 1; # 1- 32,768 - Variable E
$ic_af = 0; # Variable F
$ic_ag = 0; # Variable G

###############
## Variables ##
###############
my $start_run = time;
my $max_count = 1; # Number of times to loop
my $max_counter = 2; # Loop Counter
my $core = 8388609; # Starting number
my $core_check = 'no';
my @list; # Array to store successful EQ
my $mem_limit = 1;
my $end_run;
my $run_time;
my $c_point = $core;

##########
## Main ##
##########

# Go though a set of 100
# Did any match? yes or no
# if yes, start next number in main set
# if no, continue to the next 100 of current set
# repeat till main set is complet

while($max_counter != $max_count){
# Call subroutine
$core_check = count_to_more();
print " \n core 256 is $core_256 and core 32768 is $core_32768 \n ";
# Checks if loop found valid answer
# If so, it updates and moves to test next number
if ($core_check eq 'yes'){
$core++;
$max_counter++;
$mem_limit++;
}
#output data to file every 100 verified keys
if ($mem_limit == 10000){
print_to_file(@list);
$mem_limit = 1;
@list = undef;
$end_run = time;
$run_time = $end_run - $start_run;
$c_point = $c_point + 10000;
push @c_times, " $c_point check point time $run_time \n";
}
}

# Outputs the information to file
print "\n starting print to file \n";
print_to_file(@list);
print "\n ending print to file \n";

# Print time taken to complet task
$end_run = time;
$run_time = $end_run - $start_run;
print "Job took $run_time seconds\n";

foreach (@c_times){
print $_;
}

###############################################
############## Sub Routines ###################
###############################################

#Open File then append contents of text area to the files
# Read <
# Write > ,                creates if not existing and truncates(deletes original content so file is like new)
# Write/Append >> ,        creates if not existing
# Read/Write +<
# Read/Write +> ,          creates if not existing and truncates(deletes original content so file is like new)
# Read/Write +> ,          creates if not existing
sub print_to_file {
open (my $outfile,">",'s-EQ2.txt') or die $!;
foreach (@_) { print $outfile "$_ \n" ;}
close $outfile;
}

#####################
#     My Formula    #
# a*d*e-e = f+e = g #
#####################

#$multiple_10 = 10; # Variable A
#$multiple_100 = 100; # Variable B
#$multiple_1000 = 1000; # Variable C
#$core_256 = 1; # 1-256 - Variable D
#$core_32768 = 1; # 1- 32,768 - Variable E
#$ic_af = 0; # Variable F
#$ic_ag = 0; # Variable G

sub count_to_more {
my $even_or_odd = 'no';
# My formula
$ic_ag = $core;
$ic_ag = $ic_ag - $core_32768;
$ic_ade = $multiple_10 * $core_256;
$ic_ade = $ic_ade * $core_32768;
$ic_af = $ic_ag / $ic_ade;
$ic_ag = $ic_af + $core_32768;
# Checks if answer is valid, if so, it add to valid list
if ($ic_ag == 1){
push @list, "$multiple_10 * $core_256 * $core_32768 = $ic_af + $core_32768 = $ic_ag";
$even_or_odd = 'yes';
$core_32768 = 1;
$core_256 = 1;
}
# Check is counter is at limit, if so resets
if ($core_32768 == 32768){
$core_32768 = 1;
$core_256++;
}
if ($core_256 == 256){
$core_32768 = 1;
$core_256 = 1;
$core++;
return($even_or_odd);
}
# Adds value to $core_32768
$core_32768++;
#returns a yes or no depending on if EQ is valid
return($even_or_odd);
}


