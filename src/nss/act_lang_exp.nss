// act_lang_exp - dialog action: the player gains language experience from this NPC.
// Parameters: language (a name such as "dwarven"; default is the NPC's own
// language, npc_language or its racial language), points (default 1).
// Use it where a conversation earns practice, such as a drink bought for a dwarf
// at the tavern. It works with the PC-only setting on and ignores the cooldown, so
// the dialog decides how often it can happen. It gives nothing while advancement
// by listening is off (lang_exp_on) and only to a language the player already
// knows at level 1 to 5.

#include "dmfi_lang_dialog"

void main()
{
    if (!LangCfgExpEnabled()) return;
    object oPC = GetPCSpeaker();
    if (!GetIsObjectValid(oPC)) return;

    int iLang = LangFromName(GetScriptParam("language"));
    if (!iLang) iLang = LangNpcLanguage(OBJECT_SELF);
    if (!iLang) return;

    int iPoints = StringToInt(GetScriptParam("points"));
    if (iPoints < 1) iPoints = 1;
    LangAddExposure(oPC, iLang, iPoints);
}
