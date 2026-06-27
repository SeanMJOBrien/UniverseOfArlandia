<?php
session_start();

include('uoa.php');
include('helpers.php');

$is_dm = $_SESSION['is_dm'] ?? false;

$link = mysqli_connect($host, $user, $pass, $data, (int)($port ?? 3306));
if (!$link) {
    echo 'service offline';
    exit;
}

$pc_records = [];
if ($is_dm) {
    $pwdata_cache = [];
    $res = mysqli_query($link, 'SELECT name, val FROM pwdata');
    while ($row = mysqli_fetch_assoc($res)) {
        $pwdata_cache[$row['name']] = $row['val'];
    }

    $pc_keys = array_filter(array_keys($pwdata_cache), fn($k) => str_starts_with($k, 'PCLoc_'));
    foreach ($pc_keys as $k) {
        $p = $pwdata_cache[$k];
        $pc_records[] = [
            'account'  => str_replace('~', "'", encoded_field($p, 1)),
            'charname' => str_replace('~', "'", encoded_field($p, 2)),
            'planet'   => str_replace('~', "'", encoded_field($p, 3)),
            'tilearea' => encoded_field($p, 4),
            'areatag'  => encoded_field($p, 5),
            'x'        => encoded_field($p, 6),
            'y'        => encoded_field($p, 7),
            'z'        => encoded_field($p, 8),
            'facing'   => encoded_field($p, 9),
            'is_dm'    => encoded_field($p, 10),
        ];
    }
    usort($pc_records, fn($a, $b) => strcasecmp($a['charname'], $b['charname']));
}
?>
<!DOCTYPE html>
<html lang="fr-CH">
<head>
    <meta charset="UTF-8">
    <title>UOA &mdash; All Characters</title>
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

        table.data-table {
            border-collapse: collapse;
            width: 100%;
        }
        table.data-table td {
            color: #FFC800;
            font-weight: bold;
            font-size: 0.9em;
            padding: 5px;
            text-align: center;
            vertical-align: top;
            border: 1px solid #FFFFFF;
        }
        table.data-table td.col-header {
            background-color: #005064;
            color: #66CCFF;
        }
        .nav-link { text-align: right; font-size: 0.9em; font-weight: bold; }

        #pcSearch {
            width: 100%;
            box-sizing: border-box;
            padding: 6px 8px;
            margin: 10px 0;
            background-color: #001428;
            color: #FFC800;
            border: 1px solid #334466;
            font-family: Arial, sans-serif;
            font-size: 1em;
        }
    </style>
</head>
<body>

<?php if (!$is_dm): ?>
    <p>DM access required.</p>
<?php else: ?>

    <p class="nav-link"><a href="galaxy.php?planet=infos"><u>Back to Infos</u></a></p>

    <h2>All Characters</h2>

    <input type="text" id="pcSearch" placeholder="Search character, account, or planet..."
           oninput="filterPCTable()">

    <table class="data-table" id="pcTable">
        <thead>
        <tr>
            <td class="col-header"><u>Account</u> :</td>
            <td class="col-header"><u>Character</u> :</td>
            <td class="col-header"><u>Planet</u> :</td>
            <td class="col-header"><u>Tile Area</u> :</td>
            <td class="col-header"><u>Area Tag</u> :</td>
            <td class="col-header"><u>X</u> :</td>
            <td class="col-header"><u>Y</u> :</td>
            <td class="col-header"><u>Z</u> :</td>
            <td class="col-header"><u>Facing</u> :</td>
        </tr>
        </thead>
        <tbody>
        <?php if (empty($pc_records)): ?>
            <tr><td colspan="9">No character location data found.</td></tr>
        <?php else: foreach ($pc_records as $pc): ?>
            <tr>
                <td><?= htmlspecialchars($pc['account']) ?></td>
                <td><?= htmlspecialchars($pc['charname']) ?><?php if ($pc['is_dm'] === '1') echo ' <span style="color:#FF0000">(DM)</span>'; ?></td>
                <td><?= htmlspecialchars($pc['planet']) ?></td>
                <td><?= htmlspecialchars($pc['tilearea']) ?></td>
                <td><?= htmlspecialchars($pc['areatag']) ?></td>
                <td><?= htmlspecialchars($pc['x']) ?></td>
                <td><?= htmlspecialchars($pc['y']) ?></td>
                <td><?= htmlspecialchars($pc['z']) ?></td>
                <td><?= htmlspecialchars($pc['facing']) ?></td>
            </tr>
        <?php endforeach; endif; ?>
        </tbody>
    </table>

    <script>
    function filterPCTable() {
        const q = document.getElementById('pcSearch').value.toLowerCase();
        document.querySelectorAll('#pcTable tbody tr').forEach(row => {
            row.style.display = row.textContent.toLowerCase().includes(q) ? '' : 'none';
        });
    }
    </script>

<?php endif; ?>

</body>
</html>
