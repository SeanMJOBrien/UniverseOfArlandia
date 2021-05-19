<html>

<head>
<TITLE></TITLE> 
<META NAME="description" Content="Universe of Arlandia for Neverwinter Nights - The Universe is infinite"> 
<META NAME="keywords" Content="arlandia uoa universe neverwinter nights nwn lkt the rack therack marc racordon"> 
<META NAME="author" CONTENT="TheRack"> 
<META NAME="Copyright" CONTENT="TheRack, 2009">
<META NAME="GENERATOR" CONTENT="Microsoft FrontPage 5.0">
<META HTTP-EQUIV="Content-Language" CONTENT="fr-ch" > 
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<style fprolloverstyle>A:hover {color: #00FF00;}</style>
</head>

<body topmargin="0" leftmargin="30" text="#FFFFFF" link="#FFFFFF" vlink="#FFFFFF" alink="#FFFFFF" background="UOA_BG2.jpg">

<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Connect to the MySQL server on Wamp
include("uoa.php");
$link = @ mysqli_connect("$host:$port", $user, $pass)
// if no connexion
or die ("service offline");
// Select the base
mysqli_select_db($link,"uoa");
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Planet name
$galaxyx = @ $_GET['galaxyx'];if($galaxyx==""){$galaxyx = 0;}
$galaxyy = @ $_GET['galaxyy'];if($galaxyy==""){$galaxyy = 0;}
$login = @ $_GET['login'];
$system = @ $_GET['system'];
$planet = @ $_GET['planet'];
$server = @ $_GET['server'];
$result = mysqli_query($link, "SELECT val FROM pwdata WHERE name='$planet'")or die(mysqli_error($link));
// orig $result = @ mysqli_result($result,0);
$result = @ mysqli_fetch_assoc($result,0); 
$tiletype1pos = strpos($result,"&003&");$tiletype1 = substr($result, 0, $tiletype1pos);$tiletype2pos = strpos($tiletype1,"&002&");$tiletype2 = strlen($tiletype1);$tiletype = substr($tiletype1, $tiletype2pos+5);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if($planet=="infos")
 {
?>
<br><p align=right><font=Bell MT><font size=2><font bold=True><font color=#FFFFFF><u><a href="galaxy.php?planet=<?php echo "$planet" ?> ">actualise</a></u></p>

<table border="0" cellpadding="5" cellspacing="0" style="border-collapse: collapse" bordercolor="#FFFFFF" width="100%">
  <tr>
    <td width="20%" valign="top">

<p><b><font face="Arial" size="2"><font color="#66CCFF">&nbsp;&nbsp;<u>Server time</u> :</font></p>
<b><font face="Arial" size="2"><font color="#66CCFF">&nbsp;&nbsp;<u>Server reboot</u> :</font>

    </td>
    <td width="80%" valign="top">

<?php
$reboot = "Reboot";
$result = mysqli_query($link,"SELECT val FROM pwdata WHERE name='$reboot'")or die(mysql_error());
// orig $result = mysql_query("SELECT val FROM pwdata WHERE name='$reboot'")or die(mysql_error());
$result = @ mysqli_fetch_assoc($result,0);
if($result=="")
  {
$time1 = "offline";$time2 = $time1;
  }
else if($result=="rebooting")
  {
$time1 = $result;$time2 = $time1;
  }
else
  {
$reboot11pos = strpos($result,"&&&");$reboot1 = substr($result, 0, $reboot11pos);$reboot2 = substr($result, $reboot11pos+3);
$hour1 = 0;$minute1 = $reboot1;while($minute1>=60){$minute1 = $minute1-60;$hour1++;}if($minute1<10){$minute1 = "0".$minute1;}$time1 = $hour1."h".$minute1;
$hour2 = 0;$minute2 = $reboot2;while($minute2>=60){$minute2 = $minute2-60;$hour2++;}if($minute2<10){$minute2 = "0".$minute2;}$time2 = $hour2."h".$minute2;
  }
?>

<p><b><font face="Arial" size="2"><font color="#FFC800"><?php echo "$time1"; ?></font></p>
<b><font face="Arial" size="2"><font color="#FFC800"><?php echo "$time2"; ?></font>

    </td>
  </tr>
</table>

<br/>
<br/>

<table border="1" cellpadding="5" cellspacing="0" style="border-collapse: collapse" bordercolor="#FFFFFF" width="100%">
  <tr>
    <td width="25%" align="center" valign="top" bgcolor="#005064"><b><font face="Arial" size="2"><font color="#66CCFF"><u>Player</u> :</font></td>
    <td width="25%" align="center" valign="top" bgcolor="#005064"><b><font face="Arial" size="2"><font color="#66CCFF"><u>Character</u> :</font></td>
    <td width="25%" align="center" valign="top" bgcolor="#005064"><b><font face="Arial" size="2"><font color="#66CCFF"><u>Planet</u> :</font></td>
    <td width="25%" align="center" valign="top" bgcolor="#005064"><b><font face="Arial" size="2"><font color="#66CCFF"><u>Area</u> :</font></td>
  </tr>

<?php

$players = "Players";
$result = mysqli_query($link,"SELECT val FROM pwdata WHERE name='$players'")or die(mysql_error());
$players = @ mysqli_fetch_assoc($result,0);

while($players>0)
  {
$player = "Player".$players;
$result = mysqli_query($link,"SELECT val FROM pwdata WHERE name='$player'")or die(mysql_error());
$player = @ mysqli_fetch_assoc($result,0);

$var11pos = strpos($player,"&1&");$var1 = substr($player, 0, $var11pos);$var1 = str_replace("~","'",$var1);
$var21pos = strpos($player,"&2&");$var21 = substr($player, 0, $var21pos);$var22pos = strpos($var21,"&1&");$var22 = strlen($var21);$var2 = substr($var21, $var22pos+3);$var2 = str_replace("~","'",$var2);
$var31pos = strpos($player,"&3&");$var31 = substr($player, 0, $var31pos);$var32pos = strpos($var31,"&2&");$var32 = strlen($var31);$var3 = substr($var31, $var32pos+3);$var3 = str_replace("~","'",$var3);
$var41pos = strpos($player,"&4&");$var41 = substr($player, 0, $var41pos);$var42pos = strpos($var41,"&3&");$var42 = strlen($var41);$var4 = substr($var41, $var42pos+3);$var4 = str_replace("~","'",$var4);
$var51pos = strpos($player,"&5&");$var51 = substr($player, 0, $var51pos);$var52pos = strpos($var51,"&4&");$var52 = strlen($var51);$var5 = substr($var51, $var52pos+3);$var5 = str_replace("~","'",$var5);

if($var1!="")
   { 
?>

  <tr>
   <td width="25%" align="center" valign="top"><b><font face="Arial" size="2"><font color="#FFC800"> <?php echo "$var1";?> </font></td>
   <td width="25%" align="center" valign="top"><b><font face="Arial" size="2"><font color="#FFC800"> <?php echo "$var2"; if($var5=="1"){ ?><font color="#FF0000"><?php echo " (DM)";} ?> </font></td>
   <td width="25%" align="center" valign="top"><b><font face="Arial" size="2"><font color="#FFC800"> <?php echo "$var3";?> </font></td>
   <td width="25%" align="center" valign="top"><b><font face="Arial" size="2"><font color="#FFC800"> <?php echo "$var4";?> </font></td>
  </tr>

<?php
   }
$players--;
  }

?>

</table>

<p align=right><font=Bell MT><font size=2><font bold=True><font color=#FFFFFF><u><a href="galaxy.php?planet=<?php echo "$planet" ?> ">actualise</a></u></p><br>
<?php
 }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Stars
else if((substr($tiletype,0,1)=="b")||(substr($tiletype,0,1)=="s"))
 {
echo "<br/>";
?><center><font=Bell MT><font size=+1><font bold=True><font color=#66CCFF><u><?php echo "$planet";?></u><?php
echo "<br/>";
echo "<br/>";
?><p><img border="0" src="<?php echo "$tiletype" ?>.jpg"></p><?php
echo "<br/>";
 }
else
 {
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Other automatic parameters and page layout
echo "<br/>";
$planetname = $planet;if($planetname=="Space"){$planetname = "$system";}
?><center><font=Bell MT><font size=+1><font bold=True><font color=#66CCFF><u><?php echo "$planetname";?></u><?php
echo "<br/>";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Define show variables
$show = "ShowAreas";
$result = mysqli_query($link, "SELECT val FROM pwdata WHERE name='$show'")or die(mysqli_error());
$showAreas = @ mysqli_fetch_assoc($result,0);
//
$show = "ShowInterests";
$result = mysqli_query($link, "SELECT val FROM pwdata WHERE name='$show'")or die(mysql_error());
$showInterests = @ mysqli_fetch_assoc($result,0);
//
$show = "ShowPlanets";
$result = mysqli_query($link, "SELECT val FROM pwdata WHERE name='$show'")or die(mysql_error());
$showPlanets = @ mysqli_fetch_assoc($result,0);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Planet size
if($planet=="Space")
 {
$size = 30;

$system = $system."SystemCenter";
$result = mysqli_query("SELECT val FROM pwdata WHERE name='$system'")or die(mysql_error());
$result = @ mysql_result($result,0);

$systempos = strpos($result,"_");
$systemx = substr($result, 0, $systempos);
$systemy = substr($result, -1, (strlen($result)-$systempos-1));

if(($systemx!="")&&($systemx!="0")){$galaxyx = $systemx/($size/2);$galaxyx = intval($galaxyx);}
if(($systemy!="")&&($systemy!="0")){$galaxyy = $systemy/($size/2);$galaxyy = intval($galaxyy);}

if($galaxyx==""){$galaxyx = 0;}
if($galaxyy==""){$galaxyy = 0;}

?>

<br/>

<table border="0" cellpadding="0" cellspacing="0">

  <tr>
   <td width="33%" align="center" valign="top"></td>
   <td width="34%" align="center" valign="top"><a href="galaxy.php?planet=<?php echo "Space" ?>&login=<?php echo "$login" ?>&galaxyx=<?php echo "$galaxyx" ?>&galaxyy=<?php echo "$galaxyy"+1 ?>"><img border="0" src=Arrow_N.gif    alt=North /></td>
   <td width="33%" align="center" valign="top"></td>
  </tr>
  <tr>
   <td width="33%" align="center" valign="top"><a href="galaxy.php?planet=<?php echo "Space" ?>&login=<?php echo "$login" ?>&galaxyx=<?php echo "$galaxyx"-1 ?>&galaxyy=<?php echo "$galaxyy" ?>"><img border="0" src=Arrow_W.gif    alt=West /></td>
   <td width="34%" align="center" valign="top"></td>
   <td width="33%" align="center" valign="top"><a href="galaxy.php?planet=<?php echo "Space" ?>&login=<?php echo "$login" ?>&galaxyx=<?php echo "$galaxyx"+1 ?>&galaxyy=<?php echo "$galaxyy" ?>"><img border="0" src=Arrow_E.gif    alt=East /></td>
  </tr>
  <tr>
   <td width="33%" align="center" valign="top"></td>
   <td width="34%" align="center" valign="top"><a href="galaxy.php?planet=<?php echo "Space" ?>&login=<?php echo "$login" ?>&galaxyx=<?php echo "$galaxyx" ?>&galaxyy=<?php echo "$galaxyy"-1 ?>"><img border="0" src=Arrow_S.gif    alt=South /></td>
   <td width="33%" align="center" valign="top"></td>
  </tr>

</table>

<?php
 }

else
 {
$result = mysqli_query($link,"SELECT val FROM pwdata WHERE name='$planet'")or die(mysql_error());
$result = @ mysqli_fetch_assoc($result,0);
$size1pos = strpos($result,"&002&");$size1 = substr($result, 0, $size1pos);$size2pos = strpos($size1,"&001&");$size2 = strlen($size1);$size = substr($size1, $size2pos+5);
 }
$Y = $size/2+1;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// If not Universe, show local informations
if($planet!="Space"){
?>

<div align="center">
  <center>

<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#FFFFFF" width="100%">

  <tr>

    <td colspan="4">

<p align="left"><font=Bell MT><font size=+1><font bold=True><font color=#66CCFF><u>Local informations</u> :</font><p/>

<?php
$result = mysqli_query($link,"SELECT val FROM pwdata WHERE name='$planet'") or die(mysql_error());
$result = @ mysqli_fetch_assoc($result,0);
$descr1pos = strpos($result,"&010&");$descr1 = substr($result, 0, $descr1pos);$descr2pos = strpos($descr1,"&009&");$descr2 = strlen($descr1);$descr = substr($descr1, $descr2pos+5);
$descr = str_replace("~","'",$descr);
if(($descr=="")||($descr=="0")){$descr = "no description";}
?>

<p><font=Bell MT><font size=+1><font bold=True><font color=#00FFFF> <?php echo $descr; ?> </font><p/>

   </td>

 </tr>

 <tr>

   <td width="30%" valign="top">

<br>

<p><font=Bell MT><font size=+1><font bold=True><font color=#66CCFF>Position :</font><p/><br/>
<p><font=Bell MT><font size=+1><font bold=True><font color=#66CCFF>Level :</font><p/><br/>

   </td>

   <td width="30%" valign="top">

<?php
// Planet Position and Level
$result = mysqli_query($link,"SELECT val FROM pwdata WHERE name='$planet'") or die(mysql_error());
$result = @ mysqli_fetch_assoc($result,0);
$position1pos = strpos($result,"&001&");$position = substr($result, 0, $position1pos);
$level1pos = strpos($result,"&009&");$level1 = substr($result, 0, $level1pos);$level2pos = strpos($level1,"&008&");$level2 = strlen($level1);$level = substr($level1, $level2pos+5);if(($level=="")||($level==0)){$level = "unknown";}
?>

<br>
<p><font=Bell MT><font size=+1><font bold=True><font color=#00FFFF><?php echo "$position" ?></font><p/><br/>
<p><font=Bell MT><font size=+1><font bold=True><font color=#00FFFF><?php echo "$level" ?></font><p/><br/>

<?php
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
?>

    </td>

    <td width="20%" valign="top">
<br/>

<p><font=Bell MT><font size=+1><font bold=True><font color=#66CCFF>Time :</font><p/><br/>
<p><font=Bell MT><font size=+1><font bold=True><font color=#66CCFF>Weather :</font><p/><br/>

    </td>

    <td width="20%" valign="top">

<?php
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Day/Night
$result = mysqli_query($link,"SELECT val FROM pwdata WHERE name='Calendar'") or die(mysql_error());
$result = @ mysqli_fetch_assoc($result,0);
$time1pos = strpos($result,"/C4/");$time1 = substr($result, 0, $time1pos);$time2pos = strpos($time1,"/C3/");$time2 = strlen($time1);$time = substr($time1, $time2pos+4);

     if(($time>=8)&&($time<=20)){echo "<img src=time_day.gif    alt=Day />";}
else				{echo "<img src=time_night.gif  alt=Night />";}

?>

<br/>
<br/>

<?php
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Weather

$result = mysqli_query($link,"SELECT val FROM pwdata WHERE name='$planet'") or die(mysql_error());
$result = @ mysqli_fetch_assoc($result,0);
$weather1pos = strpos($result,"&011&");$weather1 = substr($result, 0, $weather1pos);$weather2pos = strpos($weather1,"&010&");$weather2 = strlen($weather1);$weather = substr($weather1, $weather2pos+5);

     if($weather=="0") {echo "<img src=weather_clear.gif  alt=Clear />";}
else if($weather=="1") {echo "<img src=weather_rain.gif  alt=Rain />";}
else if($weather=="2") {echo "<img src=weather_snow.gif  alt=Snow />";}
else if($weather=="3") {echo "<img src=weather_fog.gif  alt=Fog />";}
else if($weather=="4") {echo "<img src=weather_storm.gif  alt=Storm />";}

?>
<br/>

    </td>

  </tr>
</table>

<?php
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}
?>

<br>

  <table border="1" cellpadding="0" cellspacing="1" bordercolor="#C0C0C0">

<?php
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Map
// Start with upper line then goes down

while($Y>-($size/2+1))
 {

?><tr><?php

// Upper mapper
if($Y==($size/2)+1)
   {
$X = -($size/2);

?><td><?php echo "<img src=black.gif />";

while($X<$size/2+1)
    {

?><td bgcolor="#005064"><center><?php if($galaxyx!=0){echo $X+($galaxyx*15);}else{echo $X;}

$X++;
    }
   }
else
   {

$X = -($size/2)-1;
while($X<$size/2+1)
   {

// Left mapper
if($X==-($size/2)-1)
    {

?><td bgcolor="#005064"><center><?php if($galaxyy!=0){echo $Y+($galaxyy*15);}else{echo $Y;}

    }
else
    {

// Start with the left column then goes down

     if(($galaxyx!=0)&&($galaxyy!=0)){$XX = $X+($galaxyx*15);$YY = $Y+($galaxyy*15);}
else if($galaxyx!=0){$XX = $X+($galaxyx*15);$YY = $Y;}
else if($galaxyy!=0){$XX = $X;$YY = $Y+($galaxyy*15);}
else{$XX = $X;$YY = $Y;}

$area = "_".$XX."_".$YY;

//$type = "_Type";

// Tile
$planetarea = $planet."AreasX".$XX;
$result = mysqli_query($link,"SELECT val FROM pwdata WHERE name='$planetarea'") or die(mysql_error());
$tile = @ mysqli_fetch_assoc($result,0);
$s1 = "+".$YY;if($YY<=-10){$s1 = "-".-$YY;}else if($YY<0){$s1 = "-0".-$YY;}else if($YY<10){$s1 = "+0".$YY;}
$s1b = "+".($YY-1);if(($YY-1)<=-10){$s1b = "-".(-$YY+1);}else if(($YY-1)<0){$s1b = "-0".(-$YY+1);}else if(($YY-1)<10){$s1b = "+0".($YY-1);}
if($YY==-($size/2)){$tilepos = strpos($tile,"&".$s1."&");$tiletype = substr($tile, 0, $tilepos);}else{$tile1pos = strpos($tile,"&".$s1."&");$tile1 = substr($tile, 0, $tile1pos);$tile2pos = strpos($tile1,"&".$s1b."&");$tile2 = strlen($tile1);$tiletype = substr($tile1, $tile2pos+5);}

$show = 0;if(substr($tiletype,-1,1)=="*"){$tiletype = substr($tiletype,0,strlen($tiletype)-1);$show = 1;}

if($planet!="Space")
 {
     if($tiletype=="01"){$tiletype = "clouds";}
else if($tiletype=="02"){$tiletype = "desert";}
else if($tiletype=="03"){$tiletype = "foothills";}
else if($tiletype=="04"){$tiletype = "forest";}
else if($tiletype=="05"){$tiletype = "frozenland";}
else if($tiletype=="22"){$tiletype = "gaz";}
else if($tiletype=="06"){$tiletype = "ground";}
else if($tiletype=="07"){$tiletype = "hills";}
else if($tiletype=="08"){$tiletype = "moon";}
else if($tiletype=="09"){$tiletype = "mountain";}
else if($tiletype=="10"){$tiletype = "mountsnow";}
else if($tiletype=="11"){$tiletype = "mounts";}
else if($tiletype=="12"){$tiletype = "ocean";}
else if($tiletype=="13"){$tiletype = "plain";}
else if($tiletype=="14"){$tiletype = "river";}
else if($tiletype=="15"){$tiletype = "rural";}
else if($tiletype=="16"){$tiletype = "ruralcastle";}
else if($tiletype=="17"){$tiletype = "ruralswamp";}
else if($tiletype=="18"){$tiletype = "seafloor";}
else if($tiletype=="19"){$tiletype = "snow";}
else if($tiletype=="20"){$tiletype = "swamp";}
else if($tiletype=="21"){$tiletype = "tropical";}
 }

?><td width="24" height="24"><?php

// Interests
$area = $XX."_".$YY;
$area = str_replace("-", "m", $area); 
$interests = $planet."&".$area."&Interests";
$result = mysqli_query($link,"SELECT val FROM pwdata WHERE name='$interests'") or die(mysql_error());
$interests = @ mysqli_fetch_assoc($result,0);

// Interest
$interest1pos = strpos($interests,"&1&");$interest = substr($interests, 0, $interest1pos);
$interest2 = substr($interest, 0, 1);
// Name
$name1pos = strpos($interests,"&2&");$name1 = substr($interests, 0, $name1pos);$name2pos = strpos($name1,"&1&");$name2 = strlen($name1);$name = substr($name1, $name2pos+3);
// Planet type
$var1pos = strpos($interests,"&3&");$var1 = substr($interests, 0, $var1pos);$var2pos = strpos($var1,"&2&");$var2 = strlen($var1);$var = substr($var1, $var2pos+3);
$type = $var;
$alt1 = $XX."_".$YY."&nbsp;:&nbsp;";
$alt1 = str_replace("-", "m", $alt1);
$alt2 = ucwords("$tiletype");
$alt3 = $alt1.$alt2;
$tiletype2 = substr($tiletype, 0, 4);if($tiletype2=="city"){$tiletype = $tiletype2;$alt3 = $alt1.$name;}
// Interest visible
$visible1pos = strpos($interests,"&4&");$visible1 = substr($interests, 0, $visible1pos);$visible2pos = strpos($visible1,"&3&");$visible2 = strlen($visible1);$visible = substr($visible1, $visible2pos+3);
if(($visible==0)&&($login!=$dmlogin)){$interest2 = "";}
// Planet show
$planetshow = "Space".$area;
$planetshow = mysqli_query($link,"SELECT val FROM pwdata WHERE name='$planetshow'") or die(mysql_error());
$planetshow = @ mysqli_fetch_assoc($planetshow,0);
$planetshow1pos = strpos($planetshow,"&005&");$planetshow1 = substr($planetshow, 0, $planetshow1pos);$planetshow2pos = strpos($planetshow1,"&004&");$planetshow2 = strlen($planetshow1);$planetshow1 = substr($planetshow1, $planetshow2pos+5);
$planetshow2 = "Space".$area."Show";
$planetshow2 = mysqli_query($link,"SELECT val FROM pwdata WHERE name='$planetshow2'") or die(mysql_error());
$planetshow2 = @ mysqli_fetch_assoc($planetshow2,0);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Put right icon with or without link
$space = "Space".$area;
$result = @ mysqli_query($link, "SELECT val FROM pwdata WHERE name='$space'") or die(mysql_error());
$space = @ mysqli_fetch_assoc($result,0);

if((($tiletype!="")&&(($login==$dmlogin)||($show==1)||($showAreas==1)||(($showInterests==1)&&($interest2!="")))||(($planet=="Space")&&($planetshow!="")&&(($login==$dmlogin)||($planetshow1==1)||($planetshow2==1)))))
     {
$area = $XX."_".$YY;
$area = str_replace("-", "m", $area);

if($planet=="Space"){if($space!=""){$name1pos = strpos($space,"&001&");$name = substr($space, 0, $name1pos);$tiletype1pos = strpos($space,"&004&");$tiletype1 = substr($space, 0, $tiletype1pos);$tiletype2pos = strpos($tiletype1,"&003&");$tiletype2 = strlen($tiletype1);$tiletype = substr($tiletype1, $tiletype2pos+5);$alt3 = $alt1.$name;$tiletype2 = $tiletype;}else{$tiletype2 = "space";}}
else if($interest2=="D"){$alt3 = $alt1."Domain";$tiletype2 = $tiletype."_doma";}
else if($interest2=="1"){$alt3 = $alt1.$name;$tiletype2 = $tiletype."_town";}
else if($interest2=="2"){$alt3 = $alt1."Dungeon";$tiletype2 = $tiletype."_dung";}
else if($interest2=="3"){$alt3 = $alt1."Castle";$tiletype2 = $tiletype."_cast";}
else if($interest2=="4"){$alt3 = $alt1."Ruins";$tiletype2 = $tiletype."_ruin";}
else if($interest2=="5"){$alt3 = $alt1."Animal reserve";$tiletype2 = $tiletype."_anre";}
else if($interest2=="6"){$alt3 = $alt1."Resource mountain";$tiletype2 = $tiletype."_remo";}
else if($interest2=="7"){$alt3 = $alt1."Amusement place";$tiletype2 = $tiletype."_amus";}
else{$tiletype2 = $tiletype;}

?> <p><a title="<?php echo "$alt3" ?>" <?php if(($tiletype=="city")||($interest2>0)||($interest2=="D")) { ?> href="interests.php?planet=<?php echo "$planet" ?>&area=<?php echo "$area" ?>&login=<?php echo "$login" ?>&galaxyx=<?php echo "$galaxyx" ?>&galaxyy=<?php echo "$galaxyy" ?>"<?php } else if(($planet=="Space")&&($tiletype!="")){ ?> href="galaxy.php?planet=<?php echo "$name" ?>&login=<?php echo "$login" ?>&galaxyx=<?php echo "$galaxyx" ?>&galaxyy=<?php echo "$galaxyy" ?>"<?php } ?> ><img border="0" src="<?php echo "$tiletype2" ?>.gif"></a></p> <?php
     }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    }

?></td><?php

$X++;
   }
  }

?></tr><?php

$Y--;
 }

?>


  </table>
  </center>
</div>


<br/>
<br/>


<?php
 }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Disconnect from the server
mysqli_close($link);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
?>


</body>

</html>
