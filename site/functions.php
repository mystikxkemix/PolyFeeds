<?php

##########################################################################
#  functions.php
#  Fichier contenant les fonctions de recherche dans la BDD
#  Michaël Heidelberger
#  05.10.2015
##########################################################################


##########################################################################
#  Fonction Info_user
#  Attend en entrée l'identifiant de l'utilisateur.
#  Renvoie une variable contenant le nom, mot de passe, 
#  identifiant de formation et prenom de l'utilisateur.
##########################################################################
function Info_user($nom_user){
    include ("db_inc.php");
    
    $query = "select idt_users,nom,password,t_formation_idt_formation,prenom from ".$USER_TB." where idt_users='".$nom_user."'";
    $pdo = new PDO('mysql:host=localhost;dbname=projet','projet','projet');
    $result = $pdo->query($query) ;  
    $row = $result->fetch(PDO::FETCH_OBJ);
    return $row;
}

##########################################################################
#  Fonction Formation_user
#  Attend en entrée l'identifiant de formation de l'utilisateur.
#  Renvoie une variable contenant le nom et l'année de la formation.
##########################################################################
function Formation_user ($formation){
    include ("db_inc.php");
    
    $pdo = new PDO('mysql:host=localhost;dbname=projet','projet','projet');
    $query_formation = "select nom,annee from ".$FORMATION_TB." where idt_formations='".$formation."'";
    $result_formation = $pdo->query($query_formation) ;  
    $row_formation = $result_formation->fetch(PDO::FETCH_OBJ);  
    return $row_formation;
}

##########################################################################
#  Fonction Affiche_menu
#  Attend en entrée l'identifiant de l'utilisateur
#  et la page sur laquelle il se trouve.
#  Affiche le menu du site avec prise en compte de la page sur laquelle
#  l'utilisateur se trouve.
##########################################################################
function Affiche_menu($user,$page){
    echo"<div id='menu'>";
    echo"<ul id='onglets'>";
    if ($page == "accueil"){
        echo"<li class='active'><a href='master.php?login=$user'> Accueil </a></li>";
    }
    else{
        echo"<li><a href='master.php?login=$user'> Accueil </a></li>";
    }
    if ($page == "planning"){
        echo"<li class='active'><a href='planning.php?login=$user'> Planning </a></li>";
    }
    else{
        echo"<li><a href='planning.php?login=$user'> Planning </a></li>";
    }
    if ($page == "note"){
        echo"<li class='active'><a href='note.php?login=$user'> Notes </a></li>";
    }
    else{
        echo"<li><a href='note.php?login=$user'> Notes </a></li>";
    }
    if ($page == "contact"){
        echo"<li class='active'><a href='contact.php?login=$user'> Contact </a></li>";
    }
    else{
        echo"<li><a href='contact.php?login=$user'> Contact </a></li>";
    }
    echo"<li><a href='default.php?op=logout'> Deconnexion </a></li>";
    if ($page == "apropos"){
        echo"<li class='active'><a href='apropos.php?login=$user'> ? </a></li>";
    }
    else{
        echo"<li><a href='apropos.php?login=$user'> ? </a></li>";
    }
    echo"</ul>";
    echo"</div>";
}

##########################################################################
#  Fonction Tableau_note
#  Attend en entrée l'identifiant de l'utilisateur et sa formation.
#  Affiche les notes de l'utilisateur par module.
##########################################################################
function Tableau_note($user,$formation){
    include ("db_inc.php");
    
    $query_module = "select nom,idt_module,t_formations_idt_formations,semestre from ".$MODULE_TB." where t_formations_idt_formations='".$formation."'";
    $pdo = new PDO('mysql:host=localhost;dbname=projet','projet','projet');
    $result_module = $pdo->query($query_module);
    echo"<table id='tab_note'>";
    echo"<thead><tr><td>Module</td><td>Notes</td><td>Moyenne</td></tr></thead>";
    while($row_module = $result_module->fetch(PDO::FETCH_OBJ)){
        echo"<tbody><tr><td>";
        echo $row_module->nom;
        echo"</td><td>";
        Note_user($user,$row_module->idt_module,$pdo);
        echo"</td><td>";
        Calcul_moyenne($user,$row_module->idt_module,$pdo);
        echo"</td></tr></tbody>";
    }
    echo"</table>";
}

