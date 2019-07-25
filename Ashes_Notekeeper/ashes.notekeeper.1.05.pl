#!/usr/bin/perl

###########
# Modules #
###########
use Tk;
use warnings;
use strict;
require Tk::Dialog;

# Check to see if running on windows computer, then runs the script with no console windo
if ($^O eq 'MSWin32') { require Win32::Console; Win32::Console::Free( );}

##############
# Get Config #
##############
my $defcon = 'cnf.srs';
my %config_hash = &get_conf;

#############
# Variables #
#############
my $txt_var2;
my $cur_time;
my $cur_date;
my @text_var3;
my @ct_var =  split(/ /, $config_hash{area_1_options});


###############
# Main Window #
###############
my $mw = MainWindow -> new;
$mw->title('Ashes Note Keeper - Version 1.05');

#Window Width and File title bar
my $label_fill_1 = $mw -> Label(-width => '175' ) ->pack(-side => 'top');
$label_fill_1->configure (-text => $config_hash{cur_wk_file});

##################
# Text Edit Area #
##################

#Large text area on right side of window, current file view/edit area
my $text_area1 = $mw-> Scrolled("Text",-width=>70, -height=>45, -wrap => 'none')->pack(-side => 'right', -padx => '10');

################
# Entry Fields #
################

#List box for contact type
my $label_area_1 = $mw -> Label(-text=>"$config_hash{widgit_1_lable}") ->pack(-padx => '10', -anchor => 'nw');
my $lb = $mw -> Scrolled("Listbox", -selectmode => "single", -width=>20, -height=>5) ->pack(-padx => '10', -pady => '10', -anchor => 'nw');
$lb->insert('end', @ct_var);
$lb->bind('<Button-1>', sub { $config_hash{ct_select_var} = $lb->get($lb->curselection( ));});

#Text area for customer account number
my $label_area_2 = $mw -> Label(-text=>"$config_hash{widgit_2_lable}") ->pack(-padx => '10',-anchor => 'nw');
my $ent_area_2 = $mw -> Entry(-width=>80) -> pack(-padx => '10',-anchor => 'nw');

#Text area for customer phone number
my $label_area_3 = $mw -> Label(-text=>"$config_hash{widgit_3_lable}") -> pack(-padx => '10',-anchor => 'nw');
my $ent_area_3 = $mw -> Entry(-width=>80) -> pack(-padx => '10',-anchor => 'nw');

#Text area for customer email
my $label_area_4 = $mw -> Label(-text=>"$config_hash{widgit_4_lable}") -> pack(-padx => '10',-anchor => 'nw');
my $ent_area_4 = $mw -> Entry(-width=>80) -> pack(-padx => '10',-anchor => 'nw');

#Text area for customer name
my $label_area_5 = $mw -> Label(-text=>"$config_hash{widgit_5_lable}") -> pack(-padx => '10',-anchor => 'nw');
my $ent_area_5 = $mw -> Entry(-width=>80) -> pack(-padx => '10',-anchor => 'nw');

#Text area for current issue
my $label_area_6 = $mw -> Label(-text=>"$config_hash{widgit_6_lable}") -> pack(-padx => '10',-anchor => 'nw');
my $ent_area_6 = $mw -> Entry(-width=>80) -> pack(-padx => '10',-anchor => 'nw');

#Text Area for notes
my $text_area_lable = $mw -> Label(-text=>"$config_hash{widgit_7_lable}") -> pack(-padx => '10',-anchor => 'nw');
my $text_area2 = $mw-> Scrolled("Text",-width=>70, -height=>10, -wrap => 'none')->pack(-anchor => 'nw');

#####################
# Text Area Buttons #
#####################

#Send contents of entry boxes to a file
my $button4 = $mw->Button(-text => 'Add New Log Entry', -width=>80, -command => sub{ &add_new })-> pack(-padx => '10', -pady => '10',-anchor => 'nw');

#Create A New File
$mw->Button(-text => "Create New Log File",-width=>80, -command => sub { &sv_file; })
->pack(-padx => '10', -pady => '1',-anchor => 'nw');

#Select a current log file
$mw->Button(-text => "Select New Log File",-width=>80, -command => sub { &s_log }) ->pack(-padx => '10', -pady => '1',-anchor => 'nw');

#Save changes to document in current side view
$mw->Button(-text => "Save Changes Current Log File",-width=>80, -command => sub {
@text_var3 = $text_area1->get('1.0','end'); &save_change(@text_var3); 
}) ->pack(-padx => '10', -pady => '1',-anchor => 'nw');

#refresh document in current side view
$mw->Button(-text => "Refresh Current Log File",-width=>80, -command => sub { &f_open }) ->pack(-padx => '10', -pady => '1',-anchor => 'nw');

