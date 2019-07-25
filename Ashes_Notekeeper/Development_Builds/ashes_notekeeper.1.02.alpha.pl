#!/usr/bin/perl
use Tk;
use warnings;
use strict;
require Tk::Dialog;

#######################
##### Variables #######
#######################
my $widgit_1_lable    = "CONTACT TYPE\:";
my $widgit_1_label_p2 = "\n\"Click once on the Contact type\"";
my $widgit_2_lable    = "ACCOUNT\: ";
my $widgit_3_lable    = "CALL\: ";
my $widgit_4_lable    = "EMAIL\: ";
my $widgit_5_lable    = "NAME\: ";
my $widgit_6_lable    = "ISSUE\: ";
my $widgit_7_lable    = "NOTES\: ";
my $line_divide       = "--\n";
my $long_dash         = "----------------------\n";
my $short_dash        = "--";
my $txt_var2;
my @text_var3;
my $ct_select_var;
my $cur_wk_file;

#my $defcon = "cnf.srs";
my $junk   = "EMAIL PHONE VOICEMAIL STORE TECHBENCH";
my @ct_var = split( / /, $junk );
my @cur_config;
my $cur_time;
my $cur_date;

###################################################

my $mw = MainWindow->new;

#$mw->title("Ashes Note Keeper - Version 1.0 - $cur_wk_file");
#$label_fill_1->configure (-text => $cur_wk_file,-justify => 'right');

my $tb_size = 57;
my @text    = ( 1 .. $tb_size );
my ( $c_height, $c_width ) = ( 1, 1 );
my ( $i, $c, $rtc, $w, $w2 ) = ( 0, 0, 1, undef, undef );

####################################################

foreach my $temp (@text) {
    if ( 0 == $i % 2 ) {
        if ( $i < 26 ) {
            $w = $mw->Label( -height => $c_height, -width => $c_width, )
              ;    # -background => 'white');
            $w->grid( -row => $i, -column => $c, -sticky => 'w' );
        }
        $w2 = $mw->Label( -height => $c_height, -width => $c_width, )
          ;        # -background => 'white');
        $w2->grid( -row => $c, -column => $i, -sticky => 'n' );
        $i++;
    }
    else {
        if ( $i < 26 ) {
            $w = $mw->Label( -height => $c_height, -width => $c_width, )
              ;    # -background => 'black');
            $w->grid( -row => $i, -column => $c, -sticky => 'w' );
        }
        $w2 = $mw->Label( -height => $c_height, -width => $c_width, )
          ;        # -background => 'black');
        $w2->grid( -row => $c, -column => $i, -sticky => 'n' );
        $i++;
    }
}

#Gets the current config file(default cnf.srs) and copies it into @cur_config then updates necessary config variables
#&get_conf;
#######################################
#Set default config file name, check
my $defcon = 'cnf.srs';
&get_conf;
my %config_hash = &csv_open;

#Window Width and File title bar
#my $label_fill_1 = $mw -> Label(-width => '75') ->grid(-row => 0, -column => 10, -columnspan => 55, -sticky => 'w');
#$label_fill_1->configure (-text => $cur_wk_file,-justify => 'right');

################################################
######### Customer Care Edit Area #############
################################################

my $customer_log_lable =
  $mw->Label( -text => "Customer Log", -height => 2 )->grid(
    -row        => 1,
    -column     => 35,
    -columnspan => 10,
    -rowspan    => 2,
    -sticky     => 'nsew'
  );

#Large text area on right side of window, current file view/edit area
my $text_area1 =
  $mw->Scrolled( "Text", -width => 45, -height => 10, -wrap => 'none' )->grid(
    -row        => 2,
    -column     => 27,
    -rowspan    => 10,
    -columnspan => 30,
    -sticky     => 'w'
  );

#Send contents of entry boxes to a file
$mw->Button( -text => 'Select Log File', -width => 14, -command => sub { } )
  ->grid( -row => 12, -column => 28, -columnspan => 14, -sticky => 'w' );

