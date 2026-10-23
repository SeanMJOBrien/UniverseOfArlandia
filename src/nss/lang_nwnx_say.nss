// lang_nwnx_say - run on a speaker by LangSpeak when the NWNX Chat plugin is in
// use: sends the line to each listener as a chat line and speech bubble.
#include "dmfi_lang_nwnx"

void main()
{
    LangNwnxSay(OBJECT_SELF);
}
