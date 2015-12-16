<?php

##########################################################################
#  master.php
#  Fichier d'affichage de la page principale
#  Michaël Heidelberger
#  05.10.2015
##########################################################################

############################################################################
#
# Verification de la connexion
if (isset($_GET['login'])){
    if ($_GET['login']!= NULL){
        $user = $_GET['login'];
    }
}
else{
     header("location: /projet_long/"."default.php");
}

include ("db_inc.php");
include ("functions.php");
include ("header.php");

echo "<title>Accueil</title>";

echo "<link rel=\"stylesheet\" type=\"text/css\" href=\"style.css\">";



Affiche_menu($user,"accueil");


echo "Bienvenue sur le site de l'application Polyfeeds ";

//Appel de la fonction récupérant les informations de l'utilisateur.
$utilisateur = Info_user($user);

//Appel de la fonction récupérant la formation de l'utilisateur.
$formation = Formation_user($utilisateur->t_formation_idt_formation);

echo $utilisateur->prenom;
echo "</br>";

echo "Ce site et son application sont developpes par des etudiants de E2I annee 4.</br>";
echo "Ici, tu as acces a ton emploi du temps mais aussi a tes notes et a l'ensemble des contacts de ton ecole.";
echo "</br>";
echo "Si tu souhaites en savoir plus sur notre equipe, tu peux te rendre dans la rubrique '?' du menu.</br>";


include ("footer.php");