<html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns="http://www.w3.org/TR/REC-html40">

<head>
<TITLE>Universe of Arlandia</TITLE> 
<META NAME="description" Content="Universe of Arlandia for Neverwinter Nights - The Universe is infinite"> 
<META NAME="keywords" Content="arlandia uoa universe neverwinter nights nwn lkt therack the rack marc racordon"> 
<META NAME="author" CONTENT="TheRack"> 
<META NAME="Copyright" CONTENT="TheRack, 2009-2011">
<META NAME="GENERATOR" CONTENT="Microsoft FrontPage 5.0">
<META NAME="Robot" CONTENT="INDEX,FOLLOW"> 
<META HTTP-EQUIV="Content-Language" CONTENT="fr-ch" > 
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<link rel="File-List" href="index_fichiers/filelist.xml">

<style fprolloverstyle>A:hover {color: #00FF00;}</style>
<!--[if !mso]>
<style>
v\:*         { behavior: url(#default#VML) }
o\:*         { behavior: url(#default#VML) }
.shape       { behavior: url(#default#VML) }
</style>
<![endif]--><!--[if gte mso 9]>
<xml><o:shapedefaults v:ext="edit" spidmax="1027"/>
</xml><![endif]-->
</head>

<body topmargin="0" leftmargin="0" bgcolor="#000000" link="#FFFFFF" text="#FFFFFF" vlink="#FFFFFF" alink="#FFFFFF">


<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

/////////////////////////////////////////////////////////////////////////////////////////////////////
// Connect to the MySQL server on XAMPP
include("uoa.php");
$link = @ mysqli_connect("$host:3306", $user, $pass, $data)
// if no connexion
or die ("service offline");
/////////////////////////////////////////////////////////////////////////////////////////////////////
?>


<div align="center">
  <center>
  <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" height="100%" background="UOA_BG.jpg">
    <tr>
      <td width="12%" align="center" height="20%">
      &nbsp;</td>
      <td width="76%" align="center" height="20%">
      
	  <br>
		<font face="Arial" color="#82AAFF" size="9"><b><i>The Universe of Arlandia</i></b></font>
		<br>
		<font face="Arial" color="#82AAFF" size="3"><b>For Neverwinter Nights - The universe is infinite</b></font>
	  <br>
	  <br>  
	  
      <td width="12%" align="center" height="20%">
      &nbsp;</td>
    </tr>
    <tr>
      <td width="12%" align="center" height="75%" valign="top">
      <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" width="100">
        <tr>
          <td width="100%">

<br>

<b><font face="Arial" color="#66CCFF" size="2"><u>
      Server statut</u> :</font></b><p><b><font face="Arial" size="2">

<iframe name="Statut" marginwidth="1" marginheight="1" height="90" width="100%" scrolling="no" align="absmiddle" border="0" frameborder="1" src="statut.php"></iframe>

</p>

      <b><font face="Arial" color="#66CCFF" size="2"> <u>Connexion</u> :</font>
      <br><br>

      <font face="Arial" color="#b9b9c8" size="2">
      <a style="text-decoration: none" target="UOA_Frame" href="uoa.nwl">Direct connect</a><br>
      <a style="text-decoration: none" target="UOA_Frame" href="nwlaunch-setup-0.1.1.exe">Install launcher</a><br>
      <br>
	  
      <font face="Arial" color="#FFFFFF" size="1">Direct IP :<br>
      <font face="Arial" color="#00E600" size="1">uoa.no-ip.org<br>
      <font face="Arial" color="#FFFFFF" size="1">Gamespy :<br>
      <font face="Arial" color="#00E600" size="1">PW Story<br>
      </font></b>

      <br>
	  <b><font face="Arial" color="#66CCFF" size="2"> <u>Module</u> :</font>
      <br><br>
      
      <font face="Arial" color="#b9b9c8" size="2">
      <a style="text-decoration: none" target="UOA_Frame" href="news.html">Home/News</a><br>
      <a style="text-decoration: none" target="UOA_Frame" href="description.html">Description</a><br>
      <a style="text-decoration: none" target="UOA_Frame" href="screenshots.html">Screenshots</a><br>
      <a style="text-decoration: none" target="UOA_Frame" href="interests.html">Interests</a><br>
      <a style="text-decoration: none" target="UOA_Frame" href="domains.html">Domains</a><br>
      <a style="text-decoration: none" target="UOA_Frame" href="crafting.html">Crafting</a><br>
      </font></b>

      <br>
	  <b><font face="Arial" color="#66CCFF" size="2"> <u>Characters</u> :</font>
      <br><br>
	  
      <font face="Arial" color="#b9b9c8" size="2">
      <a style="text-decoration: none" target="UOA_Frame" href="races.html">Races</a><br>
      <a style="text-decoration: none" target="UOA_Frame" href="classes.html">Classes</a><br>
      <a style="text-decoration: none" target="UOA_Frame" href="feats.html">Feats</a><br>
      <a style="text-decoration: none" target="UOA_Frame" href="grades.html">Grades</a><br>
      <a style="text-decoration: none" target="UOA_Frame" href="talents.html">Talents</a><br>
      </font></b>
	  
	  <br>
      <b><font face="Arial" size="2"><font color="#66CCFF"><u>Community</u> :</font>
      <br><br>
      
      <font color="#b9b9c8" size="2" face="Arial">
      <a style="text-decoration: none" target="_blank" href="http://www.simtotal.com/uoa/forum/index.php">Forum</a><br>
      <a style="text-decoration: none" target="UOA_Frame" href="downloads.html">Downloads</a><br>
      <a style="text-decoration: none" target="UOA_Frame" href="links.html">Links</a><br>
      <a style="text-decoration: none" target="UOA_Frame" href="contact.html">Contact</a><br>
      </font></b>
	  <br>

          </td>
        </tr>
        <tr>
          <td width="100%">
           
<?php
/////////////////////////////////////////////////////////////////////////////////////////////////////
// DM area
$logout = @ $_GET['logout'];
$login = @ $_POST['login'];
$dm = 0;

if(($login!=$dmlogin)||($logout=="1"))
 {
?>

      <form name="dmarea" action="index.php" method="post">
      <b><font face="Arial" size="2" color="#66CCFF"><u>DM area</u> :<br><br><input type="password" name="login" size="8" value="" /></b>
      <noscript><input type="submit" value="connect"></noscript>
      </form>

<?php
 }
else
 {
?>

      <b><font face="Arial" size="2" font color="#66CCFF"><u>DM area</u> :<font color="#ff0000"><br>
      </font><br>
      <a target="UOA_Frame" href="galaxy.php?planet=infos" style="text-decoration: none">
      Informations</a>
      
      <a href="index.php?logout=1" style="text-decoration: none">
      Disconnect</a></b>

<?php
 }
/////////////////////////////////////////////////////////////////////////////////////////////////////
// Galaxies & planets menu
$galaxy = "Galaxy";
$result = mysqli_query($link,"SELECT val FROM pwdata WHERE name='$galaxy'") or die(mysql_error($link));
$galaxies = @ mysqli_fetch_assoc($result);
$galaxies = implode($galaxies);
$galaxytot = substr($galaxies, strlen($galaxies)-4, 3);
$t1 = 0;
?>
          </td>
        </tr>
      </table>
      </td>
      <td width="76%" align="center" height="75%" valign="top">
      <iframe name="UOA_Frame" height="100%" width="100%" border="0" frameborder="0" marginwidth="1" marginheight="1" src="news.html"></iframe></td>
      <td width="12%" align="center" height="75%" valign="top">

      <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" width="100">
        <tr>
          <td width="100%">
          
<?php if(($galaxies!="")&&($galaxies!="0")){ ?> <p><b><font size="2"></font><u><font face="Arial" size="2" color="#66CCFF"><br>Star systems</font></u><font face="Arial" color="#66CCFF" size="2"> :</font></b></p> <?php } ?>

<?php
/////////////////////////////////////////////////////////////////////////////////////////////////////
// Galaxies
while($t1<$galaxytot)
 {
$t1++;
// System name
$s1 = $t1;if($t1<10){$s1 = "00".$s1;}else if($t1<100){$s1 = "0".$s1;}$t1b = $t1-1;$s1b = $t1b;if($t1b<10){$s1b = "00".$s1b;}else if($t1b<100){$s1b = "0".$s1b;}
if($t1==1){$namepos = strpos($galaxies,"&".$s1."&");$name = substr($galaxies, 0, $namepos);}else{$name1pos = strpos($galaxies,"&".$s1."&");$name1 = substr($galaxies, 0, $name1pos);$name2pos = strpos($name1,"&".$s1b."&");$name2 = strlen($name1);$name = substr($name1, $name2pos+5);}
$name1pos = strpos($name,"##");$name1 = substr($name, 0, $name1pos);$name2pos = strpos($name1,"#");$name2 = strlen($name1);$name = substr($name1, $name2pos+1);

//
if($name!=""){ ?> <a target="UOA_Frame" href="galaxy.php?system=<?php echo "$name" ?>&planet=Space&login=<?php echo "$login" ?>" ><font size="2" face="Arial"><font color=#00FFFF><u><b><?php echo "$name" ?></u> :</b><br> <?php } 
//

if($t1==1){$planetpos = strpos($galaxies,"&".$s1."&");$planets = substr($galaxies, 0, $planetpos);}else{$planet1pos = strpos($galaxies,"&".$s1."&");$planet1 = substr($galaxies, 0, $planet1pos);$planet2pos = strpos($planet1,"&".$s1b."&");$planet2 = strlen($planet1);$planets = substr($planet1, $planet2pos+5);}
$planetpos = strpos($planets,"#");$planets = substr($planets, 0, $planetpos);
$planetstot = substr($planets, strlen($planets)-4, 3);
$t2 = 0;

// Planets of the system
while($t2<$planetstot)
  {
$t2++;
// Planet name
$s2 = $t2;if($t2<10){$s2 = "00".$s2;}else if($t2<100){$s2 = "0".$s2;}$t2b = $t2-1;$s2b = $t2b;if($t2b<10){$s2b = "00".$s2b;}else if($t2b<100){$s2b = "0".$s2b;}
if($t2==1){$namepos = strpos($planets,"_".$s2."_");$namep = substr($planets, 0, $namepos);}else{$name1pos = strpos($planets,"_".$s2."_");$name1 = substr($planets, 0, $name1pos);$name2pos = strpos($name1,"_".$s2b."_");$name2 = strlen($name1);$namep = substr($name1, $name2pos+5);}

//
if($namep!=""){ ?> <a target="UOA_Frame" style="text-decoration: none" href="galaxy.php?planet=<?php echo "$namep" ?>&login=<?php echo "$login" ?>" font size="2" face="Arial"><b><?php echo "$namep" ?></a></b><br> <?php }
//

  }
?>

</br>
<br/>

<?php
 }
///////////////////////////////////////////////////////////////////////////////////////////////////
?>
          
          </td>
        </tr>
      </table>
      </td>
    </tr>
    <tr>
      <td width="100%" colspan="3" align="center" height="5%">
      <font color="#ffffff" size="1" face="Arial"><b>© TheRack, all rights 
      reserved, 2009-2011.</b></font></td>
    </tr>
  </table>
  </center>
</div>

</body>

</html>