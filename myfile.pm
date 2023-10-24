package myfile;
                use Cwd qw();
		our $X = 666;
		use File::Basename;
		use Cwd;
		my $dir = getcwd;
		use Cwd 'abs_path';
		my $abs_path = abs_path($file);
		my $abs_path_dir = abs_path($dir);
		sub lire{

			 my ($path,$myname) = @_;
			 my $mypath = dirname(__FILE__);

						                      my $find = "./";
						                                            my $replace = "/";
						                                                                  $path =~ s/$find/$replace/;
						                                                                                                                                    warn "$abs_path";
						
						                                                                                                                                                                my $filename = $abs_path_dir . $path . '/' . $myname;
						                                                                                                                                    warn "$filename";
						                                                                                                                                                                                            open my $fh, '<', $filename or die "Failed to open file: $filename";
						
						                                                                                                                                                                                                                        chomp(my @fileArray = <$fh>);
						                                                                                                                                                                                                                                                    close $fh or warn "close failed: $!";
																																				    return "@fileArray";
		}
		1;
