#!/usr/bin/perl
use Tk;
use warnings;
use strict;
require Tk::Dialog;

#check to see if running on windows computer
#then runs the script with no console window, since it is a gui app
if ($^O eq 'MSWin32') {
require Win32::Console;
Win32::Console::Free( );
}

#######################
##### Variables #######
#######################
my $widgit_1_lable = "CONTACT TYPE\:";
my $widgit_1_label_p2 = "\n\"Click once on the Contact type\"";
my $widgit_2_lable = "ACCOUNT\: ";
my $widgit_3_lable = "CALL\: ";
my $widgit_4_lable = "EMAIL\: ";
my $widgit_5_lable = "NAME\: ";
my $widgit_6_lable = "ISSUE\: ";
my $widgit_7_lable = "NOTES\: \n";
my $line_divide = "--\n";
my $long_dash = "----------------------\n";
my $short_dash = "--";
my $txt_var2;
my @text_var3;
my $ct_select_var;
my $cur_wk_file;
my $defcon = "cnf.srs";
my $junk = "EMAIL PHONE VOICEMAIL STORE TECHBENCH";
my @ct_var =  split(/ /, $junk);
my @cur_config;
my $cur_time;
my $cur_date;

#######################
##### Main Window #####
#######################
my $mw = MainWindow -> new;;
$mw->title('TK Notekeeper - Version 1.0');

#Gets the current config file(default cnf.srs) and copies it into @cur_config then updates necessary config variables
&get_conf;

#Window Width and File title bar
my $label_fill_1 = $mw -> Label(-width => '175' ) ->pack(-side => 'top');
$label_fill_1->configure (-text => $cur_wk_file);

################################################
######### Customer Care Edit Area #############
################################################

#Large text area on right side of window, current file view/edit area
my $text_area1 = $mw-> Scrolled("Text",-width=>70, -height=>45, -wrap => 'none')->pack(-side => 'right', -padx => '10');

################################################
######## Customer Care Entry Fields ############
################################################

#List box for contact type
my $label_area_1 = $mw -> Label(-text=>"$widgit_1_lable . $widgit_1_label_p2") ->pack(-anchor => 'nw');
my $lb = $mw -> Scrolled("Listbox", -selectmode => "single", -width=>20, -height=>5) ->pack(-padx => '10', -pady => '10',-anchor => 'nw');
$lb->insert('end', @ct_var);
$lb->bind('<Button-1>', sub { $ct_select_var = $lb->get($lb->curselection( ));});

#Text area for customer account number
my $label_area_2 = $mw -> Label(-text=>"$widgit_2_lable") ->pack(-padx => '10',-anchor => 'nw');
my $ent_area_2 = $mw -> Entry(-width=>80) -> pack(-padx => '10',-anchor => 'nw');

#Text area for customer phone number
my $label_area_3 = $mw -> Label(-text=>"$widgit_3_lable") -> pack(-padx => '10',-anchor => 'nw');
my $ent_area_3 = $mw -> Entry(-width=>80) -> pack(-padx => '10',-anchor => 'nw');

#Text area for customer email
my $label_area_4 = $mw -> Label(-text=>"$widgit_4_lable") -> pack(-padx => '10',-anchor => 'nw');
my $ent_area_4 = $mw -> Entry(-width=>80) -> pack(-padx => '10',-anchor => 'nw');

#Text area for customer name
my $label_area_5 = $mw -> Label(-text=>"$widgit_5_lable") -> pack(-padx => '10',-anchor => 'nw');
my $ent_area_5 = $mw -> Entry(-width=>80) -> pack(-padx => '10',-anchor => 'nw');

#Text area for current issue
my $label_area_6 = $mw -> Label(-text=>"$widgit_6_lable") -> pack(-padx => '10',-anchor => 'nw');
my $ent_area_6 = $mw -> Entry(-width=>80) -> pack(-padx => '10',-anchor => 'nw');

#Text Area for notes
my $text_area_lable = $mw -> Label(-text=>"$widgit_7_lable") -> pack(-padx => '10',-anchor => 'nw');
my $text_area2 = $mw-> Scrolled("Text",-width=>70, -height=>10, -wrap => 'none')->pack(-anchor => 'nw');

##########################################################
#################### Text Area Buttons ###################
##########################################################

#Send contents of entry boxes to a file
my $button4 = $mw->Button(-text => 'Add New Log Entry', -width=>80, -command => sub{ &add_new })-> pack(-padx => '10', -pady => '10',-anchor => 'nw');

#Create A New File
$mw->Button(-text => "Create New Log File",-width=>80, -command => sub { &sv_file; })
->pack(-padx => '10', -pady => '1',-anchor => 'nw');

#Select a current log file
$mw->Button(-text => "Select New Log File",-width=>80, -command => sub { &s_log }) ->pack(-padx => '10', -pady => '1',-anchor => 'nw');

#Save changes to document in current side view
$mw->Button(-text => "Save Changes Current Log File",-width=>80, -command => sub {
@text_var3 = $text_area1->get('1.0','end'); &save_change (@text_var3); 
}) ->pack(-padx => '10', -pady => '1',-anchor => 'nw');

#refresh document in current side view
$mw->Button(-text => "Refresh Current Log File",-width=>80, -command => sub { &f_open }) ->pack(-padx => '10', -pady => '1',-anchor => 'nw');

#Exit button
$mw->Button(-text => "Exit",-width=>80, -command => sub { exit }) ->pack(-padx => '10', -pady => '1',-anchor => 'nw');
my $label_fill_2 = $mw -> Label(-text=>"",-width=>80) ->pack(-padx => '10',-anchor => 'nw');

#######################
###### Menu Bar #######
#######################

$mw->configure(-menu => my $menubar = $mw->Menu);

