#!/usr/bin/perl
use IO::Handle;

## Variables ##
my $xml_inrto = '<?xml version="1.0" encoding="UTF-8"?>';
my $entry_counter = 1;
my $doc_name;
my $entry = 'Entry_';
my @blocks =('Title','URL','Notes');
my $input = 'y';
my $b_input;
my $file;
my $fdoc_name;
my $s_loop = 'y';


#get user input
#file name
print "\nWhat is the name of your new Document? No white space allowed.\n";
chomp(my $doc_name = <>);
$doc_name =~ s/\s/_/g;
$doc_name = "$doc_name.xml";
fileopen();
print $file $xml_inrto . "\n";
print $file "<$fdoc_name>\n";


###############
## Main Loop ##
###############
while($input eq 'y'){
print $doc_name;
#New Entry (y or n)
print "\nDo you want to add a new entry? y or n.\n";
chomp($input = <>);
if ($input eq 'y') {
print $file "<$entry" . "$entry_counter>\n";
## Title ##
print "\nWhat is the Title? \n";
chomp($b_input = <>);
print $file "<@blocks[0]>$b_input</@blocks[0]>\n";
## URL ##
print "\nWhat is the URL? \n";
chomp($b_input = <>);
print $file "<@blocks[1]>$b_input</@blocks[1]>\n";
## Notes ##
print "\nDo you have any notes to add? \n";
chomp($b_input = <>);
print $file "<@blocks[2]>$b_input</@blocks[2]>\n";
print $file "</$entry" . "$entry_counter>\n";
$entry_counter ++;
clear_buffer();
} elsif ($input eq 'n') {
last;
} else {
print "\n** Invalid Selection. **\n";
$input = 'y';
}
}
print $file "</$fdoc_name>";
print "\n$doc_name now closed.\n";


# Open file
sub fileopen {
open ($file,">",$doc_name) or die "Could not open file '$doc_name' $!";
}

sub clear_buffer {
close $file;
open ($file,">>",$doc_name) or die "Could not open file '$doc_name' $!";
}

#<?xml version="1.0" encoding="UTF-8"?>
#<160728_Home_Theater_101>
#<Entry_1>
	#<Title></Tilte>
	#<URL></URL>
	#<Notes></Notes>
#</Entry_1>