#Create A New File
$mw->Button( -text => "Create", -width => 10, -command => sub { } )
  ->grid( -row => 12, -column => 36, -columnspan => 10, -sticky => 'w' );

#Select a current log file
$mw->Button( -text => "Save", -width => 10, -command => sub { } )
  ->grid( -row => 12, -column => 42, -columnspan => 10, -sticky => 'w' );

#refresh document in current side view
$mw->Button( -text => "Refresh", -width => 10, -command => sub { } )
  ->grid( -row => 12, -column => 48, -columnspan => 10, -sticky => 'w' );

################################################
########## Activity Log Edit Area ##############
################################################

#activity log label
my $activity_log_lable =
  $mw->Label( -text => "Activity Log", -height => 2 )->grid(
    -row        => 13,
    -column     => 35,
    -columnspan => 10,
    -rowspan    => 2,
    -sticky     => 'nsew'
  );

#Large text area on right side of window, current file view/edit area
my $lb2 = $mw->Scrolled(
    "Listbox",
    -selectmode => "single",
    -width      => 53,
    -height     => 10
)->grid(
    -row        => 14,
    -column     => 27,
    -rowspan    => 10,
    -columnspan => 53,
    -sticky     => 'w'
);
$lb2->insert( 'end', @ct_var );
$lb2->bind( '<Button-1>',
    sub { $ct_select_var = $lb2->get( $lb2->curselection() ); } );

#Send contents of entry boxes to a file
$mw->Button( -text => 'Select Log File', -width => 14, -command => sub { } )
  ->grid( -row => 24, -column => 28, -columnspan => 14, -sticky => 'w' );

#Create A New File
$mw->Button( -text => "Create", -width => 10, -command => sub { } )
  ->grid( -row => 24, -column => 36, -columnspan => 10, -sticky => 'w' );

#Select a current log file
$mw->Button( -text => "Edit", -width => 10, -command => sub { } )
  ->grid( -row => 24, -column => 42, -columnspan => 10, -sticky => 'w' );

#refresh document in current side view
$mw->Button( -text => "Delete", -width => 10, -command => sub { } )
  ->grid( -row => 24, -column => 48, -columnspan => 10, -sticky => 'w' );

################################################
######## Customer Care Entry Fields ############
################################################

#List box for contact type
my $label_area_1 = $mw->Label( -text => $config_hash{$widgit_1_lable} )
  ->grid( -row => 1, -column => 4, -columnspan => 10, -sticky => 'w' );
my $lb = $mw->Scrolled(
    "Listbox",
    -selectmode => "single",
    -width      => 20,
    -height     => 5
)->grid(
    -row        => 2,
    -column     => 2,
    -columnspan => 20,
    -rowspan    => 5,
    -sticky     => 'w'
);
$lb->insert( 'end', @ct_var );
$lb->bind( '<Button-1>',
    sub { $ct_select_var = $lb->get( $lb->curselection() ); } );

#Text area for customer account number
my $label_area_2 = $mw->Label( -text => "$widgit_2_lable" )
  ->grid( -row => 8, -column => 1, -columnspan => 5, -sticky => 'w' );
my $ent_area_2 = $mw->Entry( -width => 35 )
  ->grid( -row => 8, -column => 6, -columnspan => 35, -sticky => 'w' );

#Text area for customer phone number
my $label_area_3 = $mw->Label( -text => "$widgit_3_lable" )
  ->grid( -row => 9, -column => 1, -columnspan => 5, -sticky => 'w' );
my $ent_area_3 = $mw->Entry( -width => 35 )
  ->grid( -row => 9, -column => 6, -columnspan => 35, -sticky => 'w' );

#Text area for customer email
my $label_area_4 = $mw->Label( -text => "$widgit_4_lable" )
  ->grid( -row => 10, -column => 1, -columnspan => 5, -sticky => 'w' );
my $ent_area_4 = $mw->Entry( -width => 35 )
  ->grid( -row => 10, -column => 6, -columnspan => 35, -sticky => 'w' );

#Text area for customer name
my $label_area_5 = $mw->Label( -text => "$widgit_5_lable" )
  ->grid( -row => 11, -column => 1, -columnspan => 5, -sticky => 'w' );
