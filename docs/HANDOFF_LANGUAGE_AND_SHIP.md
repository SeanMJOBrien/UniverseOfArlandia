# Handoff: language system and ship combat prototype

State as of 2026-10-29, branch `language-nwnx` (main branch: `main`). Latest commits: `4166e21` (manual: overlapping books), `1de3674` (0-1000 fluency, consumable books), `3326a83`, `3e12a71`, `49e049b` (language test tablet), `27f701d` and `39eaadb` (ship camera and draw list). Only `export/` is untracked.

## Environment and conventions

- Repo: `/home/qlippoth/git/UniverseOfArlandia`. Live server: `~/uoa/`, deployed with `~/uoa/build_deploy.sh`. Restart with `docker-compose down` then `docker-compose up -d`, never `restart`.
- Nothing from this work is deployed. The language changes are not on the live server. The ship code is test-only (`tools/ship_test`) and is not part of the server build.
- Do not delete `.swamp/` directories. Do not use `git add -A` or `git add .`; stage named files. `export/` stays untracked.
- Commit messages end with:
  `Co-Authored-By: Claude Sonnet 5.5 <noreply@anthropic.com>` and `Claude-Session: https://claude.ai/code/session_01RzcttqoG91DpBvm3LhGwfC`.
- Prose style (docs, replies): declarative, global English, no aphorisms, no emphasis, no nominalized subjects. Use they/them for people whose pronouns are unknown.
- Tools: `nwnsc` at `/home/qlippoth/git/nwn-tools/linux/nwnsc/nwnsc` (call with `-i . -i /home/qlippoth/git/uoaNasherReuse/nwn-base-scripts -b <outdir>`), `nwn_gff` and `nwn_erf` in `nwn-tools/linux/neverwinter/` (run `nwn_erf -x -f` inside the target directory), nwn-mcp tools (`load_module` takes `modPath`; `verify_dialog resref`; `resolve_2da table row`; `search_2da table column value`). Put temporary files in the session scratchpad.
- Shell hook note: a command with `rm -rf` and a relative glob after `cd` was blocked. Extract into fresh directories instead.
- Nothing here has been played in the client. Every in-game behavior below is untested unless marked as confirmed.

## Language system

### Design (as implemented)

- Fluency is 0-1000 points per language per character. `DMFI_LANG_FLUENT` = 1000. Constants live in `src/nss/dmfi_lang_inc.nss`.
- Storage: local string `lang_pts` on the character, format `,id:points,` (for example `,6:1000,1:500,`), mirrored in the campaign database row (`LangDb`, `DMFI_LANG_DB`, `DMFI_LANG_VAR_LOADED`, `DMFI_LANG_DB_MARK`; `LangLoad` restores it and calls `LangSaveKnown`).
- Legacy data: `lang_known` (levels 1-6, `,4,` = fluent) converts lazily in `LangMigrateKnown` on first read. Level n of 6 becomes n*1000/6 points; 6 becomes 1000. Listening progress toward the next level is lost.
- Hand-set values (dialog `maxlevel`, `npc_lang_cap`, `lang_dialect_<name>`, `lang_interp_max_level`, `cond_lang_know` `level`, `.teach`) go through `LangPoints(v)`: 1-6 count as levels of six (v*1000/6), 7-1000 are points, above 1000 is 1000.
- Word knowledge: a word is known when `(hash % 1000) < fluency`, so the known words are stable for a given fluency.
- Key functions: `LangPoints`, `LangPercent`, `LangPtsFind`, `LangListWithout`, `LangMigrateKnown`, `LangListLevel`, `LangSaveKnown`, `LangListPut` (no DB write), `LangListSet` (put plus save), `LangAddExposure(oListener, iLang, iPoints = 0)`, `LangGainExposure`, `LangKnownSummary`.
- Descriptor: `npc_lang_descriptor` (`DMFI_LANG_DESCRIPTOR_VAR`) on a creature or placeable replaces the race name in translated descriptions; `LangRaceName` returns it first when set. The test tablet uses "tablet".

### Books (`src/nss/dmfi_lang_book.nss`)

- Item tag and resref: `lang_book_<languageId>_<volume>`. 66 items from `tools/lang_books.py` (`--volumes N` generates another count; it does not delete stale files above N in `src/uti`). The bookshelf blueprint is `src/utp/lang_bookshelf.utp.json`; `lang_shelf_fill.nss` restocks it, so the test shelf supplies unlimited books.
- Default numbers for volume v of N (`lang_book_volumes`, default 6): min = (v-1)*1000/N, max = v*1000/N (last = 1000), gain = max - min.
- Item locals override: `lang_book_min`, `lang_book_gain`, `lang_book_max`. Setting gain or max puts the book on its own numbers and the volume number is ignored. Gain defaults to max - min; max defaults to 1000; min defaults to 0.
- Reading: fluency below min refuses and keeps the book; fluency at or above max refuses and keeps the book; otherwise new fluency = min(fluency + gain, max), the book is consumed (stack decrement or `DestroyObject`), and a message with the percentage is sent. The first book of a new language takes a language slot.
- Overlapping ranges work without code changes (confirmed by reading the code, not by play). Example: min 300, max 450, reader at 350 ends at 450. Documented in `docs/LANGUAGE_SYSTEM.md`, "Overlapping books".
- Open idea (not built, not requested): refuse and keep a book when it would give fewer than some minimum number of points; add overlapping books to `tools/lang_books.py`.

### Other settings (module variable overrides the file constant; `src/nss/dmfi_lang_cfg.nss`)

