// dmfi_lang_teach - one character teaches another a language (.tutor).
// ---
// Needs LANGCFG_TUTOR_ENABLED (or the module variable lang_tutor_on). The teacher
// types .tutor, picks a nearby player character and one of their own languages,
// and presses Offer. The learner gets a second window with Accept and Decline.
// An accepted lesson raises the learner by the lesson gain (lang_tutor_gain, in
// fluency points of 1000) in that language, up to the teacher's own fluency. A new language takes a slot (Intelligence) unless slots
// are ignored (lang_slots_ignore). The same learner can take another lesson in
// the same language only after the cooldown. Events are handled by
// lang_teach_event.

#include "nw_inc_nui"
#include "dmfi_lang_inc"

const string TUTOR_EVENT = "lang_teach_event";
const string TUTOR_WINDOW = "dmfi_lang_tutor";
const string TUTOR_OFFER_WINDOW = "dmfi_lang_tutor_offer";
const string TUTOR_BIND_LEARNER = "tutorlearner";
const string TUTOR_BIND_LANG = "tutorlang";
const string TUTOR_BIND_STATUS = "tutorstatus";
const string TUTOR_BIND_OFFER = "tutoroffer";
const string TUTOR_OFFER = "tutor_offer";
const string TUTOR_ACCEPT = "tutor_accept";
const string TUTOR_DECLINE = "tutor_decline";
// Teacher locals: the entries of the two pull-downs.
const string TUTOR_VAR_LEARNERS = "tutor_n_learners";
const string TUTOR_VAR_LEARNER = "tutor_learner_";
const string TUTOR_VAR_LANGS = "tutor_n_langs";
const string TUTOR_VAR_LANG = "tutor_lang_";
// Learner locals: the offer waiting for an answer.
const string TUTOR_VAR_FROM = "tutor_from";
const string TUTOR_VAR_OFFER_LANG = "tutor_offer_lang";

// The learner's fluency after a lesson: the lesson gain, up to the teacher's own fluency.
int LangTutorResult(object oTeacher, object oLearner, int iLang)
{
    int iNew = LangFluency(oLearner, iLang) + LangCfgTutorGain();
    int iTeacher = LangFluency(oTeacher, iLang);
    if (iNew > iTeacher) iNew = iTeacher;
    return iNew;
}

// "" if oTeacher may give oLearner a lesson in iLang now, else the reason.
string LangTutorCheck(object oTeacher, object oLearner, int iLang)
{
    if (!LangCfgTutorEnabled()) return "Tutoring is not enabled on this module.";
    if (!GetIsObjectValid(oTeacher) || !GetIsObjectValid(oLearner)) return "That character is no longer here.";
    if (oTeacher == oLearner) return "You cannot teach yourself.";
    if (!LangIsLearnable(iLang)) return "That language cannot be taught.";
    if (GetArea(oTeacher) != GetArea(oLearner) || GetDistanceBetween(oTeacher, oLearner) > IntToFloat(LangCfgTutorRange()))
        return GetName(oLearner) + " is too far away.";

    int iTeacherLevel = LangFluency(oTeacher, iLang);
    int iLearnerLevel = LangFluency(oLearner, iLang);
    if (iTeacherLevel < 1) return "You do not speak " + LangName(iLang) + ".";
    if (iLearnerLevel >= DMFI_LANG_FLUENT) return GetName(oLearner) + " already speaks " + LangName(iLang) + " fluently.";
    if (iLearnerLevel >= iTeacherLevel) return GetName(oLearner) + " already knows as much " + LangName(iLang) + " as you do.";
    if (iLearnerLevel == 0 && !LangCfgSlotsIgnore() && LangSlotsFree(oLearner) < 1)
        return GetName(oLearner) + " has no spare language slot.";
    if (GetLocalInt(GetModule(), "lang_tutorcd_" + ObjectToString(oLearner) + "_" + IntToString(iLang)))
        return GetName(oLearner) + " has had a lesson in " + LangName(iLang) + " recently.";
    return "";
}

void LangTutorForget(object oTeacher)
{
    int i;
    for (i = 0; i < GetLocalInt(oTeacher, TUTOR_VAR_LEARNERS); i++) DeleteLocalObject(oTeacher, TUTOR_VAR_LEARNER + IntToString(i));
    for (i = 0; i < GetLocalInt(oTeacher, TUTOR_VAR_LANGS); i++) DeleteLocalInt(oTeacher, TUTOR_VAR_LANG + IntToString(i));
    DeleteLocalInt(oTeacher, TUTOR_VAR_LEARNERS);
    DeleteLocalInt(oTeacher, TUTOR_VAR_LANGS);
}

