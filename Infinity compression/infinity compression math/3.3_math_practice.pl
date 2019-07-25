#!/usr/bin/perl

my $core = 8388610;
my $core_256 = 2;
my $core_div;
my @line;
my $test = 'no';

while($test eq 'no'){
$core_div = $core/$core_256;
push @lines, "\n $core_div = $core / $core_256";
$core_256++;
print "\n $core_256 \n";
if ($core_256 == 32768){
$test = 'yes';
}
}

print_to_file(@lines);

sub print_to_file {
open (my $outfile,">",'stest2.txt') or die $!;
foreach (@_) { print $outfile "$_ \n" ;}
close $outfile;
}
