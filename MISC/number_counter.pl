#/usr/bin/perl

#Simple Number Counter
my $x = 1;
while ($x) {
print $x . "\n";
$x += 1;
if ($x == 11) { last;}
}
print "That's all the numbers we got Captain! \n";