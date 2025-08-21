<?php
// PHP 8 compatible script to find player locations and add a feature to reset coordinates.

// --- SETUP AND HELPER FUNCTIONS ---

// Include database credentials.
// Assumes a file named uoa.php exists with $host, $user, $pass, $data.
include("uoa.php");

// Establish a robust database connection.
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
try {
    $link = mysqli_connect($host, $user, $pass, $data, $port ?? 3306);
    mysqli_set_charset($link, "utf8mb4");
} catch (mysqli_sql_exception $e) {
    die("Database connection failed: " . $e->getMessage());
}
mysqli_report(MYSQLI_REPORT_OFF);

function getPwData($link, $name): string {
    $stmt = mysqli_prepare($link, "SELECT `val` FROM `pwdata` WHERE `name` = ?");
    mysqli_stmt_bind_param($stmt, "s", $name);
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);
    $row = mysqli_fetch_assoc($result);
    return $row['val'] ?? '';
}

function setPwData($link, $name, $value): bool {
    $stmt = mysqli_prepare($link, "UPDATE `pwdata` SET `val` = ? WHERE `name` = ?");
    mysqli_stmt_bind_param($stmt, "ss", $value, $name);
    return mysqli_stmt_execute($stmt);
}

// --- ACTION HANDLING: RESET PLAYER COORDINATES ---

$feedbackMessage = '';
$playerToReset = $_POST['reset_player'] ?? null;

if ($playerToReset) {
    $players_count = (int)getPwData($link, "Players");
    $playerFound = false;

    // Loop through all player records to find the one matching the character name.
    for ($i = $players_count; $i >= 1; $i--) {
        $playerKey = "Player" . $i;
        $playerData = getPwData($link, $playerKey);

        if (empty($playerData)) continue;

        // Parse character name (var2) from the data string.
        $var1pos = strpos($playerData, "&1&");
        $var2pos = strpos($playerData, "&2&");
        $charName = substr($playerData, $var1pos + 3, $var2pos - ($var1pos + 3));
        $charName = str_replace("~", "'", $charName);

        if ($charName === $playerToReset) {
            // Found the player. Replace their coordinates (&3&...&4&) with "0_0".
            $pattern = '/(&3&)(.*?)(?=&4&)/';
            $newData = preg_replace($pattern, '$10_0', $playerData, 1);

            if ($newData !== null && $newData !== $playerData) {
                if (setPwData($link, $playerKey, $newData)) {
                    $feedbackMessage = "Success: Player '" . htmlspecialchars($playerToReset) . "' coordinates have been reset to 0_0.";
                } else {
                    $feedbackMessage = "Error: Could not update player '" . htmlspecialchars($playerToReset) . "' in the database.";
                }
            } else {
                 $feedbackMessage = "Error: Could not parse data for player '" . htmlspecialchars($playerToReset) . "'.";
            }
            $playerFound = true;
            break; 
        }
    }
    if (!$playerFound) {
        $feedbackMessage = "Error: Player '" . htmlspecialchars($playerToReset) . "' not found.";
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>UOA Player Information</title>
    <style>
        body {
            background-color: transparent;
            color: #FFFFFF;
            font-family: Arial, sans-serif;
            padding: 15px;
        }
        h1 {
            color: #82AAFF;
            text-align: center;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            border: 1px solid #FFFFFF;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #FFFFFF;
            padding: 8px;
            text-align: center;
            vertical-align: middle;
            font-size: 0.9em;
        }
        th {
            background-color: #005064;
            color: #66CCFF;
            font-weight: bold;
        }
        td {
            color: #FFC800;
            font-weight: bold;
        }
        button {
            background-color: #c00;
            color: white;
            border: 1px solid #ff4d4d;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 3px;
            font-weight: bold;
        }
        button:hover {
            background-color: #e00;
        }
        .feedback {
            padding: 10px;
            border-radius: 5px;
            color: #fff;
            background-color: #008000;
            border: 1px solid #006400;
            text-align: center;
            margin-bottom: 20px;
        }
        .feedback.error {
            background-color: #c00;
            border-color: #a00;
        }
    </style>
</head>
<body>
    <h1>Player Management</h1>
    <?php if ($feedbackMessage):
        $feedbackClass = (strpos(strtolower($feedbackMessage), 'error') === 0) ? 'error' : '';
    ?>
    <div class="feedback <?= $feedbackClass ?>">
        <?= $feedbackMessage ?>
    </div>
    <?php endif; ?>

    <table>
      <tr>
        <th>Player Account</th>
        <th>Character Name</th>
        <th>Current Planet</th>
        <th>Coordinates</th>
        <th>Action</th>
      </tr>
      <?php
        $players_count = (int)getPwData($link, "Players");
        if ($players_count === 0):
      ?>
        <tr>
            <td colspan="5">No players found in the database.</td>
        </tr>
      <?php
        else:
            for ($i = $players_count; $i >= 1; $i--):
                $playerData = getPwData($link, "Player" . $i);
                if (empty($playerData)) continue;

                $parts = explode('&', $playerData);
                $var1 = str_replace("~", "'", $parts[0] ?? '');
                $var2 = str_replace("~", "'", substr($parts[1] ?? '', 1));
                $var3 = str_replace("~", "'", substr($parts[2] ?? '', 1));
                $var4 = str_replace("~", "'", substr($parts[3] ?? '', 1));

                if (!empty($var2)):
      ?>
      <tr>
        <td><?= htmlspecialchars($var1) ?></td>
        <td><?= htmlspecialchars($var2) ?></td>
        <td><?= htmlspecialchars($var3) ?></td>
        <td><?= htmlspecialchars($var4) ?></td>
        <td>
            <form method="post" action="playerInfo.php" style="margin:0;">
                <input type="hidden" name="reset_player" value="<?= htmlspecialchars($var2) ?>">
                <button type="submit" onclick="return confirm('Are you sure you want to reset coordinates for <?= htmlspecialchars(addslashes($var2)) ?> to 0,0?');">
                    Set to 0,0
                </button>
            </form>
        </td>
      </tr>
      <?php
                endif;
            endfor;
        endif;
      ?>
    </table>
</body>
</html>
