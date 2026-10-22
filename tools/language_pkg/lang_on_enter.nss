#include "dmfi_lang_inc"
// Module OnClientEnter handler for the language system (standalone).
void main()
{
    object oPC = GetEnteringObject();
    if (!GetIsPC(oPC)) return;
    LangLoad(oPC);
    DelayCommand(15.0, SendMessageToPC(oPC, "Tip: .lang opens a window to speak in any language you know. .speak <language> makes your normal talk come out in it (.speak off stops); .languages lists what you know and books teach more."));
}
