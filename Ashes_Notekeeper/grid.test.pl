#!/usr/bin/perl -w 
#
# Create two columns of data: left-adjusted text
# labels and right-adjusted numbers. Each row
# consists of two labels managed by the gridder,
# which are "stuck" to opposite sides of their
# respective column. The gridder fills unused space
# in the east-west direction so that all rows are
# the same length -- that of the widest row.

#use English;
use Tk;
use strict;

my $MW   = MainWindow->new;
my @text = (
    'This is a long label',
    'Then a short',
    'Frogs lacking lipophores are blue'
);

my ( $i, $w ) = ( 0, undef );
foreach my $temp (@text) {
    $w = $MW->Label( -text => $temp );
    $w->grid( -row => $i, -column => 0, -sticky => 'w' );
    $w = $MW->Label( -text => $i . '0' x $i );
    $w->grid( -row => $i, -column => 1, -sticky => 'w' );
    $i++;
}

my $b = $MW->Label( -text => 'hello' );
$b->grid( -row => 3, -column => 0, -columnspan => 2, -sticky => 'nsew' );

my $c = $MW->Label( -text => 'hello' );
$c->grid( -row => 4, -column => 0, -columnspan => 2, -sticky => 'nsew' );

my $d = $MW->Label( -text => 'hello' );
$d->grid( -row => 0, -column => 2, -columnspan => 2, -sticky => 'news' );

my $e = $MW->Label( -text => 'hello' );
$e->grid( -row => 1, -column => 2, -sticky => 'w' );

my $f = $MW->Label( -text => 'hello' );
$f->grid( -row => 1, -column => 3, -sticky => 'w' );

MainLoop;
