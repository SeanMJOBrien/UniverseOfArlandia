// dmfi_lang_dialog - NPC dialog lines in a language.
// ---
// A dialog node cannot change its text per player, so lines that should be
// language-aware use a custom token as their text (<CUSTOM60000>) and a
// condition script that fills the token just before the node shows. The
// condition script is cond_lang_line, driven by two script parameters on the
// link into the node:
//   token   the custom token number
//   text    the line as a fluent speaker reads it
// tools/lang_dialog.py sets all of this up on a .dlg.json.
//
// The NPC's language is its local int npc_language (a language id from
// dmfi_lang_inc, or -1 for the common tongue). Without it the NPC speaks its
// racial language, if it has one.
//
// What the player reads:
//   fluent (6)    the text as written
//   partial (1-5) a garbled version; listening improves it, as with chat
//   no language   scrambled text in the NPC's language
// Partial and unknown lines are prefixed with the language name.
// A line can be read at a limited level, for an archaic dialect or a worn text:
// the script parameter maxlevel on the link, or the local int npc_lang_cap on
// the speaker (the lower one wins). A fluent reader then reads the line as a
// reader of that level would, with the same unknown words every time. A capped
// line gives no exposure. The script parameter language gives the line a
// language of its own, for a placeable or item that has no npc_language.
// A line can name its dialect (script parameter dialect, or the local string
// npc_lang_dialect on the speaker). An interpreter henchman that has studied the
// dialect (local int lang_dialect_<name> = 1-6 on the henchman) reads the line at
// that level instead of the cap, still held to its own fluency in the language.
// Text between asterisks in a line is narration (what the creature does, not
// says) and is always shown as written. See "narration inside a line" below.
// {id} in a line switches the language of the speech after it, up to the next
// switch ({0} is plain text): one line can carry several languages.
// <race> in a line becomes the NPC's race. A sign language (Drow) is shown as a
// description of the signing instead (see the sign languages in dmfi_lang_inc).

#include "dmfi_lang_inc"

const string DMFI_LANG_NPC_VAR = "npc_language";
const string DMFI_LANG_CAP_VAR = "npc_lang_cap";
const string DMFI_LANG_DIALECT_VAR = "npc_lang_dialect";
const string DMFI_LANG_STUDIED_PREFIX = "lang_dialect_";

// Language id the NPC speaks, or 0 for the common tongue.
int LangNpcLanguage(object oNPC)
{
    int iLang = GetLocalInt(oNPC, DMFI_LANG_NPC_VAR);
    if (iLang < 0) return 0;
    if (iLang > 0) return iLang;
    return GetDefaultRacialLanguage(oNPC, 0);
}

// The level limit for a line: the lower of the line's maxlevel and the speaker's
// npc_lang_cap, ignoring one that is not set. 0 means no limit.
int LangLineCap(object oNPC, int iLineCap)
{
    int iNpcCap = GetLocalInt(oNPC, DMFI_LANG_CAP_VAR);
    if (iNpcCap <= 0 || iNpcCap > DMFI_LANG_NATIVE_LEVEL) iNpcCap = 0;
    if (iLineCap <= 0 || iLineCap > DMFI_LANG_NATIVE_LEVEL) iLineCap = 0;
    if (!iNpcCap) return iLineCap;
    if (!iLineCap) return iNpcCap;
    return iNpcCap < iLineCap ? iNpcCap : iLineCap;
}

// Fluency a reader reads a line at: theirs, held to the line's cap.
int LangCapped(int iFluency, int iCap)
{
    if (iCap > 0 && iFluency > iCap) return iCap;
    return iFluency;
}

// The cap that applies to oReader for a line in sDialect: the line's iCap, raised
// to the level oReader has studied the dialect to. 0 means no cap.
int LangStudiedCap(object oReader, string sDialect, int iCap)
{
    if (iCap <= 0 || sDialect == "") return iCap;
    int iStudied = GetLocalInt(oReader, DMFI_LANG_STUDIED_PREFIX + sDialect);
    if (iStudied >= DMFI_LANG_NATIVE_LEVEL) return 0;
    if (iStudied > iCap) return iStudied;
    return iCap;
}

// --- narration inside a line
// Text between asterisks is narration: what the creature does, not what it says.
// It is shown as written to every reader, in any language. Only the text outside
// the asterisks is speech. Example:
//   *The <race> says,* the water is cold. *The <race> looks around nervously.*
// A line without asterisks is all speech.

