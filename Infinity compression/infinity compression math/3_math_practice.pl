#!/usr/bin/perl
use Time::HiRes qw(time);

###############
## Variables ##
###############
my $start_run = time;
my $max_count = 50000;
my $max_counter = 1;
my $core = 256;
my $div_num = 2;
my $core_check = 'no';
my @list;
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
$core_check = count_to_more();
if ($core_check eq 'yes'){
$core++;
$max_counter++;
$div_num = 2;
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
open (my $outfile,">>",'256_50000.txt') or die $!;
foreach (@_) { print $outfile "$_ \n" ;}
close $outfile;
}


sub count_to_more {
my $even_or_odd = 'no';
my $c_check = $core % $div_num;
if ($c_check == 0){
my $mul_core = $core / $div_num;
push @list, "$core = $mul_core * $div_num";
$even_or_odd = 'yes';
$div_num = 2;
}else{
$div_num++;
}
return($even_or_odd);
}