// A group stretches to the window width; see LangNuiFull in dmfi_lang_nui.
json LangTutorFull(json jElement, float fHeight)
{
    json jGroup = NuiGroup(jElement, FALSE, NUI_SCROLLBARS_NONE);
    if (fHeight > 0.0) jGroup = NuiHeight(jGroup, fHeight);
    return jGroup;
}

void LangTutorOpen(object oTeacher)
{
    if (!LangCfgTutorEnabled())
    {
        SendMessageToPC(oTeacher, "Tutoring is not enabled on this module.");
        return;
    }
    LangTutorForget(oTeacher);

    json jLearners = JsonArray();
    int nLearners = 0;
    object oNear = GetFirstObjectInShape(SHAPE_SPHERE, IntToFloat(LangCfgTutorRange()), GetLocation(oTeacher), TRUE, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(oNear))
    {
        if (oNear != oTeacher && GetIsPC(oNear) && !GetIsDM(oNear))
        {
            jLearners = JsonArrayInsert(jLearners, NuiComboEntry(GetName(oNear), nLearners));
            SetLocalObject(oTeacher, TUTOR_VAR_LEARNER + IntToString(nLearners), oNear);
            nLearners++;
        }
        oNear = GetNextObjectInShape(SHAPE_SPHERE, IntToFloat(LangCfgTutorRange()), GetLocation(oTeacher), TRUE, OBJECT_TYPE_CREATURE);
    }
    json jLangs = JsonArray();
    int nLangs = 0;
    int iLang;
    for (iLang = 1; iLang <= 13; iLang++)
    {
        if (!LangIsLearnable(iLang) || LangFluency(oTeacher, iLang) < 1) continue;
        jLangs = JsonArrayInsert(jLangs, NuiComboEntry(LangName(iLang), nLangs));
        SetLocalInt(oTeacher, TUTOR_VAR_LANG + IntToString(nLangs), iLang);
        nLangs++;
    }
    if (nLearners == 0)
    {
        SendMessageToPC(oTeacher, "No other player character is within " + IntToString(LangCfgTutorRange()) + " metres.");
        return;
    }
    if (nLangs == 0)
    {
        SendMessageToPC(oTeacher, "You know no language you can teach.");
        return;
    }
    SetLocalInt(oTeacher, TUTOR_VAR_LEARNERS, nLearners);
    SetLocalInt(oTeacher, TUTOR_VAR_LANGS, nLangs);

    json jCol = JsonArray();
    jCol = JsonArrayInsert(jCol, LangTutorFull(NuiLabel(JsonString("Teach a language to"), JsonInt(NUI_HALIGN_LEFT), JsonInt(NUI_VALIGN_MIDDLE)), 24.0));
    jCol = JsonArrayInsert(jCol, LangTutorFull(NuiCombo(jLearners, NuiBind(TUTOR_BIND_LEARNER)), 32.0));
    jCol = JsonArrayInsert(jCol, LangTutorFull(NuiLabel(JsonString("Language"), JsonInt(NUI_HALIGN_LEFT), JsonInt(NUI_VALIGN_MIDDLE)), 24.0));
    jCol = JsonArrayInsert(jCol, LangTutorFull(NuiCombo(jLangs, NuiBind(TUTOR_BIND_LANG)), 32.0));
    jCol = JsonArrayInsert(jCol, LangTutorFull(NuiLabel(NuiBind(TUTOR_BIND_STATUS), JsonInt(NUI_HALIGN_CENTER), JsonInt(NUI_VALIGN_MIDDLE)), 44.0));
    jCol = JsonArrayInsert(jCol, LangTutorFull(NuiId(NuiButton(JsonString("Offer lesson")), TUTOR_OFFER), 36.0));

    int nOld = NuiFindWindow(oTeacher, TUTOR_WINDOW);
    if (nOld) NuiDestroy(oTeacher, nOld);
    json jWin = NuiWindow(NuiCol(jCol), JsonString("Teach a language"), NuiRect(-1.0, -1.0, 340.0, 300.0),
        JsonBool(FALSE), JsonBool(FALSE), JsonBool(TRUE), JsonBool(FALSE), JsonBool(TRUE));
    int nToken = NuiCreate(oTeacher, jWin, TUTOR_WINDOW, TUTOR_EVENT);
    NuiSetBind(oTeacher, nToken, TUTOR_BIND_LEARNER, JsonInt(0));
    NuiSetBind(oTeacher, nToken, TUTOR_BIND_LANG, JsonInt(0));
    NuiSetBind(oTeacher, nToken, TUTOR_BIND_STATUS, JsonString("The other character is asked to accept."));
}

