#!/usr/bin/perl
use Time::HiRes qw(time);

my $start_run = time;
my $core = 5000;
my $temp1 = $core;
my $temp2 = $core;
my $temp3 = 0;
my $counter = $core;
my @list;

while($counter != 0){
$temp3 = $temp1*$temp2;
push @list, "$temp3 = $temp1*$temp2";
#print "$temp3 = $temp1*$temp2";
count_to_more($temp1,$temp2);
$temp1--;
$counter--;
}

#print "\n starting print to file \n";
#print_to_file(@list);
#print "\n ending print to file \n";
#$counter = $core;
#my @list = undef;
#$temp1++;

#while($counter != 0){
#$temp3 = $temp1*$temp2;
#push @list, $temp3;
#$temp2--;
#$counter--;
#}

print "\n starting print to file \n";
print_to_file(@list);
print "\n ending print to file \n";

my $end_run = time;
my $run_time = $end_run - $start_run;
print "Job took $run_time seconds\n";

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
open (my $outfile,">",'test.txt') or die $!;
foreach (@_) { print $outfile "$_ \n" ;}
close $outfile;
}


sub count_to_more {
my $c_temp1 = $_[0];
my $c_temp2 = $_[1];
$c_temp2--;
my $c_counter = $core;
while($c_counter != 0){
my $c_temp3 = $c_temp1*$c_temp2;
push @list, "$c_temp3 = $c_temp1*$c_temp2";
$c_temp2--;
$c_counter--;
}
return();
}
