// lang_on_chat - module OnPlayerChat handler for the language system.
// Set it as the module's OnPlayerChat script, or call its logic from an existing one.
#include "dmfi_lang_nui"

void main()
{
    object oPC = GetPCChatSpeaker();
    string sMsg = GetPCChatMessage();

    if (GetStringLeft(sMsg, 1) == ".")
    {
        string sCmd = GetStringLowerCase(sMsg);
        while (GetStringRight(sCmd, 1) == " ") sCmd = GetStringLeft(sCmd, GetStringLength(sCmd) - 1);
        if (sCmd == ".lang")
        {
            SetPCChatMessage("");
            LangNuiOpen(oPC);
            return;
        }
        if (LangChatCommand(oPC, sMsg))
        {
            SetPCChatMessage("");
            return;
        }
    }

    // Talk mode: ordinary talk and whispers come out in the chosen language.
    LangHandleTalk(oPC);
}
