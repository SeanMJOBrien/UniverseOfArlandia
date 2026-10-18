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
// a local string on the PC (",4,10,"). Locals on a PC are saved with the
// character, so the list and the chosen speaking language survive relogs.
//
// Player chat commands (handled by LangChatCommand, called from mod_chat):
//   .lang               open the speaking window (dmfi_lang_nui)
//   .languages          list known languages, the one in use and spare slots
//   .speak <language>   choose the language [text] is spoken in
//   .learn <language>   spend a spare slot (Intelligence bonus) on a language
// DM only:
//   .teach <language>   give the DMFI target a language, no slot needed

const string DMFI_LANG_ALPHABET = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
const int DMFI_LANG_ENTRY_WIDTH = 4;

// Id of the .lang window (dmfi_lang_nui); LangSpeak feeds its log when open.
const string DMFI_LANG_NUI_WINDOW = "langspeak";
const string DMFI_LANG_VAR_NUI_LINE = "langnui_line";

const string DMFI_LANG_VAR_KNOWN = "lang_known";
const string DMFI_LANG_VAR_SLOTS_USED = "lang_slotsused";
const string DMFI_LANG_VAR_SPEAKING = "hls_MyLanguage";
const string DMFI_LANG_VAR_SPEAKING_NAME = "hls_MyLanguageName";

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

int LangListHas(object oPC, int iLang)
{
    return FindSubString(GetLocalString(oPC, DMFI_LANG_VAR_KNOWN), "," + IntToString(iLang) + ",") != -1;
}

void LangListAdd(object oPC, int iLang)
{
    if (LangListHas(oPC, iLang)) return;
    string sKnown = GetLocalString(oPC, DMFI_LANG_VAR_KNOWN);
    if (sKnown == "") sKnown = ",";
    SetLocalString(oPC, DMFI_LANG_VAR_KNOWN, sKnown + IntToString(iLang) + ",");
}

int GetKnowsLanguage(object oPC, int iLang)
{
    if (iLang <= 0) return FALSE;
    if (GetIsDM(oPC) || GetIsDMPossessed(oPC)) return TRUE;
    return GetIsObjectValid(GetItemPossessedBy(oPC, "hlslang_" + IntToString(iLang))) ||
           GetIsObjectValid(GetItemPossessedBy(oPC, "babelfish")) ||
           iLang == GetDefaultRacialLanguage(oPC, 0) ||
           iLang == GetDefaultClassLanguage(oPC) ||
           LangListHas(oPC, iLang);
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
        if (!GetKnowsLanguage(oPC, iLang)) continue;
        if (sOut != "") sOut += ", ";
        sOut += LangName(iLang);
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
    SendMessageToPC(oPC, "You speak: " + LangKnownSummary(oPC));
    SendMessageToPC(oPC, "Speaking in: " + sCurrent + ". Spare language slots: " + IntToString(LangSlotsFree(oPC)));
    SendMessageToPC(oPC, "Say [text] to speak in that language, or [dwarven: text] for one line. .speak <language> changes it, .learn <language> uses a slot.");
}

void LangCmdSpeak(object oPC, string sArg)
{
    if (sArg == "")
    {
        LangCmdList(oPC);
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
    SendMessageToPC(oPC, "You now speak " + LangName(iLang) + " when you say [text]. This is remembered between sessions.");
}

void LangCmdLearn(object oPC, string sArg)
{
    int iLang = LangFromName(sArg);
    if (!iLang || !LangIsLearnable(iLang))
    {
        SendMessageToPC(oPC, "Learnable languages: Elven, Gnome, Halfling, Dwarven, Orc, Goblin, Draconic, Celestial, Abyssal, Infernal, Drow. Spare slots: " + IntToString(LangSlotsFree(oPC)));
        return;
    }
    if (GetKnowsLanguage(oPC, iLang))
    {
        SendMessageToPC(oPC, "You already speak " + LangName(iLang) + ".");
        return;
    }
    if (LangSlotsFree(oPC) < 1)
    {
        SendMessageToPC(oPC, "You have no spare language slots (one per point of Intelligence modifier).");
        return;
    }
    LangListAdd(oPC, iLang);
    SetLocalInt(oPC, DMFI_LANG_VAR_SLOTS_USED, GetLocalInt(oPC, DMFI_LANG_VAR_SLOTS_USED) + 1);
    SendMessageToPC(oPC, "You have learned " + LangName(iLang) + ". It cannot be unlearned.");
}

void LangCmdTeach(object oDM, string sArg)
{
    object oTarget = GetLocalObject(oDM, "dmfi_univ_target");
    if (!GetIsObjectValid(oTarget)) oTarget = GetLocalObject(oDM, "dmfi_VoiceTarget");
    int iLang = LangFromName(sArg);
    if (!GetIsObjectValid(oTarget) || !iLang)
    {
        SendMessageToPC(oDM, ".teach <language> gives the language to your current DMFI target.");
        return;
    }
    LangListAdd(oTarget, iLang);
    SendMessageToPC(oDM, GetName(oTarget) + " now speaks " + LangName(iLang) + ".");
    SendMessageToPC(oTarget, "You have learned " + LangName(iLang) + ".");
}

// Handles .languages, .speak, .learn and .teach. Returns TRUE if the message
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

// Speaks sSaid in iTranslate: scrambled in the speech bubble, with the original
// text sent to every listener within 20m who knows the language.
void LangSpeak(object oShouter, int iTranslate, string sSaid)
{
    if (!iTranslate || sSaid == "") return;

    string sLanguageName = LangName(iTranslate);
    if (sLanguageName == "") sLanguageName = GetLocalString(oShouter, DMFI_LANG_VAR_SPEAKING_NAME);

    if (iTranslate == 9 && GetStringLength(sSaid) > DMFI_LANG_CANT_MAX_LENGTH)
        sSaid = GetStringLeft(sSaid, DMFI_LANG_CANT_MAX_LENGTH);
    AssignCommand(oShouter, SpeakString(TranslateCommonToLanguage(iTranslate, sSaid)));

    location lShouter = GetLocation(oShouter);
    object oEavesdrop = GetFirstObjectInShape(SHAPE_SPHERE, 20.0f, lShouter, FALSE, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(oEavesdrop))
    {
        int bListener = GetIsPC(oEavesdrop) || GetIsDM(oEavesdrop) || GetIsDMPossessed(oEavesdrop);
        // Walls and closed doors block comprehension; DMs hear everything.
        if (bListener && oEavesdrop != oShouter && !GetIsDM(oEavesdrop) && !GetIsDMPossessed(oEavesdrop))
            bListener = LineOfSightObject(oShouter, oEavesdrop);
        if (bListener)
        {
            if (GetKnowsLanguage(oEavesdrop, iTranslate))
            {
                string sLine = GetName(oShouter) + " says in " + sLanguageName + ": " + sSaid;
                SendMessageToPC(oEavesdrop, sLine);
                // Also show it in the .lang window, if that is open.
                if (NuiFindWindow(oEavesdrop, DMFI_LANG_NUI_WINDOW))
                {
                    SetLocalString(oEavesdrop, DMFI_LANG_VAR_NUI_LINE, sLine);
                    ExecuteScript("lang_nui_append", oEavesdrop);
                }
            }
            else
                NoticeLanguage(oEavesdrop, oShouter, iTranslate, sLanguageName);
        }
        oEavesdrop = GetNextObjectInShape(SHAPE_SPHERE, 20.0f, lShouter, FALSE, OBJECT_TYPE_CREATURE);
    }
}
