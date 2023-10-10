package directory;
                use Cwd qw();
our $X = 666;
use File::Basename;
use Cwd;
my $dir = getcwd;
use Cwd 'abs_path';
my $abs_path = abs_path($file);



sub add_numbers {
	  my @num = @_;
	    my $total = 0;
	      $total += $_ for @num;
	        $total;
	}
sub hello {
	  my ($title, $path,$myname) = @_;
	  my $css = "";
	  my $js = "";

		      my $mypath = dirname(__FILE__);

		      #print "$mypath";
		      my $find = "./";
		      my $replace = "/";
		      $path =~ s/$find/$replace/;
		      warn "$mypath";
		      warn "$path";
		      warn "$abs_path";

		            my $filename = $abs_path . $path . '/index.html';
			    open my $fh, '<', $filename or die "Failed to open file: $filename"; 
			        
			    # You can then either read the file one line at a time...
			    chomp(my @fileArray = <$fh>); 
			    warn "@fileArray";
			    close $fh or warn "close failed: $!";

			    #eval {my $content = open(FH, '<', $filename) or die $!};
			    #if ($@) {
			    #		  warn "Oh no! [$@]\n for $filename\n"
			    #}
	  my $main = "@fileArray";
					            
	  my $header = "";
	  my $footer = "";
	  my $js = "";
	       warn ($title, $css,$header,$main,$footer,$js);
	       warn ($title, $css,$header,$main,$footer,$js);
	        return ($title, $css,$header,$main,$footer,$js);
	}

1;
