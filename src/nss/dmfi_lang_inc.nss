// dmfi_lang_inc - racial/class language support for the DMFI voice system
// ---
// A player writes [text] (or [dwarven: text]) in normal chat; the speech
// bubble shows a scrambled version and every listener who knows the language
// also gets the original text in their message log.
//
// Language ids: 1 Elven, 2 Gnome, 3 Halfling, 4 Dwarven, 5 Orc, 6 Goblin,
// 7 Draconic, 8 Animal, 9 Thieves' Cant, 10 Celestial, 11 Abyssal,
// 12 Infernal, 13 Drow, 99 Leetspeak, 101+ rotating custom ciphers.
//
// Substitution languages are one fixed-width table each (see LangTable): 52
// slots of DMFI_LANG_ENTRY_WIDTH characters, in the order of DMFI_LANG_ALPHABET,
// padded with spaces. A letter missing from a language maps to itself.
//
// Known languages come from: a hlslang_<id> widget or babelfish in the
// inventory, the race/class/subrace default, and the lang_known list stored as
// a local string on the PC (",4:3,10:2," = id:fluency). Locals on a PC are saved
// with the character, so the list, the chosen speaking language and the talk
// mode survive relogs.
//
// Fluency runs 1-6. Native languages are 6 and listeners get the full text;
// a partial speaker catches only part of it, and improves by listening.
//
// With talk mode on (.speak <language>), LangHandleTalk, called from
// OnPlayerChat, turns ordinary talk and whispers into the language.
//
// Player chat commands (handled by LangChatCommand, called from mod_chat):
//   .lang               open the speaking window (dmfi_lang_nui)
//   .speak <language>   also makes ordinary talk come out in it (.speak off stops)
//   .languages          list known languages, the one in use and spare slots
//   .speak <language>   choose the language [text] is spoken in
//   .learn              hint only: languages are learned from books (dmfi_lang_book)
// DM only:
//   .teach <language> [1-6]  give the DMFI target a language at a fluency level, no slot needed

#include "dmfi_lang_cfg"

const string DMFI_LANG_ALPHABET = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
const int DMFI_LANG_ENTRY_WIDTH = 4;

// Id of the .lang window (dmfi_lang_nui); LangSpeak feeds its log when open.
const string DMFI_LANG_NUI_WINDOW = "langspeak";
const string DMFI_LANG_VAR_NUI_LINE = "langnui_line";

const string DMFI_LANG_VAR_TALK = "lang_talk";
// Module flag set by LangNwnxInit (dmfi_lang_nwnx) when the NWNX Chat plugin is loaded.
const string DMFI_LANG_NWNX_FLAG = "lang_nwnx";
// Locals LangSpeak sets on the speaker for lang_nwnx_say.
const string DMFI_LANG_VAR_DLV_LANG = "lang_dlv_lang";
const string DMFI_LANG_VAR_DLV_TEXT = "lang_dlv_text";
const string DMFI_LANG_VAR_DLV_RANGE = "lang_dlv_range";
// Set (saved with the character) when the player turned off translations in the .lang window.
const string DMFI_LANG_VAR_NUI_OFF = "lang_nui_off";
const string DMFI_LANG_VAR_EXP = "lang_exp_";

const string DMFI_LANG_VAR_KNOWN = "lang_known";
const string DMFI_LANG_VAR_SLOTS_USED = "lang_slotsused";
const string DMFI_LANG_VAR_SPEAKING = "hls_MyLanguage";
const string DMFI_LANG_VAR_SPEAKING_NAME = "hls_MyLanguageName";

// Fluency: 1 basic .. 6 fluent. Native languages (race, class, widget) are 6.
// Fluent speakers read the plain text; levels 1-5 catch part of it.
// A learned language starts at DMFI_LANG_LEARN_LEVEL and grows with exposure.
const int DMFI_LANG_NATIVE_LEVEL = 6;
const int DMFI_LANG_LEARN_LEVEL = 1;
// Percent of the words a listener catches, per fluency level.
const int DMFI_LANG_CHANCE_PER_LEVEL = 16;
// Words a listener does not know: TRUE shows them in the foreign language (the
// same scrambled word every time), FALSE hides runs of them as "...".
const int DMFI_LANG_SHOW_FOREIGN = TRUE;
// Per-character seed (saved with the character) that decides which words it knows.
const string DMFI_LANG_VAR_SEED = "lang_seed";
// Local int on an NPC: 1 = it gives exposure in its language even with the PC-only setting on.
const string DMFI_LANG_TRAINER_VAR = "lang_trainer";
const string DMFI_LANG_WORD_CHARS = "abcdefghijklmnopqrstuvwxyz0123456789'-";
// Hearing range in metres, by chat volume.
const float DMFI_LANG_RANGE_TALK = 20.0;
const float DMFI_LANG_RANGE_WHISPER = 3.0;

// Seconds before a listener re-rolls Lore to notice a language being spoken.
const float DMFI_LANG_LORE_RECHECK = 60.0;
// Lore check: d20 + Lore rank must exceed this to recognize the language.
const int DMFI_LANG_LORE_DC = 20;
// Longest Thieves' Cant message, in characters.
const int DMFI_LANG_CANT_MAX_LENGTH = 25;
// Longest "<language>:" prefix accepted in [dwarven: text].
const int DMFI_LANG_PREFIX_MAX_LENGTH = 12;

// --- names and ids

string LangName(int iLang)
{
    switch (iLang)
    {
        case 1: return "Elven";
        case 2: return "Gnome";
        case 3: return "Halfling";
        case 4: return "Dwarven";
        case 5: return "Orc";
        case 6: return "Goblin";
        case 7: return "Draconic";
        case 8: return "Animal";
        case 10: return "Celestial";
        case 11: return "Abyssal";
        case 12: return "Infernal";
        case 13: return "Drow";
        case 9: return "Thieves' Cant";
    }
    return "";
}

// Matches the start of a language name or common adjective: "dwarf",
// "dwarvish", "Dwarven" all give 4. Returns 0 when nothing matches.
int LangFromName(string sName)
{
    sName = GetStringLowerCase(sName);
    while (GetStringLeft(sName, 1) == " ") sName = GetStringRight(sName, GetStringLength(sName) - 1);
    while (GetStringRight(sName, 1) == " ") sName = GetStringLeft(sName, GetStringLength(sName) - 1);
    string sStart = GetStringLeft(sName, 3);
    if (GetStringLength(sName) < 3) return 0;
    if (sStart == "elf" || sStart == "elv") return 1;
    if (sStart == "gno") return 2;
    if (sStart == "hal") return 3;
    if (sStart == "dwa") return 4;
    if (sStart == "orc") return 5;
    if (sStart == "gob") return 6;
    if (sStart == "dra") return 7;
    if (sStart == "ani") return 8;
    if (sStart == "thi" || sStart == "can") return 9;
    if (sStart == "cel") return 10;
    if (sStart == "aby") return 11;
    if (sStart == "inf") return 12;
    if (sStart == "dro") return 13;
    if (sStart == "lee") return 99;
    return 0;
}

