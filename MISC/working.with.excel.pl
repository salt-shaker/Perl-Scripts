#!/usr/bin/perl

###########
# Modules #
###########
use warnings;
use strict;
use Spreadsheet::ParseXLSX;
use Excel::Writer::XLSX;

# Open file to be read
my $parser = Spreadsheet::ParseXLSX->new();
my $workbook = $parser->parse('test.xlsx');

# Create new file
my $workbook_out = Excel::Writer::XLSX->new('test.out.xlsx');
	
# Add a worksheet to new file
my $worksheet_out = $workbook_out->add_worksheet();
	
# Check to make sure input file is defined
if (!defined $workbook){ die $parser->error(), ".\n"; }

for my $worksheet($workbook->worksheet(0)){

# Get row and column count from input file
my ( $row_min, $row_max ) = $worksheet->row_range();
my ( $col_min, $col_max ) = $worksheet->col_range();

# Start control loop
for my $row( $row_min .. $row_max ){
for my $col( $col_min .. $col_max ){

my $cell = $worksheet->get_cell( $row, $col ); # Get current cell value
next unless $cell; # Move to next loop element unless $cell is defined

my $read_cell_value = $cell->value();
#$read_cell_value =~ s///g; # Find and replace patterns
#$read_cell_value =~ s/\W//g; # Remove everything except alphanumeric characters and underscores
$read_cell_value =~ s/[#\%&\*+()]//g; # Removing select special charecters

$worksheet_out->write( $row, $col, $read_cell_value); # write value to new file
}
}
}
	print "\nDone\n";
