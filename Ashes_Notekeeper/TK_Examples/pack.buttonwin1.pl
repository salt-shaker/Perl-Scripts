#!/usr/bin/perl
use Tk;
 my $mw = MainWindow -> new;
 $mw->title('Button Window');
 $mw->Button(-text => "done", -command => sub { exit })->pack;
 $mw->Button(-text => "done", -command => sub { exit })->pack;
 $mw->Button(-text => "done", -command => sub { exit })->pack;
 $mw->Button(-text => "done", -command => sub { exit })->pack;
 MainLoop;