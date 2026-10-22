// dmfi_lang_nui - "Speak in a language" window (.lang).
// ---
// A single pull-down lists Common and the languages the character knows.
// Choosing a language makes it the language the character speaks in, for chat
// and for the Speak button (no widget item needed); choosing Common returns to
// ordinary speech. Below
// it a text box and Speak send the line through LangSpeak exactly as a typed
// [text] would: scrambled in the speech bubble, original text for listeners
// who know the language. Translations of what is said nearby are logged at the
// top; the "Show translations" check box turns that log off. The choice is
// saved on the character (local int lang_nui_off, like the other language
// variables) and the window itself is optional: .lang opens it, nothing else
// requires it. Events are handled by lang_nui_event.
//
// The combo entries carry their list position as value; the position maps back
// to a language id through PC locals set when the window opens.

#include "nw_inc_nui"
#include "dmfi_lang_inc"

const string LANGNUI_EVENT = "lang_nui_event";
const string LANGNUI_BIND_SELECTED = "langsel";
const string LANGNUI_BIND_TEXT = "langtext";
const string LANGNUI_BIND_LOG = "langlog";
const string LANGNUI_VAR_LOG = "langnui_log";
const string LANGNUI_BIND_STATUS = "langstatus";
const string LANGNUI_BIND_SHOW = "langshow";
const string LANGNUI_BIND_LOGVIS = "langlogvis";
const string LANGNUI_SPEAK = "speak";
const string LANGNUI_VAR_COUNT = "langnui_count";
const string LANGNUI_VAR_ID = "langnui_id_";
// Pull-down value for ordinary (common) speech.
const int LANGNUI_COMMON = -1;
const int LANGNUI_MAX_LENGTH = 400;
// Oldest log lines are dropped beyond this many characters.
const int LANGNUI_LOG_MAX_CHARS = 2000;

// Highest id offered in the pull-down (13 = Drow).
const int LANGNUI_LAST_LANGUAGE = 13;

void LangNuiForget(object oPC)
{
    int nCount = GetLocalInt(oPC, LANGNUI_VAR_COUNT);
    int i;
    for (i = 0; i < nCount; i++)
        DeleteLocalInt(oPC, LANGNUI_VAR_ID + IntToString(i));
    DeleteLocalInt(oPC, LANGNUI_VAR_COUNT);
    DeleteLocalString(oPC, LANGNUI_VAR_LOG);
}

// Language id behind pull-down position nIndex, LANGNUI_COMMON for Common, or 0.
int LangNuiLanguageAt(object oPC, int nIndex)
{
    if (nIndex < 0 || nIndex >= GetLocalInt(oPC, LANGNUI_VAR_COUNT)) return 0;
    return GetLocalInt(oPC, LANGNUI_VAR_ID + IntToString(nIndex));
}

// A row holding only jElement: an element alone in a row takes the row's
// whole width, so the field fills the window and follows it when resized.
// fHeight 0.0 leaves the height flexible.
json LangNuiFull(json jElement, float fHeight)
{
    if (fHeight > 0.0) jElement = NuiHeight(jElement, fHeight);
    json jOut = NuiRow(JsonArrayInsert(JsonArray(), jElement));
    if (fHeight > 0.0) jOut = NuiHeight(jOut, fHeight);
    return jOut;
}

