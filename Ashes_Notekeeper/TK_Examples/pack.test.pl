#!/usr/bin/perl
use  Tk;

my $mw = MainWindow->new;
$mw -> title('new window');
$mw ->Label(-text => 'I think i like it')->pack;
$mw -> Button( -text => 'exit', -command => sub { exit })->pack;
$mw -> Button( -text => 'exit', -command => sub { exit })->pack(-side => top, -fill => 'x');
$mw -> Button( -text => 'exit', -command => sub { exit })->pack(-side => right);
$mw -> Button( -text => 'exit', -command => sub { exit })->pack(-side => left);
$mw -> Button( -text => 'exit', -command => sub { exit })->pack(-side => right);
$mw -> Button( -text => 'exit', -command => sub { exit })->pack(-side => left);
$mw -> Button( -text => 'exit', -command => sub { exit })->pack(-side => bottom);
$mw -> Button( -text => 'exit', -command => sub { exit })->pack(-side => right);
$mw -> Button( -text => 'exit', -command => sub { exit })->pack(-side => left);

MainLoop;