`lang_exp_on` (master switch for listening, trainers and `act_lang_exp`), `lang_exp_gain` (points per heard line, default 1), `lang_exp_cooldown`, `lang_interp_on`, `lang_interp_max_level`, `lang_tutor_on`, `lang_tutor_gain` (default 167, capped by the teacher), `lang_book_volumes` (default 6), `lang_slots_ignore`. The full table is in the manual.

### Files

- Scripts: `src/nss/dmfi_lang_inc.nss`, `dmfi_lang_cfg.nss`, `dmfi_lang_book.nss`, `dmfi_lang_dialog.nss`, `dmfi_lang_teach.nss`, `dmfi_lang_nwnx.nss`, `lang_shelf_fill.nss`, `act_lang_exp.nss`, `cond_lang_know.nss`, `lang_book_use.nss`. `dmfi_*` files derive from DMFI; upstream updates would overwrite local edits.
- Docs: `docs/LANGUAGE_SYSTEM.md` (manual), `docs/LANGUAGE_TEST_SPEC.md`, `docs/LANGUAGE_TEST_MODULE.md`.
- Tools: `tools/build_language_erf.sh` (compiles the package and manual; writes `export/uoa_language_system_nwscript.erf` and `export/uoa_language_system_manual.html`), `tools/build_test_module.py` (writes `export/uoa_language_test.mod`), `tools/lang_books.py`, `tools/lang_dialog.py` (`--maxlevel` takes 1-1000, or 1-6 as level of six), `tools/language_test/*.nss` (test module scripts).
- Packages sent to the user: `export/uoa_language_system_nwscript.zip` (ERF and manual; rebuilt 2026-10-29 with the overlapping-books section) and `export/uoa_language_test.zip` (module and test docs; built 2026-10-27, not rebuilt since). To rebuild the system zip: run `tools/build_language_erf.sh`, then zip the ERF and the manual HTML from `export/`.

### Test module

- `export/uoa_language_test.mod`. The Ancient Dwarven Tablet is read through a placeable-initiated conversation (`lang_tablet_use.nss` calls `ActionStartConversation(oUser, "lang_tablet", TRUE, FALSE)`); the dialog has a fallback last root "The runes are too worn to read." The user confirmed this version worked in game.
- Boddyknock's `lang_pts` is `,6:1000,1:500,7:1000,`, with `lang_dialect_old_dwarven` 5. Module settings: `lang_exp_on` 1, `lang_exp_gain` 25, `lang_exp_cooldown` 2, `lang_interp_on` 1, `lang_tutor_on` 1.

### Unverified

- The 0-1000 fluency system, consumable books, messages, tutoring and exposure in the client.
- Migration of existing characters' saved data on the live server.
- The NWNX path and the bookshelf blueprint (never run in game).

### Next steps

1. Wait for the user's play-test feedback on the language test module.
2. If the user asks to deploy: run `~/uoa/build_deploy.sh`, then `docker-compose down` and `up -d`. The first load of each character converts saved levels to points.
3. Branch status in the manual: `dmfi-language-tables` is the deployed branch (fluency 1-5, `.learn`, no books); `language-nwnx` holds books, bookshelf, NWNX chat support and the quest dialog example and is not deployed.

## Ship combat prototype

- Module: `export/uoa_ship_test.mod` (and `.zip`), built by `tools/build_ship_module.py` from `tools/ship_test`. Needs the template module `~/nwn-data/user/modules/uoa_ship_test.mod`. Docs: `docs/SHIP_COMBAT_PROTOTYPE.md` (rules, controls, tuning, checklist) and `docs/SHIP_COMBAT_REPORT.md`.
- Design: 20x20 grid of 5 m cells, round-based plotting (30 s), NUI "Ship Orders" window, ships as placeables moved by visual transform only (`SetObjectVisualTransform`), turns by `SetFacing`.
- Scripts: `sc_inc.nss` (grid, state, resolution, plotting, `ScStartBattle`, `ScReturnToShore`, `ScEndBattle`), `sc_nui.nss` (window and map), `sc_nui_event.nss` (events), `sc_ui_open.nss`, `sc_ui_refresh.nss`, `sc_bell_use.nss`, `sc_on_enter.nss`, `act_ship_hire.nss`, `act_ship_dismiss.nss`.
- NUI draw list: the list cannot be bound as a whole (that caused `[json.exception.type_error.302] type must be array, but is object`). `ScUiMapList()` builds a fixed list whose items bind points, colors, rects, text, enabled and line endpoints (binds named by `ScUiBind`, such as `sctle`/`scta`/`sctb`, `sccol<i>`, `scpts<i>`, `sclr<i>`, `sclt<i>`). `ScUiPushMap` pushes values.
- Camera: `ScStartBattle` calls `AttachCamera(oPC, ScShip(1))`; "Follow ship" and "Return to shore" buttons exist; `ScEndBattle` re-attaches to the player after 6 s.
- Unverified: whether the camera glides with the ship (it follows the real object, which never moves, so it may stay at the mooring); NUI bound polylines and colors; tile 7 shore appearance; ship height (z 0.0) and scale (`ship_scale_pct` 300, `ship_yaw_offset` 0).
- Fallback if the camera stays at the mooring: attach the camera to an invisible object that moves with the ship each step.
- Offered but not confirmed by the user: rewording `docs/SHIP_COMBAT_REPORT.md` and its published artifact with generic terms.
- Not built: spells, stations other than pilot, player versus player, boarding, wind.