my $ent_area_5 = $mw->Entry( -width => 35 )
  ->grid( -row => 11, -column => 6, -columnspan => 35, -sticky => 'w' );

#Text area for current issue
my $label_area_6 = $mw->Label( -text => "$widgit_6_lable" )
  ->grid( -row => 12, -column => 1, -columnspan => 5, -sticky => 'w' );
my $ent_area_6 = $mw->Entry( -width => 35 )
  ->grid( -row => 12, -column => 6, -columnspan => 35, -sticky => 'w' );

#Text Area for notes
my $text_area_lable =
  $mw->Label( -text => "$widgit_7_lable", -height => 2 )->grid(
    -row        => 13,
    -column     => 9,
    -columnspan => 5,
    -rowspan    => 2,
    -sticky     => 'nsew'
  );
my $text_area2 =
  $mw->Scrolled( "Text", -width => 40, -height => 10, -wrap => 'none' )->grid(
    -row        => 14,
    -column     => 1,
    -columnspan => 40,
    -rowspan    => 10,
    -sticky     => 'w'
  );
##########################################################
#################### Text Area Buttons ###################
##########################################################

#Send contents of entry boxes to a file
my $button4 = $mw->Button(
    -text    => 'Add New Log Entry',
    -width   => 44,
    -command => sub { &add_new }
)->grid( -row => 24, -column => 3, -columnspan => 44, -sticky => 'w' );

#Create A New File
#$mw->Button(-text => "Create New Log File",-width=>25, -command => sub { &sv_file; })->grid(-row => 25, -column => 2, -columnspan => 25, -sticky => 'w');

#Select a current log file
#$mw->Button(-text => "Select New Log File",-width=>25, -command => sub { &s_log })->grid(-row => 26, -column => 2, -columnspan => 25, -sticky => 'w');

#Save changes to document in current side view
#$mw->Button(-text => "Save Changes Current Log File",-width=>25, -command => sub {
#@text_var3 = $text_area1->get('1.0','end'); &save_change (@text_var3);
#}) ->grid(-row => 27, -column => 2, -columnspan => 25, -sticky => 'w');

#refresh document in current side view
#$mw->Button(-text => "Refresh Current Log File",-width=>25, -command => sub { &f_open }) ->grid(-row => 28, -column => 2, -columnspan => 25, -sticky => 'w');

#Exit button
#$mw->Button(-text => "Exit",-width=>30, -command => sub { exit }) ->grid(-row => 25, -column => 5, -columnspan => 30, -sticky => 'w');
#my $label_fill_2 = $mw -> Label(-text=>"",-width=>80) ->grid(-row => 0, -column => 0, -sticky => 'w');

#######################
###### Menu Bar #######
#######################

$mw->configure( -menu => my $menubar = $mw->Menu );

my $file = $menubar->cascade( -label => '~File' );
my $edit = $menubar->cascade( -label => '~Edit' );
my $help = $menubar->cascade( -label => '~Help' );

my $new = $file->cascade(
    -label       => 'New',
    -accelerator => 'Ctrl-n',
    -underline   => 0,
);
$file->separator;
$file->command(
    -label       => 'Open',
    -accelerator => 'Ctrl-o',
    -underline   => 0,
);
$file->separator;
$file->command(
    -label       => 'Save',
    -accelerator => 'Ctrl-1',
    -underline   => 0,
);
$file->command(
    -label       => 'Save As ...',
    -accelerator => 'Ctrl-2',
    -underline   => 0,
);
$file->separator;
$file->command(
    -label       => "Quit",
    -accelerator => 'Ctrl-q',
    -underline   => 0,
    -command     => sub { &exit },
);

$edit->command( -label => 'Preferences ...' );
$help->command( -label => 'Version', -command => sub { print "Version\n" } );
$help->separator;
$help->command( -label => 'About', -command => sub { print "About\n" } );

