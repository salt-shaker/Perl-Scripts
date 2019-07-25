#usr/bin/perl
use warnings;
use POSIX;
 
# Script is used to make a simple HTML pages for low to medium sized images and webm videos
# would not suggest for anything other than local use because the lack of security
 
# Reads all files in current directory
my @files = glob("*");
my $fcount = 0;
my $file_name_count = 1;
my $page_size = 10; #sets the number of items per page
my $file_name = "index.".$file_name_count.".html";
 
# Determine the number of pages
my $rec_count = scalar @files;
my $page_count = ceil($rec_count/$page_size);
my @menu_bar_count = 1..$page_count;
 
 
# Opens a new file, or opens existing file to be appended to, then selects that file
open (my $outfile,">",$file_name) or die $!;
select $outfile;
 
# Setting values for Extensions to filter
my $webm_find = ".webm";
my $gif_find = ".gif";
my $jpg_find = ".jpg";
my $jpeg_find = ".jpeg";
 
# Prints first part of basic html layout
print "<html>\n<body>\n<table>\n<tr>\n";
my $lcount = 0;
 
# Constructs rows and columns for HTML table
foreach (@files) {
 
# Creates a new HTML file based on page limit
if ($fcount == $page_size){
$fcount = 0;
$file_name_count ++;
print "</tr>\n</table>\n";
&make_link_bar;
print "</body>\n</html>";
close $outfile;
$file_name = "index.".$file_name_count.".html";
open (my $outfile,">",$file_name) or die $!;
select $outfile;
print "<html>\n<body>\n<table>\n<tr>\n";
}
 
# Resets Table Row
if ($lcount == 2) {
print "</tr>\n<tr>\n";
$lcount = 0;
}
# Right Side of HTML table
if ($lcount == 0) {
print "<td>\n";
# Searches for .webm files
if ($_ =~ m/$webm_find/) {
print "<video id=\"_\" src=\"$_\" autoplay loop></video><br>\n";
}
# Searches for .gif files
if ($_ =~ m/$gif_find/) {
print "<img src=\"$_\"><br>\n";
}
# Searches for .jpg files
if ($_ =~ m/$jpg_find/) {
print "<img src=\"$_\"><br>\n";
}
# Searches for .jpeg files
if ($_ =~ m/$jpeg_find/) {
print "<img src=\"$_\"><br>\n";
}
}
 
# Left Side of HTML table
if ($lcount == 1) {
print "<td>\n";
# Searches for .webm files
if ($_ =~ m/$webm_find/) {
print "<video id=\"$_\" src=\"$_\" autoplay loop></video><br>\n";
}
# Searches for .gif files
if ($_ =~ m/$gif_find/) {
print "<img src=\"$_\"><br>\n";
}
# Searches for .jpg files
if ($_ =~ m/$jpg_find/) {
print "<img src=\"$_\"><br>\n";
}
# Searches for .jpeg files
if ($_ =~ m/$jpeg_find/) {
print "<img src=\"$_\"><br>\n";
}
}
# Closes Table Column
print "</td>\n";
$lcount ++;
$fcount ++;
}
# Closes out table and adds navbar to last page
print "</tr>\n</table>\n";
&make_link_bar;
print "</body>\n</html>";
close $outfile;

# Navbar Creation Sub Routine
sub make_link_bar{
my $number_of_links = $page_count;
print "<table><tr>";
foreach(@menu_bar_count){
my $link_name = "index.".$_.".html";
print "<td>\n<a href=\"$link_name\">$_</a>\n</td>\n";
}
print "</tr></table>";
}
