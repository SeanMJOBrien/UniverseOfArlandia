// act_lang_exp - dialog action: the player gains language experience from this NPC.
// Parameters: language (a name such as "dwarven"; default is the NPC's own
// language, npc_language or its racial language), points (fluency points of 1000;
// default is the listening gain, lang_exp_gain).
// Use it where a conversation earns practice, such as a drink bought for a dwarf
// at the tavern. It works with the PC-only setting on and ignores the cooldown, so
// the dialog decides how often it can happen. It gives nothing while advancement
// by listening is off (lang_exp_on) and only to a language the player already
// knows at least a little and not yet fluently.

#include "dmfi_lang_dialog"

void main()
{
    if (!LangCfgExpEnabled()) return;
    object oPC = GetPCSpeaker();
    if (!GetIsObjectValid(oPC)) return;

    int iLang = LangFromName(GetScriptParam("language"));
    if (!iLang) iLang = LangNpcLanguage(OBJECT_SELF);
    if (!iLang) return;

    LangAddExposure(oPC, iLang, StringToInt(GetScriptParam("points")));
}