$mw->bind(
    $mw,
    "<Control-KeyPress-1>" => sub {
        @text_var3 = $text_area1->get( '1.0', 'end' );
        &save_change(@text_var3);
    }
);
$mw->bind(
    $mw,
    "<Control-KeyPress-2>" => sub {
        @text_var3 = $text_area1->get( '1.0', 'end' );
        &save_as(@text_var3);
    }
);
$mw->bind( $mw, "<Control-q>" => sub { exit } );

###################
##End of mainloop##
###################
MainLoop;

###############################################
############## Sub Routines ###################
###############################################

#Open File then append contents of text area to the files
# Read <
# Write > ,                creates if not existing and truncates(deletes original content so file is like new)
# Write/Append >> ,        creates if not existing
# Read/Write +<
# Read/Write +> ,          creates if not existing and truncates(deletes original content so file is like new)
# Read/Write +> ,          creates if not existing
sub print_to_file {
    my @temp_file = @_;
    open( my $outfile, ">>", $cur_wk_file ) or die $!;
    foreach (@temp_file) { print $outfile $_; }
    close $outfile;
    return;
}

#Create A New File
sub sv_file {
    my $sfile = $mw->getSaveFile();
    open( my $outfile, ">", $sfile ) or die $!;
    close $outfile;
    $cur_wk_file = $sfile;

    #$label_fill_1->configure (-text => "$cur_wk_file");
    $mw->configure(
        -title => "Ashes Note Keeper - Version 1.0 - $cur_wk_file" );
    &update_conf;
    return;
}

#Send contents of entry boxes to a file
sub add_new {
    my $answer = $mw->Dialog(
        -title          => 'Please Reply',
        -text           => 'Would you like to continue?',
        -default_button => 'yes',
        -buttons        => [ 'yes', 'no' ],
        -bitmap         => 'question'
    )->Show();
    if ( $answer eq 'yes' ) {
        &get_loc_time;
        $txt_var2 =
"\n$long_dash$short_dash $cur_time - $cur_date $short_dash\n$long_dash";
        &print_to_file($txt_var2);
        $txt_var2 = $ct_select_var . "\n";
        &print_to_file( $widgit_1_lable, $txt_var2 . $line_divide );
        $txt_var2 = $ent_area_2->get() . "\n";
        &print_to_file( $widgit_2_lable, $txt_var2 );
        $txt_var2 = $ent_area_3->get() . "\n";
        &print_to_file( $widgit_3_lable, $txt_var2 );
        $txt_var2 = $ent_area_4->get() . "\n";
        &print_to_file( $widgit_4_lable, $txt_var2 );
        $txt_var2 = $ent_area_5->get() . "\n";
        &print_to_file( $widgit_5_lable, $txt_var2 );
        $txt_var2 = $ent_area_6->get() . "\n";
        &print_to_file( $widgit_6_lable, $txt_var2 );
        @text_var3 = $text_area2->get( '1.0', 'end' );
        &print_to_file( $line_divide, $widgit_7_lable );
        &print_to_file(@text_var3);    #foreach (@text_var3) { print $_; }
        &clear_data_fields;
        &f_open;
    }
    return;
}

#Gets the local time and stores the values in a string
sub get_loc_time {
    my ( $sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst ) =
      localtime();
    $cur_date = sprintf( "%02d/%02d/%02d", $mon + 1, $mday, $year % 100, );
    $cur_time = sprintf( "%02d:%02d",      $hour,    $min, );
    return;
}

#refresh document in current side view
sub f_open {
    $text_area1->delete( '0.0', 'end' );
    open( my $outfile, '<', $cur_wk_file ) or die $!;
    my @file_temp = <$outfile>;
    close($outfile);
    foreach (@file_temp) { $text_area1->insert( 'end', $_ ); }
    return;
}

#Select a current log file
sub s_log {
    my $filename = $mw->getOpenFile(
        -title            => 'Open File:',
        -defaultextension => '.txt',
        -initialdir       => '.'
    );
    $cur_wk_file = $filename;
    &update_conf;

    #$label_fill_1->configure (-text => "$cur_wk_file");
    $mw->configure(
        -title => "Ashes Note Keeper - Version 1.0 - $cur_wk_file" );
    open( my $outfile, '<', $cur_wk_file ) or die $!;
    my @file_temp = <$outfile>;
    close($outfile);
    foreach (@file_temp) { $text_area1->insert( 'end', $_ ); }
    &f_open;
    return;
}

