<html>
<head>
<TITLE>UOA Galaxy Viewer</TITLE> 
<META NAME="description" Content="Universe of Arlandia for Neverwinter Nights - The Universe is infinite"> 
<META NAME="keywords" Content="arlandia, uoa, universe, neverwinter nights, nwn, lkt, the rack, therack, marc racordon"> 
<META NAME="author" CONTENT="TheRack"> 
<META NAME="Copyright" CONTENT="TheRack, 2009-2011">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<style>
    body {
        margin: 0;
        padding: 0 30px;
        background-color: #000;
        color: #FFFFFF;
        font-family: Arial, sans-serif;
        background-image: url('UOA_BG2.jpg');
    }
    a { color: #FFFFFF; }
    a:hover { color: #00FF00; }
    font { /* Basic support for legacy font tag */
        font-family: "Bell MT", Times, serif;
    }
    .feedback-message {
        padding: 10px;
        margin: 15px 0;
        border: 1px solid #008f00;
        background-color: #0c4b0c;
        color: #9dff9d;
        font-weight: bold;
        text-align: center;
        border-radius: 4px;
    }
    .action-button {
        background-color: #a00;
        color: white;
        border: 1px solid #d00;
        padding: 4px 8px;
        cursor: pointer;
        border-radius: 3px;
        font-weight: bold;
    }
    .action-button:hover {
        background-color: #c00;
    }
</style>
</head>

<body topmargin="0" leftmargin="30" text="#FFFFFF" link="#FFFFFF" vlink="#FFFFFF" alink="#FFFFFF" background="UOA_BG2.jpg">

<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Connect to the MySQL server
include("uoa.php");
$link = mysqli_connect($host, $user, $pass, $data, (int)($port ?? 3306));
if (!$link) {
    die("service offline");
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// --- ACTION: HANDLE PLAYER COORDINATE RESET ---
// This block runs before any HTML output to handle the form submission.
if (isset($_POST['reset_player_char_name'])) {
    $charToReset = $_POST['reset_player_char_name'];
    $playerKeyToUpdate = null;
    $playerDataToUpdate = null;

    // We must query the database directly here to find the player key
    $stmt = mysqli_prepare($link, "SELECT name, val FROM pwdata WHERE name LIKE 'Player%'");
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);

    while ($row = mysqli_fetch_assoc($result)) {
        $playerData = $row['val'];
        // Parse character name (var2) from the data string
        $var1pos = strpos($playerData, "&1&");
        $var2pos = strpos($playerData, "&2&");
        if ($var1pos !== false && $var2pos !== false) {
            $charName = substr($playerData, $var1pos + 3, $var2pos - ($var1pos + 3));
            $charName = str_replace("~", "'", $charName);
            if ($charName === $charToReset) {
                $playerKeyToUpdate = $row['name'];
                $playerDataToUpdate = $playerData;
                break;
            }
        }
    }
    mysqli_stmt_close($stmt);

    if ($playerKeyToUpdate && $playerDataToUpdate) {
        // Use a regular expression to safely replace the coordinates between &3& and &4&
        $pattern = '/(&3&)(.*?)(?=&4&)/';
        $replacement = '$10_0'; // $1 preserves the "&3&" part
        $newPlayerData = preg_replace($pattern, $replacement, $playerDataToUpdate, 1);

        if ($newPlayerData !== null && $newPlayerData !== $playerDataToUpdate) {
            // Use a prepared statement to securely update the database
            $update_stmt = mysqli_prepare($link, "UPDATE pwdata SET val = ? WHERE name = ?");
            mysqli_stmt_bind_param($update_stmt, "ss", $newPlayerData, $playerKeyToUpdate);
            mysqli_stmt_execute($update_stmt);
            mysqli_stmt_close($update_stmt);

            // Redirect to prevent form resubmission on refresh (Post-Redirect-Get pattern)
            header("Location: " . $_SERVER['PHP_SELF'] . "?planet=infos&reset_success=" . urlencode($charToReset));
            exit();
        }
    }
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Get URL parameters safely
$galaxyx = (int)($_GET['galaxyx'] ?? 0);
$galaxyy = (int)($_GET['galaxyy'] ?? 0);
$login = $_GET['login'] ?? '';
$system = $_GET['system'] ?? '';
$planet = $_GET['planet'] ?? '';

// --- PERFORMANCE OPTIMIZATION ---
$pwdata_cache = [];
$result = mysqli_query($link, "SELECT name, val FROM pwdata");
while ($row = mysqli_fetch_assoc($result)) {
    $pwdata_cache[$row['name']] = $row['val'];
}
function get_val_from_cache($key) {
    global $pwdata_cache;
    return $pwdata_cache[$key] ?? '';
}

$result = get_val_from_cache($planet);
$tiletype1pos = strpos($result,"&003&");$tiletype1 = substr($result, 0, $tiletype1pos);$tiletype2pos = strpos($tiletype1,"&002&");$tiletype = substr($tiletype1, $tiletype2pos+5);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if($planet=="infos") {
?>
<br><p align=right><font size=2><b><u><a href="galaxy.php?planet=infos">Actualise</a></u></b></p>

<?php
// Display a success message if the redirect from the POST action includes it
if (isset($_GET['reset_success'])) {
    echo '<div class="feedback-message">Success: Player ' . htmlspecialchars($_GET['reset_success']) . '\'s coordinates have been reset to 0,0.</div>';
}
?>

<table border="1" cellpadding="5" cellspacing="0" style="border-collapse: collapse" bordercolor="#FFFFFF" width="100%">
  <tr>
    <td width="25%" align="center" valign="top" bgcolor="#005064"><b><font face="Arial" size="2" color="#66CCFF"><u>Player</u> :</font></b></td>
    <td width="25%" align="center" valign="top" bgcolor="#005064"><b><font face="Arial" size="2" color="#66CCFF"><u>Character</u> :</font></b></td>
    <td width="20%" align="center" valign="top" bgcolor="#005064"><b><font face="Arial" size="2" color="#66CCFF"><u>Planet</u> :</font></b></td>
    <td width="15%" align="center" valign="top" bgcolor="#005064"><b><font face="Arial" size="2" color="#66CCFF"><u>Area</u> :</font></b></td>
    <!-- ADDED a new column for the action button -->
    <td width="15%" align="center" valign="top" bgcolor="#005064"><b><font face="Arial" size="2" color="#66CCFF"><u>Action</u> :</font></b></td>
  </tr>
<?php
$players_keys = array_filter(array_keys($pwdata_cache), function($k) { return strpos($k, 'Player') === 0; });

if (empty($players_keys)) {
    echo '<tr><td colspan="5" align="center">No player data found.</td></tr>';
} else {
    // Sort player keys numerically (Player1, Player2, ... Player10)
    natsort($players_keys);
    foreach (array_reverse($players_keys) as $player_key) {
        $player = get_val_from_cache($player_key);
        if (empty($player)) continue;
        
        // Parse the player string
        $var11pos = strpos($player,"&1&");$var1 = substr($player, 0, $var11pos);$var1 = str_replace("~","'",$var1);
        $var21pos = strpos($player,"&2&");$var21 = substr($player, 0, $var21pos);$var22pos = strpos($var21,"&1&");$var2 = substr($var21, $var22pos+3);$var2 = str_replace("~","'",$var2);
        $var31pos = strpos($player,"&3&");$var31 = substr($player, 0, $var31pos);$var32pos = strpos($var31,"&2&");$var3 = substr($var31, $var32pos+3);$var3 = str_replace("~","'",$var3);
        $var41pos = strpos($player,"&4&");$var41 = substr($player, 0, $var41pos);$var42pos = strpos($var41,"&3&");$var4 = substr($var41, $var42pos+3);$var4 = str_replace("~","'",$var4);
        $var51pos = strpos($player,"&5&");$var51 = substr($player, 0, $var51pos);$var52pos = strpos($var51,"&4&");$var5 = substr($var51, $var52pos+3);$var5 = str_replace("~","'",$var5);

        if($var1!="") { ?>
          <tr>
           <td align="center" valign="top"><b><font face="Arial" size="2" color="#FFC800"><?= htmlspecialchars($var1); ?></font></b></td>
           <td align="center" valign="top"><b><font face="Arial" size="2" color="#FFC800"><?= htmlspecialchars($var2); if($var5=="1"){ ?><font color="#FF0000"><?php echo " (DM)";}?></font></b></td>
           <td align="center" valign="top"><b><font face="Arial" size="2" color="#FFC800"><?= htmlspecialchars($var3); ?></font></b></td>
           <td align="center" valign="top"><b><font face="Arial" size="2" color="#FFC800"><?= htmlspecialchars($var4); ?></font></b></td>
           <!-- ADDED the form with the reset button -->
           <td align="center" valign="top">
                <form method="post" action="galaxy.php?planet=infos" style="margin:0;">
                    <input type="hidden" name="reset_player_char_name" value="<?= htmlspecialchars($var2) ?>">
                    <button type="submit" class="action-button" onclick="return confirm('Are you sure you want to reset coordinates for <?= htmlspecialchars(addslashes($var2)) ?> to 0,0?');">
                        Set to 0,0
                    </button>
                </form>
           </td>
          </tr>
        <?php }
    }
}
?>
</table>
<p align=right><font size=2><b><u><a href="galaxy.php?planet=infos">Actualise</a></u></b></p><br>
<?php
 } else if((substr($tiletype,0,1)=="b")||(substr($tiletype,0,1)=="s")) {
    echo "<br/><center><font size=+1><b><u><font color=#66CCFF>" . htmlspecialchars($planet) . "</font></u></b><br/><br/><p><img border='0' src='" . htmlspecialchars($tiletype) . ".jpg'></p><br/></center>";
 } else {
    // The rest of the map display code remains untouched
    echo "<br/>";
    $planetname = $planet;if($planetname=="Space"){$planetname = "$system";}
    ?><center><font size=+1><b><u><font color=#66CCFF><?php echo htmlspecialchars($planetname);?></font></u></b><?php
    echo "<br/>";
    $showAreas = get_val_from_cache('ShowAreas');
    $showInterests = get_val_from_cache('ShowInterests');
    $showPlanets = get_val_from_cache('ShowPlanets');

    if($planet=="Space"){
        $size = 30;
        $result = get_val_from_cache($system."SystemCenter");
        $systempos = strpos($result,"_");
        $systemx = substr($result, 0, $systempos);
        $systemy = substr($result, $systempos + 1);
        if(!empty($systemx)){$galaxyx = intval($systemx/($size/2));}
        if(!empty($systemy)){$galaxyy = intval($systemy/($size/2));}
    ?>
    <br/>
    <table border="0" cellpadding="0" cellspacing="0">
      <tr>
       <td width="33%" align="center"></td><td width="34%" align="center"><a href="galaxy.php?planet=Space&login=<?= urlencode($login) ?>&galaxyx=<?= $galaxyx ?>&galaxyy=<?= $galaxyy+1 ?>"><img border="0" src=Arrow_N.gif alt=North /></a></td><td width="33%" align="center"></td>
      </tr><tr>
       <td width="33%" align="center"><a href="galaxy.php?planet=Space&login=<?= urlencode($login) ?>&galaxyx=<?= $galaxyx-1 ?>&galaxyy=<?= $galaxyy ?>"><img border="0" src=Arrow_W.gif alt=West /></a></td><td width="34%" align="center"></td><td width="33%" align="center"><a href="galaxy.php?planet=Space&login=<?= urlencode($login) ?>&galaxyx=<?= $galaxyx+1 ?>&galaxyy=<?= $galaxyy ?>"><img border="0" src=Arrow_E.gif alt=East /></a></td>
      </tr><tr>
       <td width="33%" align="center"></td><td width="34%" align="center"><a href="galaxy.php?planet=Space&login=<?= urlencode($login) ?>&galaxyx=<?= $galaxyx ?>&galaxyy=<?= $galaxyy-1 ?>"><img border="0" src=Arrow_S.gif alt=South /></a></td><td width="33%" align="center"></td>
      </tr>
    </table>
    <?php
     } else {
        $result = get_val_from_cache($planet);
        $size1pos = strpos($result,"&002&");$size1 = substr($result, 0, $size1pos);$size2pos = strpos($size1,"&001&");$size = substr($size1, $size2pos+5);
     }
    $Y = (int)($size/2)+1;

    if($planet!="Space"){
    ?>
    <div align="center"><center>
    <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" width="100%">
      <tr><td colspan="4"><p align="left"><font size=+1><b><u><font color=#66CCFF>Local informations</font></u> :</b></p>
    <?php
    $result = get_val_from_cache($planet);
    $descr1pos = strpos($result,"&010&");$descr1 = substr($result, 0, $descr1pos);$descr2pos = strpos($descr1,"&009&");$descr = substr($descr1, $descr2pos+5);
    $descr = str_replace("~","'",$descr);
    if(empty($descr) || $descr=="0"){$descr = "no description";}
    ?>
    <p><font size=+1><b><font color=#00FFFF> <?= htmlspecialchars($descr); ?> </font></b></p></td></tr>
     <tr>
       <td width="30%" valign="top"><br><p><font size=+1><b><font color=#66CCFF>Position :</font></b></p><br/><p><font size=+1><b><font color=#66CCFF>Level :</font></b></p><br/></td>
       <td width="30%" valign="top">
    <?php
    $result = get_val_from_cache($planet);
    $position1pos = strpos($result,"&001&");$position = substr($result, 0, $position1pos);
    $level1pos = strpos($result,"&009&");$level1 = substr($result, 0, $level1pos);$level2pos = strpos($level1,"&008&");$level = substr($level1, $level2pos+5);if(empty($level)){$level = "unknown";}
    ?>
    <br><p><font size=+1><b><font color=#00FFFF><?= htmlspecialchars($position) ?></font></b></p><br/><p><font size=+1><b><font color=#00FFFF><?= htmlspecialchars($level) ?></font></b></p><br/></td>
        <td width="20%" valign="top"><br/><p><font size=+1><b><font color=#66CCFF>Time :</font></b></p><br/><p><font size=+1><b><font color=#66CCFF>Weather :</font></b></p><br/></td>
        <td width="20%" valign="top">
    <?php
    $result = get_val_from_cache('Calendar');
    $time1pos = strpos($result,"/C4/");$time1 = substr($result, 0, $time1pos);$time2pos = strpos($time1,"/C3/");$time = (int)substr($time1, $time2pos+4);
    if(($time>=8)&&($time<=20)){echo "<img src=time_day.gif alt=Day />";} else {echo "<img src=time_night.gif alt=Night />";}
    ?><br/><br/>
    <?php
    $result = get_val_from_cache($planet);
    $weather1pos = strpos($result,"&011&");$weather1 = substr($result, 0, $weather1pos);$weather2pos = strpos($weather1,"&010&");$weather = substr($weather1, $weather2pos+5);
    $weather_icons = ["0"=>"clear", "1"=>"rain", "2"=>"snow", "3"=>"fog", "4"=>"storm"];
    $icon = $weather_icons[$weather] ?? 'clear';
    echo "<img src='weather_{$icon}.gif' alt='" . ucfirst($icon) . "' />";
    ?><br/></td></tr></table>
    <?php
    }
    ?>
    <br>
    <table border="1" cellpadding="0" cellspacing="1" bordercolor="#C0C0C0">
    <?php
    while($Y>-($size/2+1)) {
        echo "<tr>";
        // This entire map-drawing loop is highly complex and specific. It is left as-is to preserve its original functionality.
        if($Y==($size/2)+1) {
            $X = -($size/2); echo "<td><img src=black.gif /></td>";
            while($X<$size/2+1) { echo "<td bgcolor='#005064'><center>".($X+($galaxyx*15))."</center></td>"; $X++; }
        } else {
            $X = -($size/2)-1;
            while($X<$size/2+1) {
                if($X==-($size/2)-1) { echo "<td bgcolor='#005064'><center>".($Y+($galaxyy*15))."</center></td>";
                } else {
                    $XX = $X+($galaxyx*15); $YY = $Y+($galaxyy*15);
                    $planetarea = $planet."AreasX".$XX; $tile = get_val_from_cache($planetarea);
                    $s1 = ($YY>=0?'+':'-').str_pad(abs($YY),2,'0',STR_PAD_LEFT); $s1b = (($YY-1)>=0?'+':'-').str_pad(abs($YY-1),2,'0',STR_PAD_LEFT);
                    if($YY==-($size/2)){$tilepos = strpos($tile,"&".$s1."&");$tiletype = substr($tile, 0, $tilepos);}else{$tile1pos = strpos($tile,"&".$s1."&");$tile1 = substr($tile, 0, $tile1pos);$tile2pos = strpos($tile1,"&".$s1b."&");$tiletype = substr($tile1, $tile2pos+5);}
                    $show = (substr($tiletype,-1)=="*");if($show){$tiletype=substr($tiletype,0,-1);}
                    $tile_map=["01"=>"clouds","02"=>"desert","03"=>"foothills","04"=>"forest","05"=>"frozenland","22"=>"gaz","06"=>"ground","07"=>"hills","08"=>"moon","09"=>"mountain","10"=>"mountsnow","11"=>"mounts","12"=>"ocean","13"=>"plain","14"=>"river","15"=>"rural","16"=>"ruralcastle","17"=>"ruralswamp","18"=>"seafloor","19"=>"snow","20"=>"swamp","21"=>"tropical"];
                    if($planet!="Space"){$tiletype=$tile_map[$tiletype]??$tiletype;}
                    echo "<td width='24' height='24'>";
                    $area = str_replace("-", "m", $XX."_".$YY); $interests = get_val_from_cache($planet."&".$area."&Interests");
                    $interest1pos = strpos($interests,"&1&");$interest = substr($interests, 0, $interest1pos);$interest2=substr($interest,0,1);
                    $name1pos = strpos($interests,"&2&");$name1 = substr($interests, 0, $name1pos);$name2pos = strpos($name1,"&1&");$name = substr($name1, $name2pos+3);
                    $visible1pos = strpos($interests,"&4&");$visible1=substr($interests,0,$visible1pos);$visible2pos=strpos($visible1,"&3&");$visible=substr($visible1,$visible2pos+3);
                    if($visible==0 && $login!=$dmlogin){$interest2="";}
                    $planetshow = get_val_from_cache("Space".$area);$planetshow1pos=strpos($planetshow,"&005&");$planetshow1=substr($planetshow,0,$planetshow1pos);$planetshow2pos=strpos($planetshow1,"&004&");$planetshow1=substr($planetshow1,$planetshow2pos+5);$planetshow2=get_val_from_cache("Space".$area."Show");
                    $space = get_val_from_cache("Space".$area); $alt1 = str_replace("-", "m", $XX."_".$YY)." : "; $alt2=ucwords($tiletype); $alt3=$alt1.$alt2;
                    if(strpos($tiletype, "city")===0){$tiletype="city";$alt3=$alt1.$name;}
                    if((!empty($tiletype)&&($login==$dmlogin||$show||$showAreas==1||($showInterests==1&&$interest2!="")))||($planet=="Space"&&!empty($planetshow)&&($login==$dmlogin||$planetshow1==1||$planetshow2==1))){
                        if($planet=="Space"){if(!empty($space)){$name1pos=strpos($space,"&001&");$name=substr($space,0,$name1pos);$tiletype1pos=strpos($space,"&004&");$tiletype1=substr($space,0,$tiletype1pos);$tiletype2pos=strpos($tiletype1,"&003&");$tiletype=substr($tiletype1,$tiletype2pos+5);$alt3=$alt1.$name;$tiletype2=$tiletype;}else{$tiletype2="space";}}
                        else{$interest_map=['D'=>'doma','1'=>'town','2'=>'dung','3'=>'cast','4'=>'ruin','5'=>'anre','6'=>'remo','7'=>'amus']; $alt_map=['D'=>'Domain','1'=>$name,'2'=>'Dungeon','3'=>'Castle','4'=>'Ruins','5'=>'Animal reserve','6'=>'Resource mountain','7'=>'Amusement place']; if(isset($interest_map[$interest2])){$alt3=$alt1.$alt_map[$interest2];$tiletype2=$tiletype.'_'.$interest_map[$interest2];}else{$tiletype2=$tiletype;}}
                        $href=""; if($tiletype=="city"||(ctype_digit($interest2)&&$interest2>0)||$interest2=="D"){$href="interests.php?planet=".urlencode($planet)."&area=".urlencode($area)."&login=".urlencode($login)."&galaxyx=$galaxyx&galaxyy=$galaxyy";}else if($planet=="Space"&&$tiletype!=""){$href="galaxy.php?planet=".urlencode($name)."&login=".urlencode($login)."&galaxyx=$galaxyx&galaxyy=$galaxyy";}
                        echo "<p>".(!empty($href)?"<a title='".htmlspecialchars($alt3)."' href='$href'>":"")."<img border='0' src='".htmlspecialchars($tiletype2).".gif'>".(!empty($href)?"</a>":"")."</p>";
                    } echo "</td>";
                } $X++;
            }
        }
        echo "</tr>"; $Y--;
    }
    ?>
    </table></center></div><br/><br/>
<?php
 }
mysqli_close($link);
?>
</body>
</html>
