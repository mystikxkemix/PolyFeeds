<?php

##########################################################################
#  beacon.php
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

if(isset($_GET["beacon"])){
    if($_GET["beacon"]!=""){
        $beacon = $_GET["beacon"];
    }else{
        $beacon="";
    }
}else{
    $beacon="";
}
        
        $query = "Select * from t_users where nom='".$name."'";
        $pdo = new PDO('mysql:host=localhost;dbname=projet','projet','projet');
        $result = $pdo->query($query);
        while($row = $result->fetch(PDO::FETCH_OBJ)){
            $id_user = $row->id_user;
            echo"</br>";
        }
        $query = "Select * from t_beacons where uuid='".$beacon."'";
        $result = $pdo->query($query);
        while($row = $result->fetch(PDO::FETCH_OBJ)){
            $id_beacon = $row->id_beacon;
            echo"</br>";
        }
        
        $query_add = "INSERT INTO t_presences (id_user,id_beacon) VALUES (".$id_user.",".$id_beacon.")";
        $result = $pdo->query($query_add);
        
        