// Languages a character may learn with spare slots; Animal and Thieves' Cant
// belong to a class, Leetspeak is a joke.
int LangIsLearnable(int iLang)
{
    return (iLang >= 1 && iLang <= 7) || (iLang >= 10 && iLang <= 13);
}

// --- substitution tables

string LangTable(int iLang)
{
    switch (iLang)
    {
        case 1: return "il  f   ny  w   a   o   v   ir  e   qu  n   c   s   l   e   ty  h   m   la  an  y   el  am  '   a   j   "
            + "Il  F   Ny  W   A   O   V   Ir  E   Qu  N   C   S   L   E   Ty  H   M   La  An  Y   El  Am  '   A   J   ";
        case 2: return "y   p   l   t   a   v   k   r   e   z   g   m   s   h   u   b   x   n   c   d   i   j   f   q   o   w   "
            + "Y   P   L   T   A   V   K   R   E   Z   G   M   S   H   U   B   X   N   C   D   I   J   F   Q   O   W   ";
        case 3: return "e   p   s   t   i   w   k   n   u   v   g   c   l   r   y   b   x   h   m   d   o   f   z   q   a   j   "
            + "E   P   S   T   I   W   K   N   U   V   G   C   L   R   Y   B   X   H   M   D   O   F   Z   Q   A   J   ";
        case 4: return "az  po  zi  t   a   wa  k   '   a   dr  g   n   l   r   ur  rh  k   h   th  k   '   g   zh  q   o   j   "
            + "Az  Po  Zi  T   A   Wa  K   '   A   Dr  G   N   L   R   Ur  Rh  K   H   Th  K   '   G   Zh  Q   O   J   ";
        case 5: return "ha  p   z   t   o       k   r   a   m   g   h   r   k   u   b   k   h   g   n       g   r   r   '   m   "
            + "Ha  P   Z   T   O       K   R   A   M   G   H   R   K   U   B   K   H   G   N       G   R   R   '   M   ";
        case 6: return "u   p       t   '   v   k   r   o   z   g   m   s       u   b       n   k   d   u       '       o   w   "
            + "U   P       T   '   V   K   R   O   Z   G   M   S       U   B       N   K   D   U       '       O   W   ";
        case 7: return "e   po  st  ty  i   w   k   ni  un  vi  go  ch  li  ra  y   ba  x   hu  my  dr  on  fi  zi  qu  an  ji  "
            + "E   Po  St  Ty  I   W   K   Ni  Un  Vi  Go  Ch  Li  Ra  Y   Ba  X   Hu  My  Dr  On  Fi  Zi  Qu  An  Ji  ";
        case 8: return "'   '   '   '   '   '   '   '   '   '   '   '   '   '   '   '   '   '   '   '   '   '   '   '   '   '   "
            + "'   '   '   '   '   '   '   '   '   '   '   '   '   '   '   '   '   '   '   '   '   '   '   '   '   '   ";
        case 10: return "a   p   v   t   el  b   w   r   i   m   x   h   s   c   u   q   d   n   l   y   o   j   f   g   z   k   "
            + "A   P   V   T   El  B   W   R   I   M   X   H   S   C   U   Q   D   N   L   Y   O   J   F   G   Z   K   ";
        case 11: return "oo  n   m   g   a   k   s   d   oo  h   b   l   p   t   e   b   ch  n   m   g   ae  ts  b   bb  ee  t   "
            + "OO  N   M   G   A   K   S   D   OO  H   B   L   P   T   E   B   Ch  N   M   G   Ae  Ts  B   Bb  Ee  T   ";
        case 12: return "o   c   r   j   a   v   k   r   y   z   g   m   z   r   y   k   r   n   k   d   '   r   '   k   i   g   "
            + "O   C   R   J   A   V   K   R   Y   Z   G   M   Z   R   Y   K   R   N   K   D   '   R   '   K   I   G   ";
        case 13: return "il  f   st  w   a   o   v   ir  e   vi  go  c   li  l   e   ty  r   m   la  an  y   el  ky  '   a   p'  "
            + "Il  F   St  W   A   O   V   Ir  E   Vi  Go  C   Li  L   E   Ty  R   M   La  An  Y   El  Ky  '   A   P'  ";
        case 99: return "4   8   (   |)  3   f   9   h   !   j   |<  1   /\\/\\|\\| 0   p   Q   R   5   7   u   \\/  \\/\\/x   y   2   "
            + "4   8   (   |)  3   F   9   H   !   J   |<  1   /\\/\\|\\| 0   P   Q   R   5   7   U   \\/  \\/\\/X   Y   2   ";
    }
    return "";
}

string LangTableEntry(string sTable, int iIndex)
{
    string sEntry = GetSubString(sTable, iIndex * DMFI_LANG_ENTRY_WIDTH, DMFI_LANG_ENTRY_WIDTH);
    int iPad = FindSubString(sEntry, " ");
    if (iPad != -1) sEntry = GetStringLeft(sEntry, iPad);
    return sEntry;
}

// Text between *asterisks* is left alone (emotes).
string TranslateByTable(string sTable, string sPhrase)
{
    string sOutput = "";
    int bLiteral = FALSE;
    int nLength = GetStringLength(sPhrase);
    int i;
    for (i = 0; i < nLength; i++)
    {
        string sChar = GetSubString(sPhrase, i, 1);
        if (sChar == "*")
        {
            bLiteral = !bLiteral;
            sOutput += sChar;
            continue;
        }
        int iIndex = FindSubString(DMFI_LANG_ALPHABET, sChar);
        if (bLiteral || iIndex == -1)
            sOutput += sChar;
        else
            sOutput += LangTableEntry(sTable, iIndex);
    }
    return sOutput;
}

// --- other cipher types

string ConvertCustom(string sLetter, int iRotate)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);

    //Functional groups for custom languages
    //Vowel Sounds: a, e, i, o, u
    //Hard Sounds: b, d, k, p, t
    //Sibilant Sounds: c, f, s, q, w
    //Soft Sounds: g, h, l, r, y
    //Hummed Sounds: j, m, n, v, z
    //Oddball out: x, the rarest letter in the alphabet

    string sTranslate = "aeiouAEIOUbdkptBDKPTcfsqwCFSQWghlryGHLRYjmnvzJMNVZxX";
    int iTrans = FindSubString(sTranslate, sLetter);
    if (iTrans == -1) return sLetter; //return any character that isn't on the cipher

    //Now here's the tricky part... recalculating the offsets according functional
    //letter group, to produce an huge variety of "new" languages.

    int iOffset = iRotate % 5;
    int iGroup = iTrans / 5;
    int iBonus = iTrans / 10;
    int iMultiplier = iRotate / 5;
    iOffset = iTrans + iOffset + (iMultiplier * iBonus);

    return GetSubString(sTranslate, iGroup * 5 + iOffset % 5, 1);
}//end ConvertCustom