const string DMFI_LANG_NARRATION_MARK = "*";
const string DMFI_LANG_SWITCH_OPEN = "{";
const string DMFI_LANG_SWITCH_CLOSE = "}";

int LangHasNarration(string sText)
{
    return FindSubString(sText, DMFI_LANG_NARRATION_MARK) != -1;
}

// The speech parts (bNarration FALSE) or the narration parts (TRUE) of sText,
// joined by a space.
string LangTextParts(string sText, int bNarration)
{
    string sOut = "";
    string sRest = sText;
    int bInNarration = FALSE;
    while (sRest != "")
    {
        string sPart = sRest;
        int iPos = FindSubString(sRest, DMFI_LANG_NARRATION_MARK);
        if (iPos == -1)
            sRest = "";
        else
        {
            sPart = GetStringLeft(sRest, iPos);
            sRest = GetStringRight(sRest, GetStringLength(sRest) - iPos - 1);
        }
        if (GetStringLength(sPart) > 0 && bInNarration == bNarration)
        {
            if (sOut != "") sOut += " ";
            sOut += sPart;
        }
        bInNarration = !bInNarration;
    }
    return sOut;
}

// sSpeech as oPC reads it: garbled, scrambled or as written. Spaces at the ends
// stay, so it joins cleanly to narration beside it. bPrefix adds "(Language) ".
string LangReadSpeech(object oPC, object oNPC, string sSpeech, int iLang, int iFluency, int iCap, int bPrefix)
{
    if (iFluency >= DMFI_LANG_NATIVE_LEVEL) return sSpeech;
    string sLead = "";
    string sTrail = "";
    while (GetStringLeft(sSpeech, 1) == " ")
    {
        sLead = " ";
        sSpeech = GetStringRight(sSpeech, GetStringLength(sSpeech) - 1);
    }
    while (GetStringRight(sSpeech, 1) == " ")
    {
        sTrail = " ";
        sSpeech = GetStringLeft(sSpeech, GetStringLength(sSpeech) - 1);
    }
    if (sSpeech == "") return sLead + sTrail;

    string sPrefix = "";
    string sName = LangName(iLang);
    if (bPrefix && sName != "") sPrefix = "(" + sName + ") ";

    string sRead;
    if (iFluency > 0)
    {
        if (!iCap) LangGainExposure(oPC, iLang, oNPC);
        sRead = sPrefix + LangGarble(sSpeech, iFluency, iLang, oPC);
    }
    else
    {
        sRead = LangScramble(iLang, sSpeech);
        if (sRead == "") sRead = sSpeech;
        else sRead = sPrefix + sRead;
    }
    return sLead + sRead + sTrail;
}

// One speech segment in language iLang as oPC reads it. Language 0 is plain text.
string LangReadSegment(object oPC, object oNPC, string sSpeech, int iLang, int iCap)
{
    if (iLang <= 0) return sSpeech;
    if (LangIsSign(iLang)) return LangSignLine(oNPC, oPC, iLang, sSpeech);
    int iFluency = LangCapped(LangFluency(oPC, iLang), iCap);
    return LangReadSpeech(oPC, oNPC, sSpeech, iLang, iFluency, iCap, FALSE);
}

// A line with narration marks (*...*) or language switches ({id}): reads it part by
// part. {id} switches the language of the speech that follows, until the next
// switch; {0} is plain text. Narration is left as written.
string LangDialogMarked(object oPC, object oNPC, string sText, int iLang, int iCap)
{
    string sOut = "";
    string sRest = sText;
    int bInNarration = FALSE;
    while (sRest != "")
    {
        int iStar = FindSubString(sRest, DMFI_LANG_NARRATION_MARK);
        int iBrace = bInNarration ? -1 : FindSubString(sRest, DMFI_LANG_SWITCH_OPEN);
        if (iBrace != -1 && (iStar == -1 || iBrace < iStar))
        {
            string sBefore = GetStringLeft(sRest, iBrace);
            string sAfter = GetStringRight(sRest, GetStringLength(sRest) - iBrace - 1);
            int iClose = FindSubString(sAfter, DMFI_LANG_SWITCH_CLOSE);
            if (sBefore != "") sOut += LangReadSegment(oPC, oNPC, sBefore, iLang, iCap);
            if (iClose == -1)
            {
                sOut += DMFI_LANG_SWITCH_OPEN;
                sRest = sAfter;
            }
            else
            {
                iLang = StringToInt(GetStringLeft(sAfter, iClose));
                sRest = GetStringRight(sAfter, GetStringLength(sAfter) - iClose - 1);
            }
            continue;
        }
        string sPart = sRest;
        if (iStar == -1)
            sRest = "";
        else
        {
            sPart = GetStringLeft(sRest, iStar);
            sRest = GetStringRight(sRest, GetStringLength(sRest) - iStar - 1);
        }
        if (GetStringLength(sPart) > 0)
        {
            if (bInNarration) sOut += sPart;
            else sOut += LangReadSegment(oPC, oNPC, sPart, iLang, iCap);
        }
        bInNarration = !bInNarration;
    }
    return sOut;
}

