#!/usr/bin/perl
use Tk;
use warnings;
use strict;
require Tk::Dialog;
my $version = 'v1.03';

#######################
##### Variables #######
#######################
my ( @cur_config, @text_var3, $cur_date, $cur_time, $cur_wk_file,
    $ct_select_var, $lb2_select_var, $txt_var2 )
  = ( undef, undef, undef, undef, undef, undef, undef, undef );

#sets file types for opening documents
my $types = [ [ 'Text Files', [ '.txt', '.text' ] ], [ 'All Files', '*', ], ];

########################
##Main Window settings##
########################

#Creates the main window
my $mw = MainWindow->new;

#sets the table grid size
my $tb_size = 75;

#Creates an array for the grid size
my @text = ( 1 .. $tb_size );

#Creates all other variable for creating the main window grid
my ( $c_height, $c_width ) = ( 1, 1 );
my ( $i, $c, $rtc, $w, $w2 ) = ( 0, 0, 1, undef, undef );

######################
## Main Window Grid ##
######################

#Creates a grid for all other widgets to be built on
foreach my $temp (@text) {
    if ( 0 == $i % 2 ) {
        if ( $i < 26 ) {
            $w = $mw->Label( -height => $c_height, -width => $c_width, );
            $w->grid( -row => $i, -column => $c, -sticky => 'w' );
        }
        $w2 = $mw->Label( -height => $c_height, -width => $c_width, );
        $w2->grid( -row => $c, -column => $i, -sticky => 'n' );
        $i++;
    }
    else {
        if ( $i < 26 ) {
            $w = $mw->Label( -height => $c_height, -width => $c_width, );
            $w->grid( -row => $i, -column => $c, -sticky => 'w' );
        }
        $w2 = $mw->Label( -height => $c_height, -width => $c_width, );
        $w2->grid( -row => $c, -column => $i, -sticky => 'n' );
        $i++;
    }
}

################
## Get Config ##
################

#Set default config file name, check
my $defcon = 'cnf.srs';
&get_conf;
my %config_hash = &csv_open;
&update_title;
my @ct_var = &update_slb;

################################################
######### Customer Care Edit Area #############
################################################

#Customer Log Label
my $text_area_2_lable =
  $mw->Label( -text => "Customer Log", -height => 2 )->grid(
    -row        => 1,
    -column     => 35,
    -columnspan => 10,
    -rowspan    => 2,
    -sticky     => 'nsew'
  );

#Large text area on right side of window, current file view/edit area
my $text_area_2 =
  $mw->Scrolled( "Text", -width => 75, -height => 10, -wrap => 'none' )->grid(
    -row        => 2,
    -column     => 27,
    -rowspan    => 10,
    -columnspan => 50,
    -sticky     => 'w'
  );

#Create a new log file
my $text_area_2_button_1 = $mw->Button(
    -text    => 'Select Log File',
    -width   => 14,
    -command => sub { &s_log }
)->grid( -row => 12, -column => 28, -columnspan => 14, -sticky => 'w' );

#Create A New File
my $text_area_2_button_2 = $mw->Button(
    -text    => "Create",
    -width   => 10,
    -command => sub { &sv_file('text_area_2'); }
)->grid( -row => 12, -column => 36, -columnspan => 10, -sticky => 'w' );

#Select a current log file
my $text_area_2_button_3 = $mw->Button(
    -text    => "Save",
    -width   => 10,
    -command => sub {
        @text_var3 = $text_area_2->get( '0.0', 'end' );
        &save_change(@text_var3);
    }
)->grid( -row => 12, -column => 42, -columnspan => 10, -sticky => 'w' );

#refresh document in current side view
my $text_area_2_button_4 = $mw->Button(
    -text    => "Refresh",
    -width   => 10,
    -command => sub { &log_refresh }
)->grid( -row => 12, -column => 48, -columnspan => 10, -sticky => 'w' );

################################################
########## Activity Log Edit Area ##############
################################################

