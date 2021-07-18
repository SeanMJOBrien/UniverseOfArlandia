<?php
include("uoa.php");

echo $sql.'<BR>';
echo $port.'<BR>';
echo $host.'<BR>';
echo $user.'<BR>';
echo $pass.'<BR>';
echo $data.'<BR>';
echo $nwnport.'<BR>';

$link = mysqli_connect("$sql:$port", $user, $pass);

if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    exit;
	}
else{
	echo'working';
	$result = mysql_query("SELECT val FROM pwdata WHERE name='Calendar'") or die(mysql_error());
$result = @ mysql_result($result,0);
$year1pos = strpos($result,"/C1/");$year = substr($result, 0, $year1pos);
$month1pos = strpos($result,"/C2/");$month1 = substr($result, 0, $month1pos);$month2pos = strpos($month1,"/C1/");$month2 = strlen($month1);$month = substr($month1, $month2pos+4);
$day1pos = strpos($result,"/C3/");$day1 = substr($result, 0, $day1pos);$day2pos = strpos($day1,"/C2/");$day2 = strlen($day1);$day = substr($day1, $day2pos+4);
$hour1pos = strpos($result,"/C4/");$hour1 = substr($result, 0, $hour1pos);$hour2pos = strpos($hour1,"/C3/");$hour2 = strlen($hour1);$hour = substr($hour1, $hour2pos+4);
	}
?>