string ProcessCustom(string sPhrase, int iLanguage)
{
    string sOutput;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertCustom(GetStringLeft(sPhrase, 1), iLanguage);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ProcessCant(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);

    if (sLetter == "a" || sLetter == "A") return "*shields eyes*";
    if (sLetter == "b" || sLetter == "B") return "*blusters*";
    if (sLetter == "c" || sLetter == "C") return "*coughs*";
    if (sLetter == "d" || sLetter == "D") return "*furrows brow*";
    if (sLetter == "e" || sLetter == "E") return "*examines ground*";
    if (sLetter == "f" || sLetter == "F") return "*frowns*";
    if (sLetter == "g" || sLetter == "G") return "*glances up*";
    if (sLetter == "h" || sLetter == "H") return "*looks thoughtful*";
    if (sLetter == "i" || sLetter == "I") return "*looks bored*";
    if (sLetter == "j" || sLetter == "J") return "*rubs chin*";
    if (sLetter == "k" || sLetter == "K") return "*scratches ear*";
    if (sLetter == "l" || sLetter == "L") return "*looks around*";
    if (sLetter == "m" || sLetter == "M") return "*mmm hmm*";
    if (sLetter == "n" || sLetter == "N") return "*nods*";
    if (sLetter == "o" || sLetter == "O") return "*grins*";
    if (sLetter == "p" || sLetter == "P") return "*smiles*";
    if (sLetter == "q" || sLetter == "Q") return "*shivers*";
    if (sLetter == "r" || sLetter == "R") return "*rolls eyes*";
    if (sLetter == "s" || sLetter == "S") return "*scratches nose*";
    if (sLetter == "t" || sLetter == "T") return "*turns a bit*";
    if (sLetter == "u" || sLetter == "U") return "*glances idly*";
    if (sLetter == "v" || sLetter == "V") return "*runs hand through hair*";
    if (sLetter == "w" || sLetter == "W") return "*waves*";
    if (sLetter == "x" || sLetter == "X") return "*stretches*";
    if (sLetter == "y" || sLetter == "Y") return "*yawns*";
    if (sLetter == "z" || sLetter == "Z") return "*shrugs*";

    return "*nods*";
}

string TranslateCommonToLanguage(int iLang, string sText)
{
    if (iLang == 9) return ProcessCant(sText);
    if (iLang > 100) return ProcessCustom(sText, iLang - 100);

    string sTable = LangTable(iLang);
    if (sTable == "") return "";
    return TranslateByTable(sTable, sText);
}

// --- who knows what

// Race ids added by the Tethyr racialtypes.2da.
const int DMFI_RACE_DRIDER = 50;
const int DMFI_RACE_BROWNIE = 53;

// TRUE if oCreature knows iLang without learning it, from its race, subrace,
// alignment or class levels. These languages are fluent and use no slot.
//   Elven      elf, half-elf, drow, drider, fey
//   Gnome, Halfling, Dwarven   the matching race
//   Orc        orc, half-orc
//   Goblin     goblinoids: goblin, hobgoblin, bugbear, gnoll
//   Draconic   dragons and reptilians: kobold, lizardfolk, troglodyte
//   Animal     any Ranger or Druid level
//   Thieves' Cant   any Rogue level
//   Celestial / Infernal / Abyssal   outsiders that are good / lawful evil / chaotic evil
//   Drow       subrace "drow", drider
int LangInnate(object oCreature, int iLang)
{
    int iRace = GetRacialType(oCreature);
    int bDrow = GetStringLowerCase(GetSubRace(oCreature)) == "drow" || iRace == DMFI_RACE_DRIDER;
    int bOutsider = iRace == RACIAL_TYPE_OUTSIDER;
    int iGoodEvil = GetAlignmentGoodEvil(oCreature);
    int iLawChaos = GetAlignmentLawChaos(oCreature);

    switch (iLang)
    {
        case 1: return iRace == RACIAL_TYPE_ELF || iRace == RACIAL_TYPE_HALFELF || iRace == RACIAL_TYPE_FEY
                    || iRace == DMFI_RACE_BROWNIE || bDrow;
        case 2: return iRace == RACIAL_TYPE_GNOME;
        case 3: return iRace == RACIAL_TYPE_HALFLING;
        case 4: return iRace == RACIAL_TYPE_DWARF;
        case 5: return iRace == RACIAL_TYPE_HUMANOID_ORC || iRace == RACIAL_TYPE_HALFORC;
        case 6: return iRace == RACIAL_TYPE_HUMANOID_GOBLINOID;
        case 7: return iRace == RACIAL_TYPE_DRAGON || iRace == RACIAL_TYPE_HUMANOID_REPTILIAN;
        case 8: return GetLevelByClass(CLASS_TYPE_RANGER, oCreature) > 0 || GetLevelByClass(CLASS_TYPE_DRUID, oCreature) > 0;
        case 9: return GetLevelByClass(CLASS_TYPE_ROGUE, oCreature) > 0;
        case 10: return bOutsider && iGoodEvil == ALIGNMENT_GOOD;
        case 11: return bOutsider && iGoodEvil == ALIGNMENT_EVIL && iLawChaos == ALIGNMENT_CHAOTIC;
        case 12: return bOutsider && iGoodEvil == ALIGNMENT_EVIL && iLawChaos == ALIGNMENT_LAWFUL;
        case 13: return bDrow;
    }
    return FALSE;
}

// The language a creature speaks by default: the first one it knows
// innately (race before class). 0 if none. With iRename, also records the
// language name on the creature for the voice widget.
int GetDefaultRacialLanguage(object oPC, int iRename)
{
    int iLang;
    for (iLang = 1; iLang <= 13; iLang++)
    {
        if (LangInnate(oPC, iLang))
        {
            if (iRename) SetLocalString(oPC, "hls_MyLanguageName", LangName(iLang));
            return iLang;
        }
    }
    return 0;
}

// Entries look like ",4:3,10:2," (id:level). Older entries without a level
// (",4,") count as fluent.
int LangListLevel(object oPC, int iLang)
{
    string sKnown = GetLocalString(oPC, DMFI_LANG_VAR_KNOWN);
    string sKey = "," + IntToString(iLang) + ":";
    int iPos = FindSubString(sKnown, sKey);
    if (iPos != -1)
    {
        string sRest = GetStringRight(sKnown, GetStringLength(sKnown) - iPos - GetStringLength(sKey));
        return StringToInt(GetStringLeft(sRest, FindSubString(sRest, ",")));
    }
    if (FindSubString(sKnown, "," + IntToString(iLang) + ",") != -1) return DMFI_LANG_NATIVE_LEVEL;
    return 0;
}

string LangListWithout(string sKnown, int iLang)
{
    string sPrefix = "," + IntToString(iLang);
    int iPos = FindSubString(sKnown, sPrefix + ":");
    if (iPos == -1) iPos = FindSubString(sKnown, sPrefix + ",");
    if (iPos == -1) return sKnown;
    string sAfter = GetStringRight(sKnown, GetStringLength(sKnown) - iPos - 1);
    int iEnd = FindSubString(sAfter, ",");
    return GetStringLeft(sKnown, iPos + 1) + GetStringRight(sAfter, GetStringLength(sAfter) - iEnd - 1);
}

