
#!/usr/bin/perl
{

    package MyWebServer;

    use HTTP::Server::Simple::CGI;
    use base qw(HTTP::Server::Simple::CGI);
	        require './directory.pm';
	        require './render.pm';
	        require './Example.pm';
		use Cwd qw();
		use Cwd;
		my $dir = getcwd;
		use Cwd 'abs_path';
		my $abs_path = abs_path($file);



    my %dispatch = (
        '/hello' => \&resp_hello,

        # ...
    );
    sub render_figure {
	    my $myarg=@_;
	    warn "$myarg my arg @_";
	    my ( $title, $css, $header, $main,$footer,$js ) = @_;
	    warn ( $title, $css, $header, $main,$footer,$js );

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
		  my $xx=$document;
		  warn $xx . "hahaha";
		  my $a=replace_render_figure("<%=title","$title",$document);
		  my $b=replace_render_figure("<%=css","$css",$a);
		  my $c=replace_render_figure("<%=header","$header",$b);
		  my $d=replace_render_figure("<%=main","$main",$c);
		  my $e=replace_render_figure("<%=footer","$footer",$d);
		  my $f=replace_render_figure("<%=js","$js",$e);
      warn "$document- my string";
      return $f;
    }
       sub replace_render_figure {
	             my ($from,$to,$string) = @_;
		           $string =~s/$from/$to/ig;                          #case-insensitive/global (all occurrences)
			   return $string;

				    }


    sub handle_request {
        my $self = shift;
        my $cgi  = shift;

        my $path    = $cgi->path_info();
        my $handler = $dispatch{$path};
	warn "Tu es daccord daccord $handler";
	my $refhandler=ref($handler);
	#warn "$handler : handler";
	my $code=$handler->($cgi);
	warn "code : $code ---$refhandler";

        if ( ref($handler) eq "CODE" ) {
            print "HTTP/1.0 200 OK\r\n";
            print "Content-Type: text/html\r\n";
            print "\r\n";
            print $code;

        }
        else {
            print "HTTP/1.0 404 Not found\r\n";
            print $cgi->header,
              $cgi->start_html('Not found'),
              $cgi->h1('Not found'),
              $cgi->end_html;
        }
    }

    sub resp_hello {
        my $cgi = shift;    # CGI.pm object
        return if !ref $cgi;

        my $who = $cgi->param('name');
        my $otherwho = directory::add_numbers(1,2),"\n";
        my $otherotherwho = $Example::X;

	#print $cgi->header,
        #  $cgi->start_html("Hello"),
        #  $cgi->h1("Hello $who! 1+2= $otherwho! X= $otherotherwho"),
        #  $cgi->end_html;
	my ($title, $css,$header,$main,$footer,$js)=directory::hello("mytitle","./welcome","index.html");
	warn "$title, $css,$header,$main,$footer,$js HELLO";
	my $x= render_figure($title, $css,$header,$main,$footer,$js);
	warn "my x $x";
	return $x;
    }

}

# start the server on port 8080
my $pid = MyWebServer->new(8080)->background();
# Opening file Hello.txt in write mode
 open (fh, ">", "hello.sh");
   
   # Getting the string to be written
   # to the file from the user
   $a = "kill $pid; perl http_server.pl;";
     
     # Writing to the file
     print fh $a;
       
       # Closing the file
       close(fh) or "Couldn't close the file"; 
print "Use 'kill $pid' to stop server.\n ou pour relancer le serveur faire 'sh ./hello.sh'\n";
