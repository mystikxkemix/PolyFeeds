<?php

##########################################################################
#  planning.php
#  Fichier d'affichage du planning d'un utilisateur
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

  $week_active ="0";
  if (isset($_GET['semaine'])){
    if ($_GET['semaine']!= NULL){
        $week_active = $_GET['semaine'];
    }
  }

  include ("db_inc.php");
  include ("functions.php");
  include ("header.php");

  echo "<title>Planning</title>";

  echo "<link rel=\"stylesheet\" type=\"text/css\" href=\"style.css\">";

  if (isset($_GET['login'])){
    if ($_GET['login']!= NULL){
        $user = $_GET['login'];
    }
  }
  Affiche_menu($user,"planning");


  function calculDateDebut($dateDeb, $jourChoisiFR){
    $choixPossible = array('monday' => 'lundi', 'sunday' => 'dimanche');    
    $jourChoisiEN = array_search($jourChoisiFR, $choixPossible);
    $dateDeb -> modify('+0 month');
    $libelleJour = strftime('%A', $dateDeb -> format('U'));
    if ($libelleJour != $jourChoisiFR){
      $dateDeb -> modify('previous ' . $jourChoisiEN);
    }
    return $dateDeb;    
  }
 
  function calculSemaine($nbSemaine, $dateDeb,$week_active,$user){
    $semaine = '';
    $i = 0;
    while ($i < $nbSemaine){
      $debut = $dateDeb -> format('d/m/Y');
      $dateDeb -> modify('+6 days');
      $fin = $dateDeb -> format('d/m/Y');
      if($i == $week_active){
          $semaine .= '<li class="active"><a href="planning.php?login='.$user.'&semaine='.$i.'&debut='.$debut.'&fin='.$fin.'">' . $debut . '>' . $fin . '</a></li>' . "\n";
      }else{
        $semaine .= '<li><a href="planning.php?login='.$user.'&semaine='.$i.'&debut='.$debut.'&fin='.$fin.'">' . $debut . '>' . $fin . '</a></li>' . "\n";
      
      }
      $dateDeb -> modify('+1 days');
      $i ++;
    }
    return $semaine;
  }
//----------------------------------------------------------------------  
//----------------------------------------------------------------------  
  setlocale(LC_TIME, 'fr', 'fr_FR', 'fr_FR.ISO8859-1');
 
  $nbSemaineAAfficher = 5;
  $jourChoisi = 'lundi';
 
  $dateDeb = new DateTime();  

  echo "<html>";
  echo "<head>";
  echo "</head>";
  echo "<body>";
  echo"<div id='menu'>";
  echo"<ul id='semaine'>";
  echo $semaine = calculSemaine($nbSemaineAAfficher, calculDateDebut($dateDeb, $jourChoisi),$week_active,$user);
  echo"</ul></div>";
  if(isset($_GET["debut"])){
    $debut_sem = $_GET["debut"];
  }
  else{
    $dateDeb -> modify('-1 month');
    $libelleJour = strftime('%A', $dateDeb -> format('U'));
    if ($libelleJour != "lundi"){
        $dateDeb -> modify('previous ' . "monday");
    }
    $debut_sem=$dateDeb-> format('d/m/Y');
  }
  Affiche_tableau_date($debut_sem,$user);
  echo "</body>";
  echo "</html>";

  include ("footer.php");