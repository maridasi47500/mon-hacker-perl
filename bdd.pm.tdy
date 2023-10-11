package Mabdd;                
use Encode;
                use utf8;
                use DBI;
                use vars qw/ VERSION /;
                $VERSION = '1.0';

		ActiverAccents();
		my $bd = 'France2023';
		my $serveur = 'localhost';
		my $id='root';
		my $pass = '';
		my $port = '';
		print "Connexion à la base de dooné $bd\n";
		my $dbh = DBI->connect("DBI:mysql:database=$bd;host=$serveur;port=$port",
			$id,
			$pass,{
				RaisseError => 1
			}
		) or die "Connexion imposible à la bd $bd!\n$! \n $@\n$DBI::errstr";
		print "Création de la table posts\n";
		my $sql_creation_posts= <<"SQL"
		CREATE TABLE posts (
			id INT NOT NULL,
			title VARCHAR(200),
			image VARCHAR(200),
			content VARCHAR(3000),
			PRIMARY KEY (id) ) COMMENT = 'la table posts';
		SQL
		$dbh->do('DROP TABLE IF EXISTS posts;') or die "impossible de supprimer la table posts\n\n";
		$dbh->do($sql_creation_posts) or die "impossible de creer la table posts\n\n";
		# Lecture des fichiers et insertion des données
		my $fichier_posts     = 'posts2023.txt';
		

		print "insertion des donees dans la table posts\n";
		open my $fh_posts,'<:encoding(UTF-8)',$fichier_posts or die "impossible de lire le fichier $fichier_posts\n";
		my $entete_fichier_posts = <$fh_posts>;
		# Insertion des données
		my $requete_sql_post = <<"SQL";
		  INSERT INTO posts ( id, title, content, image )
		    VALUES ( ?, ?, ?, ? );
		    SQL
		
		    my $sth_posts = $dbh->prepare($requete_sql_post);
		
		    while ( my $ligne = <$fh_posts> ) {
		      chomp $ligne;
		        my ( $TITLE, $POST, $IMAGE ) = split /\t/, $ligne;
		          $sth_posts->execute( $TITLE, $CONTENT, $IMAGE )
		              or die "Echec Requ&#234;te $requete_sql_post : $DBI::errstr";
		              }
		              close $fh_posts;


			     # Déconnection de la base de données
			       $dbh->disconnect();

			       #==============================================================
			       ## Pour avoir les accents sur la console DOS ou non
			       ## https://perl.developpez.com/faq/perl/?page=Terminal#Accents
			       ##==============================================================
			       sub ActiverAccents {
			           my $encodage;
			               # Windows
			                     if ( lc($^O ) eq 'mswin32') {
			                         eval {
			                                 my ($codepage) = ( `chcp` =~ m/:\s+(\d+)/ );
			                                         $encodage = "cp$codepage";
			                                                 foreach my $h ( \*STDOUT, \*STDERR, \*STDIN, ) {
			                                                         binmode $h, ":encoding($encodage)";
			                                                                 }
			                                                                     };
			                                                                         }
			                                                                             else {
			                                                                                 $encodage = `locale charmap`;
			                                                                                     eval {
			                                                                                             foreach my $h ( \*STDOUT, \*STDERR, \*STDIN, ) {
			                                                                                                     binmode $h, ":encoding($encodage)";
			                                                                                                             }
			                                                                                                                 };
			                                                                                                                     }
			                                                                                                                       return $encodage;
			                                                                                                                       }
			      
			      

		sub mabasedonnee{
		}
		1;