#Exit button
$mw->Button(-text => "Exit",-width=>80, -command => sub { exit }) ->pack(-padx => '10', -pady => '1',-anchor => 'nw');
my $label_fill_2 = $mw -> Label(-text=>"",-width=>80) ->pack(-padx => '10',-anchor => 'nw');

############
# Menu Bar #
############
$mw->configure(-menu => my $menubar = $mw->Menu);

my $file = $menubar->cascade(-label => '~File');
my $edit = $menubar->cascade(-label => '~Edit');
my $help = $menubar->cascade(-label => '~Help');

my $file_menu = 
# File Menu
$file->command(
    -label       => 'Create New Log File',
    -accelerator => 'Ctrl-n',
    -underline   => 0,
    -command     => sub {&sv_file},
);
$file->separator;
$file->command(
    -label       => 'Open Log File',
    -accelerator => 'Ctrl-o',
    -underline   => 0,
	-command     => sub {&s_log},
);
$file->separator;
$file->command(
    -label       => 'Save Changes To Log',
    -accelerator => 'Ctrl-s',
    -underline   => 0,
	-command     => sub {@text_var3 = $text_area1->get('1.0','end'); &save_change(@text_var3);},
);
$file->separator;
$file->command(
    -label       => 'Refresh ...',
    -accelerator => 'Ctrl-r',
    -underline   => 0,
    -command     => sub {&f_open},
);
$file->separator;
$file->command(
    -label       => "Quit",
    -accelerator => 'Ctrl-q',
    -underline   => 0,
    -command     => sub {&exit},
);

# Edit Menu
$edit->command(-label => 'Preferences ...');

# Help Menu
$help->command(-label => 'Version', -command => sub {print "Version\n"});
$help->separator;
$help->command(-label => 'About',   -command => sub {print "About\n"});

# Hot Keys
$mw->bind($mw, "<Control-n>" => sub {&sv_file;});
$mw->bind($mw, "<Control-o>" => sub {&s_log;});
$mw->bind($mw, "<Control-s>" => sub {@text_var3 = $text_area1->get('1.0','end'); &save_change(@text_var3);});
$mw->bind($mw, "<Control-r>" => sub {&f_open;});
$mw->bind($mw, "<Control-q>" => sub {&exit;});

# Run first refresh
&f_open;

###################
#Start of mainloop#
###################
MainLoop;

################
# Sub Routines #
################

# Prints errors into an error log file
sub sv_log {
my @temp_file = @_;
&get_loc_time;
open (my $outfile,">>","log.txt") or die $!;
foreach (@temp_file) { print $outfile "$cur_time $cur_date - $_";}
close $outfile;
return;
}

# Prints data to file currently being worked on
sub print_to_file {
my @temp_file = @_;
open (my $outfile,">>",$config_hash{cur_wk_file}) or die &sv_log("Can't save file '$config_hash{cur_wk_file}' in subroutine 'print_to_file' [$!]\n");
foreach (@temp_file) { print $outfile $_  ;}
close $outfile;
return;
}

# Create A New File
sub sv_file{
my $sfile = $mw->getSaveFile( );
open (my $outfile,">",$sfile) or die &sv_log("Can't create file '$sfile' in subroutine 'sv_file' [$!]\n");
close $outfile;
$config_hash{cur_wk_file} = $sfile;
$label_fill_1->configure (-text => "$config_hash{cur_wk_file}");
&update_conf;
&f_open;
return;
}

# Send contents of entry boxes to a file
sub add_new {
my $answer = $mw->Dialog(-title => 'Please Reply',
   -text => 'Would you like to continue?', 
   -default_button => 'yes', -buttons => [ 'yes', 'no'], 
   -bitmap => 'question' )->Show( );
if ($answer eq 'yes') {
&get_loc_time;
$txt_var2 = "\n$config_hash{long_dash}\n$config_hash{short_dash} $cur_time - $cur_date $config_hash{short_dash}\n$config_hash{long_dash}\n"; &print_to_file ($txt_var2);
$txt_var2 = $config_hash{ct_select_var} . "\n"; &print_to_file ($config_hash{widgit_1_lable}, $txt_var2, $config_hash{line_divide},"\n");
$txt_var2 = $ent_area_2->get() . "\n"; &print_to_file ($config_hash{widgit_2_lable}, $txt_var2);
$txt_var2 = $ent_area_3->get() . "\n"; &print_to_file ($config_hash{widgit_3_lable}, $txt_var2);
$txt_var2 = $ent_area_4->get() . "\n"; &print_to_file ($config_hash{widgit_4_lable}, $txt_var2);
$txt_var2 = $ent_area_5->get() . "\n"; &print_to_file ($config_hash{widgit_5_lable}, $txt_var2);
$txt_var2 = $ent_area_6->get() . "\n"; &print_to_file ($config_hash{widgit_6_lable}, $txt_var2);
@text_var3 = $text_area2->get('1.0','end'); &print_to_file ($config_hash{line_divide}, "\n",$config_hash{widgit_7_lable}, "\n");
&print_to_file (@text_var3); #foreach (@text_var3) { print $_; }
&clear_data_fields;
&f_open;
}
return;
}

