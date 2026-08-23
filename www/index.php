<?php
session_start();

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

include('uoa.php');
include('helpers.php');
include('player_auth.php');

mysqli_report(MYSQLI_REPORT_OFF); // mysqli_connect() must return false, not throw, on failure
$link = @mysqli_connect($host, $user, $pass, $data, (int)$port);
if (!$link) {
    die('Failed to connect to MySQL.');
}

// DM auth via session
if (isset($_GET['logout'])) {
    session_destroy();
    header('Location: index.php');
    exit();
}
if (isset($_POST['login'])) {
    if (csrf_verify() && $dmlogin !== '' && password_verify($_POST['login'], $dmlogin)) {
        $_SESSION['is_dm'] = true;
    }
}
$is_dm = $_SESSION['is_dm'] ?? false;

// Player auth via session — the CD key a player registered with decides which
// map areas galaxy.php shows them.
$player_error = '';
if (isset($_GET['player_logout'])) {
    player_logout();
    header('Location: index.php');
    exit();
}
if (isset($_POST['player_cdkey'])) {
    if (csrf_verify()) {
        $player_error = player_login($link, $_POST['player_cdkey'], $_POST['player_password'] ?? '');
    } else {
        $player_error = 'Session expired — try again.';
    }
}
$player_chars = player_is_logged_in() ? player_characters($link, player_cdkey()) : [];

// Load galaxy list
$stmt = mysqli_prepare($link, "SELECT val FROM pwdata WHERE player='~' AND tag='uoa' AND name=?");
$key = 'Galaxy';
mysqli_stmt_bind_param($stmt, 's', $key);
mysqli_stmt_execute($stmt);
$row = mysqli_fetch_assoc(mysqli_stmt_get_result($stmt));
mysqli_stmt_close($stmt);
mysqli_close($link);

