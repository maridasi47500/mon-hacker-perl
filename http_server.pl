
#!/usr/bin/perl
{

    package MyWebServer;

    use HTTP::Server::Simple::CGI;
    use base qw(HTTP::Server::Simple::CGI);
    require './directory.pm';
    require './Example.pm';
    require './bdd.pm';
    use Cwd qw();
    use Cwd;
    my $dir = getcwd;
    use Cwd 'abs_path';
    my $abs_path = abs_path($file);
    use Encode;
    use utf8;
    use DBI;

    #use vars qw/ VERSION /;
    $VERSION = '1.0';

    my %dispatch = (
        '/users/log_in'  => \&resp_login,
        '/users/sign_up' => \&resp_signup,
        '/hello'         => \&resp_hello,
        '/'              => \&resp_welcome,

        # ...
    );

    sub render_figure {
        my $myarg = @_;
	#warn "$myarg my arg @_";
        my ( $title, $css, $header, $main, $footer, $js ) = @_;
	#warn( $title, $css, $header, $main, $footer, $js );

        my $filename = $abs_path . '/index.html';
        warn "$filename";

#                            open my $fh, '<', $filename or die "Failed to open file: $filename";

#  			                              # You can then either read the file one line at a time...
#  						                                   chomp(my @content = <$fh>);
#  						                                                               warn "@content";
#  						                                                                                           close $fh or warn "close failed: $!";
#
#
        my $document = do {
            local $/ = undef;
            open my $fh, "<", $filename
              or die "could not open $filename: $!";
            <$fh>;
        };
        my $xx = $document;
	#warn $xx . "hahaha";
        my $a = replace_render_figure( "<%=title",  "$title",  $document );
        my $b = replace_render_figure( "<%=css",    "$css",    $a );
        my $c = replace_render_figure( "<%=header", "$header", $b );
        my $d = replace_render_figure( "<%=main",   "$main",   $c );
        my $e = replace_render_figure( "<%=footer", "$footer", $d );
        my $f = replace_render_figure( "<%=js",     "$js",     $e );
	#warn "$document- my string";
        my @words = split /<%=/, $f;

        my $bump       = myfunc;
        my @otherwords = map { &$bump($_) } @words;

        my @joinwords = join '', @otherwords;

        #warn "@joinwords join words";
        return "@joinwords";
    }

    sub myfunc {
        warn "this is my func";
        my ($str) = @_;

        #warn "It is my string : $str";
        my $z = index( $str, "%>" );

        #warn "value of z : $z";
        my $mytest = $z eq -1;

        #warn "%> is not in string : $mytest";
        my $myothertest = $mytest eq 1;

        #warn "my test eq 1 : $myothertest";
        if ( $mytest eq 1 ) {
            return $str;
        }
        else {
            my $y           = $z;
            my $w           = $z + 2;
            my $sub_string1 = substr( $str, 0, $y );

            #warn "this is my sub string $sub_string1";

            my $string2 = eval($sub_string1);
            warn "this is my string executing $string2";
            my $string3 = substr( $str, $w, -1 );
            warn "my string return" . $string2 . $string3;
            return $string2 . $string3;
        }
    }

    sub replace_render_figure {
        my ( $from, $to, $string ) = @_;
        $string =~ s/$from/$to/ig;    #case-insensitive/global (all occurrences)
        return $string;
    }

    sub handle_request {
        my $self = shift;
        my $cgi  = shift;

        my $path    = $cgi->path_info();
        my $handler = $dispatch{$path};
        warn "Tu es daccord daccord $handler";

        #warn "$handler : handler";
	#warn "my error;;; $handler";

        my $code = $handler->($cgi) or warn "oh non je peux pas recuperer le code " ;

        warn "$handler OK";
        my $refhandler = ref($handler);
        warn "code : $code ---$refhandler";

        if ( $refhandler eq "CODE" ) {
            warn "$refhandler eq CODE";
            warn "code : $refhandler eq CODE";
            print "HTTP/1.0 200 OK\r\n";
            print "Content-Type: text/html\r\n";
            print "\r\n";
            print $code;

        } elsif ( $refhandler eq "HASH" ) {
            warn "$refhandler eq CODE";
            print "HTTP/1.0 200 OK\r\n";
            print "\r\n";
            print $cgi->redirect( $handler["redirect"] );
        } else {
            warn "$refhandler eq CODE";
            print "HTTP/1.0 404 Not found\r\n";
            print $cgi->header,
              $cgi->start_html('Not found'),
              $cgi->h1('Not found'),
              $cgi->end_html;
        }
    }

    sub resp_welcome {
        my $cgi = shift;    # CGI.pm object
        return if !ref $cgi;

        my $who           = $cgi->param('name');
        my $otherwho      = directory::add_numbers( 1, 2 ), "\n";
        my $otherotherwho = $Example::X;

        my ( $title, $css, $header, $main, $footer, $js ) =
          directory::hello( "bienvenue", "./welcome", "page.html" );
	  #warn "$title, $css,$header,$main,$footer,$js HELLO";
        my $x = render_figure( $title, $css, $header, $main, $footer, $js );
	#warn "my x $x";
        return $x;
    }

    sub resp_hello {
        my $cgi = shift;    # CGI.pm object
        return if !ref $cgi;

        my $who           = $cgi->param('name');
        my $otherwho      = directory::add_numbers( 1, 2 ), "\n";
        my $otherotherwho = $Example::X;

        #print $cgi->header,
        #  $cgi->start_html("Hello"),
        #  $cgi->h1("Hello $who! 1+2= $otherwho! X= $otherotherwho"),
        #  $cgi->end_html;
        my ( $title, $css, $header, $main, $footer, $js ) = directory::hello( "mytitle", "./welcome", "index.html" );
	#warn "$title, $css,$header,$main,$footer,$js HELLO";
        my $x = render_figure( $title, $css, $header, $main, $footer, $js );
	#warn "my x $x";
        return "$x";
    }

    sub resp_login {
        my $cgi = shift;    # CGI.pm object
        return if !ref $cgi;

        my $name           = $cgi->param('username');
        my $pw             = $cgi->param('password');
        my $pwconfirmation = $cgi->param('password_confirmation');
        my $email          = $cgi->param('email');
        my $otherwho       = directory::add_numbers( 1, 2 ), "\n";
        my $otherotherwho  = $Example::X;

        my ($hash) = directory::login( $name, $pw );
        return $hash;
    }

    sub resp_signup {
        my $cgi = shift;    # CGI.pm object
        return if !ref $cgi;

        my $name           = $cgi->param('username');
        my $pw             = $cgi->param('password');
        my $pwconfirmation = $cgi->param('password_confirmation');
        my $email          = $cgi->param('email');
        my $otherwho       = directory::add_numbers( 1, 2 ), "\n";
        my $otherotherwho  = $Example::X;

        my ($hash) = directory::signup( $email, $name, $pw, $pwconfirmation );
        return $hash;
    }

}

# start the server on port 8080
my $pid = MyWebServer->new(8080)->background();

# Opening file Hello.txt in write mode
open( fh, ">", "hello.sh" );

# Getting the string to be written
# to the file from the user
$a = "kill $pid; perl http_server.pl;";

# Writing to the file
print fh $a;

# Closing the file
close(fh) or "Couldn't close the file";
print
"Use 'kill $pid' to stop server.\n ou pour relancer le serveur faire 'sh ./hello.sh'\n";