// --- persistence
// Local variables on a player are lost when the player logs out, so the
// language state is also written to the campaign database (character-specific
// files in the server's database folder, no NWNX needed). LangLoad restores it
// when the player enters; every change calls LangSave or LangSaveExp.

// Campaign database name. Each account (public CD key) gets its own file,
// <CD key>.sqlite3, with its characters' rows told apart by account and
// character name; DMFI_LANG_DB is the older shared file, read once to migrate.
const string DMFI_LANG_DB = "dmfi_lang";
const string DMFI_LANG_VAR_LOADED = "lang_loaded";
const string DMFI_LANG_DB_MARK = "saved";

string LangDb(object oPC)
{
    string sKey = GetPCPublicCDKey(oPC);
    if (sKey == "") return DMFI_LANG_DB;
    return sKey;
}

void LangSaveExp(object oPC, int iLang)
{
    if (!GetIsPC(oPC)) return;
    string sVar = DMFI_LANG_VAR_EXP + IntToString(iLang);
    SetCampaignInt(LangDb(oPC), sVar, GetLocalInt(oPC, sVar), oPC);
}

// Writes the whole language state of oPC.
void LangSave(object oPC)
{
    if (!GetIsPC(oPC) || GetIsDM(oPC)) return;
    string sDb = LangDb(oPC);
    SetCampaignString(sDb, DMFI_LANG_VAR_KNOWN, GetLocalString(oPC, DMFI_LANG_VAR_KNOWN), oPC);
    SetCampaignInt(sDb, DMFI_LANG_VAR_SEED, GetLocalInt(oPC, DMFI_LANG_VAR_SEED), oPC);
    SetCampaignInt(sDb, DMFI_LANG_VAR_SLOTS_USED, GetLocalInt(oPC, DMFI_LANG_VAR_SLOTS_USED), oPC);
    SetCampaignInt(sDb, DMFI_LANG_VAR_SPEAKING, GetLocalInt(oPC, DMFI_LANG_VAR_SPEAKING), oPC);
    SetCampaignInt(sDb, DMFI_LANG_VAR_TALK, GetLocalInt(oPC, DMFI_LANG_VAR_TALK), oPC);
    SetCampaignInt(sDb, DMFI_LANG_VAR_NUI_OFF, GetLocalInt(oPC, DMFI_LANG_VAR_NUI_OFF), oPC);
    int iLang;
    for (iLang = 1; iLang <= 13; iLang++) LangSaveExp(oPC, iLang);
    SetCampaignInt(sDb, DMFI_LANG_DB_MARK, 1, oPC);
}

// Copies the language state stored in campaign database sDb onto oPC.
void LangRestore(object oPC, string sDb)
{
    SetLocalString(oPC, DMFI_LANG_VAR_KNOWN, GetCampaignString(sDb, DMFI_LANG_VAR_KNOWN, oPC));
    SetLocalInt(oPC, DMFI_LANG_VAR_SEED, GetCampaignInt(sDb, DMFI_LANG_VAR_SEED, oPC));
    SetLocalInt(oPC, DMFI_LANG_VAR_SLOTS_USED, GetCampaignInt(sDb, DMFI_LANG_VAR_SLOTS_USED, oPC));
    int iSpeaking = GetCampaignInt(sDb, DMFI_LANG_VAR_SPEAKING, oPC);
    if (iSpeaking)
    {
        SetLocalInt(oPC, DMFI_LANG_VAR_SPEAKING, iSpeaking);
        SetLocalString(oPC, DMFI_LANG_VAR_SPEAKING_NAME, LangName(iSpeaking));
    }
    SetLocalInt(oPC, DMFI_LANG_VAR_TALK, GetCampaignInt(sDb, DMFI_LANG_VAR_TALK, oPC));
    SetLocalInt(oPC, DMFI_LANG_VAR_NUI_OFF, GetCampaignInt(sDb, DMFI_LANG_VAR_NUI_OFF, oPC));
    int iLang;
    for (iLang = 1; iLang <= 13; iLang++)
    {
        int iExp = GetCampaignInt(sDb, DMFI_LANG_VAR_EXP + IntToString(iLang), oPC);
        if (iExp) SetLocalInt(oPC, DMFI_LANG_VAR_EXP + IntToString(iLang), iExp);
    }
}

// Restores the language state when a player enters (once per session). A
// character with nothing stored keeps what it has and has it saved; one found
// only in the older shared database is moved to its account database.
void LangLoad(object oPC)
{
    if (!GetIsPC(oPC) || GetIsDM(oPC)) return;
    if (GetLocalInt(oPC, DMFI_LANG_VAR_LOADED)) return;
    SetLocalInt(oPC, DMFI_LANG_VAR_LOADED, 1);

    string sDb = LangDb(oPC);
    if (GetCampaignInt(sDb, DMFI_LANG_DB_MARK, oPC))
        LangRestore(oPC, sDb);
    else if (sDb != DMFI_LANG_DB && GetCampaignInt(DMFI_LANG_DB, DMFI_LANG_DB_MARK, oPC))
    {
        LangRestore(oPC, DMFI_LANG_DB);
        LangSave(oPC);
    }
    else
        LangSave(oPC);
}

void LangListSet(object oPC, int iLang, int iLevel)
{
    string sKnown = LangListWithout(GetLocalString(oPC, DMFI_LANG_VAR_KNOWN), iLang);
    if (sKnown == "") sKnown = ",";
    SetLocalString(oPC, DMFI_LANG_VAR_KNOWN, sKnown + IntToString(iLang) + ":" + IntToString(iLevel) + ",");
    LangSave(oPC);
}

// 0 = does not know it .. 5 = fluent.
int LangFluency(object oPC, int iLang)
{
    if (iLang <= 0) return 0;
    if (GetIsDM(oPC) || GetIsDMPossessed(oPC)) return DMFI_LANG_NATIVE_LEVEL;
    if (GetIsObjectValid(GetItemPossessedBy(oPC, "hlslang_" + IntToString(iLang))) ||
        GetIsObjectValid(GetItemPossessedBy(oPC, "babelfish")) ||
        LangInnate(oPC, iLang))
        return DMFI_LANG_NATIVE_LEVEL;
    return LangListLevel(oPC, iLang);
}

int GetKnowsLanguage(object oPC, int iLang)
{
    return LangFluency(oPC, iLang) > 0;
}

// Listening to a language you partly know slowly improves it.
// True if oSource may teach oListener by being heard: another player character
// (a DM, or a creature a DM controls, counts as a person) or an NPC marked as a
// trainer. Ordinary NPCs do not, when the PC-only setting is on.
int LangExposureSourceOk(object oListener, object oSource)
{
    if (!LangCfgExpPcOnly()) return TRUE;
    if (!GetIsObjectValid(oSource) || oSource == oListener) return FALSE;
    if (GetIsPC(oSource) || GetIsDMPossessed(oSource)) return TRUE;
    return GetLocalInt(oSource, DMFI_LANG_TRAINER_VAR) == 1;
}

