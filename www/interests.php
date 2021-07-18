<html>

<head>
<TITLE></TITLE> 
<META NAME="description" Content="Universe of Arlandia for Neverwinter Nights - The Universe is infinite"> 
<META NAME="keywords" Content="arlandia uoa universe neverwinter nights nwn lkt therack the rack marc racordon"> 
<META NAME="author" CONTENT="TheRack"> 
<META NAME="Copyright" CONTENT="TheRack, 2009">
<META NAME="GENERATOR" CONTENT="Microsoft FrontPage 5.0">
<META HTTP-EQUIV="Content-Language" CONTENT="fr-ch" > 
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<style fprolloverstyle>A:hover {color: #00FF00;}</style>
</head>

<body topmargin="0" leftmargin="30" text="#FFFFFF" link="#FFFFFF" vlink="#FFFFFF" alink="#FFFFFF" background="UOA_BG2.jpg">

<br/>

<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Connect to the MySQL server on Wamp
include("uoa.php");
$link = @ mysql_connect ("$host:$port", $user, $pass)
// if no connexion
or die ("service offline");
// Select the base
mysql_select_db("$data");

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Planet + Area
$galaxyx = @ $_GET['galaxyx'];if($galaxyx==""){$galaxyx = 0;}
$galaxyy = @ $_GET['galaxyy'];if($galaxyy==""){$galaxyy = 0;}
$login = @ $_GET['login'];
$planet = $_GET['planet'];
$area = $_GET['area'];
$interests = $planet."&".$area."&Interests";
// Other variables
$result = mysql_query("SELECT val FROM pwdata WHERE name='$interests'") or die(mysql_error());
$interest = @ mysql_result($result,0);
$interest = str_replace("~","'" , $interest);
// Name
$inttype = substr($interest, 0, 1);
$name1pos = strpos($interest,"&2&");$name1 = substr($interest, 0, $name1pos);$name2pos = strpos($name1,"&1&");$name2 = strlen($name1);$name = substr($name1, $name2pos+3);if($inttype=="D"){$title = "Domain";}else if($inttype=="1"){$title = $name;}else if($inttype=="2"){$title = "Dungeon";}else if($inttype=="3"){$title = "Castle";}else if($inttype=="4"){$title = "Ruins";}else if($inttype=="5"){$title = "Animal reserve";}else if($inttype=="6"){$title = "Resource mountain";}else if($inttype=="7"){$title = "Amusement place";}
$var1pos = strpos($interest,"&3&");$var1 = substr($interest, 0, $var1pos);$var2pos = strpos($var1,"&2&");$var2 = strlen($var1);$var = substr($var1, $var2pos+3);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Titles and general infos
?>

<center><font=Bell MT><font size=4><font bold=True><font color=#66CCFF><u><?php echo "$title" ?> informations</u></center>

<p align=right><font=Bell MT><font size=2><font bold=True><font color=#FFFFFF><u><a href="interests.php?planet=<?php echo "$planet" ?>&area=<?php echo "$area" ?>&login=<?php echo "$login" ?>&galaxyx=<?php echo "$galaxyx" ?>&galaxyy=<?php echo "$galaxyy" ?> ">actualise</a></u> - <u><a href="galaxy.php?planet=<?php echo "$planet" ?>&area=<?php echo "$area" ?>&login=<?php echo "$login" ?>&galaxyx=<?php echo "$galaxyx" ?>&galaxyy=<?php echo "$galaxyy" ?> ">back to map</a></u></p>


<table border="1" cellpadding="10" cellspacing="0" style="border-collapse: collapse" bordercolor="#404040" width="100%">

  <tr>

    <td width="100%" valign="top">

<font=Bell MT><font size=4><font bold=True><font color=#66CCFF>Planet : <font color=#FFC800><?php echo "$planet" ?><br/>

<br/><font=Bell MT><font size=4><font bold=True><font color=#66CCFF>Area : <font color=#FFC800><?php echo "$area" ?><br/>

    </td>

  </tr>

</table>

<br/>
<br/>





<?php
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Domains
if($inttype=="D")
 {
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
?>


<table border="1" cellpadding="10" cellspacing="0" style="border-collapse: collapse" bordercolor="#404040" width="100%">

  <tr>

    <td width="100%" valign="top" colspan="2">

<p><font=Bell MT><font size=4><font bold=True><font color=#66CCFF>Domain owner : </font><font color=#FFC800><?php echo $name;?></font><p/>

<?php
$var11pos = strpos($var,"_01_");$var1 = substr($var, 0, $var11pos);
$var21pos = strpos($var,"_02_");$var21 = substr($var, 0, $var21pos);$var22pos = strpos($var21,"_01_");$var22 = strlen($var21);$var2 = substr($var21, $var22pos+4);
$var31pos = strpos($var,"_03_");$var31 = substr($var, 0, $var31pos);$var32pos = strpos($var31,"_02_");$var32 = strlen($var31);$var3 = substr($var31, $var32pos+4);
$var41pos = strpos($var,"_04_");$var41 = substr($var, 0, $var41pos);$var42pos = strpos($var41,"_03_");$var42 = strlen($var41);$var4 = substr($var41, $var42pos+4);
$var51pos = strpos($var,"_05_");$var51 = substr($var, 0, $var51pos);$var52pos = strpos($var51,"_04_");$var52 = strlen($var51);$var5 = substr($var51, $var52pos+4);
$var61pos = strpos($var,"_06_");$var61 = substr($var, 0, $var61pos);$var62pos = strpos($var61,"_05_");$var62 = strlen($var61);$var6 = substr($var61, $var62pos+4);
$var71pos = strpos($var,"_07_");$var71 = substr($var, 0, $var71pos);$var72pos = strpos($var71,"_06_");$var72 = strlen($var71);$var7 = substr($var71, $var72pos+4);
$var81pos = strpos($var,"_08_");$var81 = substr($var, 0, $var81pos);$var82pos = strpos($var81,"_07_");$var82 = strlen($var81);$var8 = substr($var81, $var82pos+4);
$var91pos = strpos($var,"_09_");$var91 = substr($var, 0, $var91pos);$var92pos = strpos($var91,"_08_");$var92 = strlen($var91);$var9 = substr($var91, $var92pos+4);
$var101pos = strpos($var,"_10_");$var101 = substr($var, 0, $var101pos);$var102pos = strpos($var101,"_09_");$var102 = strlen($var101);$var10 = substr($var101, $var102pos+4);
$var111pos = strpos($var,"_11_");$var111 = substr($var, 0, $var111pos);$var112pos = strpos($var111,"_10_");$var112 = strlen($var111);$var11 = substr($var111, $var112pos+4);

$var1 = substr($var1, 0, strpos($var1,"%"));
$var2 = substr($var2, 0, strpos($var2,"%"));
$var3 = substr($var3, 0, strpos($var3,"%"));
$var4 = substr($var4, 0, strpos($var4,"%"));
$var5 = substr($var5, 0, strpos($var5,"%"));
$var6 = substr($var6, 0, strpos($var6,"%"));
$var7 = substr($var7, 0, strpos($var7,"%"));
$var8b = substr($var8, -1);
$var8 = substr($var8, 0, strpos($var8,"%"));
$var9 = substr($var9, 0, strpos($var9,"%"));
$var10 = substr($var10, 0, strpos($var10,"%"));

$var = "";$structure = "";$i = 0;$i1 = 0;$i2 = 0;$i3 = 0;

while($i<10)
 {
$i++;
if($i==1){$structure = $var1;}else if($i==2){$structure = $var2;}else if($i==3){$structure = $var3;}else if($i==4){$structure = $var4;}else if($i==5){$structure = $var5;}else if($i==6){$structure = $var6;}else if($i==7){$structure = $var7;}else if($i==8){$structure = $var8;}else if($i==9){$structure = $var9;}else if($i==10){$structure = $var10;}
if(($structure==5)||($structure==7)||($structure==8)||($structure==21)){$i1++;}
else if($structure==6){$i2++;}
else if($structure!=0){$i3++;}
 }
if($i1>0){$var = "Primary";}
if($i2>0){if($var==""){$var = "Secundary";}else{$var = $var.", Secundary";}}
if($i3>0){if($var==""){$var = "Tertiary";}else{$var = $var.", Tertiary";}}

?>

<font=Bell MT><font size=4><font bold=True><font color=#66CCFF>Domain sectors : </font><font color=#FFC800><?php echo $var;?></font>

    </td>

  </tr>

  <tr>

    <td width="30%" valign="top">

<p><font=Bell MT><font size=4><font bold=True><font color=#66CCFF>Domain description : </font><p/>

    </td>

    <td width="70%" valign="top">

<p><font=Bell MT><font size=4><font bold=True><font color=#00FF00><?php echo $var11;?></font><p/>

    </td>

  </tr>

</table>


<br/>
<br/>

<?php
if($var8b>2)
  {
?>

<table border="1" cellpadding="10" cellspacing="0" style="border-collapse: collapse" bordercolor="#404040" width="100%">

  <tr>

    <td width="100%" valign="top" colspan="2">

<?php
$mail = $planet."&".$area."&Mailbox";
$result = mysql_query("SELECT val FROM pwdata WHERE name='$mail'") or die(mysql_error());
$result = @ mysql_result($result,0);

if(($result=="")||($result=="0")){ ?> <font=Bell MT><font size=4><font bold=True><font color=#66CCFF>Mailbox : <font color=#FFC800>empty</font> <?php }
else{ ?> <font=Bell MT><font size=4><font bold=True><font color=#66CCFF>Mailbox : <font color=#00FF00>mail</font> <?php }
?>

    </td>

  </tr>

</table>


<?php
  }
 }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Cities and Towns
else if($inttype=="1")
 {
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Player Shop
?>


<table border="1" cellpadding="10" cellspacing="0" style="border-collapse: collapse" bordercolor="#404040" width="100%">

  <tr>

    <td width="100%" valign="top" colspan="2">


<?php if($var=="000"){$var = "Player Shop";}else if($var=="001"){$var = "General Shop";}else if($var=="002"){$var = "Weaponsmith";}else if($var=="003"){$var = "Armorsmith";}else if($var=="004"){$var = "Arcane shop";}else if($var=="005"){$var = "Alchemist shop";}else if($var=="006"){$var = "Jeweler";}else if($var=="007"){$var = "Rogue shop";}else if($var=="008"){$var = "Tailor";}else if($var=="009"){$var = "Library";}else if($var=="010"){$var = "Bank";}else if($var=="011"){$var = "Animal shop";}else if($var=="012"){$var = "Blacksmith";}else if($var=="013"){$var = "Tavern";}else if($var=="014"){$var = "Inn";}else if($var=="015"){$var = "Temple";}else if($var=="016"){$var = "Architect";}else if($var=="017"){$var = "Trainer";} ?>
<font=Bell MT><font size=4><font bold=True><font color=#66CCFF>Special shop :<font color=#FFC800> <?php echo "$var" ?>

    </td>

  </tr>

  <tr>

    <td width="30%" valign="top">


<p><font=Bell MT><font size=4><font bold=True><font color=#66CCFF>Local player shop :</font><p/>


    </td>

    <td width="70%" valign="top">



<?php
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$saletot = $planet."&".$area."&SaleShopTot";
$saletot = mysql_query("SELECT val FROM pwdata WHERE name='$saletot'") or die(mysql_error());
$saletot = @ mysql_result($saletot,0);
$saletot = str_replace("~","'" , $saletot);
$ittot = 0;

while($saletot>0)
  {
$sale = $planet."&".$area."&SaleShop".$saletot;
$result = mysql_query("SELECT val FROM pwdata WHERE name='$sale'") or die(mysql_error());
$result = @ mysql_result($result,0);
$result = str_replace("~","'" , $result);
$Var = substr($result,-4,3);if($Var<10){$Var = substr($Var, -1);}else if($Var<100){$Var = substr($Var, -2);}
//

$iT = 0;
while($iT<$Var)
   {
$iT++;
$sT1 = $iT;if($iT<10){$sT1 = "00".$iT;}else if($iT<100){$sT1 = "0".$iT;}
$sT2 = $iT-1;if(($iT-1)<10){$sT2 = "00".($iT-1);}else if(($iT-1)<100){$sT2 = "0".($iT-1);}

if($iT==1){$All1pos = strpos($result,"&".$sT1."&");$All = substr($result, 0, $All1pos);}else{$All1pos = strpos($result,"&".$sT1."&");$All1 = substr($result, 0, $All1pos);$All2pos = strpos($All1,"&".$sT2."&");$All2 = strlen($All1);$All = substr($All1, $All2pos+5);}

$Name1pos = strpos($All,"_C_");$Name1 = substr($All, 0, $Name1pos);$Name2pos = strpos($Name1,"_B_");$Name2 = strlen($Name1);$Name = substr($Name1, $Name2pos+3);
$Master1pos = strpos($All,"_E_");$Master1 = substr($All, 0, $Master1pos);$Master2pos = strpos($Master1,"_D_");$Master2 = strlen($Master1);$Master = substr($Master1, $Master2pos+3);
$Value1pos = strpos($All,"_K_");$Value1 = substr($All, 0, $Value1pos);$Value2pos = strpos($Value1,"_J_");$Value2 = strlen($Value1);$Value = substr($Value1, $Value2pos+3);if($Value<1){$Value = 1;}
$WearP1pos = strpos($All,"_G_");$WearP1 = substr($All, 0, $WearP1pos);$WearP2pos = strpos($WearP1,"_F_");$WearP2 = strlen($WearP1);$WearP = substr($WearP1, $WearP2pos+3);

$Array[] = $Name."_A_".$Master."_B_".$Value."_C_".$WearP."_D_";
$ittot++;
   }
$saletot--;
  }
//

@ sort($Array);

//
$iT = 0;
while($iT<$ittot)
  {
$Vars = $Array[$iT];
$Name1pos = strpos($Vars,"_A_");$Name = substr($Vars, 0, $Name1pos);
$Master1pos = strpos($Vars,"_B_");$Master1 = substr($Vars, 0, $Master1pos);$Master2pos = strpos($Master1,"_A_");$Master2 = strlen($Master1);$Master = substr($Master1, $Master2pos+3);
$Value1pos = strpos($Vars,"_C_");$Value1 = substr($Vars, 0, $Value1pos);$Value2pos = strpos($Value1,"_B_");$Value2 = strlen($Value1);$Value = substr($Value1, $Value2pos+3);
$WearP1pos = strpos($Vars,"_D_");$WearP1 = substr($Vars, 0, $WearP1pos);$WearP2pos = strpos($WearP1,"_C_");$WearP2 = strlen($WearP1);$WearP = substr($WearP1, $WearP2pos+3);

?><font=Bell MT><font size=4><font bold=True><font color=#00FF00><?php echo $Name;?><font color=#66CCFF><font size=3> ( <font color=#FFC800><?php echo $Value;?><font color=#66CCFF> GP / <font color=#FFC800><?php echo $WearP;?><font color=#66CCFF> % / sold by <font color=#FFC800><?php echo $Master;?><font color=#66CCFF>)</font><br/><?php

$iT++;
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
?>

    </td>

  </tr>

</table>

<br/>
<br/>


<?php
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Message board
?>


<table border="1" cellpadding="10" cellspacing="0" style="border-collapse: collapse" bordercolor="#404040" width="100%">

  <tr>

    <td width="30%" valign="top">

<p><font=Bell MT><font size=4><font bold=True><font color=#66CCFF>Local message board :</font><p/>

    </td>

    <td width="70%" valign="top">


<?php
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$board = $planet."&DHBoardTot";
$result = mysql_query("SELECT val FROM pwdata WHERE name='$board'") or die(mysql_error());
$result = @ mysql_result($result,0);
$result = str_replace("~","'" , $result);
$messagenumbers = $result;

while($messagenumbers>0)
  {

$All = $planet."&DHBoard".$messagenumbers;
$result = mysql_query("SELECT val FROM pwdata WHERE name='$All'") or die(mysql_error());
$result = @ mysql_result($result,0);
$result = str_replace("~","'" , $result);
$All = $result;

$author1pos = strpos($All,"_A_");$author = substr($All, 0, $author1pos);
$title1pos = strpos($All,"_B_");$title1 = substr($All, 0, $title1pos);$title2pos = strpos($title1,"_A_");$title2 = strlen($title1);$title = substr($title1, $title2pos+3);
$message = substr($All, strpos($All,"_B_")+3);

?><font=Bell MT><font size=4><font bold=True><font color=#FF0000><u><?php echo "$title";?></u><font color=#66CCFF><font size=3> (posted by <font color=#FF0000><?php echo "$author";?><font color=#66CCFF>) : <br/></font><font=Bell MT><font size=4><font bold=True><font color=#FF0000><?php echo "$message";?></font><br/><br/><?php

$messagenumbers--;
  }

$board = $planet."&".$area."&BoardTot";
$result = mysql_query("SELECT val FROM pwdata WHERE name='$board'") or die(mysql_error());
$result = @ mysql_result($result,0);
$result = str_replace("~","'" , $result);
$messagenumbers = $result;

while($messagenumbers>0)
  {
$All = $planet."&".$area."&Board".$messagenumbers;
$result = mysql_query("SELECT val FROM pwdata WHERE name='$All'") or die(mysql_error());
$result = @ mysql_result($result,0);
$result = str_replace("~","'" , $result);
$All = $result;

$author1pos = strpos($All,"_A_");$author = substr($All, 0, $author1pos);
$title1pos = strpos($All,"_B_");$title1 = substr($All, 0, $title1pos);$title2pos = strpos($title1,"_A_");$title2 = strlen($title1);$title = substr($title1, $title2pos+3);
$message = substr($All, strpos($All,"_B_")+3);

?><font=Bell MT><font size=4><font bold=True><font color=#FFC800><u><?php echo "$title";?></u><font color=#66CCFF><font size=3> (posted by <font color=#FFC800><?php echo "$author";?><font color=#66CCFF>) : <br/></font><font=Bell MT><font size=4><font bold=True><font color=#00FF00><?php echo "$message";?></font><br/><br/><?php

$messagenumbers--;
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
?>


    </td>

  </tr>

</table>


<?php
 }





////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Dungeons
else if($inttype=="2")
 {
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
?>


<table border="1" cellpadding="10" cellspacing="0" style="border-collapse: collapse" bordercolor="#404040" width="100%">

  <tr>

    <td width="100%" valign="top" colspan="2">

<?php

$dungeon = substr($interest, 0, strpos($interest,"&1&"));
$dungeontype1pos = strpos($dungeon,"_B_");$dungeontype1 = substr($dungeon, 0, $dungeontype1pos);$dungeontype2pos = strpos($dungeontype1,"_A_");$dungeontype2 = strlen($dungeontype1);$dungeontype = substr($dungeontype1, $dungeontype2pos+3);
if($dungeontype==1){$dungeontype = "Temple";}else if($dungeontype==2){$dungeontype = "Cave";}else if($dungeontype==3){$dungeontype = "Pyramid";}else if($dungeontype==4){$dungeontype = "Old Castle";}else if($dungeontype==5){$dungeontype = "Crypt";}else if($dungeontype==6){$dungeontype = "Tower";}else if($dungeontype==7){$dungeontype = "Tower";}else if($dungeontype==8){$dungeontype = "Underground dungeon";}

$dungeonfamily1pos = strpos($dungeon,"_D_");$dungeonfamily1 = substr($dungeon, 0, $dungeonfamily1pos);$dungeonfamily2pos = strpos($dungeonfamily1,"_C_");$dungeonfamily2 = strlen($dungeonfamily1);$dungeonfamily = substr($dungeonfamily1, $dungeonfamily2pos+3);if($dungeonfamily==1000){$dungeonfamily = "None";}if(($dungeonfamily=="")||($dungeonfamily=="0")){$dungeonfamily = "Unknown";}
$dungeonfull1pos = strpos($dungeon,"_E_");$dungeonfull1 = substr($dungeon, 0, $dungeonfull1pos);$dungeonfull2pos = strpos($dungeonfull1,"_D_");$dungeonfull2 = strlen($dungeonfull1);$dungeonfull = substr($dungeonfull1, $dungeonfull2pos+3);

$dungeonfullTot = "Dungeons";
$result = mysql_query("SELECT val FROM pwdata WHERE name='$dungeonfullTot'") or die(mysql_error());
$dungeonfullTot = @ mysql_result($result,0);
$count = 0;$check = 0;

while($dungeonfullTot>0)
 {
$dungeonfullAct = "Dungeons".$dungeonfullTot;
$result = mysql_query("SELECT val FROM pwdata WHERE name='$dungeonfullAct'") or die(mysql_error());
$dungeonfullAct = @ mysql_result($result,0);

$dungeonplanet1pos = strpos($dungeonfullAct,"_A_");$dungeonplanet = substr($dungeonfullAct, 0, $dungeonplanet1pos);
$dungeonarea1pos = strpos($dungeonfullAct,"_B_");$dungeonarea1 = substr($dungeonfullAct, 0, $dungeonarea1pos);$dungeonarea2pos = strpos($dungeonarea1,"_A_");$dungeonarea2 = strlen($dungeonarea1);$dungeonarea = substr($dungeonarea1, $dungeonarea2pos+3);
$dungeonremains1pos = strpos($dungeonfullAct,"_B_");$dungeonremains = substr($dungeonfullAct, $dungeonremains1pos+3);

if(($dungeonplanet==$planet)&&($dungeonarea==$area)){$count = $dungeonremains;$check = 1;break;}

$dungeonfullTot--;
 }
?>

<font=Bell MT><font size=4><font bold=True><font color=#66CCFF>Dungeon type :<font color=#FFC800> <?php echo "$dungeontype" ?><br>
<br><font=Bell MT><font size=4><font bold=True><font color=#66CCFF>Dungeon monster family :<font color=#FFC800> <?php echo "$dungeonfamily" ?><br>

<?php 

if($dungeonfamily=="None"){ ?> <br><font=Bell MT><font size=4><font bold=True><font color=#66CCFF>Dungeon statut : <font color=#FFC800>Empty<br> <?php } 
else if($dungeonfamily=="Unknown"){ ?> <br><font=Bell MT><font size=4><font bold=True><font color=#66CCFF>Dungeon statut : <font color=#FFC800>Unknown<br> <?php } 
else if(($check>0)&&($count<11)){ ?> <br><font=Bell MT><font size=4><font bold=True><font color=#66CCFF>Dungeon statut : <font color=#FF0000>Empty<br> <?php } 
else if(($check>0)&&($count<$dungeonfull-10)){ ?> <br><font=Bell MT><font size=4><font bold=True><font color=#66CCFF>Dungeon statut : <font color=#FFFF00>Started<br> <?php } 
else{ ?> <br><font=Bell MT><font size=4><font bold=True><font color=#66CCFF>Dungeon statut : <font color=#00FF00>Full<br> <?php }
?>

    </td>

  </tr>

</table>


<?php
 }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Animal reserves
else if($inttype=="5")
 {
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
?>

<table border="1" cellpadding="10" cellspacing="0" style="border-collapse: collapse" bordercolor="#404040" width="100%">

  <tr>

    <td width="100%" valign="top" colspan="2">

<?php
$reserve1pos = strpos($interest,"_B_");$reserve1 = substr($interest, 0, $reserve1pos);$reserve2pos = strpos($reserve1,"_A_");$dungeontype2 = strlen($reserve1);$reserve = substr($reserve1, $reserve2pos+3);

$reserve11pos = strpos($interest,"_C_");$reserve11 = substr($interest, 0, $reserve11pos);$reserve12pos = strpos($reserve11,"_B_");$dungeontype12 = strlen($reserve11);$reserve1 = substr($reserve11, $reserve12pos+3);$reserve1L = substr($reserve1,0,1);
$reserve21pos = strpos($interest,"_D_");$reserve21 = substr($interest, 0, $reserve21pos);$reserve22pos = strpos($reserve21,"_C_");$dungeontype22 = strlen($reserve21);$reserve2 = substr($reserve21, $reserve22pos+3);$reserve2L = substr($reserve2,0,1);
$reserve31pos = strpos($interest,"_E_");$reserve31 = substr($interest, 0, $reserve31pos);$reserve32pos = strpos($reserve31,"_D_");$dungeontype32 = strlen($reserve31);$reserve3 = substr($reserve31, $reserve32pos+3);$reserve3L = substr($reserve3,0,1);
$reserve41pos = strpos($interest,"_F_");$reserve41 = substr($interest, 0, $reserve41pos);$reserve42pos = strpos($reserve41,"_E_");$dungeontype42 = strlen($reserve41);$reserve4 = substr($reserve41, $reserve42pos+3);$reserve4L = substr($reserve4,0,1);
$reserve51pos = strpos($interest,"_G_");$reserve51 = substr($interest, 0, $reserve51pos);$reserve52pos = strpos($reserve51,"_F_");$dungeontype52 = strlen($reserve51);$reserve5 = substr($reserve51, $reserve52pos+3);$reserve5L = substr($reserve5,0,1);
$i1 = 0;$reserveL = "";

while($i1<5)
 {
$i1++;if($i1==1){$reserveL = $reserve1L;}else if($i1==2){$reserveL = $reserve2L;}else if($i1==3){$reserveL = $reserve3L;}else if($i1==4){$reserveL = $reserve4L;}else if($i1==5){$reserveL = $reserve5L;}

if(($i1>$reserve)||($reserveL==0)||($reserveL=="")){$reserveL = "None";}
else if($reserveL==1){$reserveL = "Deers";}
else if($reserveL==2){$reserveL = "Wild Angus";}
else if($reserveL==3){$reserveL = "Badgers";}
else if($reserveL==4){$reserveL = "Bears";}
else if($reserveL==5){$reserveL = "Boars";}
else if($reserveL==6){$reserveL = "Goats";}

if($reserveL=="None") { ?> <font=Bell MT><font size=4><font bold=True><font color=#66CCFF>Pen <?php echo $i1; ?> :<font color=#FF0000> <?php echo $reserveL; ?><br> <?php }
else { ?> <font=Bell MT><font size=4><font bold=True><font color=#66CCFF>Pen <?php echo $i1; ?> :<font color=#FFC800> <?php echo $reserveL; ?><br> <?php }

 }
?>

    </td>

  </tr>

</table>

<?php
 }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
?>



<p align=right><font=Bell MT><font size=2><font bold=True><font color=#FFFFFF><u><a href="interests.php?planet=<?php echo "$planet" ?>&area=<?php echo "$area" ?>&login=<?php echo "$login" ?>&galaxyx=<?php echo "$galaxyx" ?>&galaxyy=<?php echo "$galaxyy" ?> ">actualise</a></u> - <u><a href="galaxy.php?planet=<?php echo "$planet" ?>&area=<?php echo "$area" ?>&login=<?php echo "$login" ?>&galaxyx=<?php echo "$galaxyx" ?>&galaxyy=<?php echo "$galaxyy" ?> ">back to map</a></u></p>

<br/>

<?php
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Disconnect from the server
mysql_close($link);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
?>


</body>

</html>