##########################################################################
#  Fonction Note_user
#  Attend en entrée l'identifiant de l'utilisateur et le module.
#  Affiche les notes de l'utilisateur dans ce module
##########################################################################
function Note_user($user,$module,$pdo){
    include ("db_inc.php");
    $query_note = "select note,idt_module,t_users_idt_users,coeff,infos from ".$NOTE_TB." where t_users_idt_users='".$user."'and idt_module='".$module."'";
    $result_note = $pdo->query($query_note);
    while($row_note = $result_note->fetch(PDO::FETCH_OBJ)){
        echo "<div title='".$row_note->infos." coeff ".$row_note->coeff."'>";
        echo $row_note->note;
        echo "</div>";
    }
}

##########################################################################
#  Fonction Calcul_moyenne
#  Attend en entrée l'identifiant de l'utilisateur et le module.
#  Calcule et affiche la moyenne dans un module
##########################################################################
function Calcul_moyenne($user,$module,$pdo){
    include ("db_inc.php");
    
    $moyenne=0;
    $coeff=0;
    $query_note = "select note,idt_module,t_users_idt_users,coeff from ".$NOTE_TB." where t_users_idt_users='".$user."'and idt_module='".$module."'";
    $result_note = $pdo->query($query_note);
    while($row_note = $result_note->fetch(PDO::FETCH_OBJ)){
        $moyenne += $row_note->note*$row_note->coeff;
        $coeff += $row_note->coeff;
    }
    if ($coeff !=0)
        echo $moyenne/$coeff;
}

##########################################################################
#  Fonction Affiche_contact
#  N'attend rien en entrée
#  Affiche l'ensemble des contacts des étudiants.
##########################################################################
function Affiche_contact(){
    include ("db_inc.php");
    
    $query = "select idt_contacts,nom,mail,telephone,bureau from ".$CONTACT_TB;
    $pdo = new PDO('mysql:host=localhost;dbname=projet','projet','projet');
    $result = $pdo->query($query) ;  
    echo"<table id='tab_note'>";
    echo"<thead><tr><td>Contact</td><td>Mail</td><td>Telephone</td><td>Bureau</td></tr></thead>";
    while ($row = $result->fetch(PDO::FETCH_OBJ)){
        echo"<tbody><tr><td>";
        echo $row->nom;
        echo"</td><td>";
        echo $row->mail;
        echo"</td><td>";
        echo"0";
        echo $row->telephone;
        echo"</td><td>";
        echo $row->bureau;
        echo"</td></tr></tbody>";
    }
    echo"</table>";
}

##########################################################################
#  Fonction Affiche_edt
#  Attend en entrée la date de début, la date de fin et l'identifiant 
#  de l'utilisateur.
#  Affiche l'emploi du temps de l'utilisateur entre les dates spécifiées.
##########################################################################
function Affiche_edt($debut,$user,$h){
    include ("db_inc.php");
    
    $query = "select idt_users,nom,t_formation_idt_formation from ".$USER_TB." WHERE idt_users='".$user."'";
    $pdo = new PDO('mysql:host=localhost;dbname=projet','projet','projet');
    $result = $pdo->query($query);
    $row = $result->fetch(PDO::FETCH_OBJ);
    
    Cherche_module($debut,$user,$row->t_formation_idt_formation,$pdo,$h);
}

##########################################################################
#  Fonction Cherche_module
#  Attend en entrée la date de début, la date de fin l'identifiant 
#  de l'utilisateur et sa formation.
#  N'est utilse que pour alléger le code de la fonction Affiche_edt.
##########################################################################
function Cherche_module($debut,$user,$formation,$pdo,$h){
    include ("db_inc.php");
    
    $query = "select idt_module,nom,t_formations_idt_formations from ".$MODULE_TB." WHERE t_formations_idt_formations='".$formation."'";
    $result = $pdo->query($query);
    
    while($row = $result->fetch(PDO::FETCH_OBJ)){
        Cherche_cours($debut,$user,$row->idt_module,$pdo,$h);
    }
}

