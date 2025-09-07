<?php
// --- Configuration ---
ini_set('display_errors', 1);
error_reporting(E_ALL);

$servers = [
    'gPKQEIagD9qti4PbEZOU5nSCGsGROXQjSlZGv4VOR0w=' => 'The Frozen North',
    '+GHY5xzH9u0M1TJzrEKOPlI3hQAh+EOYGEP7ynSjNDo=' => 'World of Greyhawk Mithral',
    'Df3RmiT95Lrx7N0lCEz8hGagAMSg7XmCKofdy2sntxQ=' => 'Typhaeon US',
    'xoJRlTtP95Qj8MNKJXw2/TTB9rodlE9cZ+m/GkhFYm4=' => 'Wyrms And Mortals',
    'BhJsN1pvs/5hM8MmsMIn43y2Jig/dJCsZUIIiksGQHc=' => 'NWN-Players Castle Defense 2',
    '9EGU9XH+hrXUJlfoKjKt+VfpOjBzY58QkC1lQiy0M2U=' => 'Universe of Arlandia',
    '7xGinyfzhmweFMmck0GRDqrMTx1IqvqXounJ4MVMOjQ=' => 'NWN-Players Good vs Evil 3',
    'PbhlQ8d9JUG5SsPbHfMpZQXdTdLHh8Q5eN5XcPrT9Ec=' => 'Alestorm',
    'SZGZ2b1qC0bM76MpJ5A2ph7Tk9kVbPeCnFQNIIfPf0s=' => "Erithorn's Might",
    'r0zz3w4loPUuUoB4aRVh8ZTjQG2WhTzLM0RwFwPt/Gg=' => 'Adventure Island',
    'rZueSBk44l94bnaa/TfXcrnl9NdTwwLLmY1X6rH6J3s=' => 'Mabrak Maleficarum',
    'MZ/1+lls6UjLWbhLywzUor7aJ/Y1kgvyf3DsKDG2mB0=' => 'AradusDev',
    'VACzgVD77Mb+Uh6ivQinA0vQDylF/CTf5OzaqCY1NRg=' => 'Isandor',
    '2wlnuVPuZn50jL0HI9Xh1FDFdh0NXaEYuRkpaQ+77zs=' => 'Aradus',
    'ck/m9uPRAHBjqhYYHqNkBb3QwA7ObwcN5X/DAlcOq0E=' => 'Spellplague: The Rebirth',
    'TalAtTnZTbZocHg5Gyx0RSdbBVHCQb0MXq5DfhqJHgk=' => 'Lands of Intrigue',
];

// Caching configuration
$cacheFile = __DIR__ . '/nwn_server_status.cache';
$cacheTime = 60; // Cache results for 60 seconds

function get_from_cache(string $cacheFile, int $cacheTime): ?array {
    if (file_exists($cacheFile) && (time() - filemtime($cacheFile) < $cacheTime)) {
        $cachedData = file_get_contents($cacheFile);
        return $cachedData ? json_decode($cachedData, true) : null;
    }
    return null;
}

function fetch_server_data_sequential(array $servers): array {
    $baseUrl = "https://api.nwn.beamdog.net/v1/servers/";
    $results = [];
    $contextOptions = [ "ssl" => [ "verify_peer" => false, "verify_peer_name" => false, ], ];
    $streamContext = stream_context_create($contextOptions);

    foreach (array_keys($servers) as $serverId) {
        $url = $baseUrl . $serverId;
        $content = @file_get_contents($url, false, $streamContext);
        $results[$serverId] = $content ? json_decode($content, true) : null;
    }
    return $results;
}

// --- Main Logic ---
$results = get_from_cache($cacheFile, $cacheTime);

if ($results === null) {
    $results = fetch_server_data_sequential($servers);
    file_put_contents($cacheFile, json_encode($results));
}
?>
<html>
<head>
    <title>NWN Server Status</title>
    
    <!-- Original Meta Tags -->
    <meta name="description" content="Universe of Arlandia for Neverwinter Nights - The Universe is infinite">
    <meta name="keywords" content="arlandia uoa universe neverwinter nights nwn lkt therack the rack marc racordon">
    <meta name="author" content="TheRack">
    <meta name="Copyright" content="TheRack, 2009">
    <meta name="GENERATOR" content="Microsoft FrontPage 5.0">
    <meta name="Robot" content="INDEX,FOLLOW">
    <meta http-equiv="Content-Language" content="fr-ch">
    
    <!-- Modern/Essential Tags -->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="refresh" content="60">
    
    <style>
        body { background-color: #000; color: #FFF; font-family: Arial, sans-serif; margin: 0; padding: 0; }
        .container { display: flex; justify-content: center; align-items: center; width: 100%; min-height: 100vh; text-align: center; }
        .server-block { margin-bottom: 1em; }
        .server-name { font-size: 1.1em; }
        .online { color: #00FF00; }
        .offline { color: #FF0000; font-size: 1.2em; font-weight: bold; }
        .server-details { color: #E6E6E6; font-size: 0.9em; }
        .contact-info { font-size: 0.8em; }
        .contact-email { color: #00E600; font-size: 0.8em; }
    </style>
</head>
<body>

<div class="container">
    <div>
    <?php foreach ($servers as $serverId => $serverName): ?>
        <div class="server-block">
            <?php
            $serverData = $results[$serverId] ?? null;

            if ($serverData && isset($serverData['current_players'])) {
                echo '<span class="server-name online">' . htmlspecialchars($serverName) . ' is Online</span><br>';
                echo '<span class="server-details">Players: ' . htmlspecialchars($serverData['current_players']) . '</span><br>';
                if (isset($serverData['port'])) {
                     echo '<span class="server-details">Port: ' . htmlspecialchars($serverData['port']) . '</span><br>';
                }
            } else {
                echo '<span class="server-name offline">' . htmlspecialchars($serverName) . ' is OFFLINE</span><br>';
                echo '<span class="contact-info">Please contact</span><br>';
                echo '<span class="contact-email">Qlippoth@Speakeasy.net</span>';
            }
            ?>
        </div>
    <?php endforeach; ?>
    </div>
</div>

</body>
</html>
