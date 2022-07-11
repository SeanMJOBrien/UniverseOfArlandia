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
//Error reporting/debug
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

/////////////////////////////////////////////////////////////////////////////////////////////////////
// Connect to the MySQL server on XAMPP
include("uoa.php");
$link = mysqli_connect("$host:$port", $user, $pass, $data)
// if no connection
or die ("service offline");
/////////////////////////////////////////////////////////////////////////////////////////////////////



/////////////////////////////////////////////////////////////////////////////////////////////////////
// Server statut
// THIS NEW ADDITION removes security when accessintg the NWmaster website... But it works. Apparently we should have the cert for the target website? Or the website I'm running?
// https://stackoverflow.com/questions/26148701/file-get-contents-ssl-operation-failed-with-code-1-failed-to-enable-crypto
$arrContextOptions=array(
    "ssl"=>array(
        "verify_peer"=>false, //disables security
        "verify_peer_name"=>false,
		"allow_self_signed"=>true,
		"capture_peer_cert"=>true,
		"capture_peer_cert_chain"=>true,
    ),
);  
// Need to add check and message when server is NOT running, which is the point
// 1. Server not running, 2. MySQL not running, 3. 404 on URL
$me = file_get_contents("https://api.nwn.beamdog.net/v1/servers/9EGU9XH+hrXUJlfoKjKt+VfpOjBzY58QkC1lQiy0M2U=", false, stream_context_create($arrContextOptions));
$jsonreceived = 'current_players';
$player_count = json_decode($me)->{'current_players'};
//
//
if($me==NULL)
 {
print("<a4><font face=Arial color=#FF0000 size=2>Offline</a4>\n");
 } 
else
{ 
$reboot = "Reboot";
$result = mysqli_query($link, "SELECT val FROM pwdata WHERE name='$reboot'")or die(mysqli_error($link));
$result = mysqli_fetch_assoc($result);
$result = implode($result);
//var_dump($result);
if($result=="rebooting")
  {
$time2 = $result;
  }
else
  {
$reboot11pos = strpos($result,"&&&");$reboot2 = substr($result, $reboot11pos+3);
//var_dump($reboot2);
$hour2 = 0;$minute2 = $reboot2;while($minute2>=60){$minute2 = $minute2-60;$hour2++;}if($minute2<10){$minute2 = "0".$minute2;}$time2 = $hour2."h".$minute2;
  }
print("<a4><font face=Arial color=#00FF00 size=2>Online</a4><br>\n");
$players = "Players: $player_count";
print("<a4><font face=Arial color=#E6E6E6 size=2>$players</a4><br>\n" );

print("<a4><font face=Arial color=#E6E6E6 size=1>next reboot : <font color=#00FFFF>$time2</a4>\n");

$result = mysqli_query($link,"SELECT val FROM pwdata WHERE name='Calendar'") or die(mysqli_error($link));
$result = mysqli_fetch_assoc($result);
$result = implode($result);
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