// Adds iPoints exposure points and applies any level gained. No checks.
void LangAddExposure(object oListener, int iLang, int iPoints = 1)
{
    int iLevel = LangListLevel(oListener, iLang);
    if (iLevel < 1 || iLevel >= DMFI_LANG_NATIVE_LEVEL) return;
    if (LangFluency(oListener, iLang) >= DMFI_LANG_NATIVE_LEVEL) return; // native by other means

    string sVar = DMFI_LANG_VAR_EXP + IntToString(iLang);
    int iExp = GetLocalInt(oListener, sVar) + iPoints;
    int iUnit = LangCfgExpUnit();
    int bGained = FALSE;
    while (iLevel < DMFI_LANG_NATIVE_LEVEL && iExp >= iLevel * iLevel * iUnit)
    {
        iExp -= iLevel * iLevel * iUnit;
        iLevel++;
        bGained = TRUE;
    }
    if (bGained)
    {
        LangListSet(oListener, iLang, iLevel);
        SendMessageToPC(oListener, "Your grasp of " + LangName(iLang) + " has improved to " + IntToString(iLevel) + " of " + IntToString(DMFI_LANG_NATIVE_LEVEL) + ".");
    }
    if (iLevel >= DMFI_LANG_NATIVE_LEVEL || iExp <= 0) DeleteLocalInt(oListener, sVar);
    else SetLocalInt(oListener, sVar, iExp);
    LangSaveExp(oListener, iLang);
}

// A line in iLang was heard from oSource: one point, at most once per cooldown
// per listener and language, if advancement is on and the source counts.
void LangGainExposure(object oListener, int iLang, object oSource = OBJECT_INVALID)
{
    if (!LangCfgExpEnabled()) return;
    if (!LangExposureSourceOk(oListener, oSource)) return;
    int iLevel = LangListLevel(oListener, iLang);
    if (iLevel < 1 || iLevel >= DMFI_LANG_NATIVE_LEVEL) return;

    string sCooldown = "lang_expcd_" + ObjectToString(oListener) + "_" + IntToString(iLang);
    if (GetLocalInt(GetModule(), sCooldown)) return;
    SetLocalInt(GetModule(), sCooldown, 1);
    AssignCommand(GetModule(), DelayCommand(IntToFloat(LangCfgExpCooldown()), DeleteLocalInt(GetModule(), sCooldown)));
    LangAddExposure(oListener, iLang, 1);
}

// The language [text] is spoken in: the chosen one, else the racial default.
int GetSpokenLanguage(object oPC)
{
    int iLang = GetLocalInt(oPC, DMFI_LANG_VAR_SPEAKING);
    if (iLang) return iLang;
    return GetDefaultRacialLanguage(oPC, 1);
}

void SetSpokenLanguage(object oPC, int iLang)
{
    SetLocalInt(oPC, DMFI_LANG_VAR_SPEAKING, iLang);
    SetLocalString(oPC, DMFI_LANG_VAR_SPEAKING_NAME, LangName(iLang));
    LangSave(oPC);
}

// One extra language per point of base Intelligence modifier.
int LangSlotsTotal(object oPC)
{
    int iMod = (GetAbilityScore(oPC, ABILITY_INTELLIGENCE, TRUE) - 10) / 2;
    if (iMod < 0) iMod = 0;
    return iMod;
}

int LangSlotsFree(object oPC)
{
    if (LangCfgSlotsIgnore()) return 99;
    int iFree = LangSlotsTotal(oPC) - GetLocalInt(oPC, DMFI_LANG_VAR_SLOTS_USED);
    if (iFree < 0) iFree = 0;
    return iFree;
}

// Takes a slot for a new language. FALSE (nothing taken) if none is free.
int LangTakeSlot(object oPC)
{
    if (LangCfgSlotsIgnore()) return TRUE;
    if (LangSlotsFree(oPC) < 1) return FALSE;
    SetLocalInt(oPC, DMFI_LANG_VAR_SLOTS_USED, GetLocalInt(oPC, DMFI_LANG_VAR_SLOTS_USED) + 1);
    return TRUE;
}

// "3 of 3" style text for messages; "no limit" when slots are ignored.
string LangSlotsText(object oPC)
{
    if (LangCfgSlotsIgnore()) return "no limit";
    return IntToString(LangSlotsFree(oPC)) + " of " + IntToString(LangSlotsTotal(oPC));
}

// --- chat commands

string LangKnownSummary(object oPC)
{
    string sOut = "";
    int iLang;
    for (iLang = 1; iLang <= 13; iLang++)
    {
        int iLevel = LangFluency(oPC, iLang);
        if (!iLevel) continue;
        if (sOut != "") sOut += ", ";
        sOut += LangName(iLang);
        if (iLevel < DMFI_LANG_NATIVE_LEVEL) sOut += " (" + IntToString(iLevel) + "/" + IntToString(DMFI_LANG_NATIVE_LEVEL) + ")";
    }
    if (sOut == "") sOut = "none";
    return sOut;
}

void LangCmdList(object oPC)
{
    int iCurrent = GetSpokenLanguage(oPC);
    string sCurrent = "none";
    if (iCurrent) sCurrent = LangName(iCurrent);
    if (sCurrent == "") sCurrent = GetLocalString(oPC, DMFI_LANG_VAR_SPEAKING_NAME);
    string sTalk = "your normal talk is in the common tongue";
    if (GetLocalInt(oPC, DMFI_LANG_VAR_TALK)) sTalk = "your normal talk and whispers come out in " + sCurrent;
    SendMessageToPC(oPC, "You speak: " + LangKnownSummary(oPC));
    SendMessageToPC(oPC, "Chosen language: " + sCurrent + "; " + sTalk + ". New languages you can still start: " + LangSlotsText(oPC));
    SendMessageToPC(oPC, ".lang opens the speaking window. .speak <language> makes your normal talk come out in it, .speak off stops. Languages are learned from books. [text] and [dwarven: text] still work.");
}

void LangCmdSpeak(object oPC, string sArg)
{
    if (sArg == "")
    {
        LangCmdList(oPC);
        return;
    }
    if (sArg == "off" || sArg == "normal" || sArg == "common" || sArg == "none")
    {
        DeleteLocalInt(oPC, DMFI_LANG_VAR_TALK);
        LangSave(oPC);
        SendMessageToPC(oPC, "Your normal talk is back to the common tongue. [text] still speaks your chosen language.");
        return;
    }
    int iLang = LangFromName(sArg);
    if (!iLang)
    {
        SendMessageToPC(oPC, "Unknown language '" + sArg + "'. .languages lists the ones you speak.");
        return;
    }
    if (!GetKnowsLanguage(oPC, iLang))
    {
        SendMessageToPC(oPC, "You do not speak " + LangName(iLang) + ".");
        return;
    }
    SetSpokenLanguage(oPC, iLang);
    SetLocalInt(oPC, DMFI_LANG_VAR_TALK, 1);
    LangSave(oPC);
    SendMessageToPC(oPC, "Your normal talk and whispers now come out in " + LangName(iLang) + ". .speak off stops. This is remembered between sessions.");
}

