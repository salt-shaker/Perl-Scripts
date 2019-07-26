#!/usr/bin/perl
use Tk;
 my $mw = MainWindow -> new;
 $mw->title('4 Button Window');
 $mw->Button(-text => "Top", -command => sub { exit })->pack(-side => 'top',-expand => 1);
 $mw->Button(-text => "Bottom", -command => sub { exit })->pack(-side=> 'bottom',-expand => 1);
 $mw->Button(-text => "Right", -command => sub { exit })->pack(-side=> 'right', -expand => 1);
 $mw->Button(-text => "Left", -command => sub { exit })->pack(-side=> 'left', -expand => 1);
 MainLoop;