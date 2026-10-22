// lang_on_act - module OnActivateItem handler for the language books.
// Set it as the module's OnActivateItem script, or call its logic from an existing one.
#include "dmfi_lang_book"

void main()
{
    object oPC = GetItemActivator();
    object oItem = GetItemActivated();
    if (LangBookIsBook(GetTag(oItem))) LangBookUse(oPC, oItem);
}
