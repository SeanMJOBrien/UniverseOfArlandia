# TODO

## Language system

- Consider making Common a language that a new player character must select when joining (character creation), instead of being the implicit default speech of every PC. Today Common is the fallback in the `.lang` window (`dmfi_lang_nui.nss`) and talk mode is off by default (`lang_talk` unset). Open questions: whether a PC could then forget or lack Common, and how NPC dialog and `LangFluency` should treat it (currently Common is not a language id).

- Store the language state, and possibly other per-character information, on a dedicated item as an option next to the sqlite storage. The item would be a 1x1 miscellaneous item, for example an ear, that is undroppable and flagged stolen so it cannot be sold, traded or looted. Item variables are saved in the character's `.bic`, so deleting the character file would remove the data with it, with no stale rows and no reused-name problem, and the data would move with the character between servers.
  - Setting: `LANG_STORE` with `db` (today's sqlite behavior, the default), `item` or `both` (item as the source of truth, sqlite as backup).
  - Work: the item blueprint and palette entry; item read and write functions beside `LangSave`, `LangLoad` and `LangSaveExp` in `dmfi_lang_inc.nss`; creation of a missing item on entry; a one-time copy from sqlite onto the item; ERF build and docs.
  - Open points: items are saved only when characters are exported (about every 20 minutes and at server exit), so a crash can lose recent progress; a DM could copy the item to give another character the same languages; and which other information belongs on the item.

## Domain clock and ownership

Deployed: owner online clock, domain state in pwdata, caserne, lazy bank and guild, factory timer, NWNX_Item, `.wowner`/`.wgrant`/`.wrevoke`/`.wdomain`, abandoned-domain purchase (365 days away, 5000 GP), monthly bank rates.

Built and compiled, not yet deployed or tested: guild roster, owner index with login import, inactivity sweep with a 30-day waiting period and email queue, `.email`, bank settings read from `pwdata`, `dm_bank.php`, `dm_inactive.php`, `tools/send_outbox.php`.

## To decide

- **Old owner payment.** A sold domain's price leaves the game. Decide whether the old owner is paid (to a bank account, which needs them online) or stays unpaid.
- **Verify email addresses.** `.email` stores whatever is typed. Decide whether to send a confirmation link first so nobody can register someone else's address.
- **Offline accrual.** Whether bank interest and caserne troops should ever accrue while the owner is offline. No change proposed.
- **Bank rates.** Normal accounts 2% per month, investments 3% per month, both added daily with a 28-bank-day month. Over 20 days that is about 1.4% against 2.1%. Revisit if players ignore both.

## To build

- **Web console.** The console prototype (DM console, queue, spawning, world map, quests) is still a mock. The Bank and Inactive pages are the first real pages, on the existing PHP site.
- **Owner-less structure data.** An owner who never opened a structure after the update leaves its setup on their character file; a buyer of their domain then starts unconfigured. Importing at login covers owners who return; for the rest consider reading the `.bic` offline.
- **Clean up old goldbag markers** (`<Planet>&<Area><Slot>`, `Counter<i>`) once the import is confirmed.
- **Guild halls changing hands** lose their members, who hold the old owner's name in their own data. Consider moving the roster and the `Guild` strings when a hall is handed over.

## To test in game and on the site

- Owner opens an extractor: old data imports and the timer shows. A granted user sees the same numbers. An offline owner's timer is frozen. Casern, factory and farm dialogs.
- Log in as an owner: structure data imports at login (check `DS&...&Migrated` rows).
- `OnlineTicks&<Name>`, `LastSeen_<Name>`, `Account&<Name>` and `DomainIndex&<Name>` rows appear in `pwdata`; the index backfill logs "Domain owner index built." after the module loads.
- Bank: open after some play (interest and investment term); change a value in `dm_bank.php` and see it in the shop dialog and the next investment.
- Guild: join, renew, leave, log in/out; the hall dialog shows the roster.
- `.email`, `.email off`; set `LastSeen_<owner>` back 365+ days and wait for a sweep: `mail_outbox` gets a row and `tools/send_outbox.php` sends it. With 395+ days away the sign offers the sale; `.wdomain` shows the state.
- `.wowner`, `.wgrant`, `.wrevoke` on a test domain.
- `dm_inactive.php` against the real vault (and write access for removal). It has only been syntax-checked.
- `dm_bank.php` saves and the module reads the values.
