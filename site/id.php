<?php

##########################################################################
#  id.php
#  Fichier permettant la récupération des données depuis
#  une application mobile
#  Michaël Heidelberger
#  30.11.2015
##########################################################################

if(isset($_GET["name"])){
    if($_GET["name"]!=""){
        $name = $_GET["name"];
    }else{
        $name="";
    }
}else{
    $name="";
}

if(isset($_GET["password"])){
    if($_GET["password"]!=""){
        $password = $_GET["password"];
    }else{
        $password="";
    }
}else{
    $password="";
}
        $crypt = "we6c21end2r4u" ;
	$cryptpas = crypt($password,$crypt);
        $query = "Select * from t_users where nom='".$name."' and password='".$cryptpas."'";
        $pdo = new PDO('mysql:host=localhost;dbname=projet','projet','projet');
        $result = $pdo->query($query);
        while($row = $result->fetch(PDO::FETCH_OBJ)){
            echo"Utilisateur connu";
            echo"</br>";
        }