#activity log label
my $list_box_2_lable =
  $mw->Label( -text => "Activity Log", -height => 2 )->grid(
    -row        => 13,
    -column     => 35,
    -columnspan => 10,
    -rowspan    => 2,
    -sticky     => 'nsew'
  );

#Large text area on right side of window, current file view/edit area
my $list_box_2 = $mw->Scrolled(
    "Listbox",
    -selectmode => "single",
    -width      => 88,
    -height     => 10
)->grid(
    -row        => 14,
    -column     => 27,
    -rowspan    => 10,
    -columnspan => 50,
    -sticky     => 'w'
);
$list_box_2->bind( '<Button-1>',
    sub { $lb2_select_var = $list_box_2->get( $list_box_2->curselection() ); }
);

#Send contents of entry boxes to a file
my $list_box_2_button_1 = $mw->Button(
    -text    => 'Select Log File',
    -width   => 14,
    -command => sub { &s_log_lb2 }
)->grid( -row => 24, -column => 28, -columnspan => 14, -sticky => 'w' );

#Create A New File
my $list_box_2_button_2 = $mw->Button(
    -text    => "Create Log File ",
    -width   => 14,
    -command => sub { &sv_file('list_box_2') }
)->grid( -row => 24, -column => 36, -columnspan => 14, -sticky => 'w' );

#Select a current log file
my $list_box_2_button_3 = $mw->Button(
    -text    => "Add Log",
    -width   => 10,
    -command => sub { &create_new_windows }
)->grid( -row => 24, -column => 44, -columnspan => 10, -sticky => 'w' );

#Select a current log file
my $list_box_2_button_4 = $mw->Button(
    -text    => "Edit Log",
    -width   => 10,
    -command => sub { &edit_list_box }
)->grid( -row => 24, -column => 50, -columnspan => 10, -sticky => 'w' );

#refresh document in current side view
my $list_box_2_button_5 =
  $mw->Button( -text => "Delete Log", -width => 10, -command => sub { } )
  ->grid( -row => 24, -column => 56, -columnspan => 10, -sticky => 'w' );

################################################
######## Customer Care Entry Fields ############
################################################

#List box for contact type
my $list_box_1_lable = $mw->Label( -text => $config_hash{'widgit_1_lable'} )
  ->grid( -row => 1, -column => 4, -columnspan => 10, -sticky => 'w' );
my $list_box_1 = $mw->Scrolled(
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
$list_box_1->insert( 'end', @ct_var );
$list_box_1->bind( '<Button-1>',
    sub { $ct_select_var = $list_box_1->get( $list_box_1->curselection() ); } );

#Text area for customer account number
my $ent_area_1_label = $mw->Label( -text => $config_hash{'widgit_2_lable'} )
  ->grid( -row => 8, -column => 1, -columnspan => 5, -sticky => 'w' );
my $ent_area_1 = $mw->Entry( -width => 35 )
  ->grid( -row => 8, -column => 6, -columnspan => 35, -sticky => 'w' );

#Text area for customer phone number
my $ent_area_2_label = $mw->Label( -text => $config_hash{'widgit_3_lable'} )
  ->grid( -row => 9, -column => 1, -columnspan => 5, -sticky => 'w' );
my $ent_area_2 = $mw->Entry( -width => 35 )
  ->grid( -row => 9, -column => 6, -columnspan => 35, -sticky => 'w' );

#Text area for customer email
my $ent_area_3_label = $mw->Label( -text => $config_hash{'widgit_4_lable'} )
  ->grid( -row => 10, -column => 1, -columnspan => 5, -sticky => 'w' );
my $ent_area_3 = $mw->Entry( -width => 35 )
  ->grid( -row => 10, -column => 6, -columnspan => 35, -sticky => 'w' );

#Text area for customer name
my $ent_area_4_label = $mw->Label( -text => $config_hash{'widgit_5_lable'} )
  ->grid( -row => 11, -column => 1, -columnspan => 5, -sticky => 'w' );
my $ent_area_4 = $mw->Entry( -width => 35 )
  ->grid( -row => 11, -column => 6, -columnspan => 35, -sticky => 'w' );

#Text area for current issue
my $ent_area_5_label = $mw->Label( -text => $config_hash{'widgit_6_lable'} )
  ->grid( -row => 12, -column => 1, -columnspan => 5, -sticky => 'w' );
my $ent_area_5 = $mw->Entry( -width => 35 )
  ->grid( -row => 12, -column => 6, -columnspan => 35, -sticky => 'w' );

#Text Area for notes
my $text_area_1_lable =
  $mw->Label( -text => $config_hash{'widgit_7_lable'}, -height => 2 )->grid(
    -row        => 13,
    -column     => 9,
    -columnspan => 5,
    -rowspan    => 2,
    -sticky     => 'nsew'
  );
my $text_area_1 =
  $mw->Scrolled( "Text", -width => 40, -height => 10, -wrap => 'none' )->grid(
    -row        => 14,
    -column     => 1,
    -columnspan => 40,
    -rowspan    => 10,
    -sticky     => 'w'
  );

#######################
## Text Area Buttons ##
#######################

#Send contents of entry boxes to a file
my $text_area_1_button_1 = $mw->Button(
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
        @text_var3 = $text_area_2->get( '1.0', 'end' );
        &save_change(@text_var3);
    }
);
$mw->bind(
    $mw,
    "<Control-KeyPress-2>" => sub {
        @text_var3 = $text_area_2->get( '1.0', 'end' );
        &save_as(@text_var3);
    }
);
$mw->bind( $mw, "<Control-q>" => sub { exit } );

