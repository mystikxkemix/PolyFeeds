<?php
##########################################################################
#  db.inc.php
#  Fichier d'implémentation de la BDD
#  Michaël Heidelberger michael.heidelberger@sncf.fr
#  20.07.2015
##########################################################################


############################################################################
#
# database connection 

$db = 'projet';
$dbuser = 'projet';
$dbpass = 'projet';
$dbhost = 'localhost';

try {
    $pdo = new PDO('mysql:host=localhost;dbname=projet','projet','projet');
} catch (Exception $ex) {
    echo"Echec";
}



############################################################################
#
# Table definitions

$CONTACT_TB = 't_contacts' ;
$USER_TB = 't_users' ;
$FORMATION_TB = 't_formations' ;
$EDT_TB = 't_edts' ;
$MODULE_TB = 't_module' ;
$NOTE_TB = 't_notes' ;


//Fonction permettant de se connecter via une application Android
    //mysql_connect("localhost","projet","projet");
    //mysql_select_db("projet");
    //$q=mysql_query("SELECT * FROM ".$table." WHERE".$condition);
    //while($e=mysql_fetch_assoc($q))
    //    $output[]=$e;
    //print(json_encode($output));
    //mysql_close();


//Affichage du logo de polyfeeds dans l'onglet du navigateur
echo "<link rel='SHORTCUT ICON' href='images/logo.ico' />";
?>

