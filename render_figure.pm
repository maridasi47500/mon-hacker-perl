package Render_figure;
require './myfile.pm';
    my $css = "ok";
              my $title = "ok";

	                my $main = "ok";

							      my $header=myfile::lire("./home","header.html");
				            my $footer = "ok";
					              my $js = "ok ";
						      sub set_main{
							      my ($mytitle,$path,$myname) = @_;
							      warn($mytitle);
							      $title=$mytitle;
							      warn($title);
							      my $body=myfile::lire($path,$myname);
							      $main=$body;
							      warn ($title, $css,$header,$main,$footer,$js);
							      return ($title, $css,$header,$main,$footer,$js);


						      }
						      sub render{
							      return ($title, $css,$header,$main,$footer,$js);
						      }
1;