// sText as oPC reads it when oNPC says it. iLang overrides the speaker's
// language when above 0; iLineCap is the line's maxlevel (0 for none).
string LangDialogText(object oPC, object oNPC, string sText, int iLang = 0, int iLineCap = 0)
{
    sText = LangExpandVars(sText, oNPC);
    if (!iLang) iLang = LangNpcLanguage(oNPC);
    int iCap = LangLineCap(oNPC, iLineCap);
    if (LangHasNarration(sText) || FindSubString(sText, DMFI_LANG_SWITCH_OPEN) != -1)
        return LangDialogMarked(oPC, oNPC, sText, iLang, iCap);

    if (!iLang) return sText;
    if (LangIsSign(iLang)) return LangSignLine(oNPC, oPC, iLang, sText);
    int iFluency = LangCapped(LangFluency(oPC, iLang), iCap);
    return LangReadSpeech(oPC, oNPC, sText, iLang, iFluency, iCap, TRUE);
}

// For a hand-written condition script: sets nToken to sText as oPC reads it.
void LangDialogToken(object oPC, object oNPC, int nToken, string sText, int iLang = 0, int iLineCap = 0)
{
    SetCustomToken(nToken, LangDialogText(oPC, oNPC, sText, iLang, iLineCap));
}

// --- interpreter henchman
// With lang_interp_on, a henchman who knows the NPC's language states what the
// NPC says, for lines the player does not fully understand. The dialog window is
// unchanged. The translation gives the player no exposure.

const string DMFI_LANG_INTERP_KEY = "lang_interp_key";

// What a henchman of iLevel understands of sText: the whole line at 6, else the
// words it knows with "..." for each run it does not. "" if nothing.
string LangInterpWords(object oHench, int iLang, string sText, int iLevel)
{
    if (iLevel >= DMFI_LANG_NATIVE_LEVEL) return sText;
    string sOut = "";
    int bLastDots = FALSE;
    string sRest = sText;
    int bAny = FALSE;
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
        int bKnows = LangKnowsWord(oHench, iLang, sWord, iLevel);
        if (!bKnows && bLastDots) continue;
        if (sOut != "") sOut += " ";
        if (bKnows) { sOut += sWord; bAny = TRUE; }
        else sOut += "...";
        bLastDots = !bKnows;
    }
    if (!bAny) return "";
    return sOut;
}

// The best henchman of oPC that can interpret iLang (alive, same area, in range),
// or OBJECT_INVALID. The level it provides is its fluency, capped by lang_interp_max_level.
object LangInterpreter(object oPC, int iLang)
{
    object oBest = OBJECT_INVALID;
    int iBest = 0;
    float fRange = IntToFloat(LangCfgInterpRange());
    int nth;
    for (nth = 1; nth <= 8; nth++)
    {
        object oHench = GetHenchman(oPC, nth);
        if (!GetIsObjectValid(oHench)) break;
        if (GetIsDead(oHench) || GetArea(oHench) != GetArea(oPC)) continue;
        if (GetDistanceBetween(oHench, oPC) > fRange) continue;
        int iLevel = LangFluency(oHench, iLang);
        if (iLevel > LangCfgInterpMaxLevel()) iLevel = LangCfgInterpMaxLevel();
        if (iLevel > iBest)
        {
            iBest = iLevel;
            oBest = oHench;
        }
    }
    return oBest;
}

void LangInterpSay(object oHench, string sLine)
{
    AssignCommand(oHench, SpeakString(sLine));
}

