# Language system test specification

Scope: the NWScript-only package (`export/uoa_language_system_nwscript.erf`) imported into a fresh module and played in the single-player client. Behavior is described in `docs/LANGUAGE_SYSTEM.md` and `docs/LANGUAGE_PACKAGE.md`.

## Limits of a single-player test

| Feature | Status |
|---|---|
| Listener differences between two players, Lore notice, line of sight between players | Not testable. Needs a second player. Gruk covers the same masking rules for one listener. |
| `.teach` (DM command) | Not testable. Use books to set fluency. |
| NWNX Chat path (section K) | Not testable in the package or alone. Needs the server with the plugin and two clients. |
| Tutoring (`.tutor`), PC-only exposure from a real second player | Not testable. Needs a second player. Cases I6 to I10 cover what can be checked alone. |
| Typed `[text]` voice script (`dmfi_voice_exe`) | Not in the package. Use the `.lang` window or talk mode. |
| Exposure gain | Slow with the defaults (n x n x 20 points at one point per 30 seconds). It is off by default; section I turns it on and shortens it. |

## Setup

1. Create a fresh module. Import the whole ERF (File, Import, ERF).
2. Set the module events: OnPlayerChat = `lang_on_chat`, OnActivateItem = `lang_on_act`, OnClientEnter = `lang_on_enter`.
3. In the first area place the `lang_bookshelf` placeable (Special, Custom 5) and Gruk (`lang_goblin`, Special, Custom 5). Place both within walking distance of the start point.
4. Build the module and start a new game.

Test characters (create in the vault before starting):

| Name | Race | Class | Intelligence | Purpose |
|---|---|---|---|---|
| Tester | Human | Fighter | 14 (modifier +2, two slots) | main character |
| Tester2 | Human | Fighter | 8 | no free slots |
| Tester3 | Dwarf | Fighter | 14 | innate Dwarven |
| Tester4 | Half-elf | Rogue | 14 | innate Elven and Thieves' Cant |
| Tester5 | Elf | Ranger | 14 | innate Elven and Animal |

Unless a case names another character, use Tester.

## A. Installation and palette

| Id | Steps | Expected |
|---|---|---|
| A1 | Open the toolset palettes for items, placeables and creatures. | Special, Custom 5 lists 66 books (items), `lang_bookshelf` (placeable) and Gruk (creature). |
| A2 | Build the module. | No missing script errors. |
| A3 | Enter the module as Tester. | The login tip from `lang_on_enter` appears. |
| A4 | Type `.learn`. | A message says languages come from books. |
| A5 | Type `.languages`. | The list shows no learned languages, common speech in use, talk mode off, and two free slots. |

## B. Books and slots

| Id | Steps | Expected |
|---|---|---|
| B1 | Open the bookshelf. | It contains 66 books, one of each volume. Take Goblin volume 1 and volume 2. |
| B2 | Activate Goblin volume 2 first. | Refused: volumes are read in order. Fluency unchanged. |
| B3 | Activate Goblin volume 1. | Message "You study Goblin, volume 1 of 6. Volume 2 is next. You can start 1 more language." `.languages` shows Goblin 1. |
| B4 | Activate Goblin volume 1 again. | Nothing changes. |
| B5 | Activate Goblin volume 2. | Goblin 2. Free slots stay at one. |
| B6 | Take Elven volume 1 and activate it. | Elven 1. Zero free slots. |
| B7 | Take Dwarven volume 1 and activate it. | Refused with a message about languages known against the total allowed. Dwarven not learned. |
| B8 | Activate Goblin volumes 3 to 6 in order. | Fluency rises by one each time. After volume 6 `.languages` shows Goblin 6. |
| B9 | Check that the books are still in the inventory. | All books remain (not consumed). |
| B10 | Close and reopen the shelf after removing a volume. | The missing volume is restored (`lang_shelf_fill`). |
| B11 | As Tester2 (Intelligence 8), activate Goblin volume 1. | Refused: no slots. |

## C. Innate languages

| Id | Character | Steps | Expected |
|---|---|---|---|
| C1 | Tester3 | `.languages` | Dwarven at 6, uses no slot. |
| C2 | Tester4 | `.languages` | Elven 6 and Thieves' Cant 6. Drow is not listed. |
| C3 | Tester5 | `.languages` | Elven 6 and Animal 6. |
| C4 | Tester | `.languages` | No innate language. |
| C5 | Tester3 | Activate Dwarven volume 3. | No effect on a language already at 6, no slot used. |

