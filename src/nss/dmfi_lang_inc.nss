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

const string DMFI_LANG_ALPHABET = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
const int DMFI_LANG_ENTRY_WIDTH = 4;

// Id of the .lang window (dmfi_lang_nui); LangSpeak feeds its log when open.
const string DMFI_LANG_NUI_WINDOW = "langspeak";
const string DMFI_LANG_VAR_NUI_LINE = "langnui_line";

const string DMFI_LANG_VAR_TALK = "lang_talk";
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
// Lines heard to leave level n: n * n * this.
const int DMFI_LANG_EXP_UNIT = 20;
// A listener earns at most one exposure point per language in this window.
const float DMFI_LANG_EXP_COOLDOWN = 30.0;
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

int GetDefaultRacialLanguage(object oPC, int iRename)
{
    switch(GetRacialType(oPC))
    {
        case RACIAL_TYPE_DWARF: if (iRename) SetLocalString(oPC, "hls_MyLanguageName", "Dwarven"); return 4; break;
        case RACIAL_TYPE_ELF:
        case RACIAL_TYPE_HALFELF: if (iRename) SetLocalString(oPC, "hls_MyLanguageName", "Elven"); return 1; break;
        case RACIAL_TYPE_GNOME: if (iRename) SetLocalString(oPC, "hls_MyLanguageName", "Gnome"); return 2; break;
        case RACIAL_TYPE_HALFLING: if (iRename) SetLocalString(oPC, "hls_MyLanguageName", "Halfling"); return 3; break;
        case RACIAL_TYPE_HUMANOID_ORC:
        case RACIAL_TYPE_HALFORC: if (iRename) SetLocalString(oPC, "hls_MyLanguageName", "Orc"); return 5; break;
        case RACIAL_TYPE_HUMANOID_GOBLINOID: if (iRename) SetLocalString(oPC, "hls_MyLanguageName", "Goblin"); return 6; break;
        case RACIAL_TYPE_HUMANOID_REPTILIAN:
        case RACIAL_TYPE_DRAGON: if (iRename) SetLocalString(oPC, "hls_MyLanguageName", "Draconic"); return 7; break;
        default: if (GetLevelByClass(CLASS_TYPE_RANGER, oPC) || GetLevelByClass(CLASS_TYPE_DRUID, oPC))
                 {
                    if (iRename) SetLocalString(oPC, "hls_MyLanguageName", "Animal");
                    return 8;
                 }
                 if (GetLevelByClass(CLASS_TYPE_ROGUE, oPC))
                 {
                    if (iRename) SetLocalString(oPC, "hls_MyLanguageName", "Thieves' Cant");
                    return 9;
                 }
                 break;
    }
    return 0;
}

