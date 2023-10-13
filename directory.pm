package directory;
                use Cwd qw();
our $X = 666;
use File::Basename;
use Cwd;
my $dir = getcwd;
use Cwd 'abs_path';
my $abs_path = abs_path($file);
require './bdd.pm';
require './user_bdd.pm';



sub add_numbers {
	  my @num = @_;
	    my $total = 0;
	      $total += $_ for @num;
	        $total;
	}
sub signup {
	my %color_of;
	my $fruit = "redirect";
	my ($email,$username, $pw,$pwconfirmation) = @_;
	if ($pw eq $pwconfirmation){
		MabddUser::insert($email,$username, $pw);
		warn "my new user ";

	$color_of{$fruit} = "http://localhost:8080/home?success=signup";
           }else{
	$color_of{$fruit} = "http://localhost:8080/users/sign_up?error=password";
	   }
	   my $red=redirect($color_of{$fruit});
	   return "$red";
	    
	}
	sub redirect {
	my ($url) = @_;
	return "Location: $url\r\n";

	}
sub login {
	my ($username, $pw) = @_;
	my %color_of;
	my $fruit = "redirect";
		my $users=MabddUser::find_by_username_pw($username, $pw);
		if ($myusers eq 1){
	$color_of{$fruit} = "http://localhost:8080/home?success=login";
} else {
	$color_of{$fruit} = "http://localhost:8080/users/sign_in?error=userdontexist";
}
	   my $red=redirect($color_of{$fruit});
	   return "$red";
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

		            my $filename = $abs_path . $path . '/' . $myname;
			    open my $fh, '<', $filename or die "Failed to open file: $filename"; 
			        
			    # You can then either read the file one line at a time...
			    chomp(my @fileArray = <$fh>); 
			    #warn "@fileArray";
			    close $fh or warn "close failed: $!";

			    #eval {my $content = open(FH, '<', $filename) or die $!};
			    #if ($@) {
			    #		  warn "Oh no! [$@]\n for $filename\n"
			    #}
	  my $main = "@fileArray";
					            
	  my $header = "";
	  my $footer = "";
	  my $js = "";
	  #warn ($title, $css,$header,$main,$footer,$js);
	  #warn ($title, $css,$header,$main,$footer,$js);
	        return ($title, $css,$header,$main,$footer,$js);
	}

1;