// Languages are learned only from books; the command stays so old tips do not error.
void LangCmdLearn(object oPC, string sArg)
{
    SendMessageToPC(oPC, "Languages are learned from books, not by command. Find a bookshelf and study a primer by activating it. New languages you can still start: " + LangSlotsText(oPC));
}

void LangCmdTeach(object oDM, string sArg)
{
    object oTarget = GetLocalObject(oDM, "dmfi_univ_target");
    if (!GetIsObjectValid(oTarget)) oTarget = GetLocalObject(oDM, "dmfi_VoiceTarget");

    // "<language> [level 1-6]"
    int iLevel = DMFI_LANG_NATIVE_LEVEL;
    int iSpace = FindSubString(sArg, " ");
    string sName = sArg;
    if (iSpace != -1)
    {
        sName = GetStringLeft(sArg, iSpace);
        iLevel = StringToInt(GetStringRight(sArg, GetStringLength(sArg) - iSpace - 1));
        if (iLevel < 1) iLevel = 1;
        if (iLevel > DMFI_LANG_NATIVE_LEVEL) iLevel = DMFI_LANG_NATIVE_LEVEL;
    }
    int iLang = LangFromName(sName);
    if (!GetIsObjectValid(oTarget) || !iLang)
    {
        SendMessageToPC(oDM, ".teach <language> [level 1-6] gives the language to your current DMFI target (default level 6).");
        return;
    }
    LangListSet(oTarget, iLang, iLevel);
    SendMessageToPC(oDM, GetName(oTarget) + " now speaks " + LangName(iLang) + " at level " + IntToString(iLevel) + ".");
    SendMessageToPC(oTarget, "You have learned " + LangName(iLang) + " (level " + IntToString(iLevel) + " of " + IntToString(DMFI_LANG_NATIVE_LEVEL) + ").");
}

// Handles .languages, .speak, .learn (hint) and .teach. Returns TRUE if the message
// was a language command (the caller should then suppress it).
int LangChatCommand(object oPC, string sMsg)
{
    sMsg = GetStringLowerCase(sMsg);
    string sVerb = sMsg;
    string sArg = "";
    int iSpace = FindSubString(sMsg, " ");
    if (iSpace != -1)
    {
        sVerb = GetStringLeft(sMsg, iSpace);
        sArg = GetStringRight(sMsg, GetStringLength(sMsg) - iSpace - 1);
    }

    if (sVerb == ".languages" || sVerb == ".langs") LangCmdList(oPC);
    else if (sVerb == ".speak")                     LangCmdSpeak(oPC, sArg);
    else if (sVerb == ".learn")                     LangCmdLearn(oPC, sArg);
    else if (sVerb == ".teach" && GetIsDM(oPC))     LangCmdTeach(oPC, sArg);
    else return FALSE;
    return TRUE;
}

// --- speaking

// Lore notice, rolled once per listener and language per recheck window.
void NoticeLanguage(object oListener, object oShouter, int iLang, string sLanguageName)
{
    string sKey = "lang_lore_" + ObjectToString(oListener) + "_" + IntToString(iLang);
    if (GetLocalInt(GetModule(), sKey)) return;
    SetLocalInt(GetModule(), sKey, 1);
    AssignCommand(GetModule(), DelayCommand(DMFI_LANG_LORE_RECHECK, DeleteLocalInt(GetModule(), sKey)));

    if (iLang != 9 && d20() + GetSkillRank(SKILL_LORE, oListener) > DMFI_LANG_LORE_DC)
        SendMessageToPC(oListener, GetName(oShouter) + " is speaking in " + sLanguageName);
}

string LangScramble(int iLang, string sSaid)
{
    if (iLang == 9 && GetStringLength(sSaid) > DMFI_LANG_CANT_MAX_LENGTH)
        sSaid = GetStringLeft(sSaid, DMFI_LANG_CANT_MAX_LENGTH);
    return TranslateCommonToLanguage(iLang, sSaid);
}

// --- which words a character knows
// A character of fluency f knows a given word of a language when a hash of
// (the character's seed, the language, the word) falls below f * 16 percent.
// The result depends only on those three things, so the same word is always
// readable or always masked for that character, in every sentence and every
// conversation, and the set of known words only grows as fluency rises.

int LangSeed(object oPC)
{
    int iSeed = GetLocalInt(oPC, DMFI_LANG_VAR_SEED);
    if (iSeed == 0 && GetIsPC(oPC))
    {
        iSeed = Random(900000) + 1;
        SetLocalInt(oPC, DMFI_LANG_VAR_SEED, iSeed);
        LangSave(oPC);
    }
    return iSeed;
}

// sWord without punctuation, lower case; "" when no letters or digits remain.
string LangWordCore(string sWord)
{
    string sCore = "";
    sWord = GetStringLowerCase(sWord);
    int i;
    for (i = 0; i < GetStringLength(sWord); i++)
    {
        string sChar = GetSubString(sWord, i, 1);
        if (FindSubString(DMFI_LANG_WORD_CHARS, sChar) != -1) sCore += sChar;
    }
    return sCore;
}

int LangKnowsWord(object oPC, int iLang, string sWord, int iFluency)
{
    if (iFluency >= DMFI_LANG_NATIVE_LEVEL) return TRUE;
    string sCore = LangWordCore(sWord);
    if (sCore == "") return TRUE;       // punctuation or a number: nothing to hide
    if (iFluency <= 0) return FALSE;

    int iHash = (LangSeed(oPC) % 100000) + iLang * 7919;
    int i;
    for (i = 0; i < GetStringLength(sCore); i++)
        iHash = (iHash * 31 + FindSubString(DMFI_LANG_WORD_CHARS, GetSubString(sCore, i, 1)) + 1) % 1000003;
    return (iHash % 100) < iFluency * DMFI_LANG_CHANCE_PER_LEVEL;
}

// sText as oListener (of iFluency in iLang) reads or hears it. Words the
// listener does not know are replaced by the language's scrambled form, or by
// "..." (DMFI_LANG_SHOW_FOREIGN). When oSpeaker is given, the words the speaker
// does not know (iSpeakerFluency) are left out for everyone, so a learner's
// sentences read as halting speech with gaps. A run of missing words is shown
// as a single "...", never two in a row.
string LangGarble(string sText, int iFluency, int iLang, object oListener, object oSpeaker = OBJECT_INVALID, int iSpeakerFluency = 6)
{
    string sOut = "";
    int bLastDots = FALSE;
    string sRest = sText;
    while (sRest != "")
    {
        int iSpace = FindSubString(sRest, " ");
        string sWord = sRest;
        if (iSpace == -1)
            sRest = "";
        else
        {
            sWord = GetStringLeft(sRest, iSpace);
            sRest = GetStringRight(sRest, GetStringLength(sRest) - iSpace - 1);
        }
        if (sWord == "") continue;

        // A word the speaker does not know is not said at all, for every
        // listener, like a learner searching for the word. A run of them is one "...".
        int bSpeakerKnows = !GetIsObjectValid(oSpeaker) || LangKnowsWord(oSpeaker, iLang, sWord, iSpeakerFluency);
        int bKnown = bSpeakerKnows && LangKnowsWord(oListener, iLang, sWord, iFluency);
        string sShown = sWord;
        if (!bSpeakerKnows || (!bKnown && !DMFI_LANG_SHOW_FOREIGN))
            sShown = "...";
        else if (!bKnown)
            sShown = LangScramble(iLang, sWord);
        int bDots = (sShown == "...");
        if (bDots && bLastDots) continue;
        if (sOut != "") sOut += " ";
        sOut += sShown;
        bLastDots = bDots;
    }
    return sOut;
}

