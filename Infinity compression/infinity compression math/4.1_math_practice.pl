#!/usr/bin/perl
use Time::HiRes qw(time);

#highest possible number 8,388,608
#####################
#     My Formula    #
# t = e(a*b*c) + d  #
#####################
##
my $core_512 = 512; # 1-512 - Variable D
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
my $max_count = 1000; # Number of times to loop
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

while($max_counter != $max_count){
#
$core_check = count_to_more();
#
if ($core_check eq 'yes'){
$core++;
$max_counter++;
$mem_limit++;
$core_32768 = 1
}
if($core_32768 == 32768){
$core++;
$max_counter++;
$mem_limit++;
$core_32768 = 1;
push @list, " $core Not Found! \n";
print_to_file(@list);
@list = undef;
}
#output data to file every 100 verified keys
if ($mem_limit == 100){
print_to_file(@list);
$mem_limit = 1;
@list = undef;
$end_run = time;
$run_time = $end_run - $start_run;
$c_point = $c_point + 100;
push @c_times, " $c_point check point time $run_time \n";
}
}

# Print time taken to complet task
$end_run = time;
$run_time = $end_run - $start_run;
print "Job took $run_time seconds\n";

########### Subs ############

sub print_to_file {
open (my $outfile,">>",'4.1-mp.txt') or die $!;
foreach (@_) { print $outfile "$_ \n" ;}
close $outfile;
}

############################

sub count_to_more {
$even_or_odd = 'no';
# My formula
$multiple_a = $core_32768; # Variable A
$multiple_b = $core_32768; # Variable B
$multiple_c = $core_32768; # Variable C
##
if($core > 33024){
$ic_abc = $multiple_a * $multiple_b * $core_32768;
#
my $temp_core = $core - $ic_abc;
my $temp_core2 = $temp_core;
my $temp_core3 = $temp_core;
print "$ic_abc = $multiple_a * $core_32768 \n";
print " $temp_core = $core - $ic_abc \n";
if($temp_core < 513){
if($temp_core > 0){
push @list, "$core = $multiple_a * $core_32768 + $temp_core3";
print_to_file(@list);
@list = undef;
$even_or_odd = 'yes'
}
}
}
$core_32768++;
return($even_or_odd);
}
