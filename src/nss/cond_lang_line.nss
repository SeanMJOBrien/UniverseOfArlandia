// cond_lang_line - dialog condition: fill a language-aware line's custom token
// for this player and show the node. Parameters: token, text.
// See dmfi_lang_dialog.nss and tools/lang_dialog.py.

#include "dmfi_lang_dialog"

int StartingConditional()
{
    return LangDialogLine(GetPCSpeaker(), OBJECT_SELF);
}
