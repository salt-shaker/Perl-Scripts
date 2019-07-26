#usr/bin/perl
use warnings;

# This script takes all the images and videos of a matching type and puts them into a single HTML document for viewing
# Not the best way to make a web page but it works

#Reads all files in current directory
my @files = glob("*");

#opens a new file, or opens existing file to be appended to, the selects that file
open (my $outfile,">index.html") or die $!;
select $outfile;

#setting values for Extenstions to filter
my $webm_find = ".webm";
my $gif_find = ".gif";
my $jpg_find = ".jpg";
my $jpeg_find = ".jpeg";

#Prints first part of basic html layout
print "<html>\n<body>\n<table>\n<tr>\n";
my $lcount = 0;
#Runs the following for each file name found in current directory
foreach my $file (@files) {
if ($lcount == 2) {
print "</tr>\n<tr>\n";
$lcount = 0;
}
if ($lcount == 0) {
print "<td align=\"right\">\n";
#searches for .webm files
if ($file =~ m/$webm_find/) {
print "<video id=\"$file\" src=\"$file\" autoplay loop></video><br>\n";
}
#searches for .gif files
if ($file =~ m/$gif_find/) {
print "<img src=\"$file\"><br>\n";
}
#searches for .jpg files
if ($file =~ m/$jpg_find/) {
print "<img src=\"$file\"><br>\n";
}
#searches for .jpeg files
if ($file =~ m/$jpeg_find/) {
print "<img src=\"$file\"><br>\n";
}
}
if ($lcount == 1) {
print "<td align=\"left\">\n";
#searches for .webm files
if ($file =~ m/$webm_find/) {
print "<video id=\"$file\" src=\"$file\" autoplay loop></video><br>\n";
}
#searches for .gif files
if ($file =~ m/$gif_find/) {
print "<img src=\"$file\"><br>\n";
}
#searches for .jpg files
if ($file =~ m/$jpg_find/) {
print "<img src=\"$file\"><br>\n";
}
#searches for .jpeg files
if ($file =~ m/$jpeg_find/) {
print "<img src=\"$file\"><br>\n";
}
}
print "</td>\n";
$lcount ++;
}
print "</tr>\n</table>\n</body>\n</html>";
close $outfile;