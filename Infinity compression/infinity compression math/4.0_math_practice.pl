#!/usr/bin/perl
use Time::HiRes qw(time);

#highest possible number 8,388,608
#####################
#     My Formula    #
# t = e(a*b*c) + d  #
#####################
##
my $core_256 = 256; # 1-256 - Variable D
my $core_32768 = 1; # 1-32,768 - Variable E
##
my $multiple_a = 0; # Variable A
my $multiple_b = 0; # Variable B
my $multiple_c = 0; # Variable C
##
my $ic_abc = 0; # Temp value for A*B*C
my $ic_at = 0; # Variable T

###############
## Variables ##
###############
my $start_run = time;
my $max_count = 10; # Number of times to loop
my $max_counter = 1; # Loop Counter
my $core = 33025; # Starting number
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
#print " \n core 256 is $core_256 and core 32768 is $core_32768 \n ";
# Checks if loop found valid answer
# If so, it updates and moves to test next number
if ($core_check eq 'yes'){
$core++;
$max_counter++;
$mem_limit++;
$core_32768 = $core_32768 - 50;
}
#output data to file every 100 verified keys
if ($mem_limit == 2){
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
open (my $outfile,">>",'4.0-mp.txt') or die $!;
foreach (@_) { print $outfile "$_ \n" ;}
close $outfile;
}

#####################
#     My Formula    #
# t = e(a*b*c) + d  #
#####################
# my $core_256 = 256; # 1-256 - Variable D
# my $core_32768 = 32768; # 1- 32,768 - Variable E
##
# my $multiple_a = 0; # Variable A
# my $multiple_b = 0; # Variable B
# my $multiple_c = 0; # Variable C
##
# my $ic_abc = 0; # Temp value for A*B*C
# my $ic_at = 0; # Variable T

sub count_to_more {
$even_or_odd = 'no';
# My formula
$multiple_a = $core_32768; # Variable A
$multiple_b = $core_32768; # Variable B
$multiple_c = $core_32768; # Variable C
##
if($core > 33024){
$ic_abc = $multiple_a * $multiple_b * $multiple_c * $core_32768;
#if($ic_abc > $core){
#push @list, "Exceeded Limit: $ic_abc is greater than $core";
#print_to_file(@list);
#$core_32768 = $core_32768 - 50;
#$even_or_odd = 'yes';
#}
my $temp_core = $core - $ic_abc;
my $temp_core2 = $temp_core;
my $temp_core3 = $temp_core;
print "$ic_abc = $multiple_a * $core_32768 \n";
print " $temp_core = $core - $ic_abc \n";
if($temp_core < 257){
if($temp_core > 0){
push @list, "$core = $multiple_a * $core_32768 + $temp_core3";
print_to_file(@list);
$even_or_odd = 'yes'
}
}
}
##
if($core > 1073742089){
print "\n 2 \n";
$ic_abc = $multiple_a * $multiple_b * $core_32768;
if($ic_abc > $core){
push @list, "Exceeded Limit: $ic_abc is greater than $core";
print_to_file(@list);
$core_32768 = $core_32768 - 2;
$even_or_odd = 'yes';
}
my $temp_core = $core - $ic_abc;
my $temp_core2 = $temp_core;
if($temp_core < 257 && $temp_core > 0){
print "Found one: ";
my $input = <STDIN>; # make a stop
push @list, "$core = $multiple_a * $multiple_b * $core_32768 + $temp_core2";
print_to_file(@list);
$even_or_odd = 'yes';
}
}
##
if($core > 35184372089088){
print "\n 3 \n";
$ic_abc = $multiple_a * $multiple_b * $multiple_c * $core_32768;
if($ic_abc > $core){
push @list, "Exceeded Limit: $ic_abc is greater than $core";
print_to_file(@list);
$core_32768 = $core_32768 - 2;
$even_or_odd = 'yes';
}
my $temp_core = $core - $ic_abc;
my $temp_core2 = $temp_core;
if($temp_core < 257 && $temp_core > 0){
print "Found one: ";
my $input = <STDIN>; # make a stop
push @list, "$core = $multiple_a * $multiple_b * $multiple_c * $core_32768 + $temp_core2";
print_to_file(@list);
$even_or_odd = 'yes';
}
}
##
$core_32768++;
return($even_or_odd);
}
