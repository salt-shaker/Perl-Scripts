#!/usr/bin/perl

# Modules to use
use Tk; 
use warnings;
use Tk::Dialog;

# Starting new windows
my $MW = MainWindow->new; 

# Variables
my $fun_number = 26; #change this number to change the pattern
my $tb_size = 26;
my @text = (1..$tb_size);
my ($c_height, $c_width) = (1, 1);
my ($i,$c, $r, $d, $rtc, $w, $w2, $w3, $w4, $b, $b2, $b3, $b4,) = (0, 0, $tb_size, $tb_size, 1, undef, undef, undef, undef, undef, undef, undef, undef); 

# Creating grid
while ($rtc != $fun_number) {
foreach my $temp(@text) { 
if (0 == $i % 2){
	$w = $MW->Label(-height => $c_height, -width => $c_width, -background => 'white'); 
        $w->grid(-row => $i, -column => $c, -sticky => 'w'); 
	$w2 = $MW->Label(-height => $c_height, -width => $c_width, -background => 'white'); 
	$w2->grid(-row => $c, -column => $i, -sticky => 'n'); 
	$w3 = $MW->Label(-height => $c_height, -width => $c_width, -background => 'white'); 
        $w3->grid(-row => $d, -column => $r, -sticky => 'w'); 
	$w4 = $MW->Label(-height => $c_height, -width => $c_width, -background => 'white'); 
	$w4->grid(-row => $r, -column => $d, -sticky => 'n'); 
        $i++; 
	$d--;
 } else {
	$b = $MW->Label(-height => $c_height, -width => $c_width, -background => 'black'); 
        $b->grid(-row => $i, -column => $c, -sticky => 'w'); 
	$b2 = $MW->Label(-height => $c_height, -width => $c_width, -background => 'black'); 
	$b2->grid(-row => $c, -column => $i, -sticky => 'n');
	$b3 = $MW->Label(-height => $c_height, -width => $c_width, -background => 'black'); 
        $b3->grid(-row => $d, -column => $r, -sticky => 'w'); 
	$b4 = $MW->Label(-height => $c_height, -width => $c_width, -background => 'black'); 
	$b4->grid(-row => $r, -column => $d, -sticky => 'n');  
        $i++;
	$d--; 
	}
}
shift @text;
$c ++;
$i = $c;
$r --;
$d = $r;
$rtc ++;
}

# lets user know its has finished
my $popup = $MW->Dialog(-title => 'Done', 
   -text => 'All Done', 
   -default_button => 'ok', -buttons => [ 'ok'],)->Show( );

 MainLoop;