// Called as a line is shown. sOptions: optional meanings of replies the player
// cannot read, separated by "|" (script parameter "options").
void LangDialogInterpret(object oPC, object oNPC, string sText, string sOptions, int iLang = 0, int iLineCap = 0, string sDialect = "")
{
    if (!LangCfgInterpEnabled()) return;
    if (!iLang) iLang = LangNpcLanguage(oNPC);
    if (!iLang) return;
    int iCap = LangLineCap(oNPC, iLineCap);
    int iPlayer = LangCapped(LangFluency(oPC, iLang), iCap);
    if (iPlayer >= DMFI_LANG_NATIVE_LEVEL) return;

    object oHench = LangInterpreter(oPC, iLang);
    if (!GetIsObjectValid(oHench)) return;
    int iLevel = LangFluency(oHench, iLang);
    if (iLevel > LangCfgInterpMaxLevel()) iLevel = LangCfgInterpMaxLevel();
    iLevel = LangCapped(iLevel, LangStudiedCap(oHench, sDialect, iCap));
    if (iLevel <= iPlayer) return;

    // A condition can run more than once for one display.
    string sKey = ObjectToString(oNPC) + sText;
    if (GetLocalString(oPC, DMFI_LANG_INTERP_KEY) == sKey) return;
    SetLocalString(oPC, DMFI_LANG_INTERP_KEY, sKey);
    DelayCommand(3.0, DeleteLocalString(oPC, DMFI_LANG_INTERP_KEY));

    // A line that switches language ({id}) is not interpreted.
    if (FindSubString(sText, DMFI_LANG_SWITCH_OPEN) != -1) return;
    // Narration is shown to the player as written; the henchman translates speech only.
    string sPlain = LangExpandVars(sText, oNPC);
    if (LangHasNarration(sPlain)) sPlain = LangTextParts(sPlain, FALSE);
    if (sPlain == "") return;
    string sWords = LangInterpWords(oHench, iLang, sPlain, iLevel);
    string sVerb = LangIsSign(iLang) ? " signs" : " says";
    string sLine;
    if (sWords == "")
        sLine = "I cannot make out a word of it.";
    else if (iLevel >= DMFI_LANG_NATIVE_LEVEL)
        sLine = "The " + LangRaceName(oNPC) + sVerb + ": " + sWords;
    else
        sLine = "The " + LangRaceName(oNPC) + sVerb + ", as best I can tell: " + sWords;
    DelayCommand(0.5, LangInterpSay(oHench, sLine));

    int nOption = 1;
    while (sOptions != "")
    {
        int iBar = FindSubString(sOptions, "|");
        string sOption = sOptions;
        if (iBar == -1)
            sOptions = "";
        else
        {
            sOption = GetStringLeft(sOptions, iBar);
            sOptions = GetStringRight(sOptions, GetStringLength(sOptions) - iBar - 1);
        }
        if (sOption == "") continue;
        DelayCommand(0.5 + IntToFloat(nOption), LangInterpSay(oHench, "Option " + IntToString(nOption) + " means: " + sOption));
        nOption++;
    }
}

// The script-parameter form, used by cond_lang_line. Parameters: token, text,
// and optionally options (meanings of foreign-language replies, separated by "|"),
// maxlevel (read the line at this level at most), language (a language id for
// the line, in place of the speaker's) and dialect (names the dialect for
// henchmen who have studied it).
int LangDialogLine(object oPC, object oNPC)
{
    int nToken = StringToInt(GetScriptParam("token"));
    string sText = GetScriptParam("text");
    if (nToken > 0 && sText != "")
    {
        int iLang = StringToInt(GetScriptParam("language"));
        int iCap = StringToInt(GetScriptParam("maxlevel"));
        string sDialect = GetScriptParam("dialect");
        if (sDialect == "") sDialect = GetLocalString(oNPC, DMFI_LANG_DIALECT_VAR);
        LangDialogToken(oPC, oNPC, nToken, sText, iLang, iCap);
        LangDialogInterpret(oPC, oNPC, sText, GetScriptParam("options"), iLang, iCap, sDialect);
    }
    return TRUE;
}

// An NPC says sText in iLang (default: its own language, see LangNpcLanguage).
// Listeners get a bubble and chat line per listener with the NWNX Chat plugin;
// without it, a scrambled bubble and a translation message. With no language
// the NPC just speaks. For ambient and scripted lines outside dialog windows.
void LangNpcSay(object oNPC, string sText, int iLang = 0)
{
    if (!iLang) iLang = LangNpcLanguage(oNPC);
    sText = LangExpandVars(sText, oNPC);
    if (!iLang)
    {
        AssignCommand(oNPC, SpeakString(sText));
        return;
    }
    LangSpeak(oNPC, iLang, sText);
}
