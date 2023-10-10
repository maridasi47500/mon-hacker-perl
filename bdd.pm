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
		my $sql_creation_posts= <<"SQL";
		CREATE TABLE posts (
			id INT NOT NULL,
			title VARCHAR(200),
			content VARCHAR(3000),
			PRIMARY KEY (id) ) COMMENT = 'la table posts';
		SQL
		$dbh->do('DROP TABLE IF EXISTS posts;') or die "impossible de supprimer la table posts\n\n";
		$dbh->do($sql_creation_posts) or die "impossible de creer la table posts\n\n";

		print "insertion des donees dans la table posts\n";
		open my $fh_posts,'<:encoding(UTF-8)',$fichier_posts or die "impossible de lire le fichier $fichier_posts\n";


		sub mabasedonnee{
		}
		1;
