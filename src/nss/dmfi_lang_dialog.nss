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
// <race> in a line becomes the NPC's race. A sign language (Drow) is shown as a
// description of the signing instead (see the sign languages in dmfi_lang_inc).

#include "dmfi_lang_inc"

const string DMFI_LANG_NPC_VAR = "npc_language";

// Language id the NPC speaks, or 0 for the common tongue.
int LangNpcLanguage(object oNPC)
{
    int iLang = GetLocalInt(oNPC, DMFI_LANG_NPC_VAR);
    if (iLang < 0) return 0;
    if (iLang > 0) return iLang;
    return GetDefaultRacialLanguage(oNPC, 0);
}

// sText as oPC reads it when oNPC says it.
string LangDialogText(object oPC, object oNPC, string sText)
{
    sText = LangExpandVars(sText, oNPC);
    int iLang = LangNpcLanguage(oNPC);
    if (!iLang) return sText;
    if (LangIsSign(iLang)) return LangSignLine(oNPC, oPC, iLang, sText);

    int iFluency = LangFluency(oPC, iLang);
    if (iFluency >= DMFI_LANG_NATIVE_LEVEL) return sText;

    string sPrefix = "";
    string sName = LangName(iLang);
    if (sName != "") sPrefix = "(" + sName + ") ";

    if (iFluency > 0)
    {
        LangGainExposure(oPC, iLang, oNPC);
        return sPrefix + LangGarble(sText, iFluency, iLang, oPC);
    }
    string sScrambled = LangScramble(iLang, sText);
    if (sScrambled == "") return sText;
    return sPrefix + sScrambled;
}

// For a hand-written condition script: sets nToken to sText as oPC reads it.
void LangDialogToken(object oPC, object oNPC, int nToken, string sText)
{
    SetCustomToken(nToken, LangDialogText(oPC, oNPC, sText));
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
void LangDialogInterpret(object oPC, object oNPC, string sText, string sOptions)
{
    if (!LangCfgInterpEnabled()) return;
    int iLang = LangNpcLanguage(oNPC);
    if (!iLang) return;
    int iPlayer = LangFluency(oPC, iLang);
    if (iPlayer >= DMFI_LANG_NATIVE_LEVEL) return;

    object oHench = LangInterpreter(oPC, iLang);
    if (!GetIsObjectValid(oHench)) return;
    int iLevel = LangFluency(oHench, iLang);
    if (iLevel > LangCfgInterpMaxLevel()) iLevel = LangCfgInterpMaxLevel();
    if (iLevel <= iPlayer) return;

    // A condition can run more than once for one display.
    string sKey = ObjectToString(oNPC) + sText;
    if (GetLocalString(oPC, DMFI_LANG_INTERP_KEY) == sKey) return;
    SetLocalString(oPC, DMFI_LANG_INTERP_KEY, sKey);
    DelayCommand(3.0, DeleteLocalString(oPC, DMFI_LANG_INTERP_KEY));

    string sPlain = LangExpandVars(sText, oNPC);
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
// and optionally options (meanings of foreign-language replies, separated by "|").
int LangDialogLine(object oPC, object oNPC)
{
    int nToken = StringToInt(GetScriptParam("token"));
    string sText = GetScriptParam("text");
    if (nToken > 0 && sText != "")
    {
        LangDialogToken(oPC, oNPC, nToken, sText);
        LangDialogInterpret(oPC, oNPC, sText, GetScriptParam("options"));
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