// What a speaker manages of a language: a player's own fluency, full for NPCs and DMs.
int LangSpeakerFluency(object oSpeaker, int iLang)
{
    if (GetIsPC(oSpeaker) && !GetIsDM(oSpeaker) && !GetIsDMPossessed(oSpeaker))
        return LangFluency(oSpeaker, iLang);
    return DMFI_LANG_NATIVE_LEVEL;
}

// The line as it is spoken aloud (speech bubble and chat line): the language's
// scrambled form for each word the speaker knows, and "..." for each word the
// speaker does not, so a learner sounds like they are struggling to speak.
string LangSpoken(int iLang, string sSaid, object oSpeaker)
{
    int iFluency = LangSpeakerFluency(oSpeaker, iLang);
    // Emotes (*...*) span words, so a line containing one is scrambled whole.
    if (iFluency >= DMFI_LANG_NATIVE_LEVEL || FindSubString(sSaid, "*") != -1)
        return LangScramble(iLang, sSaid);

    if (iLang == 9 && GetStringLength(sSaid) > DMFI_LANG_CANT_MAX_LENGTH)
        sSaid = GetStringLeft(sSaid, DMFI_LANG_CANT_MAX_LENGTH);
    string sOut = "";
    int bLastDots = FALSE;
    string sRest = sSaid;
    while (sRest != "")
    {
        int iSpace = FindSubString(sRest, " ");
        string sWord = sRest;
        if (iSpace == -1)
            sRest = "";
        else
        {
            sWord = GetStringLeft(sRest, iSpace);
            sRest = GetStringRight(sRest, GetStringLength(sRest) - iSpace - 1);
        }
        if (sWord == "") continue;
        int bKnows = LangKnowsWord(oSpeaker, iLang, sWord, iFluency);
        if (!bKnows && bLastDots) continue;
        if (sOut != "") sOut += " ";
        if (bKnows) sOut += TranslateCommonToLanguage(iLang, sWord);
        else sOut += "...";
        bLastDots = !bKnows;
    }
    return sOut;
}

// --- sign languages
// Drow is a sign language: nothing is spoken, so there is no speech bubble and
// no scrambled text. Each viewer reads a description of the signing instead:
//   fluent   The <race> signs, <the full text>
//   partial  The <race> does not speak, but uses sign, you can only make out: <known words>.
//   none     The <race> does not speak, but moves their hands and fingers in rapid patterns.
// <race> is replaced with the signer's race (see LangRaceName).

const int DMFI_LANG_SIGN_DROW = 13;
const string DMFI_LANG_RACE_TAG = "<race>";
const string DMFI_LANG_SIGN_FLUENT = "The <race> signs, ";
const string DMFI_LANG_SIGN_PARTIAL = "The <race> does not speak, but uses sign, you can only make out: ";
const string DMFI_LANG_SIGN_NONE = "The <race> does not speak, but moves their hands and fingers in rapid patterns.";
const string DMFI_LANG_SIGN_NOTHING = "The <race> does not speak, but uses sign; you cannot make out any of it.";

int LangIsSign(int iLang)
{
    return iLang == DMFI_LANG_SIGN_DROW;
}

// The race as it reads in a description: "Elf", "Man", "Dwarf", ...
string LangRaceName(object oCreature)
{
    if (GetStringLowerCase(GetSubRace(oCreature)) == "drow") return "Drow";
    switch (GetRacialType(oCreature))
    {
        case RACIAL_TYPE_DWARF: return "Dwarf";
        case RACIAL_TYPE_ELF: return "Elf";
        case RACIAL_TYPE_GNOME: return "Gnome";
        case RACIAL_TYPE_HALFLING: return "Halfling";
        case RACIAL_TYPE_HALFELF: return "Half-elf";
        case RACIAL_TYPE_HALFORC: return "Half-orc";
        case RACIAL_TYPE_HUMAN: return "Man";
        case RACIAL_TYPE_HUMANOID_GOBLINOID: return "Goblin";
        case RACIAL_TYPE_HUMANOID_ORC: return "Orc";
        case RACIAL_TYPE_HUMANOID_REPTILIAN: return "Lizardfolk";
        case RACIAL_TYPE_HUMANOID_MONSTROUS: return "Creature";
        case RACIAL_TYPE_DRAGON: return "Dragon";
    }
    return "Creature";
}

// Replaces every <race> in sText with the race of oSpeaker. Dialog authors can
// write <race> in any NPC line.
string LangExpandVars(string sText, object oSpeaker)
{
    string sRace = LangRaceName(oSpeaker);
    string sOut = "";
    int iPos = FindSubString(sText, DMFI_LANG_RACE_TAG);
    while (iPos != -1)
    {
        sOut += GetStringLeft(sText, iPos) + sRace;
        sText = GetStringRight(sText, GetStringLength(sText) - iPos - GetStringLength(DMFI_LANG_RACE_TAG));
        iPos = FindSubString(sText, DMFI_LANG_RACE_TAG);
    }
    return sOut + sText;
}

// The words of sText the viewer can make out: the words the viewer knows
// (LangKnowsWord), punctuation removed. Words not known leave no trace.
string LangSignWords(string sText, int iFluency, int iLang, object oViewer)
{
    string sOut = "";
    string sRest = sText;
    while (sRest != "")
    {
        int iSpace = FindSubString(sRest, " ");
        string sWord = sRest;
        if (iSpace == -1)
            sRest = "";
        else
        {
            sWord = GetStringLeft(sRest, iSpace);
            sRest = GetStringRight(sRest, GetStringLength(sRest) - iSpace - 1);
        }
        string sClean = "";
        int i;
        for (i = 0; i < GetStringLength(sWord); i++)
        {
            string sChar = GetSubString(sWord, i, 1);
            if (FindSubString(".,;:!?\"()", sChar) == -1) sClean += sChar;
        }
        if (sClean == "") continue;
        if (LangKnowsWord(oViewer, iLang, sClean, iFluency))
        {
            if (sOut != "") sOut += " ";
            sOut += sClean;
        }
    }
    return sOut;
}

// What oViewer reads when oSigner signs sSaid in a sign language. The signer
// sees "You sign, ...". A viewer with a partial grasp improves by watching.
string LangSignLine(object oSigner, object oViewer, int iLang, string sSaid)
{
    if (oViewer == oSigner) return "You sign, " + sSaid;

    int iFluency = LangFluency(oViewer, iLang);
    string sLine;
    if (iFluency >= DMFI_LANG_NATIVE_LEVEL)
        sLine = DMFI_LANG_SIGN_FLUENT + sSaid;
    else if (iFluency > 0)
    {
        LangGainExposure(oViewer, iLang, oSigner);
        string sWords = LangSignWords(sSaid, iFluency, iLang, oViewer);
        if (sWords == "") sLine = DMFI_LANG_SIGN_NOTHING;
        else sLine = DMFI_LANG_SIGN_PARTIAL + sWords + ".";
    }
    else
        sLine = DMFI_LANG_SIGN_NONE;
    return LangExpandVars(sLine, oSigner);
}

