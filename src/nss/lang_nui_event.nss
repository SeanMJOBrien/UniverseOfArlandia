// lang_nui_event - NUI event handler for the language window (.lang).
// Registered per-window via NuiCreate in dmfi_lang_nui.

#include "dmfi_lang_nui"

void main()
{
    object oPC = NuiGetEventPlayer();
    int nToken = NuiGetEventWindow();
    if (NuiGetWindowId(oPC, nToken) != DMFI_LANG_NUI_WINDOW) return;

    string sEvent = NuiGetEventType();
    if (sEvent == "close")
    {
        LangNuiForget(oPC);
        return;
    }
    string sElement = NuiGetEventElement();
    if (sEvent == "watch")
    {
        if (sElement == LANGNUI_BIND_SELECTED)  LangNuiChooseLanguage(oPC, nToken);
        else if (sElement == LANGNUI_BIND_SHOW) LangNuiToggleTranslations(oPC, nToken);
        return;
    }
    if (sEvent != "click") return;

    if (sElement == LANGNUI_SPEAK) LangNuiSubmit(oPC, nToken);
}
