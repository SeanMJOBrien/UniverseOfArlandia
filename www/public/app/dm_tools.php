<?php
/**
 * DM page: the list of DM tools. Linked from the DM area on index.php.
 */
require __DIR__ . '/dm_common.php';

$tools = [
    ['dm_bank.php', 'Bank', 'Interest rates, investment term, amounts offered, account price and the length of a bank day.'],
    ['dm_rentals.php', 'Rentals', 'Who rents which house or unit, where, for how much, and how many game days of rent are left.'],
    ['dm_inactive.php', 'Inactive accounts', 'Player accounts not seen for a year, their characters and domains; archive the character files by hand.'],
    ['galaxy.php?planet=infos', 'Informations', 'Server information and the character reset.'],
    ['playerInfo.php', 'Player information', 'Look up a player and reset a character\'s location.'],
    ['playerLocations.php', 'Player locations', 'Where each character is in the world.'],
    ['planetCreator.php', 'Planet creator', 'Create, edit or delete planets.'],
];

dm_page_start('DM tools');
?>
<div class="panel">
<table>
<?php foreach ($tools as $tool):
    if (!is_file(__DIR__ . '/' . strtok($tool[0], '?'))) continue; ?>
<tr><td><a href="<?= h($tool[0]) ?>"><b><?= h($tool[1]) ?></b></a></td><td class="quiet"><?= h($tool[2]) ?></td></tr>
<?php endforeach; ?>
</table>
</div>
<?php dm_page_end();
