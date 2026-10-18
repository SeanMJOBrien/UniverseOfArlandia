// lang_nui_append - run on a PC by LangSpeak (via ExecuteScript) to add the
// line left in DMFI_LANG_VAR_NUI_LINE to that PC's open .lang window.

#include "dmfi_lang_nui"

void main()
{
    object oPC = OBJECT_SELF;
    LangNuiAppend(oPC, GetLocalString(oPC, DMFI_LANG_VAR_NUI_LINE));
    DeleteLocalString(oPC, DMFI_LANG_VAR_NUI_LINE);
}
