package MabddUser;
use DBI;
use strict;

my $driver   = "SQLite";
my $database = "mytest.db";
my $dsn      = "DBI:$driver:dbname=$database";
my $userid   = "";
my $password = "";
#my $dbh      = DBI->connect( $dsn, $userid, $password, { RaiseError => 1 } ) or die $DBI::errstr;
my $dbh      = DBI->connect( $dsn, { RaiseError => 1 } ) or die $DBI::errstr;

print "Opened database successfully\n";
#create table


    my $stmt = qq(CREATE TABLE IF NOT EXISTS 'USERS'
   (ID INT PRIMARY KEY     NOT NULL,
	         USERNAME           CHAR(300)    NOT NULL,
		       EMAIL            CHAR(300)     NOT NULL,
		             PASSWORD        CHAR(300) NOT NULL
			           ););

    my $rv = $dbh->do($stmt);
    if ( $rv < 0 ) {
        print $DBI::errstr;
    }
    else {
        print "Table created successfully\n";
    }
    $dbh->disconnect();


sub insert {
    my ( $USERNAME, $EMAIL, $PASSWORD ) = @_;
    my $stmt = qq(INSERT INTO USERS (USERNAME, EMAIL, PASSWORD)
		                VALUES ($USERNAME, $EMAIL, $PASSWORD););
    my $rv = $dbh->do($stmt) or die $DBI::errstr;
}

sub select {
    my $stmt = qq(SELECT id, username, email, password from USERS;);
    my $sth  = $dbh->prepare($stmt);
    my $rv   = $sth->execute() or die $DBI::errstr;

    if ( $rv < 0 ) {
        print $DBI::errstr;
    }

    while ( my @row = $sth->fetchrow_array() ) {
        print "ID = " . $row[0] . "\n";
        print "USERNAME = " . $row[1] . "\n";
        print "EMAIL = " . $row[2] . "\n";
        print "PASSWORD =  " . $row[3] . "\n\n";
    }
    print "Operation done successfully\n";
}

sub update {
    my ( $ID, $USERNAME, $EMAIL, $PASSWORD ) = @_;
    my $stmt =
qq(UPDATE USERS set USERNAME = $USERNAME, EMAIL = $EMAIL, PASSWORD = $PASSWORD  where ID=$ID;);
    my $rv = $dbh->do($stmt) or die $DBI::errstr;

    if ( $rv < 0 ) {
        print $DBI::errstr;
    }
    else {
        print "Total number of rows updated : $rv\n";
    }
    $stmt = qq(SELECT id, username, email, password from USERS;);
    my $sth = $dbh->prepare($stmt);
    $rv = $sth->execute() or die $DBI::errstr;

    if ( $rv < 0 ) {
        print $DBI::errstr;
    }

    while ( my @row = $sth->fetchrow_array() ) {
        print "ID = " . $row[0] . "\n";
        print "USERNAME = " . $row[1] . "\n";
        print "EMAIL = " . $row[2] . "\n";
        print "PASSWORD =  " . $row[3] . "\n\n";
    }
    print "Operation done successfully\n";
}

sub delete {
    my ($ID) = @_;
    my $stmt = qq(DELETE from USERS where ID =$ID;);
    my $rv   = $dbh->do($stmt) or die $DBI::errstr;

    if ( $rv < 0 ) {
        print $DBI::errstr;
    }
    else {
        print "Total number of rows deleted : $rv\n";
    }
}

1;
