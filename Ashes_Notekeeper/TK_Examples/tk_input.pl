#!/usr/bin/perl
use Tk;

## finally figured it out
 my $click_count;
 my $p_to_file;
 my $mw = MainWindow -> new;
 $mw->title('4 Button Window');
 $mw->Button(-text => "Top", -command => sub { $click_count +=1 })->pack(-side => 'top',-expand => 1);
 my $textarea = $mw -> Entry(-width=>40) ->pack(-fill => 'y');
 my $t = $mw-> Text(-width=>80, -height=>20)->pack();
 $mw->Button(-text => "exit", -command => sub { exit })->pack(-side => 'bottom');
 $mw->Button(-text => 'Show Click Count', -command => sub{ $textarea->insert( 'end' , $click_count);})->pack( -side => 'bottom' );
 $mw->Button(-text => 'Show Click Count 2', -command => sub{ $t->insert( 'end' , "\n" . $click_count);})->pack( -side => 'bottom' );
 $mw->Button(-text => "Bottom", -command => sub { $click_count +=1 })->pack(-side=> 'bottom');
 $mw->Button(-text => "Right", -command => sub { $click_count +=1 })->pack(-side=> 'right');
 $mw->Button(-text => "Left", -command => sub { $click_count +=1 })->pack(-side=> 'left');
 $mw->Button( -text => 'Show', -command => sub{ print $t->get('1.0','end'), "\n"; })->pack( -side => 'bottom' );
  $mw->Button( -text => 'Show2', -command => sub{ print $textarea->get(), "\n"; })->pack( -side => 'bottom' );
 $mw->Button( -text => 'print to file', -command => sub{ $p_to_file = $t->get('1.0','end'), "\n"; print $p_to_file;})->pack( -side => 'bottom' );
 
 MainLoop;

 #sub push_button {
  
#  my $name = $ent -> get();
 #   $txt -> insert('end',"\n Then click count is $click_count !!! \n");
#}

#-command => sub{ $entName->delete( 0, 'end'); $entName->insert( 'end', $default ); }

#my $textarea = $mw -> Frame() ->pack();

# http://stackoverflow.com/questions/3595369/how-can-i-get-the-text-in-the-perl-tk-text-widget
