<!DOCTYPE html>
<html lang="fr-CH">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Universe of Arlandia</title>
    <meta name="description" content="Universe of Arlandia for Neverwinter Nights - The Universe is infinite">
    <meta name="keywords" content="arlandia, uoa, universe, neverwinter nights, nwn, lkt, therack, the rack, marc racordon">
    <meta name="author" content="TheRack">
    <meta name="copyright" content="TheRack, 2009-2011">
    <meta name="generator" content="Microsoft FrontPage 5.0">
    <meta name="robots" content="index,follow">

    <style>
        /* General Body and Page Styling */
        body, html {
            height: 100%;
            margin: 0;
            padding: 0;
            background-color: #000;
            color: #FFF;
            font-family: Arial, sans-serif;
        }

        /* Link Styles */
        a {
            color: #FFF;
            text-decoration: none;
        }
        a:hover {
            color: #00FF00;
        }

        /* Layout Table: Replaces presentational attributes */
        .layout-table {
            width: 100%;
            height: 100%;
            border-collapse: collapse;
            background-image: url('UOA_BG.jpg');
            background-position: center;
            background-repeat: no-repeat;
            background-size: cover;
        }

        /* Header, Content, and Footer Cells */
        .header-cell {
            text-align: center;
            height: 60px;
        }
        .nav-cell {
            width: 12%;
            vertical-align: top;
            text-align: left;     /* MODIFIED: Changed from 'center' */
            padding: 0 15px;      /* ADDED: Provides spacing from the edge */
            box-sizing: border-box; /* ADDED: Ensures padding doesn't alter the column width */
        }
        .main-content-cell {
            width: 76%;
            vertical-align: top;
        }
        .footer-cell {
            text-align: center;
            height: 5%;
        }

        /* Typography and Text Styles (Replaces <font> tags) */
        .page-title {
            font-size: 3em; /* Equivalent to old size="9" */
            font-weight: bold;
            font-style: italic;
            color: #82AAFF;
            margin: 0.5em 0 0.1em;
        }
        .page-subtitle {
            font-size: 1.1em; /* Equivalent to old size="3" */
            font-weight: bold;
            color: #82AAFF;
            margin-bottom: 1em;
        }
        .section-title {
            font-size: 0.9em; /* Equivalent to old size="2" */
            font-weight: bold;
            color: #66CCFF;
            text-decoration: underline;
            margin-top: 1em;
            margin-bottom: 0.5em;
        }
        .nav-links {
            font-size: 0.9em; /* Equivalent to old size="2" */
            color: #b9b9c8;
            font-weight: bold;
        }
        .nav-links a {
            color: #b9b9c8;
            line-height: 1.5;
        }
        .info-text {
            font-size: 0.8em; /* Equivalent to old size="1" */
            font-weight: bold;
        }
        .ip-address {
            color: #00E600;
        }
        .galaxy-link {
            font-size: 0.9em;
            color: #00FFFF;
            font-weight: bold;
            text-decoration: underline;
        }
        .planet-link {
            font-weight: bold;
        }
        .footer-text {
            font-size: 0.8em; /* Equivalent to old size="1" */
            font-weight: bold;
        }

        /* Iframe Styles (Replaces presentational attributes) */
        .status-iframe, .content-iframe {
            border: 1px solid #ccc; /* Kept border from original frameborder="1" */
            width: 100%;
            margin: 1px 0;
            box-sizing: border-box;
        }
        .status-iframe {
            height: 90px;
            scrolling: "no";
        }
        .content-iframe {
            height: 100%;
            border: 0;
        }

        /* Form Styles */
        .dm-area input[type="password"] {
            width: 8em;
            font-size: 0.9em;
        }
        .dm-area-title {
            color: #66CCFF;
        }
        .dm-area-error {
            color: #ff0000;
        }
    </style>
</head>

<body>

<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