######################################
## Update data fields for first run ##
######################################
&f_open;
&update_list_box;

###################
##End of mainloop##
###################
MainLoop;

###############################################
############## Sub Routines ###################
###############################################

sub create_new_windows {
    my $subwin1 = $mw->Toplevel;

    #$subwin1 -> geometry ("300x100");
    $subwin1->title("sub window 1");

    #sets the table grid size
    my $tb_size = 30;

    #Creates an array for the grid size
    my @text = ( 1 .. $tb_size );

    #Creates all other variable for creating the main window grid
    my ( $c_height, $c_width ) = ( 1, 1 );
    my ( $i, $c, $rtc, $w, $w2 ) = ( 0, 0, 1, undef, undef );

######################
## Main Window Grid ##
######################

    #Creates a grid for all other widgets to be built on
    foreach my $temp (@text) {
        if ( 0 == $i % 2 ) {
            if ( $i < 10 ) {
                $w =
                  $subwin1->Label( -height => $c_height, -width => $c_width, );
                $w->grid( -row => $i, -column => $c, -sticky => 'w' );
            }
            $w2 = $subwin1->Label( -height => $c_height, -width => $c_width, );
            $w2->grid( -row => $c, -column => $i, -sticky => 'n' );
            $i++;
        }
        else {
            if ( $i < 10 ) {
                $w =
                  $subwin1->Label( -height => $c_height, -width => $c_width, );
                $w->grid( -row => $i, -column => $c, -sticky => 'w' );
            }
            $w2 = $subwin1->Label( -height => $c_height, -width => $c_width, );
            $w2->grid( -row => $c, -column => $i, -sticky => 'n' );
            $i++;
        }
    }
###############
## Text Area ##
###############

    my $ent_area_2_label = $subwin1->Label( -text => 'Key' )
      ->grid( -row => 3, -column => 1, -columnspan => 5, -sticky => 'w' );
    my $ent_area_2 = $subwin1->Entry( -width => 5 )
      ->grid( -row => 3, -column => 6, -columnspan => 35, -sticky => 'w' );

    my $ent_area_3_label = $subwin1->Label( -text => 'Value' )
      ->grid( -row => 5, -column => 1, -columnspan => 5, -sticky => 'w' );
    my $ent_area_3 = $subwin1->Entry( -width => 5 )
      ->grid( -row => 5, -column => 6, -columnspan => 35, -sticky => 'w' );

    $subwin1->Button(
        -text    => "Close",
        -width   => 10,
        -command => sub { $subwin1->destroy }
    )->grid( -row => 8, -column => 10, -columnspan => 10, -sticky => 'nsew' );
}

