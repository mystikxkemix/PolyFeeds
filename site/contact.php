<?php

##########################################################################
#  contact.php
#  Fichier d'affichage des contacts
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

echo "<title>Contact</title>";

echo "<link rel=\"stylesheet\" type=\"text/css\" href=\"style.css\">";
if (isset($_GET['login'])){
    if ($_GET['login']!= NULL){
        $user = $_GET['login'];
    }
}
Affiche_menu($user,"contact");
Affiche_contact();

include ("footer.php");