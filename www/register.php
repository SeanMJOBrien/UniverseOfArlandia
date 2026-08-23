<?php
session_start();

include('uoa.php');
include('helpers.php');
include('player_auth.php');

mysqli_report(MYSQLI_REPORT_OFF); // mysqli_connect() must return false, not throw, on failure
$link = @mysqli_connect($host, $user, $pass, $data, (int)($port ?? 3306));
if (!$link) { die('service offline'); }

$error      = '';
$registered = false;
$cdkey_in   = $_POST['cdkey'] ?? '';

if (isset($_POST['cdkey'])) {
    if (!csrf_verify()) {
        $error = 'Session expired — try again.';
    } else {
        $error = player_register(
            $link,
            $_POST['cdkey'],
            $_POST['code'] ?? '',
            $_POST['password'] ?? '',
            $_POST['password2'] ?? ''
        );
        $registered = ($error === '');
    }
}

mysqli_close($link);
?>
<!DOCTYPE html>
<html lang="fr-CH">
<head>
    <meta charset="UTF-8">
    <title>Register - UOA</title>
    <meta name="robots" content="noindex,nofollow">
    <style>
        body {
            margin: 0;
            padding: 0 30px;
            background-color: #000;
            background-image: url('app/assets/UOA_BG2.jpg');
            color: #FFFFFF;
            font-family: Arial, sans-serif;
        }
        a { color: #00FFFF; }
        a:hover { color: #00FF00; }
        code { color: #FFC800; font-weight: bold; }

        .panel {
            max-width: 34em;
            margin: 30px auto;
            padding: 20px 25px;
            border: 1px solid #005064;
            background-color: rgba(0, 20, 26, 0.85);
        }
        h1 { font-size: 1.4em; color: #82AAFF; margin-top: 0; }
        ol { color: #b9b9c8; font-size: 0.9em; line-height: 1.6; padding-left: 1.2em; }
        label { display: block; color: #66CCFF; font-weight: bold; font-size: 0.9em; margin-top: 12px; }
        input[type="text"], input[type="password"] {
            width: 14em;
            font-size: 1em;
            padding: 3px;
            margin-top: 3px;
        }
        input[type="submit"] {
            margin-top: 16px;
            background-color: #005064;
            color: #FFFFFF;
            border: 1px solid #66CCFF;
            padding: 5px 14px;
            font-weight: bold;
            cursor: pointer;
        }
        input[type="submit"]:hover { background-color: #00768f; }
        .error {
            padding: 8px 12px;
            border: 1px solid #8f0000;
            background-color: #4b0c0c;
            color: #ff9d9d;
            font-weight: bold;
        }
        .success {
            padding: 8px 12px;
            border: 1px solid #008f00;
            background-color: #0c4b0c;
            color: #9dff9d;
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="panel">
    <h1>Register for the player map</h1>

    <?php if ($registered): ?>
        <p class="success" data-testid="register-success">
            Account created. <a target="_top" href="index.php">Log in</a> with your CD key
            and password — the map will show the areas your characters have discovered.
        </p>
    <?php else: ?>
        <ol>
            <li>Log in to the server with the character you play.</li>
            <li>Type <code>.web</code> in the chat bar. The server sends you your
                8-character public CD key and a 6-digit code.</li>
            <li>Enter both below, within 30 minutes, and choose a password.</li>
        </ol>

        <?php if ($error !== ''): ?>
            <p class="error" data-testid="register-error"><?= htmlspecialchars($error) ?></p>
        <?php endif; ?>

        <form method="post" action="register.php" data-testid="register-form">
            <input type="hidden" name="csrf_token" value="<?= htmlspecialchars(csrf_token()) ?>">

            <label for="cdkey">Public CD key (8 characters)</label>
            <input type="text" id="cdkey" name="cdkey" maxlength="8" required
                   autocomplete="username" value="<?= htmlspecialchars($cdkey_in) ?>">

            <label for="code">Code from <code>.web</code></label>
            <input type="text" id="code" name="code" maxlength="6" required autocomplete="one-time-code">

            <label for="password">Password (at least <?= PLAYER_PASSWORD_MIN ?> characters)</label>
            <input type="password" id="password" name="password" required autocomplete="new-password">

            <label for="password2">Repeat password</label>
            <input type="password" id="password2" name="password2" required autocomplete="new-password">

            <input type="submit" value="Register">
        </form>
    <?php endif; ?>

    <p><a target="_top" href="index.php">Back to the site</a></p>
</div>

</body>
</html>
