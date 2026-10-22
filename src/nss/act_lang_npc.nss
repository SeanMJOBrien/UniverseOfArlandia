// act_lang_npc - dialog action: make the NPC speak a language from now on.
// Parameter: language (a name such as "dwarven", or "common" for plain
// speech). Used by Gruk's test dialog (tools/gruk_dialog.py).

#include "dmfi_lang_inc"

void main()
{
    string sName = GetScriptParam("language");
    int iLang = -1;
    if (GetStringLowerCase(sName) != "common") iLang = LangFromName(sName);
    if (iLang == 0) return;
    SetLocalInt(OBJECT_SELF, "npc_language", iLang);
}
