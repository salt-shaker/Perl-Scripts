#!/usr/bin/perl
use Tk;

#Variables
my $widgit_1_lable = "SOURCE\: ";
my $widgit_2_lable = "ACCOUNT\: ";
my $widgit_3_lable = "CALL\: ";
my $widgit_4_lable = "EMAIL\: ";
my $widgit_5_lable = "NAME\: ";
my $widgit_6_lable = "ISSUE\: ";
my $widgit_7_lable = "NOTES\: \n";
my $line_divide = "--\n";
my $txt_var;
my $txt_var2;
my @text_var3;

my $mw = MainWindow -> new;

#Should be a drop down menu
my $label_area_1 = $mw -> Label(-text=>"$widgit_1_lable") ->pack(-anchor => 'nw');
my $ent_area_1 = $mw -> Entry(-width=>80) -> pack(-anchor => 'nw');

my $label_area_2 = $mw -> Label(-text=>"$widgit_2_lable") ->pack(-anchor => 'nw');
my $ent_area_2 = $mw -> Entry(-width=>80) -> pack(-anchor => 'nw');

my $label_area_3 = $mw -> Label(-text=>"$widgit_3_lable") -> pack(-anchor => 'nw');
my $ent_area_3 = $mw -> Entry(-width=>80) -> pack(-anchor => 'nw');

my $label_area_4 = $mw -> Label(-text=>"$widgit_4_lable") -> pack(-anchor => 'nw');
my $ent_area_4 = $mw -> Entry(-width=>80) -> pack(-anchor => 'nw');

my $label_area_5 = $mw -> Label(-text=>"$widgit_5_lable") -> pack(-anchor => 'nw');
my $ent_area_5 = $mw -> Entry(-width=>80) -> pack(-anchor => 'nw');

#Should be a drop down menu
my $label_area_6 = $mw -> Label(-text=>"$widgit_6_lable") -> pack(-anchor => 'nw');
my $ent_area_6 = $mw -> Entry(-width=>80) -> pack(-anchor => 'nw');

#Space Filler
my $label_fill_1 = $mw -> Label(-text=>"") ->pack(-anchor => 'nw',-fill => 'x');


#Text Area Anchored to Bottom
my $text_area_lable = $mw -> Label(-text=>"$widgit_7_lable") -> pack(-anchor => 'sw');
my $text_area = $mw-> Text(-width=>80, -height=>20,)->pack(-anchor => 'sw');

#Send contents of entry boxes to a file
my $button4 = $mw->Button(-text => 'Save', -command => sub{ 
$txt_var2 = $ent_area_1->get() . "\n"; &print_to_file ($widgit_1_lable, $txt_var2);
$txt_var2 = $ent_area_2->get() . "\n"; &print_to_file ($widgit_2_lable, $txt_var2);
$txt_var2 = $ent_area_3->get() . "\n"; &print_to_file ($widgit_3_lable, $txt_var2);
$txt_var2 = $ent_area_4->get() . "\n"; &print_to_file ($widgit_4_lable, $txt_var2);
$txt_var2 = $ent_area_5->get() . "\n"; &print_to_file ($widgit_5_lable, $txt_var2);
$txt_var2 = $ent_area_6->get() . "\n"; &print_to_file ($widgit_6_lable, $txt_var2);
@text_var3 = $text_area->get('1.0','end'); &print_to_file ($line_divide,$widgit_7_lable); &print_to_file_var (@text_var3); #foreach (@text_var3) { print $_; }
&print_to_file ($line_divide)})-> pack(-anchor => 'nw', -before => $text_area_lable);

#Exit button
my $label_fill_1 = $mw -> Label(-text=>"") ->pack(-anchor => 'sw',-fill => 'x');
$mw->Button(-text => "exit", -command => sub { exit }) ->pack(-anchor => 'sw',-expand => 1,-fill => 'x');

MainLoop;

#Open File then append contents of text area to the files
# Read <
# Write > ,                creates if not existing and truncates(deletes original content so file is like new)
# Write/Append >> ,        creates if not existing
# Read/Write +<
# Read/Write +> ,          creates if not existing and truncates(deletes original content so file is like new)
# Read/Write +> ,          creates if not existing
sub print_to_file {
open (my $outfile,">>","test.outputfile.txt") or die $!;
foreach (@_) { print $outfile $_  ;}
#print $outfile $_[0];
#print $outfile $_[1];
close $outfile;
}

