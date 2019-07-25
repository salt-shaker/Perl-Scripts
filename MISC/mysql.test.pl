#!/usr/bin/perl

#############
## Modules ##
#############
use warnings;
#use strict;
#use Tk::Dialog; ## Part of Perl/TK Gui -no being used
#use Tk; ## Part of Perl/TK Gui -no being used
use DBI;
use POSIX "strftime";

##############################
## Database Connection Info ##
##############################
$db ="Database_name"; ## mysql user database name
$user = "Database_user"; ## mysql database user name
$pass = "Database_password"; ## mysql database password
$host= "localhost"; ## user hostname : This should be "localhost" but it can be diffrent too

#########################
## Connect to Database ##
#########################
$dbh = DBI->connect("DBI:mysql:$db:$host", $user, $pass);

#############################
## Select Data in Database ##
#############################
$sth = $dbh->prepare("SELECT * FROM Table_Name;"); ### Prepare the SQL statement ( assuming $dbh exists )
$sth->execute(); ### Execute the SQL statement and generate a result set

################################################################
### Fetch each row of result data from the database as a list ##
################################################################
while ( ( $id, $incedent_num, $name ) = $sth->fetchrow_array ) {
print "Megalithic site $id is a $incedent_num\n and the of course some $name\n";
}

######################################################################
# Fetch each row of result data from the database as a scalar value ##
######################################################################
#while ( @row = $sth->fetchrow_array ) {
#print "Megalith site $row[1] is a $row[11]\n";
#}

##############################
## Update a Database Record ##
##############################
#my $sql_insert2 = "UPDATE Table_Name SET phone='831-967-2780' WHERE id='3'";
#my $sth_insert2 = $dbh->prepare($sql_insert2);   
#$sth_insert2->execute();    

########################
## Prepare Time Stamp ##
########################
#$test = strftime('%Y-%m-%d %H:%M:%S',localtime);
#print "$test \n";
#

#######################################
## Submit a new record into database ##
#######################################
#my $sql_insert = qq/INSERT INTO Table_Name
#(id,incedent_num,name,acct_num,email,phone,address,contact_type,contact_date,issue,notes) 
#values (null,1,'sashae',34521,"some.email\@gmail.com",'831-444-4545','245 elm street,apt 220,monterey,ca,93940','phone',
#'$test','Internet Connectivty','this is just some notes');/; # the query to execute
#my $sth_insert = $dbh->prepare($sql_insert); # prepare the query
#$sth_insert->execute(); # execute the query

###############################
## Close Database Connection ##
###############################
$sth->finish;
exit(0);

#####################
## Useful Commands ##
#####################

#ALTER TABLE Table_Name ADD last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
#select * from Table_Name where id=19;
#select phone from Table_Name where id=19;
#UPDATE Table_Name SET phone='831-975-5580' WHERE id='19';
#ALTER TABLE Table_Name ADD last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP

#+--------------+---------------+------+-----+-------------------+-----------------------------+
#| Field        | Type          | Null | Key | Default           | Extra                       |
#+--------------+---------------+------+-----+-------------------+-----------------------------+
#| id           | int(11)       | NO   | PRI | NULL              | auto_increment              |
#| incedent_num | smallint(6)   | YES  |     | NULL              |                             |
#| name         | varchar(35)   | YES  |     | NULL              |                             |
#| acct_num     | smallint(6)   | YES  |     | NULL              |                             |
#| email        | varchar(35)   | YES  |     | NULL              |                             |
#| phone        | varchar(12)   | YES  |     | NULL              |                             |
#| address      | varchar(100)  | YES  |     | NULL              |                             |
#| contact_type | varchar(20)   | YES  |     | NULL              |                             |
#| contact_date | datetime      | YES  |     | NULL              |                             |
#| issue        | varchar(30)   | YES  |     | NULL              |                             |
#| notes        | varchar(2000) | YES  |     | NULL              |                             |
#| last_updated | timestamp     | NO   |     | CURRENT_TIMESTAMP | on update CURRENT_TIMESTAMP |
#+--------------+---------------+------+-----+-------------------+-----------------------------+
#12 rows in set (0.00 sec)
