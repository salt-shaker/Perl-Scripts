#!/usr/bin/perl
use Tk;
my $mw = new MainWindow; 
my $label = $mw -> Label(-text=>"Hello World") -> pack();
my $label = $mw -> Label(-text=>"yo mamma") -> pack();
my $button = $mw -> Button(-text => "Quit", 
        -command => sub { exit })
    -> pack();
MainLoop;

#A.2. Installing Perl/Tk for Win32
# http://mkweb.bcgsc.ca/intranet/perlbook/tk/appa_02.htm
#
#A guide to installing modules for Win32
# http://www.perlmonks.org/?node=A%20guide%20to%20installing%20modules%20for%20Win32
#
#A Guide to Installing Modules
# http://www.perlmonks.org/?node_id=128077
#
# Learning Perl/Tk
# http://www.perlmonks.org/?node_id=922840
#
#Introduction to GUI Programming with Gtk2-Perl
# http://gtk2-perl.sourceforge.net/doc/intro/