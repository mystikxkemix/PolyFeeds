<?php

##########################################################################
#  apropos.php
#  Donne des informations sur l'équipe de l'application
#  Michaël Heidelberger
#  09.10.2015
##########################################################################

if (isset($_GET['login'])){
    if ($_GET['login']!= NULL){
        $user = $_GET['login'];
    }
}
else{
     header("location: /projet_long/"."default.php");
}

if (isset($_GET['page'])){
    if ($_GET['page']!= NULL){
        $page = $_GET['page'];
    }
}
else{
    $page = "mike";
}

include ("db_inc.php");
include ("functions.php");
include ("header.php");

echo "<link rel=\"stylesheet\" type=\"text/css\" href=\"style.css\">";

echo "<title>A propos</title>";
Affiche_menu($user,"apropos");

echo"Le but de notre application est de mettre en oeuvre l'utilisation d'un iBeacon.</br>";
echo"Nous avons donc choisi de creer une application Android / IOS de gestion de planning, notes, flux d'actualite pour les etudiants de Polytech Paris UPMC. </br>";
echo"L'equipe de developpement comporte 3 etudiants. Chacun d'entre nous s'est vu assigner une tache precise dans le developpement de notre application.";
echo"</br>";

Affiche_equipe($user, $page);
Affiche_info_membre($page);

include ("footer.php");