##########################################################################
#  Fonction Cherche_cours
#  Attend en entrée la date de début, la date de fin l'identifiant 
#  de l'utilisateur et les modules.
#  N'est utilse que pour alléger le code de la fonction Affiche_edt et 
#  Cherche_module.
##########################################################################
function Cherche_cours($debut,$user,$module,$pdo,$h){
    include ("db_inc.php");
    
    $debut_recherche = Mise_en_forme_date($debut,$h);
    $query = "select idt_edts,t_module_idt_module,date,salle,enseignant from ".$EDT_TB." WHERE t_module_idt_module='".$module."' AND date='".$debut_recherche."'";
    $result = $pdo->query($query);
    while($row = $result->fetch(PDO::FETCH_OBJ)){
    //$mdr = substr($row->date, 0, 10);
    //if($debut_recherche==$mdr){
      //  $xd = substr($row->date, 11, 5);
       // $xd = str_replace(":", "h", $xd);
        Mise_en_forme_edt($row->salle,$row->enseignant,$row->t_module_idt_module,$pdo);
    //}  
    }
}

##########################################################################
#  Fonction Mise_en_forme_date
#  Attend en entrée la date et le type (debut ou fin).
#  Renvoie la date au format de la base de données.
##########################################################################
function Mise_en_forme_date($date,$h){
    
    
    $lol = str_replace("/", "-", $date);
    $day = substr($lol, 0, 2);
    $month = substr($lol, 3, 2);
    $year = substr($lol, 6, 4);
    if($h=="0"){
        $new_date = $year."-".$month."-".$day." 08:30:00";
    }
    if($h=="1"){
        $new_date = $year."-".$month."-".$day." 10:45:00";
    }
    if($h=="2"){
        $new_date = $year."-".$month."-".$day." 13:45:00";
    }
    if($h=="3"){
        $new_date = $year."-".$month."-".$day." 16:00:00";
    }
    
    return $new_date;
}

##########################################################################
#  Fonction Mise_en_forme_edt
#  Attend en entrée la date de debut, de fin, la salle, l'enseignant, le
#  module.
#  Allège le code des autres fonctions.
##########################################################################
function Mise_en_forme_edt($salle,$enseignant,$module,$pdo){
    include ("db_inc.php");
    
    $query = "select idt_module,nom,t_formations_idt_formations from ".$MODULE_TB." WHERE idt_module='".$module."'";
    $result = $pdo->query($query);
    $row = $result->fetch(PDO::FETCH_OBJ);
    echo "<div>";
    echo $row->nom ."</br>".$salle."</br>".$enseignant;
    echo"</div>";
}

##########################################################################
#  Fonction Affiche_tableau_date
#  Attend en entrée la date de debut, de fin
#  Affiche un tableau des jours de la semaine.
##########################################################################
function Affiche_tableau_date($debut,$user){
    echo"<table id='tab_note'>";
    echo"<thead><tr><td></td>";
    list($jour, $mois, $annee) = explode('/', $debut);
    $timestamp = mktime (0, 0, 0, $mois, $jour, $annee);
    for ($i=0;$i<7;$i++){
        $nextday = $timestamp + ($i*(24*60*60));
        $current_day = Cherche_jour ($nextday);
        echo"<td>";
        echo $current_day; 
        echo " ";
        echo date("d-m",$nextday);
        echo"</td>";
    }
    echo "</tr></thead>";
    echo "<tbody><tr>";
    echo"<td id='cours'>8h30 / 10h30</td>";
    for ($i=0;$i<7;$i++){
        $nextday = $timestamp + ($i*(24*60*60));
        echo"<td id='cours'>";
        $lol =date("d/m/Y",$nextday);
        Affiche_edt($lol,$user,"0");
        echo"</td>";
    }
    echo"</tr><tr>";
    echo"<td id='cours'>10h45 / 12h45</td>";
    for ($i=0;$i<7;$i++){
        $nextday = $timestamp + ($i*(24*60*60));
        echo"<td id='cours'>";
        $lol =date("d/m/Y",$nextday);
        Affiche_edt($lol,$user,"1");
        echo"</td>";
    }
    echo"</tr><tr>";
    echo"<td id='cours'>13h45 / 15h45</td>";
    for ($i=0;$i<7;$i++){
        $nextday = $timestamp + ($i*(24*60*60));
        echo"<td id='cours'>";
        $lol =date("d/m/Y",$nextday);
        Affiche_edt($lol,$user,"2");
        echo"</td>";
    }
    echo"</tr><tr>";
    echo"<td id='cours'>16h00 / 18h00</td>";
    for ($i=0;$i<7;$i++){
        $nextday = $timestamp + ($i*(24*60*60));
        echo"<td id='cours'>";
        $lol =date("d/m/Y",$nextday);
        Affiche_edt($lol,$user,"3");
        echo"</td>";
    }
    echo"</tr></tbody></table>";
}


