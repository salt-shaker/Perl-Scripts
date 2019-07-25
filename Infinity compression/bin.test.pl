#/usr/bin/perl
$buffer = "";
$infile = "binary.dat";
$outfile = "binary_copy.dat";
open (INFILE, "<", $infile) or die "Not able to open the file. \n";
open (OUTFILE, ">", $outfile) or die "Not able to open the file for writing. \n";
binmode (INFILE);
binmode (OUTFILE);

#Read file in 64K blocks
while ( (read (INFILE, $buffer, 65536)) != 0 ) {
  print OUTFILE $buffer;
}  

close (INFILE) or die "Not able to close the file: $infile \n";
close (OUTFILE) or die "Not able to close the file: $outfile \n";

print "Successfully able to copy the binary file to : $outfile \n";

#Read more: http://linuxpoison.blogspot.com/2013/01/perl-script-reading-writing-binary-files.html#ixzz3huZxSqEr
