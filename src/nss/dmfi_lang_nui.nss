// dmfi_lang_nui - "Speak in a language" window (.lang).
// ---
// A single pull-down lists the languages the character knows, below it a text
// box, and Speak sends the line through LangSpeak exactly as a typed [text]
// would: scrambled in the speech bubble, original text for listeners who know
// the language. Events are handled by lang_nui_event.
//
// The combo entries carry their list position as value; the position maps back
// to a language id through PC locals set when the window opens.

#include "nw_inc_nui"
#include "dmfi_lang_inc"

const string LANGNUI_WINDOW = "langspeak";
const string LANGNUI_EVENT = "lang_nui_event";
const string LANGNUI_BIND_SELECTED = "langsel";
const string LANGNUI_BIND_TEXT = "langtext";
const string LANGNUI_SPEAK = "speak";
const string LANGNUI_VAR_COUNT = "langnui_count";
const string LANGNUI_VAR_ID = "langnui_id_";
const int LANGNUI_MAX_LENGTH = 400;

// Highest id offered in the pull-down (13 = Drow).
const int LANGNUI_LAST_LANGUAGE = 13;

void LangNuiForget(object oPC)
{
    int nCount = GetLocalInt(oPC, LANGNUI_VAR_COUNT);
    int i;
    for (i = 0; i < nCount; i++)
        DeleteLocalInt(oPC, LANGNUI_VAR_ID + IntToString(i));
    DeleteLocalInt(oPC, LANGNUI_VAR_COUNT);
}

// Language id behind pull-down position nIndex, or 0.
int LangNuiLanguageAt(object oPC, int nIndex)
{
    if (nIndex < 0 || nIndex >= GetLocalInt(oPC, LANGNUI_VAR_COUNT)) return 0;
    return GetLocalInt(oPC, LANGNUI_VAR_ID + IntToString(nIndex));
}

json LangNuiLayout(json jEntries)
{
    json jCol = JsonArray();
    jCol = JsonArrayInsert(jCol, NuiHeight(NuiLabel(JsonString("Speak in:"), JsonInt(NUI_HALIGN_LEFT), JsonInt(NUI_VALIGN_MIDDLE)), 24.0));
    jCol = JsonArrayInsert(jCol, NuiHeight(NuiCombo(jEntries, NuiBind(LANGNUI_BIND_SELECTED)), 32.0));
    jCol = JsonArrayInsert(jCol, NuiTextEdit(JsonString("What do you say?"), NuiBind(LANGNUI_BIND_TEXT), LANGNUI_MAX_LENGTH, TRUE));
    jCol = JsonArrayInsert(jCol, NuiHeight(NuiId(NuiButton(JsonString("Speak")), LANGNUI_SPEAK), 34.0));
    return NuiCol(jCol);
}

void LangNuiOpen(object oPC)
{
    LangNuiForget(oPC);
    json jEntries = JsonArray();
    int nCount = 0;
    int nSelected = 0;
    int iCurrent = GetSpokenLanguage(oPC);
    int iLang;
    for (iLang = 1; iLang <= LANGNUI_LAST_LANGUAGE; iLang++)
    {
        if (!GetKnowsLanguage(oPC, iLang)) continue;
        jEntries = JsonArrayInsert(jEntries, NuiComboEntry(LangName(iLang), nCount));
        SetLocalInt(oPC, LANGNUI_VAR_ID + IntToString(nCount), iLang);
        if (iLang == iCurrent) nSelected = nCount;
        nCount++;
    }
    if (nCount == 0)
    {
        SendMessageToPC(oPC, "You do not know any languages yet. Try .learn <language>.");
        return;
    }
    SetLocalInt(oPC, LANGNUI_VAR_COUNT, nCount);

    int nOld = NuiFindWindow(oPC, LANGNUI_WINDOW);
    if (nOld) NuiDestroy(oPC, nOld);

    json jWin = NuiWindow(LangNuiLayout(jEntries), JsonString("Speak in a language"),
        NuiRect(-1.0, -1.0, 380.0, 260.0), JsonBool(TRUE), JsonBool(FALSE), JsonBool(TRUE), JsonBool(FALSE), JsonBool(TRUE));
    int nToken = NuiCreate(oPC, jWin, LANGNUI_WINDOW, LANGNUI_EVENT);
    NuiSetBind(oPC, nToken, LANGNUI_BIND_SELECTED, JsonInt(nSelected));
    NuiSetBind(oPC, nToken, LANGNUI_BIND_TEXT, JsonString(""));
}

// Speak button: send the box's text in the selected language.
void LangNuiSubmit(object oPC, int nToken)
{
    int nIndex = JsonGetInt(NuiGetBind(oPC, nToken, LANGNUI_BIND_SELECTED));
    int iLang = LangNuiLanguageAt(oPC, nIndex);
    string sText = JsonGetString(NuiGetBind(oPC, nToken, LANGNUI_BIND_TEXT));
    if (!iLang || sText == "") return;

    // The list was built when the window opened; re-check in case it changed.
    if (!GetKnowsLanguage(oPC, iLang))
    {
        SendMessageToPC(oPC, "You do not speak " + LangName(iLang) + ".");
        return;
    }
    LangSpeak(oPC, iLang, sText);
    NuiSetBind(oPC, nToken, LANGNUI_BIND_TEXT, JsonString(""));
}