$galaxies   = $row['val'] ?? '';
$galaxytot  = (int)substr($galaxies, -4, 3);
?>
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
    <meta name="robots" content="index,follow">

    <style>
        body, html {
            height: 100%;
            margin: 0;
            padding: 0;
            background-color: #000;
            color: #FFF;
            font-family: Arial, sans-serif;
        }
        a { color: #FFF; text-decoration: none; }
        a:hover { color: #00FF00; }

        .layout-table {
            width: 100%;
            height: 100%;
            border-collapse: collapse;
            background-image: url('app/assets/UOA_BG.jpg');
            background-position: center;
            background-repeat: no-repeat;
            background-size: cover;
        }
        .header-cell { text-align: center; height: 60px; }
        .nav-cell {
            width: 12%;
            vertical-align: top;
            text-align: left;
            padding: 0 15px;
            box-sizing: border-box;
        }
        .main-content-cell { width: 76%; vertical-align: top; }
        .footer-cell { text-align: center; height: 5%; }

        .page-title {
            font-size: 3em;
            font-weight: bold;
            font-style: italic;
            color: #82AAFF;
            margin: 0.5em 0 0.1em;
        }
        .page-subtitle {
            font-size: 1.1em;
            font-weight: bold;
            color: #82AAFF;
            margin-bottom: 1em;
        }
        .section-title {
            font-size: 0.9em;
            font-weight: bold;
            color: #66CCFF;
            text-decoration: underline;
            margin-top: 1em;
            margin-bottom: 0.5em;
        }
        .nav-links { font-size: 0.9em; color: #b9b9c8; font-weight: bold; }
        .nav-links a { color: #b9b9c8; line-height: 1.5; }
        .info-text { font-size: 0.8em; font-weight: bold; }
        .ip-address { color: #00E600; }
        .galaxy-link { font-size: 0.9em; color: #00FFFF; font-weight: bold; text-decoration: underline; }
        .planet-link { font-weight: bold; }
        .footer-text { font-size: 0.8em; font-weight: bold; }

        .status-iframe, .content-iframe {
            border: 1px solid #ccc;
            width: 100%;
            margin: 1px 0;
            box-sizing: border-box;
        }
        .status-iframe { height: 90px; }
        .content-iframe { height: 100%; border: 0; }

        .dm-area input[type="password"] { width: 8em; font-size: 0.9em; }
        .dm-area-title { color: #66CCFF; }

        .player-area input[type="text"],
        .player-area input[type="password"] { width: 8em; font-size: 0.9em; margin-bottom: 3px; }
        .player-area input[type="submit"] { font-size: 0.8em; }
        .hint { font-size: 0.75em; color: #b9b9c8; margin: 0 0 0.5em; }
        .login-error { font-size: 0.75em; color: #FF6666; font-weight: bold; margin: 0 0 0.5em; }
    </style>
</head>

<body>
<table class="layout-table">
    <tr>
        <td class="header-cell">&nbsp;</td>
        <td class="header-cell">
            <h1 class="page-title">The Universe of Arlandia</h1>
            <p class="page-subtitle">For Neverwinter Nights - The universe is infinite</p>
        </td>
        <td class="header-cell">&nbsp;</td>
    </tr>

    <tr style="height: 75%;">
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
                <a target="UOA_Frame" href="Crafting.html">Crafting</a><br>
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

            <div class="dm-area player-area">
                <h2 class="section-title dm-area-title">Player area :</h2>
                <?php if (!player_is_logged_in()): ?>
                <p class="hint">Your map shows the areas you have discovered.</p>
                <?php if ($player_error !== ''): ?>
                    <p class="login-error" data-testid="player-login-error"><?= htmlspecialchars($player_error) ?></p>
                <?php endif; ?>
                <form name="playerarea" action="index.php" method="post" data-testid="player-login-form">
                    <input type="hidden" name="csrf_token" value="<?= htmlspecialchars(csrf_token()) ?>">
                    <input type="text" name="player_cdkey" maxlength="8" placeholder="CD key" autocomplete="username">
                    <input type="password" name="player_password" placeholder="password" autocomplete="current-password">
                    <input type="submit" value="log in">
                </form>
                <p class="nav-links"><a target="UOA_Frame" href="register.php">Register</a></p>
                <?php else: ?>
                <p class="info-text" data-testid="player-logged-in">
                    CD key <span class="ip-address"><?= htmlspecialchars(player_cdkey()) ?></span>
                </p>
                <?php if ($player_chars): ?>
                <p class="info-text">
                    <?php foreach ($player_chars as $char): ?>
                        <?= htmlspecialchars(str_replace('~', "'", $char['charname'])) ?><br>
                    <?php endforeach; ?>
                </p>
                <?php endif; ?>
                <p class="nav-links"><a href="index.php?player_logout=1">Disconnect</a></p>
                <?php endif; ?>
            </div>

            <div class="dm-area">
                <?php if (!$is_dm): ?>
                <form name="dmarea" action="index.php" method="post">
                    <h2 class="section-title dm-area-title">DM area :</h2>
                    <input type="hidden" name="csrf_token" value="<?= htmlspecialchars(csrf_token()) ?>">
                    <input type="password" name="login" value="">
                    <noscript><input type="submit" value="connect"></noscript>
                </form>
                <?php else: ?>
                <h2 class="section-title dm-area-title">DM area :</h2>
                <p class="nav-links">
                    <a target="UOA_Frame" href="galaxy.php?planet=infos">Informations</a><br>
                    <a href="index.php?logout=1">Disconnect</a>
                </p>
                <?php endif; ?>
            </div>
        </td>

        <td class="main-content-cell">
            <iframe name="UOA_Frame" class="content-iframe" src="news.html"></iframe>
        </td>

        <td class="nav-cell">
            <?php if ($galaxytot > 0): ?>
                <h2 class="section-title">Star systems :</h2>
            <?php endif; ?>

            <?php
            for ($g = 1; $g <= $galaxytot; $g++) {
                $chunk       = encoded_field($galaxies, $g);
                $planet_data = between($chunk, '', '#');
                $system_name = between($chunk, '#', '##');
                if ($system_name === '') continue;

                $planetstot = (int)substr($planet_data, -4, 3);
                ?>
                <a class="galaxy-link" target="UOA_Frame"
                   href="galaxy.php?system=<?= urlencode($system_name) ?>&planet=Space">
                    <?= htmlspecialchars($system_name) ?> :
                </a><br>
                <?php
                for ($p = 1; $p <= $planetstot; $p++) {
                    $planet_name = between(
                        $planet_data,
                        $p > 1 ? '_' . str_pad($p - 1, 3, '0', STR_PAD_LEFT) . '_' : '',
                        '_' . str_pad($p, 3, '0', STR_PAD_LEFT) . '_'
                    );
                    if ($planet_name === '') continue;
                    ?>
                    <a class="planet-link" target="UOA_Frame"
                       href="galaxy.php?planet=<?= urlencode($planet_name) ?>">
                        <?= htmlspecialchars($planet_name) ?>
                    </a><br>
                    <?php
                }
                echo '<br>';
            }
            ?>
        </td>
    </tr>

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
