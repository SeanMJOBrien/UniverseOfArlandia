// Run by mod_activate for lang_book_* items; mod_activate stores the item on the PC.
#include "dmfi_lang_book"

void main()
{
    object oPC = OBJECT_SELF;
    object oBook = GetLocalObject(oPC, "ItemActivated");
    DeleteLocalObject(oPC, "ItemActivated");
    if (GetIsObjectValid(oBook)) LangBookUse(oPC, oBook);
}
