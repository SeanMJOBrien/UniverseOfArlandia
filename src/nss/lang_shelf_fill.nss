// Language bookshelf: keeps one copy of every language book on the shelf.
// Wired to the lang_bookshelf placeable's OnOpen and OnClosed. Players may take
// books; the shelf restocks whatever is missing when it is opened or closed.
#include "dmfi_lang_book"

// Volumes of every learnable language the shelf stocks.
const int LANG_SHELF_LAST_LANGUAGE = 13;

void LangShelfRestock(object oShelf)
{
    int iLang;
    int iVolume;
    for (iLang = 1; iLang <= LANG_SHELF_LAST_LANGUAGE; iLang++)
    {
        if (!LangIsLearnable(iLang)) continue;
        for (iVolume = 1; iVolume <= DMFI_LANG_BOOK_VOLUMES; iVolume++)
        {
            string sResRef = DMFI_LANG_BOOK_PREFIX + IntToString(iLang) + "_" + IntToString(iVolume);
            if (!GetIsObjectValid(GetItemPossessedBy(oShelf, sResRef)))
                CreateItemOnObject(sResRef, oShelf);
        }
    }
}

void main()
{
    if (GetObjectType(OBJECT_SELF) != OBJECT_TYPE_PLACEABLE) return;
    LangShelfRestock(OBJECT_SELF);
}
