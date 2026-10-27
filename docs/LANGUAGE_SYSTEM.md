# Language system

This document describes how languages work for players, DMs and builders, how the text appears on screen, and which scripts do the work. It describes the `language-nwnx` branch. The version deployed on the live server is the `dmfi-language-tables` branch; the differences are listed under "Branch status".

## Overview

A character speaks and understands a set of languages. Each language has a fluency from 0 to 1000 points. 1000 is fluent: the listener reads the original text. 1 to 999 reads that share of the words (350 points is 35 percent of them, chosen the same way every time). A listener with 0 reads a scrambled imitation of the language.

The scrambled text is produced by substituting letters according to a fixed table per language. The speech itself is never encrypted; the original text is available to the scripts, which decide per listener what to show.

## Languages

| Id | Language | Learnable from books |
|---|---|---|
| 1 | Elven | yes |
| 2 | Gnome | yes |
| 3 | Halfling | yes |
| 4 | Dwarven | yes |
| 5 | Orc | yes |
| 6 | Goblin | yes |
| 7 | Draconic | yes |
| 8 | Animal | no (Ranger, Druid) |
| 9 | Thieves' Cant | no (Rogue) |
| 10 | Celestial | yes |
| 11 | Abyssal | yes |
| 12 | Infernal | yes |
| 13 | Drow | yes |
| 99 | Leetspeak | no (DM voice command) |
| 101 and up | rotating ciphers | no (DM voice command) |

Drow is signed rather than spoken (see "Drow sign language"). Languages 1 to 13 except 9 use a substitution table. `LangTable` in `dmfi_lang_inc.nss` holds one table per language: 52 slots of 4 characters, one slot for each letter in `a-zA-Z`, padded with spaces. A letter without an entry maps to itself. Thieves' Cant (`ProcessCant`) and the rotating ciphers (`ProcessCustom`) use their own code. A Thieves' Cant message is cut at 25 characters.

## Who knows a language

`LangFluency(oPC, iLang)` returns the fluency. It returns 6 when the character is a DM or DM-possessed, carries a `hlslang_<id>` widget or a `babelfish` item, or knows the language innately (`LangInnate`). Innate languages use no slot and do not depend on Intelligence. A creature has every innate language that applies, so a drow rogue knows Elven, Drow and Thieves' Cant.

| Language | Innate for |
|---|---|
| Elven | Elf, Half-elf, subrace "drow", Drider, Fey (including Brownie) |
| Gnome | Gnome |
| Halfling | Halfling |
| Dwarven | Dwarf (including duergar) |
| Orc | Orc, Half-orc |
| Goblin | Goblinoids: goblin, hobgoblin, bugbear, gnoll |
| Draconic | Dragon, Reptilian: kobold, lizardfolk, troglodyte |
| Animal | any Ranger or Druid level |
| Thieves' Cant | any Rogue level |
| Celestial | Outsider with a good alignment |
| Infernal | Outsider with a lawful evil alignment |
| Abyssal | Outsider with a chaotic evil alignment |
| Drow | subrace "drow", Drider |

Humans have no innate language. Other racial types (animals, beasts, constructs, undead, oozes, giants, aberrations, magical beasts, monstrous humanoids, elementals, vermin, plants) have none either.

The default speaking language of a creature is the first innate language in id order, so a drow speaks Elven by default and can switch to Drow with `.speak drow`. An NPC speaks its default language unless `npc_language` is set.

Otherwise the fluency comes from the character's learned-language list. The list is a local string `lang_pts` on the character, for example `,4:350,10:1000,` for Dwarven at 350 points and Celestial fluent. An older list `lang_known` (`,4:3,10:2,`, levels 1 to 6, or `,4,` for fluent) is still read: its levels are converted once to points (level n of 6 becomes n x 1000 / 6, level 6 becomes 1000) and the older list is cleared. This also applies to a creature that has `lang_known` set in the toolset.

Local variables on a player character are lost at logout and do not reach the character file. The language state therefore lives in local variables during a session and is also written to the campaign database of the player's account: one file per account in the server's `database` folder, named by the public CD key (for example `UP7M73CG.sqlite3`), with each character's rows told apart by account and character name; no NWNX needed. Rows found only in the older shared `dmfi_lang.sqlite3` are copied to the account file the first time that character enters. Every change saves it (`LangSave`, and `LangSaveKnown` for listening gains), and `LangLoad` restores it when the player enters, once per session. A character with nothing stored keeps what it has and has it stored. These variables are saved and restored:

