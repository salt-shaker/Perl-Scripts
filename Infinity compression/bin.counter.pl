#/usr/bin/perl
my $number = 4294967295;
my $counter = 0;
my $counter2 = 0;
my $place_holder = $number;

while ($number > 255) {
print "\n$number\n";
if (0 == $number % 2) {
    $number = $number/2;
} else {
    $number ++;
    $counter2 ++;
    $number = $number/2;
#if we know that a number will only be added if even
}
$counter ++;
}
print "The number is: $number\n And the number of loops it took: $counter\n And the number of Odd numbers: $counter2\n";

my $counter3 = 1;

print "\n now to add the remainder. \n original number was: $place_holder \n new number is: $number \n And the remainder is: $counter3\n";

#$number = $number - $counter2;
my $number4 = $number;
foreach (1..$counter) {
#if ($counter3 <= 5) { $number4 = $number4 - 1}
$number4 = $number4 * 2;
print "\nthe new number is: $number4\n";
$counter3++
}

my $counter4 = $number4;

print "\nmaking the total: $counter4\n";


#64 bits to send 2 32bit frames is 1 to 2/3 ratio, which can take that and apply it again
#do that ten times and it wil reduce it to approximatly 5% of its original size
#using the good old fasioned try-fail-fix-try again meathod im sure an algorythem can be made to find the best solution
#for a particular type of application like streaming video, audio, radio
#encryption, compression, storage, or any other type of data tranmission
#levels can be determed by speed of decompilation vs compression
#
#
# 1 time = 75%
# 2 times = 56%
# 3 times = 42%
# 4 times = 31%
# 5 times = 23%
# 6 times = 17%
# 7 times = 13%
# 8 times = 10%
# 9 times = 7%
# 10 times = 5%
# 11 times = 4%
# 12 times = 3%
# 13 times = 2%
# 14 times = 1%
# 15 times = 1%
# 16 times = 1%
# 17 times = 0.7%
# 18 times = 0.5%
# 19 times = 0.4%
# 20 times = 0.3% - " level 20ic " - This would turn a 5gb file into a 15mb file. Bandwidth bottle neck issues would be a
#thing of the past. Streaming woulb be revalutionized. The main issue would be reconstruction time, caching, database avaiblilty,
# and other issues yet to be seen.

#The infiniti compression or ic

#The key file can be stored seperatly from the frames, alowing more data per packet. so 4 32 bit frames per 64 bits which would 
#double the data transfer rate. Especially useful for large files. 
#possible ratio being 1mb key file for per 1gb so 27 gb bluray file comes with 27 mb key file for level 10ic
#making the total file size about 1.5gb. Which is about the same size as compressed h264 file. But without the loss of quality.

#and where speed is not an issue level 20ic makes a 85mb file with a key file of 54mb
#its may be possible that anything higher than level 20ic may produce a way large key file than the actual data

# 1tb = 54gb @ level 10ic / Key file = 1gb
# 1tb = 3gb @ level 20ic  / Key file = 2gb

#amazing compression, but the computing power required might be phenominal
#this may be a litle ahead of its time... but it is still possible, even if only usable at level 5ic and below

#chances are these estimates will be off by up to %5 i think.


