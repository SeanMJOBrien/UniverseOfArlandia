# TODO

## Language system

- Consider making Common a language that a new player character must select when joining (character creation), instead of being the implicit default speech of every PC. Today Common is the fallback in the `.lang` window (`dmfi_lang_nui.nss`) and talk mode is off by default (`lang_talk` unset). Open questions: whether a PC could then forget or lack Common, and how NPC dialog and `LangFluency` should treat it (currently Common is not a language id).

- Store the language state, and possibly other per-character information, on a dedicated item as an option next to the sqlite storage. The item would be a 1x1 miscellaneous item, for example an ear, that is undroppable and flagged stolen so it cannot be sold, traded or looted. Item variables are saved in the character's `.bic`, so deleting the character file would remove the data with it, with no stale rows and no reused-name problem, and the data would move with the character between servers.
  - Setting: `LANG_STORE` with `db` (today's sqlite behavior, the default), `item` or `both` (item as the source of truth, sqlite as backup).
  - Work: the item blueprint and palette entry; item read and write functions beside `LangSave`, `LangLoad` and `LangSaveExp` in `dmfi_lang_inc.nss`; creation of a missing item on entry; a one-time copy from sqlite onto the item; ERF build and docs.
  - Open points: items are saved only when characters are exported (about every 20 minutes and at server exit), so a crash can lose recent progress; a DM could copy the item to give another character the same languages; and which other information belongs on the item.

## Game clocks

- Consider the effects of moving the bank-interest and caserne clocks off the engine heartbeat counters and into the database (real-time timestamps). Today bank interest (`GPdelay`/`IVdelay` on the account item) and caserne troops (`Counter` on the goldbag) only advance while a player is logged in, and bank accounts only earn while the card is carried. Questions to settle first:
  - Should interest and troops accrue while the owner is offline? That is a large economic change (balance, inflation, catch-up on login after a long absence).
  - Where would the timestamp live for a bank card that is an item (follows the character) versus a caserne (belongs to a structure)?
  - Migration of existing `GPdelay`, `IVdelay` and caserne goldbag markers, and what happens to a half-run investment.
  - Caserne shares one clock for all five levels and resets it on collection; a timestamp version needs the same reset semantics.
  - See "How time is tracked" in `DM_TOOLS_MANUAL.md`.

## Domain clock and ownership (decisions pending)

Done and deployed: owner online clock, domain state in pwdata, caserne, lazy bank, factory timer, NWNX_Item. Guild lazy is built but not yet deployed. Background: see "How time is tracked" in `DM_TOOLS_MANUAL.md`. Production, casern troops and guild terms run on the goldbag `Counter` of whoever opens the dialog; bank interest runs on the account item; rent runs on the game calendar.

- **Guild member count in the guild dialog.** Suggested and dropped: the game has no guild roster (the XP bonus counts guild members in the party). Decide whether to add a roster.
- **Inactive characters cleanup (DM web console page).** List by days since `LastSeen`, with holdings; preview, then actions: mark abandoned, release structure slots, purge clock and language rows, remove all. Offline-only, archive rows before deleting, audit log, protected list, run in the module via the command queue.
  - Decide: default threshold (60, 90 or 180 days); automatic weekly count on Overview only, or auto-mark with login warning; whether to also demolish placed objects or just free the slot; whether the console ever deletes `.bic` files; character renames/deletes.
- **DM domain controls (chosen next).** On the console domain page: "Set owner" (writes `Master`, keeps grants and stock), and grant/revoke a slot or the whole domain for a named character. All audited. Decide: whether a new owner inherits stock and markers; whether the previous owner is notified.
- **Purchase of abandoned domains (in-game).** Not chosen yet. Decide: price rule (fraction of build cost), whether the old owner may reclaim, how long a domain must be abandoned. Ownership is per domain (one `Master`), so per-building sale would need a per-slot owner field and a migration of the `Master` checks (`cond_domain004`/`005`/`019`); selling the whole domain is the cheaper option.

## Follow-ups from the owner-clock change

- **Investment gain never paid (existing bug, behaviour kept).** The old heartbeat tested a stale copy of `IVdelay`, so `iInvestmentInterest` was never applied and investments return only the principal. Decide the intended gain (documented 3% per day over the 20-day term, which would be 1000 -> 1600) and add it to `BankSettle` in `_bank.nss` where the term reaches -1.
- **Guild membership** is now lazy (`_guild.nss`, `GuildEnd`). Verify in game: join a guild, check days left in the guild dialog and the XP bonus, relog.
- **Verify in game after deploy:** owner opens an extractor (migrates old data, timer shown); granted user sees the same numbers; owner offline, grantee sees frozen timer; casern, factory and farm dialogs; bank open after some play time (interest, investment term); `OnlineTicks&<Name>` and `LastSeen_<Name>` rows appear in `pwdata`.
- **Old goldbag markers** (`<Planet>&<Area><Slot>`, `Counter<i>`) are now dead data on every goldbag. Clean up later once migration is confirmed.
- **Cleanup page** can use `LastSeen_<Name>` (real-world unix time) directly; it is written by `DomainClockSync`.