/////////////////////////////////////////////////////////////////////////////////////////////////////
// Connect to the MySQL server on XAMPP
include("uoa.php");
$link = @ mysqli_connect("$host:3306", $user, $pass, $data)
    // if no connexion
    or ("Failed to connect to MySQL: ");
/////////////////////////////////////////////////////////////////////////////////////////////////////
?>

<table class="layout-table">
    <!-- Header Row -->
    <tr>
        <td class="header-cell">&nbsp;</td>
        <td class="header-cell">
            <h1 class="page-title">The Universe of Arlandia</h1>
            <p class="page-subtitle">For Neverwinter Nights - The universe is infinite</p>
        </td>
        <td class="header-cell">&nbsp;</td>
    </tr>

    <!-- Main Content Row -->
    <tr style="height: 75%;">
        <!-- Left Navigation Column -->
        <td class="nav-cell">
            <h2 class="section-title">Server status :</h2>
            <iframe name="Status" class="status-iframe" src="statut.php"></iframe>

            <h2 class="section-title">Connection :</h2>
            <p class="info-text">
                Direct IP:<br>
                <span class="ip-address">uoanwn.homeip.net</span>
            </p>

            <h2 class="section-title">Module :</h2>
            <nav class="nav-links">
                <a target="UOA_Frame" href="news.html">Home/News</a><br>
                <a target="UOA_Frame" href="description.html">Description</a><br>
                <a target="UOA_Frame" href="screenshots.html">Screenshots</a><br>
                <a target="UOA_Frame" href="interests.html">Interests</a><br>
                <a target="UOA_Frame" href="domains.html">Domains</a><br>
                <a target="UOA_Frame" href="crafting.html">Crafting</a><br>
            </nav>

            <h2 class="section-title">Characters :</h2>
            <nav class="nav-links">
                <a target="UOA_Frame" href="races.html">Races</a><br>
                <a target="UOA_Frame" href="classes.html">Classes</a><br>
                <a target="UOA_Frame" href="feats.html">Feats</a><br>
                <a target="UOA_Frame" href="grades.html">Grades</a><br>
                <a target="UOA_Frame" href="talents.html">Talents</a><br>
            </nav>

            <h2 class="section-title">Community :</h2>
            <nav class="nav-links">
                <a target="_blank" href="http://www.simtotal.com/uoa/forum/index.php">Forum</a><br>
                <a target="UOA_Frame" href="downloads.html">Downloads</a><br>
                <a target="UOA_Frame" href="links.html">Links</a><br>
                <a target="UOA_Frame" href="contact.html">Contact</a><br>
            </nav>

            <div class="dm-area">
                <?php
                /////////////////////////////////////////////////////////////////////////////////////////////////////
                // DM area
                $logout = @ $_GET['logout'];
                $login = @ $_POST['login'];
                $dm = 0;

                if(($login != $dmlogin) || ($logout == "1")) {
                ?>
                    <form name="dmarea" action="index.php" method="post">
                        <h2 class="section-title dm-area-title">DM area :</h2>
                        <input type="password" name="login" value="" />
                        <noscript><input type="submit" value="connect"></noscript>
                    </form>
                <?php
                } else {
                ?>
                    <h2 class="section-title dm-area-title">DM area :</h2>
                    <p class="nav-links">
                        <span class="dm-area-error"></span><br>
                        <a target="UOA_Frame" href="galaxy.php?planet=infos">Informations</a>
                        <a href="index.php?logout=1">Disconnect</a>
                    </p>
                <?php
                }
                /////////////////////////////////////////////////////////////////////////////////////////////////////
                // Galaxies & planets menu
                $galaxy = "Galaxy";
                @ $result = mysqli_query($link,"SELECT val FROM pwdata WHERE name='$galaxy'") or die();
                $galaxies = mysqli_fetch_assoc($result);
                $galaxies = @ implode($galaxies);
                $galaxytot = substr($galaxies, strlen($galaxies)-4, 3);
                $t1 = 0;
                ?>
            </div>
        </td>

        <!-- Main Content Iframe -->
        <td class="main-content-cell">
            <iframe name="UOA_Frame" class="content-iframe" src="news.html"></iframe>
        </td>

        <!-- Right Navigation Column (Star Systems) -->
        <td class="nav-cell">
            <?php if(($galaxies != "") && ($galaxies != "0")) { ?>
                <h2 class="section-title">Star systems :</h2>
            <?php } ?>

            <?php
            /////////////////////////////////////////////////////////////////////////////////////////////////////
            // Galaxies
            while($t1 < $galaxytot) {
                $t1++;
                // System name
                $s1 = $t1; if($t1 < 10) { $s1 = "00".$s1; } else if($t1 < 100) { $s1 = "0".$s1; }
                $t1b = $t1-1; $s1b = $t1b; if($t1b < 10) { $s1b = "00".$s1b; } else if($t1b < 100) { $s1b = "0".$s1b; }
                if($t1 == 1) { $namepos = strpos($galaxies,"&".$s1."&"); $name = substr($galaxies, 0, $namepos); } else { $name1pos = strpos($galaxies,"&".$s1."&"); $name1 = substr($galaxies, 0, $name1pos); $name2pos = strpos($name1,"&".$s1b."&"); $name2 = strlen($name1); $name = substr($name1, $name2pos+5); }
                $name1pos = strpos($name,"##"); $name1 = substr($name, 0, $name1pos); $name2pos = strpos($name1,"#"); $name2 = strlen($name1); $name = substr($name1, $name2pos+1);

                if($name != "") { ?>
                    <a class="galaxy-link" target="UOA_Frame" href="galaxy.php?system=<?php echo "$name" ?>&planet=Space&login=<?php echo "$login" ?>">
                        <?php echo "$name" ?> :
                    </a><br>
                <?php }

                if($t1 == 1) { $planetpos = strpos($galaxies,"&".$s1."&"); $planets = substr($galaxies, 0, $planetpos); } else { $planet1pos = strpos($galaxies,"&".$s1."&"); $planet1 = substr($galaxies, 0, $planet1pos); $planet2pos = strpos($planet1,"&".$s1b."&"); $planet2 = strlen($planet1); $planets = substr($planet1, $planet2pos+5); }
                $planetpos = strpos($planets,"#"); $planets = substr($planets, 0, $planetpos);
                $planetstot = substr($planets, strlen($planets)-4, 3);
                $t2 = 0;

                // Planets of the system
                while($t2 < $planetstot) {
                    $t2++;
                    // Planet name
                    $s2 = $t2; if($t2 < 10) { $s2 = "00".$s2; } else if($t2 < 100) { $s2 = "0".$s2; }
                    $t2b = $t2-1; $s2b = $t2b; if($t2b < 10) { $s2b = "00".$s2b; } else if($t2b < 100) { $s2b = "0".$s2b; }
                    if($t2 == 1) { $namepos = strpos($planets,"_".$s2."_"); $namep = substr($planets, 0, $namepos); } else { $name1pos = strpos($planets,"_".$s2."_"); $name1 = substr($planets, 0, $name1pos); $name2pos = strpos($name1,"_".$s2b."_"); $name2 = strlen($name1); $namep = substr($name1, $name2pos+5); }

                    if($namep != "") { ?>
                        <a class="planet-link" target="UOA_Frame" href="galaxy.php?planet=<?php echo "$namep" ?>&login=<?php echo "$login" ?>"><?php echo "$namep" ?></a><br>
                    <?php }
                }
                ?>
                <br>
                <?php
            }
            ///////////////////////////////////////////////////////////////////////////////////////////////////
            ?>
        </td>
    </tr>

    <!-- Footer Row -->
    <tr>
        <td colspan="3" class="footer-cell">
            <footer>
                <p class="footer-text">&copy; TheRack, all rights reserved, 2009-2011.</p>
            </footer>
        </td>
    </tr>
</table>

</body>
</html>