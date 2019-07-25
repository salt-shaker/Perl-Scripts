#!/usr/bin/perl

  my $pod = File;
  $pod->number(50,20,30,9,14);
  $pod->new;
  $pod->old;
  $pod->high;
  $pod->low;
  $pod->big;
  $pod->small;
  
  package File;
  sub number {
	  my $class = shift;
	  #our $number = shift;
	  foreach(@_){
	  our $number = $_;
	  print "hello number object\n";
	  print "run $number here\n";
	  }
	  }
  sub new {
      print "hello new object\n";
	  print "run $number here\n";
  }
  sub old {
	  print "hello old object\n";
	  print "run $number here\n";
  }
  sub high {
      print "hello high object\n";
	  print "run $number here\n";
  }
  sub low {
      print "hello low object\n";
	  print "run $number here\n";
  }
  sub big {
      print "hello big object\n";
	  print "run $number here\n";
  }
  sub small {
      print "hello small object\n";
	  print "run $number here\n";
  }
