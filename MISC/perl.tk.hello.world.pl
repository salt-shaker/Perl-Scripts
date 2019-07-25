#!/usr/bin/perl

# I highly suggest reading the book
# http://docstore.mik.ua/orelly/perl3/tk/

# Most recent cpan link
# http://search.cpan.org/~ni-s/Tk-804.027/pod/UserGuide.pod

# Use TK Module. Must be installed before using
# Windows, Linux, or Mac - use cpan - install tk
use Tk;

# Creates a new window called MainWindow
my $mw = new MainWindow; 

# creates a new label object with a text attribute
my $label = $mw -> Label(-text=>"Hello World") -> pack();

# creates another new label object with a text attribute
my $label2 = $mw -> Label(-text=>"Hello World 2") -> pack();

# creates a new button object with a text attribute and a command attribute
my $button = $mw -> Button(-text =>"Quit", -command => sub {exit}) -> pack();

# Starts the main loop. This triggers the creation of the GUI.
MainLoop;
