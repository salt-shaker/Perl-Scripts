#!/usr/bin/perl


#highest possible number 8,388,608
my $core = 8388610;
my $core_256 = 1;
my $core_add;
my @lines;
my $test = 'no';
my $core_32768 = 1;
my $mem_limit = 1;
my $mem_ct = 0;

while($test eq 'no'){
my $core_add = $core_256 * $core_32768;
push @lines, "$core_add = $core_256 * $core_32768\n";
if ($core_256 == 256){
$test = 'yes';
}
if ($core_32768 == 32768){
$core_32768 = 1;
$core_256++;
}
$mem_limit++;
#output data to file every 100 verified keys
if ($mem_limit == 10000){
print_to_file(@lines);
$mem_limit = 1;
@list = undef;
$mem_ct += 10000;
print "\n Thats $mem_ct. \n";
}
$core_32768++;
}

print_to_file(@lines);

sub print_to_file {
open (my $outfile,">>",'stest2.txt') or die $!;
foreach (@_) { print $outfile "$_" ;}
close $outfile;
}