// True when speech goes out as per-listener chat lines (NWNX Chat loaded and
// not turned off). Otherwise the NWScript behavior applies.
int LangNwnxActive()
{
    return GetLocalInt(GetModule(), DMFI_LANG_NWNX_FLAG) && LangCfgNwnxEnabled();
}

// True if translations should also be written to the .lang window log of oPC.
int LangLogWanted(object oPC)
{
    if (GetLocalInt(oPC, DMFI_LANG_VAR_NUI_OFF)) return FALSE;
    if (LangNwnxActive() && !LangCfgNwnxWindowLog()) return FALSE;
    return TRUE;
}

// Delivers sSaid, spoken in iTranslate, to everyone within fRange metres:
//   fluent listeners   the original text
//   partial listeners  a garbled version, and they slowly improve
//   others             the occasional Lore notice
// bBubble also scrambles it over the speaker's head with SpeakString; the
// OnPlayerChat path passes FALSE and sends the scrambled text as the
// speaker's own chat line instead.
void LangSpeak(object oShouter, int iTranslate, string sSaid, float fRange = 20.0, int bBubble = TRUE)
{
    if (!iTranslate || sSaid == "") return;

    string sLanguageName = LangName(iTranslate);
    if (sLanguageName == "") sLanguageName = GetLocalString(oShouter, DMFI_LANG_VAR_SPEAKING_NAME);

    if (iTranslate == 9 && GetStringLength(sSaid) > DMFI_LANG_CANT_MAX_LENGTH)
        sSaid = GetStringLeft(sSaid, DMFI_LANG_CANT_MAX_LENGTH);
    int bSign = LangIsSign(iTranslate);
    // NWNX Chat: one bubble and chat line per listener (lang_nwnx_say). The
    // OnPlayerChat path (bBubble FALSE) is handled by the chat hook instead.
    if (bBubble && !bSign && LangNwnxActive())
    {
        SetLocalInt(oShouter, DMFI_LANG_VAR_DLV_LANG, iTranslate);
        SetLocalString(oShouter, DMFI_LANG_VAR_DLV_TEXT, sSaid);
        SetLocalFloat(oShouter, DMFI_LANG_VAR_DLV_RANGE, fRange);
        ExecuteScript("lang_nwnx_say", oShouter);
        return;
    }
    if (bBubble && !bSign)
        AssignCommand(oShouter, SpeakString(LangSpoken(iTranslate, sSaid, oShouter)));

    int iSpeakerFluency = LangSpeakerFluency(oShouter, iTranslate);

    location lShouter = GetLocation(oShouter);
    object oEavesdrop = GetFirstObjectInShape(SHAPE_SPHERE, fRange, lShouter, FALSE, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(oEavesdrop))
    {
        int bListener = GetIsPC(oEavesdrop) || GetIsDM(oEavesdrop) || GetIsDMPossessed(oEavesdrop);
        // Walls and closed doors block comprehension; DMs hear everything.
        if (bListener && oEavesdrop != oShouter && !GetIsDM(oEavesdrop) && !GetIsDMPossessed(oEavesdrop))
            bListener = LineOfSightObject(oShouter, oEavesdrop);
        if (bListener)
        {
            int iFluency = LangFluency(oEavesdrop, iTranslate);
            string sLine = "";
            if (bSign)
                sLine = LangSignLine(oShouter, oEavesdrop, iTranslate, sSaid);
            else if (oEavesdrop == oShouter)
                sLine = GetName(oShouter) + " says in " + sLanguageName + ": " + LangGarble(sSaid, iFluency, iTranslate, oEavesdrop, oShouter, iSpeakerFluency);
            else if (iFluency >= DMFI_LANG_NATIVE_LEVEL)
                sLine = GetName(oShouter) + " says in " + sLanguageName + ": " + LangGarble(sSaid, iFluency, iTranslate, oEavesdrop, oShouter, iSpeakerFluency);
            else if (iFluency > 0)
            {
                sLine = GetName(oShouter) + " says in " + sLanguageName + " (you catch only part): " + LangGarble(sSaid, iFluency, iTranslate, oEavesdrop, oShouter, iSpeakerFluency);
                LangGainExposure(oEavesdrop, iTranslate, oShouter);
            }
            else
                NoticeLanguage(oEavesdrop, oShouter, iTranslate, sLanguageName);

            if (sLine != "")
            {
                SendMessageToPC(oEavesdrop, sLine);
                // Also show it in the .lang window, if that is open and the player has not turned it off.
                if (LangLogWanted(oEavesdrop) && NuiFindWindow(oEavesdrop, DMFI_LANG_NUI_WINDOW))
                {
                    SetLocalString(oEavesdrop, DMFI_LANG_VAR_NUI_LINE, sLine);
                    ExecuteScript("lang_nui_append", oEavesdrop);
                }
            }
        }
        oEavesdrop = GetNextObjectInShape(SHAPE_SPHERE, fRange, lShouter, FALSE, OBJECT_TYPE_CREATURE);
    }
}

// OnPlayerChat: with talk mode on (.speak <language>), ordinary talk and
// whispers go out as the speaker's own chat line in the scrambled language,
// and listeners get the translation as LangSpeak describes. Returns TRUE if
// the line was handled. Shouts, party and DM chat, emotes (*...*), the voice
// prefixes (. [ :) and DMs are left alone.
int LangHandleTalk(object oPC)
{
    if (!GetLocalInt(oPC, DMFI_LANG_VAR_TALK)) return FALSE;
    if (GetIsDM(oPC) || GetIsDMPossessed(oPC)) return FALSE;

    float fRange;
    int iVolume = GetPCChatVolume();
    if (iVolume == TALKVOLUME_TALK) fRange = DMFI_LANG_RANGE_TALK;
    else if (iVolume == TALKVOLUME_WHISPER) fRange = DMFI_LANG_RANGE_WHISPER;
    else return FALSE;

    string sMsg = GetPCChatMessage();
    if (sMsg == "" || FindSubString(".[*:/", GetStringLeft(sMsg, 1)) != -1) return FALSE;

    int iLang = GetSpokenLanguage(oPC);
    if (!iLang || !GetKnowsLanguage(oPC, iLang)) return FALSE;

    string sScrambled = LangSpoken(iLang, sMsg, oPC);
    if (sScrambled == "") return FALSE;

    // A sign language has no spoken line; LangSpeak sends the descriptions.
    if (LangIsSign(iLang)) SetPCChatMessage("");
    else SetPCChatMessage(sScrambled);
    LangSpeak(oPC, iLang, sMsg, fRange, FALSE);
    return TRUE;
}