// The learner's window: who offers what, with Accept and Decline.
void LangTutorShowOffer(object oTeacher, object oLearner, int iLang)
{
    SetLocalObject(oLearner, TUTOR_VAR_FROM, oTeacher);
    SetLocalInt(oLearner, TUTOR_VAR_OFFER_LANG, iLang);

    int iNext = LangTutorResult(oTeacher, oLearner, iLang);
    string sText = GetName(oTeacher) + " offers to teach you " + LangName(iLang) + " (you would reach " + LangPercent(iNext) + ").";
    json jRow = JsonArray();
    jRow = JsonArrayInsert(jRow, NuiId(NuiButton(JsonString("Accept")), TUTOR_ACCEPT));
    jRow = JsonArrayInsert(jRow, NuiId(NuiButton(JsonString("Decline")), TUTOR_DECLINE));
    json jCol = JsonArray();
    jCol = JsonArrayInsert(jCol, LangTutorFull(NuiLabel(NuiBind(TUTOR_BIND_OFFER), JsonInt(NUI_HALIGN_CENTER), JsonInt(NUI_VALIGN_MIDDLE)), 70.0));
    jCol = JsonArrayInsert(jCol, LangTutorFull(NuiRow(jRow), 36.0));

    int nOld = NuiFindWindow(oLearner, TUTOR_OFFER_WINDOW);
    if (nOld) NuiDestroy(oLearner, nOld);
    json jWin = NuiWindow(NuiCol(jCol), JsonString("A lesson is offered"), NuiRect(-1.0, -1.0, 340.0, 170.0),
        JsonBool(FALSE), JsonBool(FALSE), JsonBool(TRUE), JsonBool(FALSE), JsonBool(TRUE));
    int nToken = NuiCreate(oLearner, jWin, TUTOR_OFFER_WINDOW, TUTOR_EVENT);
    NuiSetBind(oLearner, nToken, TUTOR_BIND_OFFER, JsonString(sText));
}

// Offer button, from the teacher's window.
void LangTutorOffer(object oTeacher, int nToken)
{
    object oLearner = GetLocalObject(oTeacher, TUTOR_VAR_LEARNER + IntToString(JsonGetInt(NuiGetBind(oTeacher, nToken, TUTOR_BIND_LEARNER))));
    int iLang = GetLocalInt(oTeacher, TUTOR_VAR_LANG + IntToString(JsonGetInt(NuiGetBind(oTeacher, nToken, TUTOR_BIND_LANG))));
    string sWhy = LangTutorCheck(oTeacher, oLearner, iLang);
    if (sWhy != "")
    {
        NuiSetBind(oTeacher, nToken, TUTOR_BIND_STATUS, JsonString(sWhy));
        return;
    }
    LangTutorShowOffer(oTeacher, oLearner, iLang);
    NuiSetBind(oTeacher, nToken, TUTOR_BIND_STATUS, JsonString("Offered to " + GetName(oLearner) + ". Waiting for an answer."));
}

void LangTutorClearOffer(object oLearner)
{
    DeleteLocalObject(oLearner, TUTOR_VAR_FROM);
    DeleteLocalInt(oLearner, TUTOR_VAR_OFFER_LANG);
}

// Accept or Decline, from the learner's window.
void LangTutorAnswer(object oLearner, int nToken, int bAccept)
{
    object oTeacher = GetLocalObject(oLearner, TUTOR_VAR_FROM);
    int iLang = GetLocalInt(oLearner, TUTOR_VAR_OFFER_LANG);
    LangTutorClearOffer(oLearner);
    NuiDestroy(oLearner, nToken);
    if (!GetIsObjectValid(oTeacher) || !iLang) return;

    if (!bAccept)
    {
        SendMessageToPC(oTeacher, GetName(oLearner) + " declines the lesson.");
        return;
    }
    string sWhy = LangTutorCheck(oTeacher, oLearner, iLang);
    if (sWhy != "")
    {
        SendMessageToPC(oLearner, sWhy);
        SendMessageToPC(oTeacher, sWhy);
        return;
    }
    int iLevel = LangFluency(oLearner, iLang);
    if (iLevel == 0 && !LangTakeSlot(oLearner))
    {
        SendMessageToPC(oLearner, "You have no spare language slot.");
        return;
    }
    int iResult = LangTutorResult(oTeacher, oLearner, iLang);
    LangListSet(oLearner, iLang, iResult);

    string sKey = "lang_tutorcd_" + ObjectToString(oLearner) + "_" + IntToString(iLang);
    SetLocalInt(GetModule(), sKey, 1);
    AssignCommand(GetModule(), DelayCommand(IntToFloat(LangCfgTutorCooldown()), DeleteLocalInt(GetModule(), sKey)));

    string sResult = LangPercent(iResult);
    SendMessageToPC(oLearner, GetName(oTeacher) + " teaches you " + LangName(iLang) + ". You now have " + sResult + ".");
    SendMessageToPC(oTeacher, "You teach " + GetName(oLearner) + " " + LangName(iLang) + ". They now have " + sResult + ".");
}