json LangNuiLayout(json jEntries)
{
    json jCol = JsonArray();
    jCol = JsonArrayInsert(jCol, LangNuiFull(NuiCheck(JsonString("Show translations in this window"), NuiBind(LANGNUI_BIND_SHOW)), 28.0));
    jCol = JsonArrayInsert(jCol, NuiVisible(LangNuiFull(NuiText(NuiBind(LANGNUI_BIND_LOG), TRUE, NUI_SCROLLBARS_AUTO), 150.0), NuiBind(LANGNUI_BIND_LOGVIS)));
    jCol = JsonArrayInsert(jCol, LangNuiFull(NuiLabel(JsonString("Speak in:"), JsonInt(NUI_HALIGN_LEFT), JsonInt(NUI_VALIGN_MIDDLE)), 24.0));
    jCol = JsonArrayInsert(jCol, LangNuiFull(NuiCombo(jEntries, NuiBind(LANGNUI_BIND_SELECTED)), 32.0));
    jCol = JsonArrayInsert(jCol, LangNuiFull(NuiTextEdit(JsonString("What do you say?"), NuiBind(LANGNUI_BIND_TEXT), LANGNUI_MAX_LENGTH, TRUE), 0.0));
    jCol = JsonArrayInsert(jCol, LangNuiFull(NuiId(NuiButton(JsonString("Speak")), LANGNUI_SPEAK), 34.0));
    jCol = JsonArrayInsert(jCol, LangNuiFull(NuiLabel(NuiBind(LANGNUI_BIND_STATUS), JsonInt(NUI_HALIGN_CENTER), JsonInt(NUI_VALIGN_MIDDLE)), 24.0));
    return NuiCol(jCol);
}

// Status line under the Speak button: how many new languages can still be started.
void LangNuiShowStatus(object oPC, int nToken)
{
    string sStatus = "New languages you can start: " + IntToString(LangSlotsFree(oPC));
    NuiSetBind(oPC, nToken, LANGNUI_BIND_STATUS, JsonString(sStatus));
}

void LangNuiOpen(object oPC)
{
    LangNuiForget(oPC);
    json jEntries = JsonArray();
    int nCount = 0;
    int nSelected = 0;
    int iCurrent = LANGNUI_COMMON;
    if (GetLocalInt(oPC, DMFI_LANG_VAR_TALK)) iCurrent = GetSpokenLanguage(oPC);
    jEntries = JsonArrayInsert(jEntries, NuiComboEntry("Common", nCount));
    SetLocalInt(oPC, LANGNUI_VAR_ID + IntToString(nCount), LANGNUI_COMMON);
    nCount++;
    int iLang;
    for (iLang = 1; iLang <= LANGNUI_LAST_LANGUAGE; iLang++)
    {
        if (!GetKnowsLanguage(oPC, iLang)) continue;
        jEntries = JsonArrayInsert(jEntries, NuiComboEntry(LangName(iLang), nCount));
        SetLocalInt(oPC, LANGNUI_VAR_ID + IntToString(nCount), iLang);
        if (iLang == iCurrent) nSelected = nCount;
        nCount++;
    }
    SetLocalInt(oPC, LANGNUI_VAR_COUNT, nCount);

    int nOld = NuiFindWindow(oPC, DMFI_LANG_NUI_WINDOW);
    if (nOld) NuiDestroy(oPC, nOld);

    json jWin = NuiWindow(LangNuiLayout(jEntries), JsonString("Speak in a language"),
        NuiRect(-1.0, -1.0, 380.0, 500.0), JsonBool(TRUE), JsonBool(FALSE), JsonBool(TRUE), JsonBool(FALSE), JsonBool(TRUE));
    int nToken = NuiCreate(oPC, jWin, DMFI_LANG_NUI_WINDOW, LANGNUI_EVENT);
    NuiSetBind(oPC, nToken, LANGNUI_BIND_SELECTED, JsonInt(nSelected));
    NuiSetBind(oPC, nToken, LANGNUI_BIND_TEXT, JsonString(""));
    NuiSetBind(oPC, nToken, LANGNUI_BIND_LOG, JsonString(""));
    int bShow = !GetLocalInt(oPC, DMFI_LANG_VAR_NUI_OFF);
    NuiSetBind(oPC, nToken, LANGNUI_BIND_SHOW, JsonBool(bShow));
    NuiSetBind(oPC, nToken, LANGNUI_BIND_LOGVIS, JsonBool(bShow));
    NuiSetBindWatch(oPC, nToken, LANGNUI_BIND_SELECTED, TRUE);
    NuiSetBindWatch(oPC, nToken, LANGNUI_BIND_SHOW, TRUE);
    LangNuiShowStatus(oPC, nToken);
}