## D. Gruk (NPC dialog)

Gruk's menu has 14 options: 13 languages (Drow as sign) and Common. Selecting one sets his language and he says a sample line.

| Id | Steps | Expected |
|---|---|---|
| D1 | Tester with no languages. Talk to Gruk, choose Common. | The line is readable plain text. |
| D2 | Choose Goblin. | The line is scrambled and prefixed `(Goblin)`. |
| D3 | Choose each other spoken language in turn (Elven, Gnome, Halfling, Dwarven, Orc, Draconic, Celestial, Abyssal, Infernal). | Each line is scrambled with the matching language prefix, and the scramble differs between languages. |
| D4 | Choose Drow. | No scramble. A description such as "The Goblin does not speak, but moves their hands and fingers in rapid patterns." |
| D5 | Choose Goblin again and repeat three times. | The scrambled line is identical every time. |
| D6 | Give Tester Goblin 6. Choose Goblin. | The line is plain text with no prefix. |
| D7 | Give Tester Goblin 3 (read volumes 1 to 3 in order, starting from a character without Goblin). Choose Goblin and repeat five times. | The same words are readable and the same words are scrambled each time. The line starts with `(Goblin)`. |
| D8 | Compare D7 at Goblin 4 (after volume 4). | Every word readable at level 3 is still readable. More words are readable than before. |
| D9 | At Goblin 5, then Goblin 6. | Level 5 shows nearly all words. Level 6 shows all. |
| D10 | Start two separate new games with two characters at the same level in the same language. | The two characters can read different words (different seeds). Expected but depends on the seed, so a rare coincidence is possible. |
| D11 | Tester4 (Rogue, Elven 6 and Thieves' Cant). Choose Elven. | Plain text, no prefix. |
| D12 | Tester with Drow 6 (books). Choose Drow. | "The Goblin signs, `<full text>`". |
| D13 | Tester with Drow 3. Choose Drow. | "...uses sign, you can only make out: ..." with a subset of words, or the "cannot make out any of it" line. The same subset on repeat. |
| D14 | Leave the area and return several times. | Exactly one Gruk is present each time. |

## E. The `.lang` window

| Id | Steps | Expected |
|---|---|---|
| E1 | Type `.lang`. | The window opens. Layout from top to bottom: translations check box, log, text box, status line, bottom row (label "Speak in:", drop-down, Speak button). |
| E2 | Resize the window wider and narrower. | The fields fill the full width and follow the resize. No error text in the title bar or body. |
| E3 | Open the drop-down as Tester with Goblin and Elven. | Common first, then Goblin and Elven. |
| E4 | Choose Goblin. Type `.languages`. | Goblin is the language in use and talk mode is on. |
| E5 | Choose Common. Type `.languages`. | Talk mode off. Speech returns to common. |
| E6 | Choose Goblin, enter "hello friend", press Speak. | The text is sent as Goblin speech (see F cases). The text box is cleared or the line appears in the log, as the window does. |
| E7 | With Common selected, enter text and press Speak. | The text is spoken normally. |
| E8 | Clear "Show translations", then speak and talk to Gruk. | The log is hidden and receives no lines. Speaking and `.languages` are unaffected. |
| E9 | Set "Show translations" again. | The log returns and lines are fed again. |
| E10 | Close the window and reopen it with `.lang`. | The language selection and the check box state are as left. |
| E11 | Open with a character that knows no language. | The drop-down offers only Common. The status line reads "New languages you can start: 2". |

## F. Speaking

Use Tester with Goblin 3 for F1 to F6, then raise the level for F7.

| Id | Steps | Expected |
|---|---|---|
| F1 | Type `.speak goblin`. Say "the water to the mountain is long". | Talk mode on. The speaker's own chat line is the scrambled text, not the original. |
| F2 | Read the speaker's line. | Words Tester knows appear in Goblin scrambled form. A run of words Tester does not know appears as a single `...`; two `...` never follow each other. |
| F3 | Say the same sentence again. | The same words are known and unknown. The line is identical. |
| F4 | Say another sentence containing "water". | "water" has the same result as in F2. |
| F5 | Type `.speak off`. Say a sentence. | Normal speech. |
| F6 | Type `.speak xyz`. | A message that the language is unknown. Talk mode unchanged. |
| F7 | Raise Goblin to 6. Say the sentence from F1 with `.speak goblin`. | Every word appears in scrambled Goblin. No `...`. |
| F8 | With `.speak goblin` on, try a shout, an emote (`*waves*`), and a message starting with `.`, `[`, `:` or `/`. | None of these is converted. |
| F9 | Whisper in talk mode (when the client allows it). | Treated as speech in the language. |
| F10 | Without a known language, type `.speak elven`. | Refused or no effect, since Tester lacks the language. |
| F11 | Tester4 (Thieves' Cant). Type `.speak thieves`. Say a short sentence. | The speaker's message becomes one gesture chosen by the first letter. |
| F12 | Tester4. Say a sentence longer than 25 characters in Thieves' Cant. | The message is cut at 25 characters. |
| F13 | Tester5. `.speak animal` and say a sentence. | Works as another language. |
| F14 | Tester with Drow 3. `.speak drow` and say a sentence. | No speech bubble and no scrambled text. The speaker reads "You sign, `<text>`" (the full text). |

## G. Persistence

Locals are not saved in the character file. The language state is saved in a campaign database named by the public CD key.

| Id | Steps | Expected |
|---|---|---|
| G1 | Learn Goblin 3 and Elven 1. Set the speaking language to Goblin. Exit the module with Save and Exit. | A file named like `<cdkey>.sqlite3` exists in the `database` folder of the NWN user directory. If the client reports no key, the shared file `dmfi_lang.sqlite3` is used instead. Note which. |
| G2 | Start a new game (not Load Game) with the same character, same name. | Goblin 3 and Elven 1 are present in `.languages`. The chosen language and talk mode are restored. The "Show translations" setting is restored. |
| G3 | Talk to Gruk in Goblin. | The same readable words as before G1. The seed is restored. |
| G4 | Start a new game with Tester2 (a different name). | No language from Tester. |
| G5 | Read Goblin volume 4. Start a new game again. | Goblin 4. |
| G6 | Check the file with `sqlite3 <file>`, `select varname, playerid from db;`. | Rows for each stored variable with the character name in `playerid`. |
| G7 | Delete `<cdkey>.sqlite3` and start a new game with Tester. | Tester has no learned languages. Languages from books held in the inventory do not count until read again. |
| G8 | Delete the character file from the vault and recreate a character with the same name. | Known gap: the old rows remain in the database and the new character inherits the old languages. Record the outcome. |
| G9 | (Optional) With a `dmfi_lang.sqlite3` that contains rows for Tester and no account file, start a game. | Rows are copied to the account file. |

## I. Advancement settings

Advancement by listening is off by default. Set the module variables in the toolset (Module Properties, Variables) before building, or change `dmfi_lang_cfg.nss` and rebuild. For on/off variables 1 is on and 2 is off. In a single-player game the only sources are Gruk and other NPCs, so PC-only cases check what is refused.

| Id | Steps | Expected |
|---|---|---|
| I1 | No variables set. With Goblin 1, talk to Gruk in Goblin repeatedly for several minutes. | No exposure points and no advancement. |
| I2 | `lang_exp_on` = 1. Repeat I1. | One point per 30 seconds at most. 20 points are needed for level 2. |
| I3 | `lang_exp_on` = 1, `lang_exp_unit` = 1, `lang_exp_cooldown` = 1. Choose the Goblin option repeatedly. | One point about every second. One point advances Goblin 1 to 2 with the message "Your grasp of Goblin has improved to 2 of 6." Level 2 needs four points. |
| I4 | `lang_exp_on` = 1, `lang_exp_unit` = 0, `lang_exp_cooldown` = 0. | Same as I2 (zero keeps the file values). |
| I5 | Set `lang_exp_on` = 2 after I3. | Advancement stops. Books still raise the level. |
| I6 | `lang_exp_on` = 1, `lang_exp_pc_only` = 1, unit 1, cooldown 1. Repeat I3 with Gruk. | No points: Gruk is an NPC. |
| I7 | As I6, and set the local int `lang_trainer` = 1 on Gruk (toolset variable on the creature). | Gruk gives points again, one per cooldown. |
| I8 | As I6, add the action `act_lang_exp` (parameters `language` = goblin, `points` = 3) to a dialog reply. Choose that reply with Goblin 1 and unit 1. | The points arrive at once, ignoring PC-only mode and the cooldown. Goblin 1 advances to 2 with 1 point and the remaining points count toward level 3. |
| I9 | As I8 with `lang_exp_on` unset. | No points from the action. |
| I10 | As I8 with the action's `language` = elven and Tester not knowing Elven. | Nothing happens. |
| I11 | Two players, `lang_exp_pc_only` = 1: player A speaks Goblin in talk mode, player B has Goblin 1. | B earns points from A's lines. Needs a second player. |

## J. Slots and tutoring

| Id | Steps | Expected |
|---|---|---|
| J1 | Tester2 (Intelligence 8), `lang_slots_ignore` unset. Read Goblin volume 1. | Refused: no slot. |
| J2 | Same, `lang_slots_ignore` = 1. | Goblin 1. The message ends "You can start any number of languages." `.languages` and the `.lang` status show "no limit". Read volume 1 of five more languages: all succeed. |
| J3 | `lang_slots_ignore` = 2 (off) with the file value TRUE. | The limit applies. |
| J4 | `lang_tutor_on` unset. Type `.tutor`. | "Tutoring is not enabled on this module." |
| J5 | `lang_tutor_on` = 1, one player alone. Type `.tutor`. | "No other player character is within 5 metres." |
| J6 | Two players A (Goblin 6) and B (no Goblin, one free slot) within 5 m. A types `.tutor`, chooses B and Goblin, presses Offer lesson. | B gets a window "A lesson is offered" naming A and Goblin. A's window says it is waiting. Needs a second player. |
| J7 | B presses Accept. | B has Goblin 1. A and B each get a message. B's slot count drops by one. |
| J8 | A offers Goblin to B again at once. | Refused: B had a lesson recently (cooldown). With `lang_tutor_cooldown` = 5 it works after five seconds and B reaches Goblin 2. |
| J9 | B presses Decline. | A is told B declined. No change. |
| J10 | B walks beyond 5 m and presses Accept. | Refused, no change. |
| J11 | B has no free slot and no Goblin. | A's offer is refused with "has no spare language slot", unless `lang_slots_ignore` = 1. |
| J12 | A has Goblin 3 and B has Goblin 3. | Refused: B already knows as much as A. |

## K. NWNX Chat (server with the plugin, two or more clients)

Set `NWNX_CHAT_SKIP=no` in `config/nwserver.env` and restart. This is Phase 0 of `docs/LANGUAGE_NWNX_PLAN.md`.

| Id | Steps | Expected |
|---|---|---|
| K1 | Read the module log after load. | "Language system: NWNX Chat active." |
| K2 | A speaks Goblin 6 in talk mode, B has no Goblin, C has Goblin 3, both within 20 m. | A's bubble shows readable text on A's own and fluent clients, scrambled on B's, and partly masked on C's. Each chat line is labelled `[Goblin]`. |
| K3 | A speaks the same sentence again. | C sees the same masked words. |
| K4 | A has Goblin 3 and speaks. | Every client's bubble shows `...` for runs of unknown words, never two in a row. A sees the same line. |
| K5 | A whispers; B stands 2 m away, C stands 10 m away. | B gets the line, C does not. |
| K6 | B stands behind a wall within 20 m. | B gets nothing. |
| K7 | A DM client is nearby. | The DM sees the original text. |
| K8 | A uses the `.lang` Speak button and typed `[goblin: text]`. | Same per-listener bubbles as K2. |
| K9 | A shouts, uses party chat and emotes in talk mode. | Not converted. |
| K10 | A speaks Drow in talk mode. | No bubble. Description lines only. |
| K11 | A speaks Thieves' Cant with more than 25 characters. | Cut at 25 characters. |
| K12 | Open `.lang` on B. | The translation log and its check box are hidden. With `lang_nwnx_log` = 1 they appear and the log fills. |
| K13 | A script calls `LangNpcSay(oNPC, "text")` for a dwarf NPC; B has no Dwarven, C has Dwarven 6. | B sees a scrambled bubble over the NPC, C the text. If an NPC sender fails, record it. |
| K14 | `lang_exp_pc_only` = 1 and `lang_exp_on` = 1: A (player) speaks, then K13 again. | C earns points from A, none from the NPC unless `lang_trainer` = 1. |
| K15 | Set `lang_nwnx_on` = 2 and repeat K2. | NWScript behavior: scrambled bubble and a translation message. |
| K16 | Stop the server, remove `NWNX_CHAT_SKIP=no`, start. | Log says NWNX Chat not loaded; K2 behaves as K15. |

## L. Interpreter henchman

Hire or add a henchman. Give the henchman languages through the creature variable `lang_known` in the toolset (for example `,6:6,` Goblin 6 and `,4:3,` Dwarven 3) or use a race with an innate language. Set `lang_interp_on` = 1.

| Id | Steps | Expected |
|---|---|---|
| L1 | `lang_interp_on` unset. Talk to Gruk in Goblin with a Goblin-speaking henchman nearby. | Garbled line only. The henchman says nothing. |
| L2 | `lang_interp_on` = 1, henchman Goblin 6, Tester no Goblin. Choose Goblin on Gruk. | The dialog shows `(Goblin)` scrambled text. About half a second later the henchman says "The Goblin says: ..." with the full line. Planned replies are unchanged. |
| L3 | Henchman Goblin 3. | "The Goblin says, as best I can tell: ..." with known words and a single `...` for each run of unknown words. Repeating the line gives the same words. |
| L4 | Henchman with no Goblin word known in the line. | "I cannot make out a word of it." |
| L5 | Henchman with no Goblin at all. | Silent. |
| L6 | Tester has Goblin 6. | Silent. Tester has Goblin 3 and the henchman 3: silent (not better). Henchman 6: speaks. |
| L7 | `lang_interp_max_level` = 3 with a Goblin 6 henchman. | Partial translation as in L3. |
| L8 | Walk the henchman more than `lang_interp_range` away, or kill it. | Silent. |
| L9 | Choose the same Gruk option twice within three seconds, and again later. | One translation per display; no repeat within three seconds. |
| L10 | Choose Drow on Gruk with a Drow-speaking henchman. | "The Goblin signs: ..." |
| L11 | Gruk's Common option. | Silent. |
| L12 | Add the parameter `options` = "Ask for peace|Refuse" to a link. | After the translation: "Option 1 means: Ask for peace", "Option 2 means: Refuse". |
| L13 | Check Tester's exposure after many translations (`lang_exp_on` = 1, `lang_exp_pc_only` = 1). | The henchman's lines add no points. |

## H. Regression checks

| Id | Steps | Expected |
|---|---|---|
| H1 | Watch the console and log during all cases. | No script errors, no TMI messages. |
| H2 | Open and close `.lang` ten times quickly. | No duplicate windows and no errors. |
| H3 | Equip and use an unrelated item (potion, scroll). | `lang_on_act` leaves other items alone. |
| H4 | Talk to a normal NPC with an ordinary dialog. | The dialog is unaffected. |
| H5 | Type an unrelated chat message with talk mode off. | The message is delivered unchanged. |
| H6 | Enter and leave the area with Gruk several times, reload a saved game. | Gruk is not duplicated. |

## Recording results

For each case record Pass, Fail or Blocked, the build, the character, and for a failure the exact on-screen text. For cases D5, D7, D8, F2, F3 and F4, copy the scrambled lines into the notes so repeat runs can be compared.

## M. Level caps (maxlevel, npc_lang_cap)

Setup: a fluent Dwarven character (`.teach dwarven 6` from a DM, or six books), and a dialog line converted with `--language 4 --maxlevel 4`, or an NPC with `npc_language` 4 and `npc_lang_cap` 4.

| # | Step | Expected |
|---|---|---|
| M1 | Read the capped line as a Dwarven level-6 character | `(Dwarven)` prefix, some words replaced by one `...` per run |
| M2 | Read it again, and after a relog | the same words are unknown each time |
| M3 | Read it as a level-2 character | at least as many words unknown as in M1 |
| M4 | Read it as a level-6 character with `lang_exp_on` | no experience from the line |
| M5 | Set `maxlevel` 4 on the link and `npc_lang_cap` 2 on the NPC | read at level 2 (the lower one) |
| M6 | Hire an interpreter at level 6, `lang_interp_on` | the henchman says nothing for a level-6 player (both read at 4) |
| M7 | Same henchman, a level-1 player | the henchman translates at level 4 at most, with `...` for unknown runs |