#Updates the config with with the current selected file
#sub update_conf {
#open (my $outfile,">",$defcon) or die $!;
#print $outfile $cur_wk_file;
#close $outfile;
#return;
#}
sub update_config {
    my ( $counter, $temp ) = ( 0, undef );
    my @config_hash_keys   = keys %config_hash;      #  e.g. ('b', 'c', 'a')
    my @config_hash_values = values %config_hash;    #  e.g. ( 2,   3,   1 )
    my @hash_counter       = @config_hash_keys;
    foreach (@hash_counter) {
        $temp .= "$config_hash_keys[$counter]";
        $temp .= ",$config_hash_values[$counter],";
        $counter++;
    }
    open( my $outfile, ">", $defcon ) or die $!;
    print $outfile $temp;
    close $outfile;
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
    print $outfile
'variable key,variable value,widgit_1_lable,,widgit_2_lable,,widgit_3_lable,,widgit_4_lable,,widgit_5_lable,,widgit_6_lable,,widgit_7_lable,,line_divide,"--\n",long_dash,"----------------------\n",short_dash,"--",cur_wk_file,,';
    close $outfile;
}

sub get_conf {
    my @files   = glob '*.*';
    my $counter = 0;
    foreach (@files) {
        if ( $_ eq $defcon ) {
            $counter += 1;
        }
    }
    if ( $counter == 0 ) {
        &create_default_config;
    }
    return;
}

#Updates the title bar with current file name
sub update_title {
    $mw->title("Ashes Notekeeper $version - $config_hash{'cur_wk_file'}");
}

#updated contents of scrolled list box
sub update_slb {
    my @temp_var = split( / /, $config_hash{'junk'} );
    @temp_var;
}

#Open File then append contents of text area to the files
# Read <
# Write > ,                creates if not existing and truncates(deletes original content so file is like new)
# Write/Append >> ,        creates if not existing
# Read/Write +<
# Read/Write +> ,          creates if not existing and truncates(deletes original content so file is like new)
# Read/Write +> ,          creates if not existing
sub print_to_file {
    my @temp_file = @_;
    open( my $outfile, '>>', $config_hash{'cur_wk_file'} ) or die $!;
    foreach (@temp_file) { print $outfile $_; }
    close $outfile;
    return;
}

