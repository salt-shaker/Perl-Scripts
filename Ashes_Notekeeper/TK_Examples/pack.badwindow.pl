#!/usr/bin/perl
use Tk;
 my $mw = MainWindow -> new;
 $mw->title('Bad Window');
 $mw->Label(-text => "This is an example of a windows that looks bad \nwhen  you dont send any options to pack")->pack;
 $mw->Checkbutton(-text => "I like it")->pack;
 $mw->Checkbutton(-text => 'I hate it')->pack;
 $mw->Checkbutton(-text => 'I dont care')->pack;
 $mw->Button(-text => "exit", -command => sub { exit })->pack;
 MainLoop;