sub print_to_file_var {
open (my $outfile,">>","test.outputfile.txt") or die $!;
foreach (@_){ print $outfile $_;}
close $outfile;
}

#########################################

#Send contents of Text Area to CLI
#my $button1 = $mw->Button( -text => 'Print to CLI', -command => sub{
#$txt_var = $text_area->get('1.0','end'), "\n"; print $txt_var;
#})->pack(-anchor => 's',-side => 'left');

#Send contents of entry boxes to the Text Area
#
#my $button2 = $mw->Button(-text => 'Print to Text Area', -command => sub{ 
#$txt_var2 = $ent_area_1->get() . "\n"; $text_area->insert('end',"$widgit_1_lable" . $txt_var2);
#$txt_var2 = $ent_area_2->get() . "\n"; $text_area->insert('end',"$widgit_2_lable" . $txt_var2);
#$txt_var2 = $ent_area_3->get() . "\n"; $text_area->insert('end',"$widgit_3_lable" . $txt_var2);
#$txt_var2 = $ent_area_4->get() . "\n"; $text_area->insert('end',"$widgit_4_lable" . $txt_var2);
#$txt_var2 = $ent_area_5->get() . "\n"; $text_area->insert('end',"$widgit_5_lable" . $txt_var2);
#$txt_var2 = $ent_area_6->get() . "\n"; $text_area->insert('end',"$widgit_6_lable" . $txt_var2);
#})->pack(-anchor => 's',-side => 'left');

#########################################

#PHONE CALL: 
#-- 
#ACCOUNT: 
#CALL: 
#EMAIL: 
#NAME: 
#ISSUE: 
#-- 
#NOTES: 

#########################################

## finally figured it out
## Variables
#my $click_count;
#my $p_to_file;
#
#Main Window
#my $mw = MainWindow -> new;
#$mw->title('4 Button Window');
#
#Buttons & Text Area
#$mw->Button(-text => "Top", -command => sub { $click_count +=1 })->pack(-side => 'top',-expand => 1);
#my $textarea = $mw -> Entry(-width=>40) ->pack(-fill => 'y');
#mw->Button(-text => "exit", -command => sub { exit })->pack(-side => 'bottom');
#$mw->Button(-text => 'Show Click Count', -command => sub{ $textarea->insert( 'end' , "\n" . $click_count);})->pack( -side => 'bottom' );
#$mw->Button(-text => 'Show Click Count 2', -command => sub{ $text_area->insert( 'end' , "\n" . $click_count);})->pack( -side => 'bottom' );
#$mw->Button(-text => "Bottom", -command => sub { $click_count +=1 })->pack(-side=> 'bottom');
#$mw->Button(-text => "Right", -command => sub { $click_count +=1 })->pack(-side=> 'right');
#$mw->Button(-text => "Left", -command => sub { $click_count +=1 })->pack(-side=> 'left');
#$mw->Button( -text => 'Show', -command => sub{ print $text_area ->get('1.0','end'), "\n"; })->pack( -side => 'bottom' );
#$mw->Button( -text => 'print to file', -command => sub{ $p_to_file = $text_area->get('1.0','end'), "\n"; print $p_to_file;})->pack( -side => 'bottom' );
# 
#MainLoop;

#########################################

#sub push_button {
#my $name = $ent -> get();
#$txt -> insert('end',"\n Then click count is $click_count !!! \n");
#}

#########################################

#-command => sub{ $entName->delete( 0, 'end'); $entName->insert( 'end', $default ); }

#########################################

#my $textarea = $mw -> Frame() ->pack();

#########################################

#http://stackoverflow.com/questions/3595369/how-can-i-get-the-text-in-the-perl-tk-text-widget

########################################
#my $scl = $mw -> Scale(-label=>"Age :", -orient=>'v', -digit=>1, -from=>10, -to=>50, -variable=>\$age, -tickinterval=>10);