my $file = $menubar->cascade(-label => '~File');
my $edit = $menubar->cascade(-label => '~Edit');
my $help = $menubar->cascade(-label => '~Help');

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
    -accelerator => 'Ctrl-s',
    -underline   => 0,
);
$file->command(
    -label       => 'Save As ...',
    -accelerator => 'Ctrl-a',
    -underline   => 1,
);
$file->separator;
$file->command(
    -label       => "Quit",
    -accelerator => 'Ctrl-q',
    -underline   => 0,
    -command     => sub {&exit},
);

$edit->command(-label => 'Preferences ...');
$help->command(-label => 'Version', -command => sub {print "Version\n"});
$help->separator;
$help->command(-label => 'About',   -command => sub {print "About\n"});

$mw->bind("<Control-s>" => sub {@text_var3 = $text_area1->get('1.0','end'); &save_change (@text_var3);});
$mw->bind($mw, "<Control-q>" => sub {exit});

#Open cur selcet document
#need to add a file check to prevent errors
&f_open;

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
open (my $outfile,">>",$cur_wk_file) or die $!;
foreach (@temp_file) { print $outfile $_  ;}
close $outfile;
return;
}

#Create A New File
sub sv_file{
my $sfile = $mw->getSaveFile( );
open (my $outfile,">",$sfile) or die $!;
close $outfile;
$cur_wk_file = $sfile;
$label_fill_1->configure (-text => "$cur_wk_file");
&update_conf;
return;
}

#Send contents of entry boxes to a file
sub add_new {
my $answer = $mw->Dialog(-title => 'Please Reply',
   -text => 'Would you like to continue?', 
   -default_button => 'yes', -buttons => [ 'yes', 'no'], 
   -bitmap => 'question' )->Show( );
if ($answer eq 'yes') {
&get_loc_time;
$txt_var2 = "\n$long_dash$short_dash $cur_time - $cur_date $short_dash\n$long_dash"; &print_to_file ($txt_var2);
$txt_var2 = $ct_select_var . "\n"; &print_to_file ($widgit_1_lable, $txt_var2 . $line_divide);
$txt_var2 = $ent_area_2->get() . "\n"; &print_to_file ($widgit_2_lable, $txt_var2);
$txt_var2 = $ent_area_3->get() . "\n"; &print_to_file ($widgit_3_lable, $txt_var2);
$txt_var2 = $ent_area_4->get() . "\n"; &print_to_file ($widgit_4_lable, $txt_var2);
$txt_var2 = $ent_area_5->get() . "\n"; &print_to_file ($widgit_5_lable, $txt_var2);
$txt_var2 = $ent_area_6->get() . "\n"; &print_to_file ($widgit_6_lable, $txt_var2);
@text_var3 = $text_area2->get('1.0','end'); &print_to_file ($line_divide,$widgit_7_lable);
&print_to_file (@text_var3); #foreach (@text_var3) { print $_; }
&clear_data_fields;
&f_open;
}
return;
}

#Gets the local time and stores the values in a string
sub get_loc_time {
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
$cur_date = sprintf("%02d/%02d/%02d", $mon + 1, $mday, $year % 100,);
$cur_time = sprintf("%02d:%02d", $hour, $min,);
return;
}

#refresh document in current side view
sub f_open {
$text_area1->delete('0.0','end');
open (my $outfile,'<', $cur_wk_file) or die $!;
my @file_temp = <$outfile>;
close($outfile);
foreach (@file_temp) { $text_area1 -> insert('end',$_);}
return;
}
 
#Select a current log file 
sub s_log {
my $filename = $mw->getOpenFile( -title => 'Open File:',-defaultextension => '.txt', -initialdir => '.' );
$cur_wk_file = $filename;
&update_conf;
$label_fill_1->configure (-text => "$cur_wk_file");
open ( my $outfile,'<', $cur_wk_file) or die $!;
my @file_temp = <$outfile>;
close($outfile);
foreach (@file_temp) { $text_area1 -> insert('end',$_);}
&f_open;
return;
}

#Just like is says, clears the data fields for quicker re-entry
sub clear_data_fields {
$text_area2->delete('0.0','end');
$ent_area_2->delete('0.0','end');
$ent_area_3->delete('0.0','end');
$ent_area_4->delete('0.0','end');
$ent_area_5->delete('0.0','end');
$ent_area_6->delete('0.0','end');
return;
}

#Save changes to document in current side view
sub save_change {
my @temp_file = @_;
my $answer2 = $mw->Dialog(-title => 'Please Reply', 
   -text => 'Are you sure you want to save the changes?', 
   -default_button => 'yes', -buttons => [ 'yes', 'no'], 
   -bitmap => 'question' )->Show( );
if ($answer2 eq 'yes') {
open (my $outfile,'>',$cur_wk_file) or die $!;
foreach (@temp_file) { print $outfile $_  ;}
close $outfile;
} 
return;
}

#Gets the current config file(default cnf.srs) and copies it into @cur_config then updates necessary config variables
sub get_conf{
my @files = glob '*.*';
my $counter = 0;
foreach (@files) {
if ($_ eq $defcon) {
$counter += 1;
open (my $outfile,'<',$defcon) or die $!;
my @file_temp = <$outfile>;
close($outfile);
@cur_config = @file_temp;
$cur_wk_file = $file_temp[0]; 
 }
}
if ($counter == 0) {
open (my $outfile,'>',$defcon) or die $!;
print $outfile "No File Selected";
close $outfile;
$cur_wk_file = "No File Selected"; 
}
return;
}

#Updates the config with with the current selected file
sub update_conf {
open (my $outfile,">",$defcon) or die $!;
print $outfile $cur_wk_file;
close $outfile;
return;
}
