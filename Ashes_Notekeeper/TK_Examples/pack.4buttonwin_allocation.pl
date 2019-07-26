#!/usr/bin/perl
use Tk;
 my $mw = MainWindow -> new;
 $mw->title('4 Button Window');
 $mw->Button(-text => "Top", -command => sub { exit })->pack(-side => 'top', -fill => 'x');
 $mw->Button(-text => "Bottom", -command => sub { exit })->pack(-side=> 'bottom', -fill => 'x');
 $mw->Button(-text => "Right", -command => sub { exit })->pack(-side=> 'right', -fill => 'x', -expand => 1);
 $mw->Button(-text => "Left", -command => sub { exit })->pack(-side=> 'left', -fill => 'x', -expand => 1);
 MainLoop;