#refresh document in current side view
sub f_open {
    $text_area_2->delete( '1.0', 'end' );
    open( my $outfile, '<', $config_hash{'cur_wk_file'} ) or die $!;
    my @file_temp = <$outfile>;
    close($outfile);
    foreach (@file_temp) { $text_area_2->insert( 'end', $_ ); }
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
"\n$config_hash{'long_dash'}\n$config_hash{'short_dash'} $cur_time - $cur_date $config_hash{'short_dash'}\n$config_hash{'long_dash'}\n";
        &print_to_file($txt_var2);
        $txt_var2 = $ct_select_var . "\n";
        &print_to_file(
            $config_hash{'widgit_1_lable'},
            $txt_var2 . $config_hash{'line_divide'}
        );
        $txt_var2 = $ent_area_1->get() . "\n";
        &print_to_file( "\n" . $config_hash{'widgit_2_lable'}, $txt_var2 );
        $txt_var2 = $ent_area_2->get() . "\n";
        &print_to_file( $config_hash{'widgit_3_lable'}, $txt_var2 );
        $txt_var2 = $ent_area_3->get() . "\n";
        &print_to_file( $config_hash{'widgit_4_lable'}, $txt_var2 );
        $txt_var2 = $ent_area_4->get() . "\n";
        &print_to_file( $config_hash{'widgit_5_lable'}, $txt_var2 );
        $txt_var2 = $ent_area_5->get() . "\n";
        &print_to_file( $config_hash{'widgit_6_lable'}, $txt_var2 );
        @text_var3 = $text_area_1->get( '1.0', 'end' );
        &print_to_file(
            $config_hash{'line_divide'} . "\n",
            $config_hash{'widgit_7_lable'}
        );
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

#refresh the log windows
sub log_refresh {
    my $refresh_answer = $mw->Dialog(
        -title => 'Please Reply',
        -text =>
"Are you sure you want to continue?\nAll data not saved will be deleted.",
        -default_button => 'no',
        -buttons        => [ 'yes', 'no' ],
        -bitmap         => 'question'
    )->Show();
    if ( $refresh_answer eq 'yes' ) {
        &f_open;
    }
}

#Select a current log file
sub s_log {
    my $filename = $mw->getOpenFile(
        -title      => 'Open File:',
        -filetypes  => $types,
        -initialdir => '.'
    );
    $config_hash{'cur_wk_file'} = $filename;
    &f_open;
    &update_title;
    &update_config;
    return;
}

#Update a list box
sub update_list_box {

    #open current log file for list box 2
    open( my $outfile, '<', $config_hash{'list_box_2_log'} )
      or die "Can't read file '$file' [$!]\n";
    my $line = <$outfile>;

    #split the file into a hash and array
    my %temp_hash = split( /\|/, $line );
    my @file_temp = split( /\|/, $line );
    my %r_temp_hash = reverse %temp_hash;
    my $t_temp      = $temp_hash{'1'};

    #print $r_temp_hash{$t_temp};
    #return(%temp_hash)
    #delete previous content
    $list_box_2->delete( '0.0', 'end' );
    my ( $temp_val, $counter ) = ( undef, 1 );

#Use current array, combine key and value from csv file, then insert into list box 2
    foreach (@file_temp) {
        if   ( $counter == 1 ) { $temp_val .= "$_    \|    "; }
        else                   { $temp_val .= "$_"; }
        if ( $counter == 2 ) {
            $list_box_2->insert( 'end', $temp_val );
            $temp_val = undef;
            $counter  = 0;
        }
        $counter++;
    }
    close $outfile;
}

sub edit_list_box {
    my %temp_hash = split( /\|/, $lb2_select_var );
    my $temp_key  = keys %temp_hash;                  #  e.g. ('b', 'c', 'a')
    my $temp_val  = values %temp_hash;                #  e.g. ( 2,   3,   1 )
    print "\n $temp_key \n";
    print "\n $temp_val \n";
    return;
}

#Select Activity log
sub s_log_lb2 {
    my $filename = $mw->getOpenFile(
        -title      => 'Open File:',
        -filetypes  => $types,
        -initialdir => '.'
    );
    $config_hash{'list_box_2_log'} = $filename;
    &update_list_box;
    &update_config;
}

#Just like is says, clears the data fields for quicker re-entry
sub clear_data_fields {
    $text_area_1->delete( '0.0', 'end' );
    $ent_area_1->delete( '0.0', 'end' );
    $ent_area_2->delete( '0.0', 'end' );
    $ent_area_3->delete( '0.0', 'end' );
    $ent_area_4->delete( '0.0', 'end' );
    $ent_area_5->delete( '0.0', 'end' );
    return;
}

#Create A New File
sub sv_file {
    my $test_var = shift @_;
    my $sfile    = $mw->getSaveFile(
        -title      => 'Create New File:',
        -filetypes  => $types,
        -initialdir => '.'
    );
    open( my $outfile, ">", $sfile ) or die $!;
    close $outfile;
    if ( $test_var eq 'text_area_2' ) {
        $config_hash{'cur_wk_file'} = $sfile;
        &update_title;
        &update_config;
    }
    if ( $test_var eq 'list_box_2' ) {
        $config_hash{'list_box_2_log'} = $sfile;
        &update_list_box;
        &update_config;
    }
    return;
}

#Save changes to document in current side view
sub save_change {
    my @temp_file = @_;
    my $answer2   = $mw->Dialog(
        -title          => 'Please Reply',
        -text           => 'Are you sure you want to save the changes?',
        -default_button => 'no',
        -buttons        => [ 'yes', 'no' ],
        -bitmap         => 'question'
    )->Show();

    #$answer2->focus;
    if ( $answer2 eq 'yes' ) {
        open( my $outfile, '>', $config_hash{'cur_wk_file'} ) or die $!;
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

