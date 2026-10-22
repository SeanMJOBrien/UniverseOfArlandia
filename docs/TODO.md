# TODO

## Language system

- Consider making Common a language that a new player character must select when joining (character creation), instead of being the implicit default speech of every PC. Today Common is the fallback in the `.lang` window (`dmfi_lang_nui.nss`) and talk mode is off by default (`lang_talk` unset). Open questions: whether a PC could then forget or lack Common, and how NPC dialog and `LangFluency` should treat it (currently Common is not a language id).

- Store the language state, and possibly other per-character information, on a dedicated item as an option next to the sqlite storage. The item would be a 1x1 miscellaneous item, for example an ear, that is undroppable and flagged stolen so it cannot be sold, traded or looted. Item variables are saved in the character's `.bic`, so deleting the character file would remove the data with it, with no stale rows and no reused-name problem, and the data would move with the character between servers.
  - Setting: `LANG_STORE` with `db` (today's sqlite behavior, the default), `item` or `both` (item as the source of truth, sqlite as backup).
  - Work: the item blueprint and palette entry; item read and write functions beside `LangSave`, `LangLoad` and `LangSaveExp` in `dmfi_lang_inc.nss`; creation of a missing item on entry; a one-time copy from sqlite onto the item; ERF build and docs.
  - Open points: items are saved only when characters are exported (about every 20 minutes and at server exit), so a crash can lose recent progress; a DM could copy the item to give another character the same languages; and which other information belongs on the item.
