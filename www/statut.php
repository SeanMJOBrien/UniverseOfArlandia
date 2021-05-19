<html>

<head>
<TITLE></TITLE> 
<META NAME="description" Content="Universe of Arlandia for Neverwinter Nights - The Universe is infinite"> 
<META NAME="keywords" Content="arlandia uoa universe neverwinter nights nwn lkt therack the rack marc racordon"> 
<META NAME="author" CONTENT="TheRack"> 
<META NAME="Copyright" CONTENT="TheRack, 2009">
<META NAME="GENERATOR" CONTENT="Microsoft FrontPage 5.0">
<META NAME="Robot" CONTENT="INDEX,FOLLOW"> 
<META HTTP-EQUIV="Content-Language" CONTENT="fr-ch" > 
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<META HTTP-EQUIV="refresh" content="60"> 
<style fprolloverstyle>A:hover {color: #00FF00;}</style>
</head>

<body background=transparent topmargin="0" leftmargin="0" bgcolor="#000000" link="#FFFFFF" text="#FFFFFF" vlink="#FFFFFF" alink="#FFFFFF">

<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" width="100%" height="100%">
  <tr>
    <td width="100%" align="center"><b>

<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

/////////////////////////////////////////////////////////////////////////////////////////////////////
// Connect to the MySQL server on Wamp
include("uoa.php");
$link = @ mysqli_connect("$host:$port", $user, $pass)
// $link = @ mysqli_connect("$host:$port", $user, $pass)
// if no connexion
or die ("service offline");
// Select the base
mysqli_select_db($link,"uoa");
/////////////////////////////////////////////////////////////////////////////////////////////////////



/////////////////////////////////////////////////////////////////////////////////////////////////////
// Server statut
//$timeout = 5;
//$connect = fsockopen( "udp://" . $host, $nwnport, $errno, $errstr, $timeout);
//
/*socket_set_timeout( $connect, $timeout );
$send = "\xFE\xFD\x00\xE0\xEB\x2D\x0E\x14\x01\x0B\x01\x05\x08\x0A\x33\x34\x35\x13\x04\x36\x37\x38\x39\x14\x3A\x3B\x3C\x3D\x00\x00";
fwrite( $connect, $send );
$output = fread( $connect, 5000 );
$lines = explode("\x00",$output);
$server = 0; */
//var_dump($output);
//var_dump($lines);

//$me = file_get_contents("https://api.nwn.beamdog.net/v1/servers/KMAlOlC8a0WPKn+Uwmt7n4S87agz4jfxHMnLuqh7hw0="); // Public Key?
$me = file_get_contents("https://api.nwn.beamdog.net/v1/servers/142.47.97.210/5121");
$player_count = json_decode($me)->{'current_players'};
// orig $connect = fsockopen( "udp://" . $host, $nwnport, $errno, $errstr, $timeout);
//
/*socket_set_timeout( $connect, $timeout );
$send = "\xFE\xFD\x00\xE0\xEB\x2D\x0E\x14\x01\x0B\x01\x05\x08\x0A\x33\x34\x35\x13\x04\x36\x37\x38\x39\x14\x3A\x3B\x3C\x3D\x00\x00";
fwrite( $connect, $send );
$output = fread( $connect, 5000 );
$lines = explode("\x00",$output);
$server = 0; */
//
/* if(!$player_count)
 {
print("<a4><font face=Arial color=#FF0000 size=2>Offline</a4>\n");
 }
else */
{ 
$reboot = "Reboot";
$result = mysqli_query($link,"SELECT val FROM pwdata WHERE name='$reboot'")or die(mysql_error());
$result = @ mysqli_fetch_assoc($result,0);
if($result=="rebooting")
  {
$time2 = $result;
  }
else
  {
$reboot11pos = strpos($result,"&&&");$reboot2 = substr($result, $reboot11pos+3);
$hour2 = 0;$minute2 = $reboot2;while($minute2>=60){$minute2 = $minute2-60;$hour2++;}if($minute2<10){$minute2 = "0".$minute2;}$time2 = $hour2."h".$minute2;
  }
print("<a4><font face=Arial color=#00FF00 size=2>Online</a4><br>\n");
// Original line: $player_count = "players";if($lines[5]<2){$players = "";}print("<a4><font face=Arial color=#E6E6E6 size=2>$lines[5] $players</a4><br>\n" );
//if($lines[5]<2){$players = "Players: $player_count";}
$players = "Players: $player_count";
print("<a4><font face=Arial color=#E6E6E6 size=2>$players</a4><br>\n" );

print("<a4><font face=Arial color=#E6E6E6 size=1>next reboot : <font color=#00FFFF>$time2</a4>\n");

$result = mysqli_query($link,"SELECT val FROM pwdata WHERE name='Calendar'") or die(mysql_error());
$result = @ mysqli_fetch_assoc($result,0);
$year1pos = strpos($result,"/C1/");$year = substr($result, 0, $year1pos);
$month1pos = strpos($result,"/C2/");$month1 = substr($result, 0, $month1pos);$month2pos = strpos($month1,"/C1/");$month2 = strlen($month1);$month = substr($month1, $month2pos+4);
$day1pos = strpos($result,"/C3/");$day1 = substr($result, 0, $day1pos);$day2pos = strpos($day1,"/C2/");$day2 = strlen($day1);$day = substr($day1, $day2pos+4);
$hour1pos = strpos($result,"/C4/");$hour1 = substr($result, 0, $hour1pos);$hour2pos = strpos($hour1,"/C3/");$hour2 = strlen($hour1);$hour = substr($hour1, $hour2pos+4);

?><br><br><?php
print("<a4><font face=Arial color=#E6E6E6 size=1>date : <font color=#00FFFF>$day.$month.$year</a4>\n");
print("<a4><font face=Arial color=#E6E6E6 size=1>hour : <font color=#00FFFF>$hour</a4>h...\n");

$server = 1;
 }
/////////////////////////////////////////////////////////////////////////////////////////////////////
?>

    </b></td>
  </tr>
</table>

</body>

</html>