##########################################################################
#  Fonction Cherche_jour
#  Attend une variable timestamp.
#  Renoie le jour auquel la variable correspond.
##########################################################################
function Cherche_jour($time){
    $lol = date("w",$time);
    if($lol == 0){
        $current = "Dimanche";
    }
    if($lol == 1){
        $current = "Lundi";
    }
    if($lol == 2){
        $current = "Mardi";
    }
    if($lol == 3){
        $current = "Mercredi";
    }
    if($lol == 4){
        $current = "Jeudi";
    }
    if($lol == 5){
        $current = "Vendredi";
    }
    if($lol == 6){
        $current = "Samedi";
    }
    return $current;
}


##########################################################################
#  Fonction Affiche_equipe
#  Attend en entrée l'identifiant de l'utilisateur
#  et la page sur laquelle il se trouve.
#  Affiche les membres de l'equipe.
##########################################################################
function Affiche_equipe($user,$page){
    echo"<div id='menu'>";
    echo"<ul id='onglets'>";
    if ($page == "mike"){
        echo"<li class='active'><a href='apropos.php?login=$user&page=mike'> Mike </a></li>";
    }
    else{
        echo"<li><a href='apropos.php?login=$user&page=mike'> Mike </a></li>";
    }
    if ($page == "gabin"){
        echo"<li class='active'><a href='apropos.php?login=$user&page=gabin'> Gabin </a></li>";
    }
    else{
        echo"<li><a href='apropos.php?login=$user&page=gabin'> Gabin </a></li>";
    }
    if ($page == "mika"){
        echo"<li class='active'><a href='apropos.php?login=$user&page=mika'> Michael </a></li>";
    }
    else{
        echo"<li><a href='apropos.php?login=$user&page=mika'> Michael </a></li>";
    }
    echo"</ul>";
    echo"</div>";
}

##########################################################################
#  Fonction Affiche_info_membre
#  Attend en entrée la page sur laquelle on est.
#  Affiche les membres de l'equipe.
##########################################################################
function Affiche_info_membre($page){
    include ("db_inc.php");
    echo "<img src=\"images/".$page.".jpg\" border=0 width=300 height=300>";
    echo"</br></br>";
    if ($page =="mike"){
        echo"Mike est notre chef de projet.</br>";
        echo"Son role principal est de faire en sorte que Gabin et Michael restent concentres sur leurs missions respectives.</br>";
        echo"Mike s'occupe egalement du developpement de l'application Android de PolyFeeds.";
    }
    elseif ($page =="gabin") {
        echo"Gabin est le graphiste de l'equipe. Il est donc le createur du logo de PolyFeeds.</br>";
        echo"Il est aussi en charge du developpement de l'application IOS.";
    }
    else{
        echo"Michael est le gestionnaire de la base de donnees de notre application.</br>";
        echo"Il est le createur de la base et son administrateur. Il s'occupe egalement du developpement du site WEB.";
    }
}