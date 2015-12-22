<?php

##########################################################################
#  mobile_access.php
#  Fichier permettant la récupération des données depuis
#  une application mobile
#  Michaël Heidelberger
#  30.11.2015
##########################################################################

if(isset($_GET["table"])){
    if($_GET["table"]!=""){
        $table = $_GET["table"];
    }else{
        $table="";
    }
}else{
    $table="";
}

if(isset($_GET["id_user"])){
    if($_GET["id_user"]!=""){
        $id_user = $_GET["id_user"];
    }else{
        $id_user="";
    }
}else{
    $id_user="";
}

if(isset($_GET["module"])){
    if($_GET["module"]!=""){
        $module = $_GET["module"];
    }else{
        $module="";
    }
}else{
    $module="";
}

if(isset($_GET["date"])){
    if($_GET["date"]!=""){
        $date = $_GET["date"];
    }else{
        $date="";
    }
}else{
    $date="";
}

if($table!=""){
    if(($id_user!="")||($module!="")||$date!=""){
        if($id_user!=""){
            $query = "Select * FROM t_".$table." WHERE id_user='".$id_user."'";
            if($module!=""){
                $query = "Select * FROM t_".$table." WHERE id_user='".$id_user."' AND id_module='".$module."'";
                if($date!=""){
                    $query = "Select * FROM t_".$table." WHERE id_user='".$id_user."' AND id_module='".$module."' AND date='".$date."'";
                }
            }
            if(($date!="")&&($module=="")){
                $query = "Select * FROM t_".$table." WHERE id_user='".$id_user."' AND date='".$date."'";
            }
        }
        if(($module!="")&&($id_user=="")){
            $query = "Select * FROM t_".$table." WHERE id_module='".$module."'";
            if($date!=""){
                $query = "Select * FROM t_".$table." WHERE id_module='".$module."' AND date='".$date."'";
            }   
        }
        if(($date!="")&&($id_user=="")&&($module=="")){
            $query = "Select * FROM t_".$table." WHERE date='".$date."'";
        }
        echo $query;
        echo"</br>";

        $pdo = new PDO('mysql:host=localhost;dbname=projet','projet','projet');
        $result = $pdo->query($query);
        while($row = $result->fetch(PDO::FETCH_OBJ)){
            echo $row->infos;
            echo"</br>";
        }
    }
}
