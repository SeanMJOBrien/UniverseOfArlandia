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

Background: see "How time is tracked" in `DM_TOOLS_MANUAL.md`. Production, casern troops and guild terms run on the goldbag `Counter` of whoever opens the dialog; bank interest runs on the account item; rent runs on the game calendar.

- **Owner online clock in the database.** Mirror the goldbag `Counter` per character (`OnlineTicks&<Name>`) at login, logout and every few minutes, plus a real-time `LastSeen`. A structure's owner clock then drives its timers, so granted users and DMs see the owner's numbers.
  - Decide: sync interval (crash loses up to one interval of the owner's play time); key by character name (like rent) or a stable id (TASK-33).
- **Move extractor, farm, field and sawmill slot markers to the database.** Lazy: written only on set, collect and build; ready items computed on read as `min(cap, stock + (ownerTicks - marker) / cost)`. Migrate goldbag markers on first read (same tick units).
  - Decide: online-only (recommended, owner clock) or real-time production that also runs offline (economy change).
- **Caserne on the owner clock.** Already computed on open; needs the clock moved. Decide: the collector keeps receiving the troops, timing follows the owner.
- **Guild membership as an expiry tick.** Replace the per-heartbeat `GuildMB` decrement with "expires at tick X", checked on read. Runs on the member's own clock.
- **Bank interest and investments lazy.** Compute `GP`/`IV` on open (balance x 1.01^days; investment after `IVdelay`). Removes the per-heartbeat inventory scan. Holder's clock, as today.
  - Decide: audit every reader of `GP` and `IV` first (shops, trade, death, web); accept rounding differences of a gold piece or two.
  - Do last. See also "Game clocks" above for the offline-accrual question.
- **Factory timer.** Not shown in the interest dialog because output depends on linked input structures. Decide whether to design a meaningful display.
- **Field spoilage warning and guild member count.** Both were suggested and dropped; the code has no spoilage and no roster. Decide whether to add either feature.
- **Inactive characters cleanup (DM web console page).** List by days since `LastSeen`, with holdings; preview, then actions: mark abandoned, release structure slots, purge clock and language rows, remove all. Offline-only, archive rows before deleting, audit log, protected list, run in the module via the command queue.
  - Decide: default threshold (60, 90 or 180 days); automatic weekly count on Overview only, or auto-mark with login warning; whether to also demolish placed objects or just free the slot; whether the console ever deletes `.bic` files; character renames/deletes.
- **DM domain controls (chosen next).** On the console domain page: "Set owner" (writes `Master`, keeps grants and stock), and grant/revoke a slot or the whole domain for a named character. All audited. Decide: whether a new owner inherits stock and markers; whether the previous owner is notified.
- **Purchase of abandoned domains (in-game).** Not chosen yet. Decide: price rule (fraction of build cost), whether the old owner may reclaim, how long a domain must be abandoned. Ownership is per domain (one `Master`), so per-building sale would need a per-slot owner field and a migration of the `Master` checks (`cond_domain004`/`005`/`019`); selling the whole domain is the cheaper option.
- **Granted users' data.** Today a granted user's extractor view reads their own goldbag and shows "No resource is set yet." Fixed by the owner-clock move above; confirm in-game before it lands.
- **Deploy.** `NWNX_ITEM_SKIP=no` (and TIME/CHAT/WEBHOOK/REDIS to review) in `/home/qlippoth/uoa/config/nwserver.env` still needs your edit; the appearance restore for broken items depends on it. The new interest-dialog lines are committed (8d5c0d7) but not pushed or deployed or tested in-game.

## Follow-ups from the owner-clock change

- **Investment gain never paid (existing bug, behaviour kept).** The old heartbeat tested a stale copy of `IVdelay`, so `iInvestmentInterest` was never applied and investments return only the principal. Decide the intended gain (documented 3% per day over the 20-day term, which would be 1000 -> 1600) and add it to `BankSettle` in `_bank.nss` where the term reaches -1.
- **Guild membership** still decrements per heartbeat on the member's goldbag. Left alone (item 4).
- **Verify in game after deploy:** owner opens an extractor (migrates old data, timer shown); granted user sees the same numbers; owner offline, grantee sees frozen timer; casern, factory and farm dialogs; bank open after some play time (interest, investment term); `OnlineTicks&<Name>` and `LastSeen_<Name>` rows appear in `pwdata`.
- **Old goldbag markers** (`<Planet>&<Area><Slot>`, `Counter<i>`) are now dead data on every goldbag. Clean up later once migration is confirmed.
- **Cleanup page** can use `LastSeen_<Name>` (real-world unix time) directly; it is written by `DomainClockSync`.
