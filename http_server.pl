
#!/usr/bin/perl
{

    package MyWebServer;

    use HTTP::Server::Simple::CGI;
    use CGI;
    use CGI::Carp qw(fatalsToBrowser);
    use CGI::Session;

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
    use URI::Query;
    use Data::Dumper;
    use warnings;
    use diagnostics;
    my $session = CGI::Session->new() or die CGI::Session->errstr;
    $CGISESSID = $session->id();
    #use vars qw/ VERSION /;
    $VERSION = '1.0';

    my %dispatch = (
        '/users/log_in'  => \&resp_login,
        '/users/sign_up' => \&resp_signup,
        '/hello'         => \&resp_hello,
        '/home'         => \&resp_home,
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
	my $current_username = $session->param('username');
        warn "this is my func $current_username";
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



        my $red= $code =~ m/Location/;
	if ($red eq 1){
		warn "c'est 1 redirection";
	}
	if (!$code){
		warn "il y a du code??";
            print "HTTP/1.0 404 Not found\r\n";
            print $cgi->header,
              $cgi->start_html('Page Not found'. $path),
              $cgi->h1('Page Not found' . $path),
              $cgi->end_html;
	      return;

	}
	elsif ( $red eq 1 or $code =~ m/Location/ ) {
	    my $url="http://localhost:8080/";

            print "HTTP/1.0 301 Redirect\r\n";
		print "Status: 301 Redirect\r\n";
		print $code;
		print "Content-Type: text/html;charset=utf-8\r\n";
		print $session->header();
                print "\r\n";
		print "Moved permanently to <a href=\"$url\">{url}</a>";
		

    } elsif ( $refhandler eq "CODE" ) {
            warn "$refhandler eq CODE";
            warn "code : $refhandler eq CODE";
            print "HTTP/1.0 200 OK\r\n";
            print "Content-Type: text/html;charset=utf-8\r\n";
	    print $session->header();
            print "\r\n";
            print $code;
        } else {
            warn "$refhandler eq CODE";
            print "HTTP/1.0 404 Not found\r\n";
	    print $session->header();
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
          directory::hello( "perl scripting for security", "./welcome", "page.html" );
	  #warn "$title, $css,$header,$main,$footer,$js HELLO";
        my $x = render_figure( $title, $css, $header, $main, $footer, $js );
	#warn "my x $x";
        return $x;
    }

    sub resp_home {
        my $cgi = shift;    # CGI.pm object
        return if !ref $cgi;

        my $who           = $cgi->param('signup');

        my ( $title, $css, $header, $main, $footer, $js ) = directory::home( "perl scripting for security", "./home", "index.html" );
        my $x = render_figure( $title, $css, $header, $main, $footer, $js );
        return "$x";
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
        my ( $title, $css, $header, $main, $footer, $js ) = directory::hello( "perl scripting for security", "./welcome", "index.html" );
	#warn "$title, $css,$header,$main,$footer,$js HELLO";
        my $x = render_figure( $title, $css, $header, $main, $footer, $js );
	#warn "my x $x";
        return "$x";
    }

    sub resp_login {
        my $cgi = shift;    # CGI.pm object
        return if !ref $cgi;

        my $data           = $cgi->param('POSTDATA');
        my $name           = $data['username'];
        my $pw             = $data['password'];
        my $pwconfirmation = $data['password_confirmation'];
        my $email          = $data['email'];
        my $otherwho       = directory::add_numbers( 1, 2 ), "\n";
        my $otherotherwho  = $Example::X;

        my ($hash) = directory::login( $name, $pw );
        return $hash;
    }

    sub resp_signup {
        my $cgi = shift;    # CGI.pm object
        return if !ref $cgi;
	my $data= $cgi->query_string("username");
	my $q = URI::Query->new($data); 
	my %hash = $q->hash;
	warn Dumper( \%hash );
	my $var= %hash{username};


        my $name           = '"' . %hash{'username'} . '"';
        my $pw             = '"' . %hash{'password'} . '"';
        my $pwconfirmation = '"' . %hash{'password_confirmation'} . '"';
        my $email          = '"' . %hash{'email'} . '"';
        my $otherwho       = directory::add_numbers( 1, 2 ), "\n";
        my $otherotherwho  = $Example::X;

        my ($hash) = directory::signup( $email, $name, $pw, $pwconfirmation );
	if ($hash =~ /success=signup/){
	my $username = $cgi->param('username');
	warn "my username value";
	warn $username;
	$session->param('username', $hash{'username'});
	warn "my username value zert";
	warn $session->param('username');
}


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

