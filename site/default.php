<?php
##########################################################################
#  default.php
#  Fichier d'affichage de la page de connexion
#  Michaël Heidelberger
#  15.09.2015
##########################################################################


ob_start();		// set output_buffering ON

include ("db_inc.php");
include ("header.php");
echo "<link rel=\"stylesheet\" type=\"text/css\" href=\"style.css\">";
echo "<title>Connexion</title>";

if (!isset($_GET['op'])){
$op = '';}
else{
$op = $_GET['op'];}

error_reporting(E_ALL);	// for error reporting on login problems
$dname = dirname($_SERVER['PHP_SELF']);	// handle directory returns "\"
if ($dname=="\\"){
    $dname = '' ;
}
if ($op == "loginok"){
  header("location: /projet_long/"."master.php?login=".$_GET["login"]);
}

if ($op == "logout"){
  session_start(); 
  session_unset(); 
  session_destroy(); 
}

if ($op == "login"){
        
	$loginok = false ;
	$request_type = strtolower($_SERVER["REQUEST_METHOD"]);
	$login = $_POST['login'];
	$password = $_POST['password'];

	if ((trim($password)!="")&&($request_type=="post")) {
	  $login = preg_replace("/[';]/", "", $login); 
	  $loginok = true ;
	}
	$crypt = "we6c21end2r4u" ;
	$cryptpas = crypt($password,$crypt);
	$query = "select idt_users,nom,password,t_formation_idt_formation from ".$USER_TB." where nom='".$login."' AND password='".$cryptpas."'";

          $pdo = new PDO('mysql:host=localhost;dbname=projet','projet','projet'); 
          $result = $pdo->query($query) ;  
          $row = $result->fetch(PDO::FETCH_OBJ);
        
	if ((!$row)||(!$loginok)){
	  
	  echo "<html><head><title>Connexion</title>\n";
	  echo "<div align=center class=menufont><p>&nbsp;</p><b><i>Identifiants incorrects</i></b>";
	  echo "<br/><br/><a href=javascript:history.back()>Retour</a><br/>";
	  echo "</div>" ;
	  }
	else {
 	  session_start(); 
	  $_SESSION["login"] = $row->nom; 
	  $_SESSION["password"]= $row->password;
          $_SESSION["team"] = $row->t_formation_idt_formation;
	  header("location: /projet_long/"."default.php?op=loginok&login=".$row->idt_users);
	  ob_end_flush();		  
	}
}
else {
	echo "<html><head><title>Connexion</title>\n";
        echo "</head><body><p>&nbsp;</p><div align=center class=titlefont>Connexion</div>" ;
        echo "<div align=center><form action=default.php?op=login method=post><table align=center  border=0><tr><td align=right><div class=menufont>";
        echo "<b>Nom d'utilisateur :</b></div></td><td align=left><input type=text name=login></td></tr><tr><td align=right><div class=menufont>" ;
        echo "<b>Mot de passe :</b></div></td><td align=left><input type=password name=password></td></tr><tr><td align=left>&nbsp;</td><td align=center>" ;
        echo "<input type=submit value='     Connexion     '></td></tr>";
        echo "</table>" ;
        echo "</form>";
        echo "</div>" ;
}


include ("footer.php");