# Gets the local time and stores the values in a string
sub get_loc_time{
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
$cur_date = sprintf("%02d/%02d/%02d", $mon + 1, $mday, $year % 100,);
$cur_time = sprintf("%02d:%02d", $hour, $min,);
return;
}

# Creates a default config hash
sub create_default_hash {
open (my $outfile,'>',$defcon) or die &sv_log("Can't create file '$defcon' in subroutine 'create_default_hash' [$!]\n");
print $outfile 'cur_wk_file,README.txt,widgit_1_lable,CONTACT TYPE:,widgit_2_lable,ACCOUNT:,widgit_3_lable,CALL:,widgit_4_lable,EMAIL:,widgit_5_lable,NAME:,widgit_6_lable,ISSUE:,widgit_7_lable,NOTES:,line_divide,--,long_dash,----------------------,short_dash,--,ct_select_var,PHONE,area_1_options,EMAIL PHONE VOICEMAIL STORE TECHBENCH,';
close $outfile;
open ($outfile,'>',"README.txt") or die &sv_log("Can't create file 'README.txt' in subroutine 'create_default_hash' [$!]\n");
print $outfile "Please create a new log file\nIf the program will not start delete the cnf.srs file\n";
close $outfile;
return;
}

# Refresh document in current side view
sub f_open {
my @files = glob '*.*';
my $counter = 0;
foreach (@files) {
$text_area1->delete('0.0','end');
open (my $outfile,'<', $config_hash{cur_wk_file}) or die &sv_log("Can't open file '$config_hash{cur_wk_file}' in subroutine 'f_open' [$!]\n");
my @file_temp = <$outfile>;
close($outfile);
foreach (@file_temp) { $text_area1 -> insert('end',$_);}
}
return
}
 
# Select a current log file 
sub s_log {
my $filename = $mw->getOpenFile( -title => 'Open File:',-defaultextension => '.txt', -initialdir => '.' );
if (defined($filename)){
$config_hash{cur_wk_file} = $filename;
&update_conf;
$label_fill_1->configure (-text => "$config_hash{cur_wk_file}");
open ( my $outfile,'<', $config_hash{cur_wk_file}) or die &sv_log("Can't open file '$config_hash{cur_wk_file}' in subroutine 's_log' [$!]\n");
my @file_temp = <$outfile>;
close($outfile);
foreach (@file_temp) { $text_area1 -> insert('end',$_);}
&f_open;
}
return;
}

# Just like is says, clears the data fields for quicker re-entry
sub clear_data_fields {
$text_area2->delete('0.0','end');
$ent_area_2->delete('0.0','end');
$ent_area_3->delete('0.0','end');
$ent_area_4->delete('0.0','end');
$ent_area_5->delete('0.0','end');
$ent_area_6->delete('0.0','end');
return;
}

# Save changes to document in current side view
sub save_change {
my @temp_file = @_;
my $answer2 = $mw->Dialog(-title => 'Please Reply', 
   -text => 'Are you sure you want to save the changes?', 
   -default_button => 'yes', -buttons => [ 'yes', 'no'], 
   -bitmap => 'question' )->Show( );
if ($answer2 eq 'yes') {
open (my $outfile,'>',$config_hash{cur_wk_file}) or die &sv_log("Can't save changes to '$config_hash{cur_wk_file}' in subroutine 'save_change' [$!]\n");
foreach (@temp_file) { print $outfile $_  ;}
close $outfile;
} 
return;
}

# CSV open subs
sub csv_open {
open(my $file_data, '<', $defcon) or die &sv_log("Can't read file '$defcon' in subroutine 'csv_open' [$!]\n");
my $line = <$file_data>;
my %temp_hash = split(/,/, $line);
close $file_data;
return(%temp_hash);
}

# Gets the current config file(default cnf.srs) and copies it into @cur_config then updates necessary config variables
sub get_conf{
my %temp_config_hash;
my @files = glob '*.*';
my $counter = 0;
foreach (@files) {
if ($_ eq $defcon) {
$counter += 1;
%temp_config_hash = &csv_open;
}
}
if ($counter == 0){&create_default_hash; %temp_config_hash = &csv_open;}
return(%temp_config_hash);
}

# Updates the config with with the current selected file
sub update_conf {
my @k = keys   %config_hash; 
my @v = values %config_hash;
my @hloop = keys %config_hash;
my $hlc = 0;
my $temp_config;

foreach(@hloop){$temp_config .= $k[$hlc].",".$v[$hlc].","; $hlc++;}

open (my $outfile,">",$defcon) or die &sv_log("Can't open file '$defcon' in subroutine 'update_conf' [$!]\n");
print $outfile $temp_config;
close $outfile;
return;
}
