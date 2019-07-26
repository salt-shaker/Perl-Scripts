use Tk;

my $winMain = MainWindow->new();
my $default = 'John Doe';
my $name    = $default;
$winMain->Label(
   -text => 'Name'
)->pack( -side => 'left' );

my $entName = $winMain->Entry(
   -width => 40,
   -textvariable => \$name
);
$entName->pack( -side => 'left' );
$winMain->Button(
   -text    => 'Show',
   -command => sub{ print 'Name: ', $entName->get(), "\n"; }
)->pack( -side => 'left' );
$winMain->Button(
   -text    => 'Default',
   -command => sub{ $entName->delete( 0, 'end');
                    $entName->insert( 'end', $default ); }
)->pack( -side => 'left' );

MainLoop();