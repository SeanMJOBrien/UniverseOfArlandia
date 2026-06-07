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
// Connect to the MySQL server
include("uoa.php");
// The mysqli_connect function parameters are: host, user, password, database, port.
$link = @ mysqli_connect($host, $user, $pass, $data, (int)$port);

// if no connexion
if (!$link) {
    die("service offline");
}

// Prepare a reusable statement for fetching data. This is more secure and efficient.
$stmt_select_val = mysqli_prepare($link, "SELECT val FROM pwdata WHERE name = ?");
if (!$stmt_select_val) {
    die("Prepare failed: " . mysqli_error($link));
}
/////////////////////////////////////////////////////////////////////////////////////////////////////



/////////////////////////////////////////////////////////////////////////////////////////////////////
// Server statut
$me = @file_get_contents("https://api.nwn.beamdog.net/v1/servers/142.47.97.210/5121");
$decoded_json = json_decode($me);
// Use null coalescing operator to prevent errors if API call fails or JSON is malformed.
$player_count = $decoded_json->current_players ?? 0;

{ 
$reboot = "Reboot";
// Execute prepared statement to get reboot info
mysqli_stmt_bind_param($stmt_select_val, "s", $reboot);
mysqli_stmt_execute($stmt_select_val);
$query_result = mysqli_stmt_get_result($stmt_select_val);
$row = mysqli_fetch_assoc($query_result);
$result = $row ? $row['val'] : '';

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
$players = "Players: $player_count";
print("<a4><font face=Arial color=#E6E6E6 size=2>$players</a4><br>\n" );

print("<a4><font face=Arial color=#E6E6E6 size=1>next reboot : <font color=#00FFFF>$time2</a4>\n");

// Execute prepared statement to get calendar info
$calendar_var = 'Calendar';
mysqli_stmt_bind_param($stmt_select_val, "s", $calendar_var);
mysqli_stmt_execute($stmt_select_val);
$query_result = mysqli_stmt_get_result($stmt_select_val);
$row = mysqli_fetch_assoc($query_result);
$result = $row ? $row['val'] : '';

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
// Close the statement and the connection
mysqli_stmt_close($stmt_select_val);
mysqli_close($link);
?>

    </b></td>
  </tr>
</table>

</body>

</html>