// Add one understood line to the window's log (called by lang_nui_append).
void LangNuiAppend(object oPC, string sLine)
{
    int nToken = NuiFindWindow(oPC, DMFI_LANG_NUI_WINDOW);
    if (!nToken || GetLocalInt(oPC, DMFI_LANG_VAR_NUI_OFF)) return;

    string sLog = GetLocalString(oPC, LANGNUI_VAR_LOG);
    if (sLog != "") sLog += "\n";
    sLog += sLine;
    int nExcess = GetStringLength(sLog) - LANGNUI_LOG_MAX_CHARS;
    if (nExcess > 0)
    {
        // Cut at the next line break so no line is left half-shown.
        sLog = GetStringRight(sLog, GetStringLength(sLog) - nExcess);
        int iBreak = FindSubString(sLog, "\n");
        if (iBreak != -1) sLog = GetStringRight(sLog, GetStringLength(sLog) - iBreak - 1);
    }
    SetLocalString(oPC, LANGNUI_VAR_LOG, sLog);
    NuiSetBind(oPC, nToken, LANGNUI_BIND_LOG, JsonString(sLog));
}

// Speak button: send the box's text in the selected language.
void LangNuiSubmit(object oPC, int nToken)
{
    int nIndex = JsonGetInt(NuiGetBind(oPC, nToken, LANGNUI_BIND_SELECTED));
    int iLang = LangNuiLanguageAt(oPC, nIndex);
    string sText = JsonGetString(NuiGetBind(oPC, nToken, LANGNUI_BIND_TEXT));
    if (!iLang || sText == "") return;

    if (iLang == LANGNUI_COMMON)
    {
        AssignCommand(oPC, SpeakString(sText));
        NuiSetBind(oPC, nToken, LANGNUI_BIND_TEXT, JsonString(""));
        return;
    }
    // The list was built when the window opened; re-check in case it changed.
    if (!GetKnowsLanguage(oPC, iLang))
    {
        SendMessageToPC(oPC, "You do not speak " + LangName(iLang) + ".");
        return;
    }
    LangSpeak(oPC, iLang, sText);
    NuiSetBind(oPC, nToken, LANGNUI_BIND_TEXT, JsonString(""));
}

// The pull-down changed: the chosen language becomes the one the character
// speaks (talk mode on); Common turns talk mode off.
void LangNuiChooseLanguage(object oPC, int nToken)
{
    int iLang = LangNuiLanguageAt(oPC, JsonGetInt(NuiGetBind(oPC, nToken, LANGNUI_BIND_SELECTED)));
    if (iLang == LANGNUI_COMMON)
    {
        DeleteLocalInt(oPC, DMFI_LANG_VAR_TALK);
        SendMessageToPC(oPC, "You now speak Common.");
        return;
    }
    if (!iLang || !GetKnowsLanguage(oPC, iLang)) return;
    SetSpokenLanguage(oPC, iLang);
    SetLocalInt(oPC, DMFI_LANG_VAR_TALK, 1);
    SendMessageToPC(oPC, "You now speak " + LangName(iLang) + ".");
}

// The "Show translations" check box: saved on the character.
void LangNuiToggleTranslations(object oPC, int nToken)
{
    int bShow = JsonGetInt(NuiGetBind(oPC, nToken, LANGNUI_BIND_SHOW));
    if (bShow) DeleteLocalInt(oPC, DMFI_LANG_VAR_NUI_OFF);
    else SetLocalInt(oPC, DMFI_LANG_VAR_NUI_OFF, 1);
    NuiSetBind(oPC, nToken, LANGNUI_BIND_LOGVIS, JsonBool(bShow));
}
