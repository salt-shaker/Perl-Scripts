#/usr/bin/perl

my $file = "binary_copy.dat";

     open(F,"<","$file") || die "Error: unable to open $file - $!\n";

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



sub totext() {
 my @in;
 my $out;
 my $x;
 @in = @_;
 for($x=0;$x<=$#in;$x++) {
     $out = pack("B*", $in[$x]);
  print($out);
