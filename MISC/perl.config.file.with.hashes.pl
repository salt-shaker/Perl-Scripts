#!/usr/bin/perl

# This script is used for a simple csv config file

#######################
##### Variables #######
#######################
my $txt_var2;
my @text_var3;
my $ct_select_var;
my $cur_wk_file;
my @cur_config;
my $cur_time;
my $cur_date;
my $klp = 1;
my $vlp = 1;

#####################
#### Get Config #####
#####################

#Set default config file name, check 
my $defcon = 'cnf.srs';
&get_conf;
my %config_hash = &csv_open;

######################
#### Testing Area ####
######################

# Puts key value pairs into sepearate arrays so they can be viewed
# key->values pairs match but the pairs are out of order
my @k = keys   %config_hash;  #  e.g. ('b', 'c', 'a')
my @v = values %config_hash;  #  e.g. ( 2,   3,   1 )

# Output Keys
foreach (@k){
if($klp == 1){print "\nKeys:\n--\n";}
print "$klp)$_ \n";
$klp++;
};

# Output Values
foreach (@v){
if($vlp == 1){print "\nValues:\n--\n";}
print "$vlp)$_ \n";
$vlp++;
};

# If changes had been made to %config_hash
&update_config;

######################
#### Sub Routines ####
######################

# Opens the Config file
sub csv_open {
my $file = $defcon;
my @data;
open(my $fh, '<', $file) or die "Can't read file '$file' [$!]\n";
my $line = <$fh>;
my %temp_hash = split(/,/, $line);
return(%temp_hash)
}

# Creates a default config if one is not present
sub create_default_config {
open (my $outfile,'>',$defcon) or die $!;
print $outfile 'widgit_1_lable,,widgit_2_lable,,widgit_3_lable,,widgit_4_lable,,widgit_5_lable,,widgit_6_lable,,widgit_7_lable,,line_divide,"--\n",long_dash,"----------------------\n",short_dash,"--",';
close $outfile;
}

# Copies the config file into memorey
sub get_conf{
my @files = glob '*.*';
my $counter = 0;

foreach (@files) {
if ($_ eq $defcon) { $counter += 1;}
}

if ($counter == 0) {&create_default_config;}
return;
}

#updates the config file with the current
sub update_config {
my $counter = 0;
my @config_hash_keys = keys %config_hash;  # Copies hash keys into an array
my @config_hash_values = values %config_hash;  # Copies hash values into an array
my @hash_counter = @config_hash_keys;
my $temp;
$counter = 0;

foreach (@hash_counter){
$temp .= "$config_hash_keys[$counter]";
$temp .= ",$config_hash_values[$counter],";
$counter ++;
}

open (my $outfile,">",$defcon) or die $!;
print $outfile $temp;
close $outfile;
}
