#!/usr/bin/perl
use warnings;

## Variables ##
my $counter = 0;
my $switch = 0;
my $curinf = 1;
my $defcon = "Copyright";
my $file_save = "email_parser_data.xml";
my @starray;
my @temp;
my $skipcount = 0;
 
open (my $outfile,"<",$defcon) or die;
@temp = <$outfile>;

push @starray, "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
push @starray, "<Copright_Infringement>\n";



#################
## Main Filter ##
#################

foreach(@temp){

if($_ =~ m/- - ---End ACNS XML/g){
$switch = 0;
$curinf++;
}

if($switch == 1){
if( $_ !~ m/\<\?xml version="1.0" encoding="UTF-8"\?\>/){
if( $_ !~ m/\<\?xml version=3D"1.0" encoding=3D"UTF-8"\?\>/){
if( $_ =~ m/Infringement xmlns=3D/){
$skipcount = 3;
}
if( $_ =~ m/\<\/F.*=/){
$_ =~ s/\<\/F.*=/\<\/FileName\>/;
$skipcount = 2;
push @starray, $_;
}

$_ =~ s/\<Infringement.*/\<Infringement_$curinf\>/gi;
$_ =~ s/\<\/Infringement.*\>/\<\/Infringement_$curinf\>/gi;

if($skipcount == 0){push @starray, $_;}
if($skipcount == 3){push @starray, $_;}
if($skipcount != 0){$skipcount--};
}
}
}

if($_ =~ m/- - ---Start ACNS XML/g){
$switch = 1;
}

}
push @starray, "</Copright_Infringement>";
close $outfile;

@temp = @starray;

#################
## Post Filter ##
#################
foreach(@temp){

if( $_ =~ m/<=/g){
$starray[$counter] =~ s/<=/<\/FileName>/;
my $temp = $counter + 1;
splice(@starray, $temp, 1);
}
$counter++
}

open ($outfile,">",$file_save) or die;
foreach(@starray){
print $outfile $_;
}
close $outfile;
