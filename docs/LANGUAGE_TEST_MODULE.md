# Language test module

`export/uoa_language_test.mod` is a small module for testing the language system in the single-player client, and later on a server with NWNX. It is built by `tools/build_test_module.py` from the language package (`tools/build_language_erf.sh`) and a template module made with the nwn-mcp `create_module` and `create_area` tools. It has not been played yet.

## Install

Copy `uoa_language_test.mod` to the `modules` folder of the Neverwinter Nights user directory, then start it from Other Modules in the single-player menu. It needs the base game only: no haks.

Create a character with Intelligence 14 (two free language slots) for most cases. A second character with Intelligence 8 tests the slot limit.

## The area

One area, "Language Test Plaza": City Exterior, 3 x 3 tiles, flat cobble. You start at the south edge facing north.

| Object | Position | Purpose |
|---|---|---|
| Book Chest | north edge | Every book: 11 languages x 6 volumes = 66. Closing it restocks any book you took. |
| Gruk the Goblin | west | Language menu (every language plus Common). Ordinary NPC. |
| Thorin the Dwarf (trainer) | east | Same menu, Dwarven by default. `lang_trainer` = 1, so he gives exposure in PC-only mode. |
| Elara the Elf | centre | Same menu, Elven by default. Ordinary NPC. |
| Ancient Dwarven Tablet | north edge, east | Three pages of Dwarven read at level 4 at most (dialect `old_dwarven`). Use it to read; "Read on." turns the page. |
| Boddyknock the Interpreter | south of centre | Dwarf henchman. Say "Join me" to hire him. Dwarven fluent (racial), Goblin fluent, Elven 50 percent, Draconic fluent. He has studied `old_dwarven` to 833 points (level 5 of six). |

Gruk's own greeting and the tester menu used by Thorin and Elara are the same menu; pick a language and the NPC says a sample line in it. The line shows as your fluency allows.

## Module settings

The module sets these module variables so the features can be tried quickly. Change them in the toolset under Module Properties, Variables, or remove them to return to the defaults.

| Variable | Value here | Default | Meaning |
|---|---|---|---|
| `lang_exp_on` | 1 | off | advancement by listening on |
| `lang_exp_gain` | 25 | 1 | fluency points (of 1000) for one heard line |
| `lang_exp_cooldown` | 2 | 30 | seconds between points |
| `lang_interp_on` | 1 | off | henchmen translate NPC dialog |
| `lang_tutor_on` | 1 | off | `.tutor` enabled (needs a second player) |

Other settings (`lang_exp_pc_only`, `lang_slots_ignore`, `lang_nwnx_on`) are at their defaults. Set `lang_exp_pc_only` = 1 to check that Gruk and Elara stop giving points while Thorin still does.

## What to try

The cases are in `docs/LANGUAGE_TEST_SPEC.md`.

1. Take Goblin volume 1 from the chest and read it (activate it). The book is used up and Goblin is 16 percent. Talk to Gruk, choose Goblin, repeat. Words stay the same; points arrive quickly with the settings above.
2. Hire Boddyknock, then talk to Gruk in Goblin without knowing it. About half a second after each line Boddyknock says "The Goblin says: ...". Talk to Elara in Elven: he gives a partial translation (Elven 50 percent).
3. Type `.lang`, pick a language you know, type a sentence and press Speak. Unknown words show as a single `...`.
4. `.languages`, `.speak <language>`, `.speak off`.
5. Quit and start a new game with the same character: the languages come back (campaign database).

5. Give yourself fluent Dwarven (six Dwarven books, each read once, or `.teach dwarven` as a DM). Use the tablet: you read the text at level 4 of six, with some words as `...`. Hire Boddyknock and use it again: he states a translation at level 5 (more words than you read). Dismiss him and the translation stops. Set `lang_interp_max_level` or his `lang_dialect_old_dwarven` to 4 or less and he stays silent.

## Notes

- The module uses the NWScript path. With the NWNX Chat plugin on a server the same module gives per-listener bubbles; see `docs/LANGUAGE_NWNX_PLAN.md`.
- The test NPCs are plot characters except Boddyknock, who can be dismissed with "Wait here".
- Rebuild with `tools/build_language_erf.sh` and then `python3 tools/build_test_module.py`. The second step needs the template module `~/nwn-data/user/modules/uoa_language_test.mod`.
