Language System (NWScript only, no NWNX) - import package

IMPORT
  Toolset: File > Import > ERF, choose uoa_language_system_nwscript.erf, import everything.
  Or unpack into a module folder with nwn_erf -x. Requires NWN:EE (nw_inc_nui).
  No haks, 2DA changes, NWNX or custom includes beyond this package are needed.

MODULE EVENTS (Module Properties > Events)
  OnPlayerChat    lang_on_chat   required: .lang, .speak, .languages, talk mode
  OnActivateItem  lang_on_act    required: the language books
  OnClientEnter   lang_on_enter  optional: a login tip
  If the module already has scripts for these events, call their logic from yours
  (each is a few lines).

OBJECTS
  lang_bookshelf     placeable; open it to get every book, it restocks on open and close
  lang_book_<id>_<n> 66 books, volumes 1-6 of Elven (1), Gnome (2), Halfling (3), Dwarven (4),
                     Orc (5), Goblin (6), Draconic (7), Celestial (10), Abyssal (11),
                     Infernal (12), Drow (13). Volume 6 makes the reader fluent.
  lang_goblin        Gruk, a test goblin; dialog lang_demo lets him speak every language

PLAYERS
  .lang  opens the window    .speak <language|off>    .languages    .learn <language>
DMs
  .teach <language> [1-6] on the player's target (see the manual)

Animal (8) and Thieves' Cant (9) are class languages given automatically; they have no books.
The full manual is uoa_language_system_manual.html.