#Just like is says, clears the data fields for quicker re-entry
sub clear_data_fields {
    $text_area2->delete( '0.0', 'end' );
    $ent_area_2->delete( '0.0', 'end' );
    $ent_area_3->delete( '0.0', 'end' );
    $ent_area_4->delete( '0.0', 'end' );
    $ent_area_5->delete( '0.0', 'end' );
    $ent_area_6->delete( '0.0', 'end' );
    return;
}

#Save changes to document in current side view
sub save_change {
    my @temp_file = @_;
    my $answer2   = $mw->Dialog(
        -title          => 'Please Reply',
        -text           => 'Are you sure you want to save the changes?',
        -default_button => 'yes',
        -buttons        => [ 'yes', 'no' ],
        -bitmap         => 'question'
    )->Show();
    if ( $answer2 eq 'yes' ) {
        open( my $outfile, '>', $cur_wk_file ) or die $!;
        foreach (@temp_file) { print $outfile $_; }
        close $outfile;
    }
    return;
}

#Save As
sub save_as {
    my @temp_file = @_;
    my $answer2   = $mw->Dialog(
        -title          => 'Please Reply',
        -text           => 'Are you sure you want to save the changes?',
        -default_button => 'yes',
        -buttons        => [ 'yes', 'no' ],
        -bitmap         => 'question'
    )->Show();
    if ( $answer2 eq 'yes' ) {
        my $sfile = $mw->getSaveFile();
        open( my $outfile, ">", $sfile ) or die $!;
        foreach (@temp_file) { print $outfile $_; }
        close $outfile;
    }
}

#Gets the current config file(default cnf.srs) and copies it into @cur_config then updates necessary config variables
#sub get_conf{
#my @files = glob '*.*';
#my $counter = 0;
#foreach (@files) {
#if ($_ eq $defcon) {
#$counter += 1;
#open (my $outfile,'<',$defcon) or die $!;
#my @file_temp = <$outfile>;
#close($outfile);
#@cur_config = @file_temp;
#$cur_wk_file = $file_temp[0];
# }
#}
#if ($counter == 0) {
#open (my $outfile,'>',$defcon) or die $!;
#print $outfile "No File Selected";
#close $outfile;
#$cur_wk_file = "No File Selected";
#}
#$mw->title("Ashes Notekeeper v1.01 - $cur_wk_file");
#return;
#}

#Updates the config with with the current selected file
sub update_conf {
    open( my $outfile, ">", $defcon ) or die $!;
    print $outfile $cur_wk_file;
    close $outfile;
    return;
}

####################################################################
#CSV open subs
sub csv_open {
    my $file = $defcon;
    my @data;
    open( my $fh, '<', $file ) or die "Can't read file '$file' [$!]\n";
    my $line      = <$fh>;
    my %temp_hash = split( /,/, $line );
    return (%temp_hash);
}

sub create_default_config {
    open( my $outfile, '>', $defcon ) or die $!;
    print $outfile 'variable key,variable value,widgit_1_lable,,widgit_2_lable,,widgit_3_lable,,widgit_4_lable,,widgit_5_lable,,widgit_6_lable,,widgit_7_lable,,line_divide,"--\n",long_dash,"----------------------\n",short_dash,"--",';
    close $outfile;
}

sub get_conf {
    my @files   = glob '*.*';
    my $counter = 0;
    foreach (@files) {
        if ( $_ eq $defcon ) {
            $counter += 1;

            #open (my $outfile,'<',$defcon) or die $!;
            #my @file_temp = <$outfile>;
            #close($outfile);
            #@cur_config = @file_temp;
            #$cur_wk_file = $file_temp[0];
        }
    }
    if ( $counter == 0 ) {
        &create_default_config;
    }
    return;
}
