# Language System package (NWScript only)

## Installing in a new module

The package is an ERF, `uoa_language_system_nwscript.erf`, built by `tools/build_language_erf.sh`. It contains no NWNX code and needs no haks or 2DA changes. It needs NWN:EE with `nw_inc_nui`.

1. In the toolset choose File, Import, ERF, and import everything in the package.
2. Open Module Properties, Events, and set the scripts below. If the module already has a script for an event, call that script's logic from the package script instead.
3. The books, the bookshelf and Gruk are listed in the palettes under Special, Custom 5. The package carries `itempalcus`, `placeablepalcus` and `creaturepalcus`, which hold only those entries; importing them replaces a module's existing custom palettes, so in a module that already has custom palette entries, import without the three `.itp` files and add the entries by hand.
4. Place the `lang_bookshelf` placeable somewhere players can reach it, and optionally the `lang_goblin` creature (Gruk) for testing.
5. Build the module. All scripts in the package are compiled and their sources are included.

| Module event | Script | Required |
|---|---|---|
| OnPlayerChat | `lang_on_chat` | yes: `.lang`, `.speak`, `.languages`, talk mode |
| OnActivateItem | `lang_on_act` | yes: the language books |
| OnClientEnter | `lang_on_enter` | no: a login tip |

## What the package contains

| Resource | Purpose |
|---|---|
| `dmfi_lang_inc` | core library: tables, fluency, garbling, speech, commands |
| `dmfi_lang_book` | book logic, six volumes per language |
| `dmfi_lang_dialog`, `cond_lang_line`, `cond_lang_know`, `act_lang_npc` | language-aware NPC dialog |
| `dmfi_lang_nui`, `lang_nui_event`, `lang_nui_append` | the `.lang` window |
| `lang_shelf_fill` | restocks the bookshelf on open and close |
| `lang_on_chat`, `lang_on_act`, `lang_on_enter` | the module event scripts |
| `lang_bookshelf` | placeable holding every book |
| `lang_book_<id>_<volume>` | 66 books: Elven (1), Gnome (2), Halfling (3), Dwarven (4), Orc (5), Goblin (6), Draconic (7), Celestial (10), Abyssal (11), Infernal (12), Drow (13) |
| `lang_goblin`, `lang_demo` | Gruk and his dialog, which speaks every language for testing |

Animal (8) and Thieves' Cant (9) are class languages and have no books.

## Differences from the full system

The rest of this manual describes the system as it runs in Universe of Arlandia. In this package:

- Talk mode always uses the NWScript path: the speaker's own chat line is the scrambled text, and each listener gets a translation message.
- The NWNX Chat path is not included.
- The quest dialog example, the DMFI widgets and Universe of Arlandia's automatic spawning of Gruk and Wren are not included. Place Gruk by hand.
- References to `mod_chat`, `mod_activate`, `mod_enter` and `dmfi_voice_exe` stand for the module's own scripts there; here the three `lang_on_*` scripts do their work.