int GetDefaultClassLanguage(object oPC)
{
    if (GetLevelByClass(CLASS_TYPE_RANGER, oPC) || GetLevelByClass(CLASS_TYPE_DRUID, oPC))
        return 8;
    if (GetLevelByClass(CLASS_TYPE_ROGUE, oPC))
        return 9;
    if ((GetSubRace(oPC)=="drow") ||(GetSubRace(oPC)=="DROW")||(GetSubRace(oPC)=="Drow"))
        return 13;

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

void LangListSet(object oPC, int iLang, int iLevel)
{
    string sKnown = LangListWithout(GetLocalString(oPC, DMFI_LANG_VAR_KNOWN), iLang);
    if (sKnown == "") sKnown = ",";
    SetLocalString(oPC, DMFI_LANG_VAR_KNOWN, sKnown + IntToString(iLang) + ":" + IntToString(iLevel) + ",");
}

// 0 = does not know it .. 5 = fluent.
int LangFluency(object oPC, int iLang)
{
    if (iLang <= 0) return 0;
    if (GetIsDM(oPC) || GetIsDMPossessed(oPC)) return DMFI_LANG_NATIVE_LEVEL;
    if (GetIsObjectValid(GetItemPossessedBy(oPC, "hlslang_" + IntToString(iLang))) ||
        GetIsObjectValid(GetItemPossessedBy(oPC, "babelfish")) ||
        iLang == GetDefaultRacialLanguage(oPC, 0) ||
        iLang == GetDefaultClassLanguage(oPC))
        return DMFI_LANG_NATIVE_LEVEL;
    return LangListLevel(oPC, iLang);
}

int GetKnowsLanguage(object oPC, int iLang)
{
    return LangFluency(oPC, iLang) > 0;
}

// Listening to a language you partly know slowly improves it.
void LangGainExposure(object oListener, int iLang)
{
    int iLevel = LangListLevel(oListener, iLang);
    if (iLevel < 1 || iLevel >= DMFI_LANG_NATIVE_LEVEL) return;
    if (LangFluency(oListener, iLang) >= DMFI_LANG_NATIVE_LEVEL) return; // native by other means

    string sCooldown = "lang_expcd_" + ObjectToString(oListener) + "_" + IntToString(iLang);
    if (GetLocalInt(GetModule(), sCooldown)) return;
    SetLocalInt(GetModule(), sCooldown, 1);
    AssignCommand(GetModule(), DelayCommand(DMFI_LANG_EXP_COOLDOWN, DeleteLocalInt(GetModule(), sCooldown)));

    string sVar = DMFI_LANG_VAR_EXP + IntToString(iLang);
    int iExp = GetLocalInt(oListener, sVar) + 1;
    if (iExp >= iLevel * iLevel * DMFI_LANG_EXP_UNIT)
    {
        LangListSet(oListener, iLang, iLevel + 1);
        DeleteLocalInt(oListener, sVar);
        SendMessageToPC(oListener, "Your grasp of " + LangName(iLang) + " has improved to " + IntToString(iLevel + 1) + " of " + IntToString(DMFI_LANG_NATIVE_LEVEL) + ".");
    }
    else
        SetLocalInt(oListener, sVar, iExp);
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
    int iFree = LangSlotsTotal(oPC) - GetLocalInt(oPC, DMFI_LANG_VAR_SLOTS_USED);
    if (iFree < 0) iFree = 0;
    return iFree;
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
    SendMessageToPC(oPC, "Chosen language: " + sCurrent + "; " + sTalk + ". New languages you can still start: " + IntToString(LangSlotsFree(oPC)) + " of " + IntToString(LangSlotsTotal(oPC)));
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
    SendMessageToPC(oPC, "Your normal talk and whispers now come out in " + LangName(iLang) + ". .speak off stops. This is remembered between sessions.");
}

// Languages are learned only from books; the command stays so old tips do not error.
void LangCmdLearn(object oPC, string sArg)
{
    SendMessageToPC(oPC, "Languages are learned from books, not by command. Find a bookshelf and study a primer by activating it. New languages you can still start: " + IntToString(LangSlotsFree(oPC)));
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

// What a listener of partial fluency catches: each word survives with a
// chance of fluency * DMFI_LANG_CHANCE_PER_LEVEL percent; runs of lost words
// become a single "...".
string LangGarble(string sText, int iFluency)
{
    string sOut = "";
    int bLastLost = FALSE;
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
        if (Random(100) < iFluency * DMFI_LANG_CHANCE_PER_LEVEL)
        {
            if (sOut != "") sOut += " ";
            sOut += sWord;
            bLastLost = FALSE;
        }
        else if (!bLastLost)
        {
            if (sOut != "") sOut += " ";
            sOut += "...";
            bLastLost = TRUE;
        }
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

// The words of sText a signer of this fluency gets across: each word is kept
// with a chance of fluency * DMFI_LANG_CHANCE_PER_LEVEL percent, punctuation
// removed. Lost words leave no trace.
string LangSignWords(string sText, int iFluency)
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
        if (Random(100) < iFluency * DMFI_LANG_CHANCE_PER_LEVEL)
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
        LangGainExposure(oViewer, iLang);
        string sWords = LangSignWords(sSaid, iFluency);
        if (sWords == "") sLine = DMFI_LANG_SIGN_NOTHING;
        else sLine = DMFI_LANG_SIGN_PARTIAL + sWords + ".";
    }
    else
        sLine = DMFI_LANG_SIGN_NONE;
    return LangExpandVars(sLine, oSigner);
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
    if (bBubble && !bSign)
        AssignCommand(oShouter, SpeakString(LangScramble(iTranslate, sSaid)));

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
            else if (iFluency >= DMFI_LANG_NATIVE_LEVEL || oEavesdrop == oShouter)
                sLine = GetName(oShouter) + " says in " + sLanguageName + ": " + sSaid;
            else if (iFluency > 0)
            {
                sLine = GetName(oShouter) + " says in " + sLanguageName + " (you catch only part): " + LangGarble(sSaid, iFluency);
                LangGainExposure(oEavesdrop, iTranslate);
            }
            else
                NoticeLanguage(oEavesdrop, oShouter, iTranslate, sLanguageName);

            if (sLine != "")
            {
                SendMessageToPC(oEavesdrop, sLine);
                // Also show it in the .lang window, if that is open.
                if (NuiFindWindow(oEavesdrop, DMFI_LANG_NUI_WINDOW))
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

    string sScrambled = LangScramble(iLang, sMsg);
    if (sScrambled == "") return FALSE;

    // A sign language has no spoken line; LangSpeak sends the descriptions.
    if (LangIsSign(iLang)) SetPCChatMessage("");
    else SetPCChatMessage(sScrambled);
    LangSpeak(oPC, iLang, sMsg, fRange, FALSE);
    return TRUE;
}
