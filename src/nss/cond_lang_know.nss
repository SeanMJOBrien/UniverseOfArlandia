// cond_lang_know - dialog condition: TRUE if the player speaks a language.
// Parameters: language (name, e.g. "dwarven"), optional level (minimum
// fluency 1-5, default 1), optional not=1 to invert (show when they do not).
// For reply options like "[Dwarven] Well met, friend." or alternate branches.

#include "dmfi_lang_inc"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iLang = LangFromName(GetScriptParam("language"));
    int iNeeded = StringToInt(GetScriptParam("level"));
    if (iNeeded < 1) iNeeded = 1;

    int bKnows = iLang && LangFluency(oPC, iLang) >= iNeeded;
    if (GetScriptParam("not") == "1") return !bKnows;
    return bKnows;
}
