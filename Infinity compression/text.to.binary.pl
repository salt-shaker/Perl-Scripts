#!/usr/bin/perl

use warnings;
use strict;

#Description
#This is a perl script to convert input text or a file from ASCII text to binary or from binary to ASCII text.

my @in;
my $file;

sub tobinary() {
 my @in;
 my $out;
 my $x;
 @in = @_;
 for($x=0;$x<=$#in;$x++) {
     $out .= unpack("B*", $in[$x]);
 }
 #print("$out");
 print("\n");
#my $outfile;
open(my $outfile,">", "binary.test.out.txt");
print $outfile $out;
close $outfile;
}

sub totext() {
 my @in;
 my $out;
 my $x;
 @in = @_;
 for($x=0;$x<=$#in;$x++) {
     $out = pack("B*", $in[$x]);
#  print($out);
open(my $outfile,">", "binary.test.out.png");
print $outfile $out;
close $outfile;
 }
 print("\n");
}

sub help() {
 print("\nUsage: $0 [-b | -t] [-f filename | \"Test to convert\"]\n\n");
 print(" -b        : text to binary conversion\n");
 print(" -t        : binary to text conversion\n");
 print(" filename  : file to be converted\n");
 print(" message   : text to be converted\n");
}

if (@ARGV < 2) { 
 &help();
 exit(1);
}

if ($ARGV[0] eq '-b') {
  if ($ARGV[1] eq '-f') {
     $file = $::ARGV[2];
     open(F, "<$file") || die "Error: unable to open $file - $!\n";

     @in = <F>;
     close(F);
     if (!@in) {
        print("Error: no data in $file\n");
        exit(1);
     }
  } else {
     @in = $::ARGV[1];
  }
  &tobinary(@in);
}
elsif ($ARGV[0] eq '-t') {
  if ($ARGV[1] eq '-f') {
     $file = $::ARGV[2];
     open(F, "<$file") || die "Error: unable to open $file - $!\n";

     @in = <F>;
     close(F);
     if (!@in) {
        print("Error: no data in $file\n");
        exit(1);
     }
  } else {
     @in = $::ARGV[1];
  }
  &totext(@in);
}
else {
 &help();
 exit(1);
}

#Example to convert from text to binary from command line:
# conv.pl -b "Convert this"

#Example to convert from binary to text from command line:
# conv.pl -t "010000110110111101101110011101100110010101110010011101000010000001110100011010000110100101110011"

#Example to convert a text file to binary:
# conv.pl -b -f infile

#Example to convert a binary file to text:
# conv.pl -t -f binfile