| Variable | Content |
|---|---|
| `lang_pts` | learned languages and their fluency points (the older `lang_known` row is cleared after conversion) |
| `lang_slotsused` | language slots in use |
| `hls_MyLanguage`, `hls_MyLanguageName` | the language chosen for speaking |
| `lang_talk` | talk mode on or off |
| `lang_nui_off` | set when translations in the `.lang` window are turned off |
| `lang_seed` | the seed that decides which words the character knows |

## Learning a language

Languages are learned from books. Nothing else grants a language except a DM's `.teach` command.

### Books

Each learnable language has books with the item tag and resref `lang_book_<languageId>_<volume>` (six volumes: 66 items, generated by `tools/lang_books.py`; `--volumes N` generates another count). The player activates a book to study it (`lang_book_use`, called from `mod_activate`).

Fluency is a number from 0 to 1000, and a book adds points to it. By default the numbers come from the volume number and the setting `lang_book_volumes`, the number of volumes that lead from nothing to fluent (6 by default). With N volumes, volume v:

- needs (v-1) x 1000 / N points of fluency before it can be followed (volume 1 needs none);
- adds points up to v x 1000 / N (volume N takes the reader to fluent), so a reader at the right level gains about 1000 / N points;
- is used up when read. A stack loses one book.

A book that is too advanced is kept, and so is one that gives nothing because the reader is already at its maximum. The reader gets a message in both cases, with the percentage needed.

With 6 volumes the steps are 0, 166, 333, 500, 666, 833 and 1000. Set `lang_book_volumes` to 4 and the same books work as a four-step course (volumes 5 and 6 then read as unreadable). Generate books with the same count (`python3 tools/lang_books.py --volumes 4`) so their names and descriptions match.

A builder can give any book its own numbers with local ints on the item (toolset: Item Properties, Variables):

| Variable | Meaning |
|---|---|
| `lang_book_min` | fluency needed to follow the book (0 if not set) |
| `lang_book_gain` | points the book adds (the range from min to max if not set) |
| `lang_book_max` | the most the book can take a reader to (1000 if not set) |

Setting `lang_book_gain` or `lang_book_max` puts the book on its own numbers; the volume number is then ignored, and a book can teach any range, for example a 100-point phrasebook with `lang_book_gain` = 100 and `lang_book_max` = 250. The language comes from the item tag.

### Language slots

A character may start a new language only while a slot is free, unless `lang_slots_ignore` is on, which removes the limit for every source. The slot total is the base Intelligence modifier (`(Intelligence - 10) / 2`, minimum 0, ability bonuses from items and spells are not counted). The first book of a new language uses one slot. Later books of that language use none. Native languages never use slots.

Each use of a book reports the result and the remaining slots, for example "You study the book and it is used up. Your Goblin is now 16% of fluent. You can start 2 more languages." A character with no free slot is told how many languages they know of the total allowed.

### The bookshelf

The `lang_bookshelf` placeable (`src/utp/lang_bookshelf.utp.json`) contains one copy of every book. Players may take books. The script `lang_shelf_fill` runs on the shelf's OnOpen and OnClosed events and adds any missing volume. The shelf has to be placed in an area in the toolset, because the build does not ship area `.git` files.

### Exposure

Advancement by listening is off by default. When it is on, a character with partial fluency (1 to 999 points) improves by listening: each line heard in that language adds `lang_exp_gain` points (1 by default), at most once per 30 seconds per language. The listener is told each time the percentage passes a multiple of ten. Books and lessons add points the same way; nothing else is stored. Points are earned from player speech, from NPC dialog lines and from signing.

PC-only mode (`lang_exp_pc_only`) stops NPCs from being a source, so a character cannot level a language by talking to NPCs. Points then come only from other player characters (and DMs, or creatures a DM controls). Two exceptions keep NPC practice available where a module wants it:

- An NPC with the local int `lang_trainer` = 1 gives points in its own language through its dialog lines, like a player would, including the 30-second limit. Its language is `npc_language`, or its racial language.
- The dialog action `act_lang_exp` gives points directly. Parameters: `language` (default: the NPC's own language) and `points` (fluency points; default `lang_exp_gain`). It ignores PC-only mode and the cooldown, so the dialog decides how often it can happen. Use it, for example, on the reply after a character buys a dwarf a drink. It gives nothing while advancement is off, and nothing for a language the character does not know at all or knows fluently.

### Settings

All settings are in `dmfi_lang_cfg.nss`, each with an explicit value and a module variable of the same purpose that overrides it without a rebuild (toolset: Module Properties, Variables; or `SetLocalInt` on the module). For on/off settings, the variable is 1 for on, 2 for off, and 0 or unset for the value in the file. For numbers, a value above 0 overrides and 0 or unset keeps the file value. A change applies to the next event.

| Module variable | Type | Default | Effect |
|---|---|---|---|
| `lang_exp_on` | on/off | off | master switch for all advancement by listening, trainers and `act_lang_exp` included. Books, tutoring and `.teach` work either way. |
| `lang_exp_pc_only` | on/off | off | points only from player characters and trainer NPCs |
| `lang_exp_gain` | number | 1 | fluency points (of 1000) for one heard line |
| `lang_book_volumes` | number | 6 | volumes of books from nothing to fluent; sets the default points and requirement of each book |
| `lang_exp_cooldown` | number | 30 | seconds between points per listener and language |
| `lang_slots_ignore` | on/off | off | removes the Intelligence limit on starting new languages for every source (books, tutors) |
| `lang_nwnx_on` | on/off | on | use the NWNX Chat plugin when it is loaded; off forces the NWScript behavior |
| `lang_nwnx_log` | on/off | off | with the plugin, also feed the `.lang` window log |
| `lang_interp_on` | on/off | off | henchmen translate NPC dialog lines |
| `lang_interp_max_level` | number | 1000 | highest fluency a henchman provides (1 to 6 count as levels of six) |
| `lang_interp_range` | number | 10 | metres between henchman and player |
| `lang_tutor_on` | on/off | off | enables `.tutor` |
| `lang_tutor_gain` | number | 167 | fluency points one lesson gives |
| `lang_tutor_cooldown` | number | 3600 | seconds before the same learner can take another lesson in the same language |
| `lang_tutor_range` | number | 5 | metres between teacher and learner |

Fluency already stored is kept when a setting changes. Changing `lang_book_volumes` changes only what books give from then on. The tutoring cooldown is kept in memory and resets when the server restarts.

### Tutoring by player characters

With `lang_tutor_on`, a character who speaks a language can teach it to another player character. The teacher types `.tutor`, which opens a window with a list of player characters within range, a list of the teacher's own languages (books languages only), and an Offer lesson button. The learner gets a window with Accept and Decline. Only then does the lesson happen:

- The learner gains `lang_tutor_gain` points in that language, never above the teacher's own fluency.
- A new language takes a slot, unless `lang_slots_ignore` is on. A learner without a free slot cannot be taught a new language.
- A learner already at the teacher's fluency, or fluent, cannot be taught.
- The learner has to wait `lang_tutor_cooldown` before another lesson in the same language.
- Everything is checked again when the learner accepts, so a learner who has walked away gets nothing.

### DM teaching

`.teach <language> [points]` gives the language to the DMFI target at the stated fluency, 1 to 1000 (default 1000). A value from 1 to 6 counts as a level of six. It needs no slot.

## Speaking

Three input methods produce speech in a language. All three pass through the same logic.

### Typed `[text]` (voice script)

A message in square brackets, optionally with a `lang:` prefix, is spoken in the chosen language (`TranslateToLanguage` in `dmfi_voice_exe.nss`). A per-speaker buffer stops the same line from being processed twice within one second.

### The `.lang` window

`.lang` opens a window (`dmfi_lang_nui.nss`) containing:

- a pull-down with Common first, then the languages the character knows; choosing a language makes it the language the character speaks (talk mode on) for chat and for Speak, and choosing Common turns talk mode off, so no widget item is needed,
- a "Show translations in this window" check box (on by default; the choice is saved on the character as local int `lang_nui_off`, and the log is hidden and no longer fed when it is off),
- a text box,
- a log of lines the character understands (nearby speech and the character's own lines),
- a status line with the number of new languages the character can still start,
- a bottom row that holds the "Speak in:" label, the pull-down and the Speak button, left to right. The fields fill the window width and follow it when resized.

The window is optional: nothing opens it automatically and every feature also works from chat. Typing in the text box and pressing Speak sends the text the same way a typed `[text]` does. Events go to `lang_nui_event`. Lines are added to the log by `lang_nui_append`, which `LangSpeak` runs with `ExecuteScript` so that the core include does not depend on the window code.

### Talk mode

`.speak <language>` chooses a language and turns talk mode on. Ordinary talk and whispers then come out in that language. `.speak off` returns to common speech. The setting is saved with the character.

Talk mode ignores shouts, party and DM chat, emotes (`*...*`), messages that begin with `.`, `[`, `:` or `/`, and DM characters.

### Range

| Volume | Range |
|---|---|
| Talk | 20 m |
| Whisper | 3 m |

A listener who is a player character needs line of sight to the speaker. A DM or DM-possessed creature hears every line in range.

## Drow sign language

Drow (id 13) is a sign language. The signer says nothing aloud, so there is no speech bubble and no scrambled text. Each viewer reads a description instead, according to their Drow fluency:

| Viewer | Text |
|---|---|
| Fluent (1000) | The `<race>` signs, `<full text>` |
| Partial (1-999) | The `<race>` does not speak, but uses sign, you can only make out: `<known words>`. |
| No Drow | The `<race>` does not speak, but moves their hands and fingers in rapid patterns. |
| The signer | You sign, `<full text>` |

For a partial viewer, each word is either known or not, decided by the same fixed rule as ordinary speech (see Garbling). A word's result never changes for that character. Punctuation is removed and lost words are left out without a mark, so only understood words appear, for example "danger challenge water". If no word is kept, the viewer reads "The `<race>` does not speak, but uses sign; you cannot make out any of it." Partial viewers gain exposure by watching.

`<race>` is the signer's race: Dwarf, Elf, Gnome, Halfling, Half-elf, Half-orc, Man, Goblin, Orc, Lizardfolk, Dragon, or Drow for a character with the subrace "drow". Any other race reads as "Creature". `LangRaceName` in `dmfi_lang_inc.nss` holds the list.

A creature or placeable can carry the local string `npc_lang_descriptor`, which replaces the race everywhere `<race>` is used: in sign descriptions, in the interpreter henchman's lines and in dialog lines. For example, a tablet with `npc_lang_descriptor` = "tablet" is described as "The tablet says, as best I can tell: ...". Without it, a placeable reads as "Creature".

The same text rules apply in chat (typed `[text]`, the window, talk mode, NWNX) and in NPC dialog. The sign lines are also written to the `.lang` window log. An NPC signs when its local int `npc_language` is 13.

## Dialog variables

A dialog author can write `<race>` in any line of an NPC that uses `cond_lang_line`. The script replaces it with the NPC's race before the line is shown, in every language. For example, "The `<race>` looks you over." reads "The Dwarf looks you over." when the NPC is a dwarf.

## What the listener sees

`LangSpeak` (`dmfi_lang_inc.nss`) handles each listener in range.

| Listener | Chat log | Speech bubble |
|---|---|---|
| The speaker | `<name> says in <Language>: <original>` | original (NWNX) or scrambled (without NWNX) |
| Fluent (1000) | `<name> says in <Language>: <original>` | as above |
| Partial (1-999) | `<name> says in <Language> (you catch only part): <garbled>` | as above |
| No knowledge | nothing, apart from a possible Lore notice | scrambled |

Garbling is fixed per word, not random. Each character has a saved seed (local int `lang_seed`, created on first use). A character of fluency f knows a word of a language when a hash of (seed, language, word) falls below f in 1000. The word is compared without punctuation and case. Consequences:

- The same word is always readable or always masked for that character, in every sentence and conversation, so repeating a dialog branch shows the same words.
- Raising fluency only adds words: every word known at 300 points is still known at 400.
- Two characters know different words of the same language, and the same character knows different words in different languages.
- Fluency 1000 knows every word and fluency 0 none.

A masked word appears as the language's scrambled form of that word, which is also always the same (for example a Goblin word looks the same every time). Setting `DMFI_LANG_SHOW_FOREIGN` to FALSE shows runs of masked words as one `...` instead.

The speaker is masked the same way. A character who types a sentence in a language they only partly know says only the words they know; the words they do not know are replaced by `...` for everyone, including fluent listeners, so the sentence reads as a learner searching for words. A run of unknown words becomes a single `...`, never two in a row. The speech bubble and the speaker's chat line follow the same rule: each word the speaker knows appears in the language's scrambled form and each run of words they do not know appears as one `...`. Said by a speaker who knows only "water", "cool" and "footing", "The water runs deep and cool, beware your footing here." reads "The water ... cool, ... footing ..." (before scrambling). The speaker sees the line the way it will be heard. NPCs and DMs speak fully.

A listener with no knowledge may see "`<name> is speaking in <Language>`" when `d20 + Lore rank` is above 20. The check runs at most once per 60 seconds per listener and language, and never for Thieves' Cant.

Every line a character understands also goes to the `.lang` window log, when that window is open. Lines the character does not understand are not logged.

### Without NWNX

The speech bubble can show only one text. `LangSpeak` makes the speaker say the scrambled text (`SpeakString`), and the readable translation arrives as a separate system message in the chat log. In talk mode (`LangHandleTalk`, called from `mod_chat`), the speaker's own chat line is replaced by the scrambled text through `SetPCChatMessage`.

### With NWNX Chat

When the NWNX Chat plugin is loaded, `LangNwnxInit` (called from `mod_load`) detects it, registers `lang_nwnx_chat` and sets a module flag. Speech then reaches each listener as a real chat line from the speaker, so the speech bubble over the speaker's head and the chat log both show what that listener understands. Every path uses the same masking rules as the NWScript path:

| Source | What happens with the plugin |
|---|---|
| Typed talk or whisper in talk mode | the chat hook cancels the original (`NWNX_Chat_SkipMessage`) and sends one line per listener |
| `.lang` Speak button, typed `[text]`, DM voice | `LangSpeak` sets the line on the speaker and runs `lang_nwnx_say`, which sends one line per listener (talk channel, whisper channel at 3 m or less) |
| NPC speech by script | `LangNpcSay(oNPC, text, language)` (`dmfi_lang_dialog`) goes through `LangSpeak`, so it follows the same path |
| Sign languages (Drow) | unchanged: description lines, no bubble |
| Thieves' Cant | unchanged: one gesture, cut at 25 characters |
| NPC dialog windows | unchanged: custom tokens (`cond_lang_line`) |

Each line is labelled `[Language]` and contains: the speaker's line as it will be heard for the speaker, the speaker's words for fluent listeners, the garbled text for partial listeners and the scrambled text for everyone else. Exposure follows the rules in "Exposure", with the speaker as the source.

Because the translations already arrive as bubbles and chat lines, the `.lang` window hides its translation log and check box while the plugin is in use. `lang_nwnx_log` = 1 puts the log back.

Falling back: the plugin path is used only if it is loaded and `lang_nwnx_on` is not off. If the plugin is missing, fails to load, or is switched off, `LangNwnxActive()` is false and everything uses the NWScript behavior described above. The package has no NWNX code and never takes the plugin path.

Setup: add `NWNX_CHAT_SKIP=no` to `config/nwserver.env`. The module log says "Language system: NWNX Chat active." at load. The plugin path has not been tested in game; see `docs/LANGUAGE_NWNX_PLAN.md` for the checks.

## Chat commands

| Command | Who | Effect |
|---|---|---|
| `.lang` | everyone | open the window |
| `.languages`, `.langs` | everyone | list known languages with their fluency in percent, the language in use, talk mode, free slots |
| `.speak <language>` | everyone | choose the language and turn talk mode on |
| `.speak off` | everyone | talk mode off |
| `.learn` | everyone | prints a hint that languages come from books |
| `.teach <language> [1-6]` | DM | give the DMFI target a language, no slot needed |
| `.tutor` | everyone, when `lang_tutor_on` | open the tutoring window |

`mod_chat` processes these. The same handler also runs the `.w` builder commands.

## NPC dialog

A dialog node cannot change its text per player. NPC lines in a language use a custom token as the node text (for example `<CUSTOM60000>`). Each link into the node carries the condition script `cond_lang_line` with two parameters, `token` and `text` (the original line). The script (`dmfi_lang_dialog.nss`) sets the token before the node is shown:

- Fluent speaker: the text as written.
- Partial speaker: `(Language) ` followed by the garbled text, with exposure gain.
- No knowledge: `(Language) ` followed by the scrambled text.

The NPC's language is its local int `npc_language` (a language id, or -1 for the common tongue). Without that variable, the NPC speaks its racial language, if it has one.

`tools/lang_dialog.py <file.dlg.json>` converts the NPC lines in a dialog. It skips a node that already has a condition script on a link into it and reports the node. Such a node needs a hand-written call to `LangDialogToken`. `tools/lang_dialog.py <file.dlg.json> --check` changes nothing and reports lines whose node token and link `token` parameter differ, links without the condition or `text`, links to one node with different text, a Comment that does not start with the text, and a token used by two nodes. It exits with status 1 when it finds any.

### Adding language to a dialog

Write each NPC line once, as the full plain text a fluent speaker reads. Do not write versions per fluency level, per language or per cap. The system masks the line for each reader.

1. Set the speaker's language: the local int `npc_language` on the NPC (a language id, or -1 for the common tongue). A creature without it speaks its racial language, if it has one. A placeable or item that "speaks" needs the variable too, or the `language` parameter below.
2. Convert the lines. Run `tools/lang_dialog.py <file.dlg.json>` on the dialog (add `--entries 0,3` for some lines only). Each chosen NPC line gets the text `<CUSTOM60000>` (and up) and the condition `cond_lang_line` on every link into it, with the parameters `token` and `text`.
3. A link that already has a condition script cannot take a second one. Call `LangDialogLine()` from that script, or `LangDialogToken(oPC, oNPC, token, text)` by hand.

Optional parameters on the `cond_lang_line` link (or flags of `lang_dialog.py`):

| Parameter | Flag | Effect |
|---|---|---|
| `options` | | meanings of foreign-language replies, separated by `\|`, spoken by the interpreter henchman |
| `maxlevel` | `--maxlevel 1-1000` | the reader reads the line at this fluency at most (1 to 6 count as levels of six) |
| `language` | `--language <id>` | the line is in this language, in place of the speaker's |

### Building a line by hand in the toolset

`lang_dialog.py` only automates these steps. In the conversation editor of the Enhanced Edition toolset, for each NPC line you want language-aware:

1. Set the text of the NPC line to a custom token, for example `<CUSTOM60010>`. Use a different number (60000 and up) for each language-aware line in the same conversation. The toolset shows the token, not the words. Text outside the token, such as `<CUSTOM60010> He nods.`, is shown to every reader as written. Copy the full plain line into the node's Comment field too, so it stays readable in the toolset (the game does not use the comment; `lang_dialog.py` fills it in).
2. Set the line's "Text Appears When" script to `cond_lang_line`. The script is stored on the link into the line, which is how the toolset does it for any line. A starting line works the same way.
3. In the parameters of that script, add `token` = `60010` (the same number) and `text` = the full plain line as a fluent speaker reads it.
4. Add any optional parameters in the same list: `maxlevel`, `language`, `dialect`, `options`.
5. Write narration (`*...*`) and language switches (`{2}`) inside the `text` value. A parameter is one line, so use a separate line of dialog for a paragraph break.

If the line already needs a condition script of its own, write a short script that does its own check and then returns `LangDialogLine(GetPCSpeaker(), OBJECT_SELF)` (`#include "dmfi_lang_dialog"`), and put that script on the line instead.

The `npc_language` variable on the NPC (or the `language` parameter) says which language the line is in. The module needs the language package, which holds `cond_lang_line`.

### Narration inside a line

Some of a line is often not speech: what the creature does, how it looks. Put that text between asterisks. Narration is shown as written to every reader in every language, while the rest of the line is speech and follows the reader's fluency.

- Write: `*The <race> says,* the water is cold and the footing poor. *The <race> looks around nervously.*`
- A fluent reader sees: The Gnome says, the water is cold and the footing poor. The Gnome looks around nervously.
- A partial reader sees: The Gnome says, the water ... cold ... footing ... The Gnome looks around nervously.
- A reader with no Gnome sees the attribution and the narration in English and scrambled words in between.
- Spaces next to an asterisk are kept, so write the space where you want it.
- A line with narration gets no `(Language)` prefix, since the narration already names who speaks.
- The interpreter henchman translates only the speech parts. If a line is all narration it says nothing.
- A sign language shows the signing description for the speech parts, then the narration.
- `<race>` works inside narration as everywhere. Names (`Gruk says,`) are plain text and are never masked.
- A line without asterisks is all speech, as before. Do not use `*` as a literal asterisk in a language-aware line.

### Several languages in one line

`{id}` in a line switches the language of the speech after it, up to the next switch. `{0}` is plain text. The ids are in the language table (1 Elven, 2 Gnome, 3 Halfling, 4 Dwarven, 5 Orc, 6 Goblin, 7 Draconic, 8 Animal, 9 Thieves' Cant, 10 Celestial, 11 Abyssal, 12 Infernal, 13 Drow sign). Combine it with narration to label each part:

`*Gnome: *{2}The little gears turn slowly. *Elven: *{1}Starlight lingers upon the leaves.`

- Each part is read at the reader's fluency in that part's language. A level cap (`maxlevel`, `npc_lang_cap`) applies to every part.
- The language before the first switch is the line's own (`language` parameter, `npc_language`, or the racial language).
- Each part with some fluency can give exposure in its language, under the usual rules.
- The interpreter henchman does not translate a line that has switches.
- A `{` without a closing `}` is shown as written.

### Archaic dialects and worn texts

A line can be limited to a level below fluent, for an ancient dialect, a damaged inscription or a corrupted spell text. A fluent reader then reads it as a reader of that level would: the same words are unknown every time, and the unknown runs show as one `...`.

- Per line: the parameter `maxlevel` on the link, for example `maxlevel` = 4 with `language` = 4 for Dwarven at level 4 of six (667 points) at most. Values 1 to 6 are levels of six and 7 to 1000 are fluency points, so `maxlevel` = 400 caps at 40 percent of the words.
- Per speaker: the local int `npc_lang_cap` on the NPC, placeable or item that speaks. It limits every line it speaks.
- When both are set, the lower one applies. A reader below the cap reads at their own level.
- A capped line gives no language experience.
- The interpreter henchman is limited by the same cap. A fluent henchman reads a line capped at level 4 at that cap, so it adds nothing for a player at the cap and stays silent.

A line can name its dialect with the parameter `dialect` (flag `--dialect <name>`), or the speaker can carry the local string `npc_lang_dialect`. An interpreter henchman that has studied the dialect carries the local int `lang_dialect_<name>` (1 to 6 as levels of six, or 7 to 1000 as points, for example `lang_dialect_old_dwarven` = 5). It then reads the line at that level in place of the cap, still held to its own fluency in the language and to `lang_interp_max_level`. A value of 6 removes the cap. Players have no such value yet: a player always reads a capped line at the cap or below.

To make a readable object (a tablet, book page or scroll), give a placeable the dialog's conversation as its `OnUsed` conversation, set `npc_language` (or use the `language` parameter) and `npc_lang_cap`, and write each page as one NPC line with `Next` and `Close` replies.

### Interpreter henchman

With `lang_interp_on`, a henchman who knows the NPC's language states a translation of each NPC line the player does not fully understand. The dialog window keeps the garbled line and the planned replies. The translation is spoken by the henchman (a bubble and a chat line) half a second after the line appears:

- Fluent henchman: `The Dwarf says: <the whole line>`.
- Partial henchman: `The Dwarf says, as best I can tell: <known words, ... for each run it does not know>`.
- A henchman that knows no word of the line: `I cannot make out a word of it.`
- A sign language reads `signs` in place of `says`. `<race>` is the NPC's race (Dwarf, Elf, ...), or "Creature".

The interpreter is the henchman with the highest fluency in the language, alive, in the same area and within `lang_interp_range` metres. Its fluency is capped by `lang_interp_max_level`. It speaks only if its fluency is higher than the player's, and not if the player is fluent. The translation gives the player no exposure. A short guard stops a condition that runs twice from repeating the line.

A henchman gets its racial languages free. Other languages come from the creature's local string `lang_known` (for example `,4:6,` for Dwarven at 6), set in the toolset.

For replies written in the NPC's own language, add the script parameter `options` to the `cond_lang_line` link: the meanings of the replies, separated by `|`. After the translation the henchman adds `Option 1 means: ...`, `Option 2 means: ...`.

Replies and branches use `cond_lang_know` with parameters `language`, `level` (the fluency needed: 1 to 6 as a level of six, or 7 to 1000 as points; default any) and `not=1` to invert. Listing several NPC lines in descending level order, each with a different level, gives a branch per fluency band. The first line whose condition passes is shown.

The demo NPCs are Gruk the goblin (`lang_goblin`, dialog `lang_demo`) and Wren the archivist (`quest_wren`, dialog `quest_demo`, described in `docs/QUEST_DIALOG_EXAMPLE.md`). Both spawn beside the first plot giver in an area a player enters (`lang_demo_inc.nss`, called from `area_enter`). Gruk's dialog (generated by `tools/gruk_dialog.py`) is a language tester: a menu of every language (Drow as sign, plus Common) that sets his `npc_language` through `act_lang_npc` and has him say a sample line, so a tester sees it at their own fluency. Wren gives no XP.

## Scripts

| File | Role |
|---|---|
| `dmfi_lang_inc.nss` | tables, fluency, learned list, slots, commands, `LangSpeak`, talk mode |
| `dmfi_lang_book.nss`, `lang_book_use.nss` | book study rules |
| `lang_shelf_fill.nss` | restocks the bookshelf |
| `dmfi_lang_cfg.nss` | settings and their readers |
| `dmfi_lang_nui.nss`, `lang_nui_event.nss`, `lang_nui_append.nss` | the `.lang` window |
| `dmfi_lang_teach.nss`, `lang_teach_event.nss` | the `.tutor` windows |
| `act_lang_exp.nss` | dialog action: gives language experience |
| `dmfi_lang_nwnx.nss`, `lang_nwnx_chat.nss`, `lang_nwnx_say.nss` | per-listener chat with NWNX |
| `dmfi_lang_dialog.nss`, `cond_lang_line.nss`, `cond_lang_know.nss` | language in dialogs |
| `dmfi_voice_exe.nss` | typed `[text]` and DM voice commands |
| `mod_chat.nss`, `mod_enter.nss`, `mod_activate.nss`, `mod_load.nss` | module event hooks |

## Tuning constants

These are in `dmfi_lang_inc.nss` or `dmfi_lang_book.nss`. The exposure, slot and tutoring settings are in `dmfi_lang_cfg.nss` (see "Settings").

| Constant | Value | Meaning |
|---|---|---|
| `DMFI_LANG_FLUENT` | 1000 | fluency points of a fluent speaker |
| `DMFI_LANG_LEGACY_LEVELS` | 6 | hand-set values up to this count as levels of six |
| `DMFI_LANG_RANGE_TALK` | 20.0 | talk range in metres |
| `DMFI_LANG_RANGE_WHISPER` | 3.0 | whisper range in metres |
| `DMFI_LANG_LORE_DC` | 20 | Lore check to notice a language |
| `DMFI_LANG_LORE_RECHECK` | 60.0 | seconds between Lore checks |
| `DMFI_LANG_CANT_MAX_LENGTH` | 25 | longest Thieves' Cant message |

## Branch status

- `dmfi-language-tables` (deployed, commit `9c1af98`): fluency 1 to 5, `.learn` grants a language, no books, no NWNX.
- `language-nwnx` (not deployed): fluency 1 to 6, books and bookshelf, NWNX Chat support, the quest dialog example.
- A character saved under the six-level scale is converted on first load: level n of 6 becomes n x 1000 / 6 points, level 6 becomes 1000. Exposure progress toward the next level is not carried over.
- Nothing in the NWNX path or the bookshelf blueprint has been run in game.
