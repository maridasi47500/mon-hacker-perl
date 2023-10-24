package MabddScript;
use DBI;
use strict;

my $driver   = "SQLite";
my $database = "myothertest.db";
my $dsn      = "DBI:$driver:dbname=$database";
my $scriptid   = "";
my $password = "";
#my $dbh      = DBI->connect( $dsn, $scriptid, $password, { RaiseError => 1 } ) or die $DBI::errstr;
my $dbh      = DBI->connect( $dsn, { RaiseError => 1 } ) or die $DBI::errstr;

print "Opened database successfully\n";
#create table


    my $stmt = qq(CREATE TABLE IF NOT EXISTS 'SCRIPTS'
   (ID INTEGER PRIMARY KEY autoincrement,
	         SCRIPTNAME           CHAR(300)  UNIQUE  NOT NULL,
		       CONTENT            CHAR(300)   UNIQUE  NOT NULL,
		             RESULT        CHAR(300) NOT NULL
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
    my ( $SCRIPTNAME, $CONTENT, $RESULT ) = @_;
	my $dbh      = DBI->connect( $dsn,$scriptid,$password, { RaiseError => 1 } ) or die $DBI::errstr;

warn "Opened database successfully\n";

    my $stmt = qq(INSERT INTO 'SCRIPTS' (SCRIPTNAME, CONTENT, RESULT)
		                VALUES ($SCRIPTNAME, $CONTENT, $RESULT););
				warn $stmt;
    my $rv = $dbh->do($stmt) or warn $DBI::errstr;
    warn $rv;
    $dbh->disconnect();
}

sub find_by_scriptname_pw {
    my ( $SCRIPTNAME, $RESULT ) = @_;
    my $stmt = qq(SELECT scriptname, password from SCRIPTS where scriptname = '$SCRIPTNAME' and password = '$RESULT';);
    my $sth  = $dbh->prepare($stmt);
    my $rv   = $sth->execute() or die $DBI::errstr;

    if ( $rv < 0 ) {
        print $DBI::errstr;
    }
    my $nb_script=0;

    while ( my @row = $sth->fetchrow_array() ) {
        warn "ID = " . $row[0] . "\n";
        warn "SCRIPTNAME = " . $row[1] . "\n";
        warn "CONTENT = " . $row[2] . "\n";
        warn "RESULT =  " . $row[3] . "\n\n";
	$nb_script = $nb_script + 1;

    }
    return $nb_script;
}
sub select {
    my $stmt = qq(SELECT id, scriptname, content, result from SCRIPTS;);
    my $sth  = $dbh->prepare($stmt);
    my $rv   = $sth->execute() or die $DBI::errstr;

    if ( $rv < 0 ) {
        print $DBI::errstr;
    }

    while ( my @row = $sth->fetchrow_array() ) {
        print "ID = " . $row[0] . "\n";
        print "SCRIPTNAME = " . $row[1] . "\n";
        print "CONTENT = " . $row[2] . "\n";
        print "RESULT =  " . $row[3] . "\n\n";
    }
    print "Operation done successfully\n";
}

sub update {
    my ( $ID, $SCRIPTNAME, $CONTENT, $RESULT ) = @_;
    my $stmt =
qq(UPDATE SCRIPTS set SCRIPTNAME = $SCRIPTNAME, CONTENT = $CONTENT, RESULT = $RESULT  where ID=$ID;);
    my $rv = $dbh->do($stmt) or die $DBI::errstr;

    if ( $rv < 0 ) {
        print $DBI::errstr;
    }
    else {
        print "Total number of rows updated : $rv\n";
    }
    $stmt = qq(SELECT id, scriptname, content, result from SCRIPTS;);
    my $sth = $dbh->prepare($stmt);
    $rv = $sth->execute() or die $DBI::errstr;

    if ( $rv < 0 ) {
        print $DBI::errstr;
    }

    while ( my @row = $sth->fetchrow_array() ) {
        print "ID = " . $row[0] . "\n";
        print "SCRIPTNAME = " . $row[1] . "\n";
        print "CONTENT = " . $row[2] . "\n";
        print "RESULT =  " . $row[3] . "\n\n";
    }
    print "Operation done successfully\n";
}

sub delete {
    my ($ID) = @_;
    my $stmt = qq(DELETE from SCRIPTS where ID =$ID;);
    my $rv   = $dbh->do($stmt) or die $DBI::errstr;

    if ( $rv < 0 ) {
        print $DBI::errstr;
    }
    else {
        print "Total number of rows deleted : $rv\n";
    }
}

1;
