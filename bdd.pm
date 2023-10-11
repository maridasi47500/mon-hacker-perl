package Mabdd;
use DBI;
use strict;

my $driver   = "SQLite"; 
my $database = "test.db";
my $dsn = "DBI:$driver:dbname=$database";
my $userid = "";
my $password = "";
my $dbh = DBI->connect($dsn, $userid, $password, { RaiseError => 1 }) 
   or die $DBI::errstr;

print "Opened database successfully\n";
sub create_table{

my $stmt = qq(CREATE TABLE POSTS
   (ID INT PRIMARY KEY     NOT NULL,
	         TITLE           VARCHAR(300)    NOT NULL,
		       CONTENT            TEXT     NOT NULL,
		             IMAGE        CHAR(300),
			           ););

		   my $rv = $dbh->do($stmt);
		   if($rv < 0) {
			      print $DBI::errstr;
		      } else {
			         print "Table created successfully\n";
			 }
			 $dbh->disconnect();

		 }
		 sub insert {
			 my {$TITLE, $CONTENT, $IMAGE} = @_;
		 my $stmt = qq(INSERT INTO POSTS (TITLE, CONTENT, IMAGE)
		                VALUES ($TITLE, $CONTENT, $IMAGE););
			my $rv = $dbh->do($stmt) or die $DBI::errstr;
		}
		sub select {
			my $stmt = qq(SELECT id, title, content, image from POSTS;);
			my $sth = $dbh->prepare( $stmt );
			my $rv = $sth->execute() or die $DBI::errstr;

			if($rv < 0) {
				   print $DBI::errstr;
			   }

			   while(my @row = $sth->fetchrow_array()) {
				         print "ID = ". $row[0] . "\n";
					       print "TITLE = ". $row[1] ."\n";
					             print "CONTENT = ". $row[2] ."\n";
						           print "IMAGE =  ". $row[3] ."\n\n";
						   }
						   print "Operation done successfully\n";
		}
		sub update {
			 my {$ID, $TITLE, $CONTENT, $IMAGE} = @_;
			my $stmt = qq(UPDATE POSTS set TITLE = $TITLE, CONTENT = $CONTENT, IMAGE = $IMAGE  where ID=$ID;);
			my $rv = $dbh->do($stmt) or die $DBI::errstr;

			if( $rv < 0 ) {
				   print $DBI::errstr;
			   } else {
				      print "Total number of rows updated : $rv\n";
			      }
			      $stmt = qq(SELECT id, title, content, image from POSTS;);
			      my $sth = $dbh->prepare( $stmt );
			      $rv = $sth->execute() or die $DBI::errstr;

			      if($rv < 0) {
				         print $DBI::errstr;
				 }

				 while(my @row = $sth->fetchrow_array()) {
					       print "ID = ". $row[0] . "\n";
					             print "TITLE = ". $row[1] ."\n";
						           print "CONTENT = ". $row[2] ."\n";
							         print "IMAGE =  ". $row[3] ."\n\n";
							 }
							 print "Operation done successfully\n";
		}
		sub delete {
			 my {$ID} = @_;
			my $stmt = qq(DELETE from POSTS where ID =$ID;);
			my $rv = $dbh->do($stmt) or die $DBI::errstr;

			if( $rv < 0 ) {
				   print $DBI::errstr;
			   } else {
				      print "Total number of rows deleted : $rv\n";
			      }
		}


1;
