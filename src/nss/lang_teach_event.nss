// lang_teach_event - NUI event handler for the tutoring windows (.tutor).

#include "dmfi_lang_teach"

void main()
{
    object oPC = NuiGetEventPlayer();
    int nToken = NuiGetEventWindow();
    string sWindow = NuiGetWindowId(oPC, nToken);
    string sEvent = NuiGetEventType();

    if (sWindow == TUTOR_WINDOW)
    {
        if (sEvent == "close") LangTutorForget(oPC);
        else if (sEvent == "click" && NuiGetEventElement() == TUTOR_OFFER) LangTutorOffer(oPC, nToken);
    }
    else if (sWindow == TUTOR_OFFER_WINDOW)
    {
        if (sEvent == "close") LangTutorClearOffer(oPC);
        else if (sEvent == "click")
        {
            string sElement = NuiGetEventElement();
            if (sElement == TUTOR_ACCEPT) LangTutorAnswer(oPC, nToken, TRUE);
            else if (sElement == TUTOR_DECLINE) LangTutorAnswer(oPC, nToken, FALSE);
        }
    }
}
