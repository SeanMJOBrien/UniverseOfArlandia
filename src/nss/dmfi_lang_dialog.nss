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
//   fluent (5)    the text as written
//   partial (1-4) a garbled version; listening improves it, as with chat
//   no language   scrambled text in the NPC's language
// Partial and unknown lines are prefixed with the language name.

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
    int iLang = LangNpcLanguage(oNPC);
    if (!iLang) return sText;

    int iFluency = LangFluency(oPC, iLang);
    if (iFluency >= DMFI_LANG_NATIVE_LEVEL) return sText;

    string sPrefix = "";
    string sName = LangName(iLang);
    if (sName != "") sPrefix = "(" + sName + ") ";

    if (iFluency > 0)
    {
        LangGainExposure(oPC, iLang);
        return sPrefix + LangGarble(sText, iFluency);
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

// The script-parameter form, used by cond_lang_line.
int LangDialogLine(object oPC, object oNPC)
{
    int nToken = StringToInt(GetScriptParam("token"));
    string sText = GetScriptParam("text");
    if (nToken > 0 && sText != "")
        LangDialogToken(oPC, oNPC, nToken, sText);
    return TRUE;
}
