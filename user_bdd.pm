package MabddUser;
use DBI;
use strict;

my $driver   = "SQLite";
my $database = "myothertest.db";
my $dsn      = "DBI:$driver:dbname=$database";
my $userid   = "";
my $password = "";
#my $dbh      = DBI->connect( $dsn, $userid, $password, { RaiseError => 1 } ) or die $DBI::errstr;
my $dbh      = DBI->connect( $dsn, { RaiseError => 1 } ) or die $DBI::errstr;

print "Opened database successfully\n";
#create table


    my $stmt = qq(CREATE TABLE IF NOT EXISTS 'USERS'
   (ID INTEGER PRIMARY KEY autoincrement,
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
	my $dbh      = DBI->connect( $dsn,$userid,$password, { RaiseError => 1 } ) or die $DBI::errstr;

warn "Opened database successfully\n";

    my $stmt = qq(INSERT INTO 'USERS' (USERNAME, EMAIL, PASSWORD)
		                VALUES ($USERNAME, $EMAIL, $PASSWORD););
				warn $stmt;
    my $rv = $dbh->do($stmt) or warn $DBI::errstr;
    warn $rv;
    $dbh->disconnect();
}

sub find_by_username_pw {
    my ( $USERNAME, $PASSWORD ) = @_;
    my $stmt = qq(SELECT username, password from USERS where username = '$USERNAME' and password = '$PASSWORD';);
    my $sth  = $dbh->prepare($stmt);
    my $rv   = $sth->execute() or die $DBI::errstr;

    if ( $rv < 0 ) {
        print $DBI::errstr;
    }
    my $nb_user=0;

    while ( my @row = $sth->fetchrow_array() ) {
        warn "ID = " . $row[0] . "\n";
        warn "USERNAME = " . $row[1] . "\n";
        warn "EMAIL = " . $row[2] . "\n";
        warn "PASSWORD =  " . $row[3] . "\n\n";
	$nb_user = $nb_user + 1;

    }
    return $nb_user;
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
