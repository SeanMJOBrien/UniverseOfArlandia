// NWNX Chat front end for the language system. With NWNX_CHAT enabled, an
// ordinary talk or whisper from a speaker in talk mode is replaced by one
// real chat line per listener, so each listener's speech bubble and chat log
// carry what that listener understands:
//   fluent listeners   the original text
//   partial listeners  a garbled version (and they slowly improve)
//   others             the scrambled language
// Needs NWNX_CHAT_SKIP=no. lang_nwnx_chat is registered from mod_load.
#include "nwnx_chat"
#include "dmfi_lang_inc"

const string DMFI_LANG_NWNX_SCRIPT = "lang_nwnx_chat";

// Called once from mod_load.
// The Chat plugin answers a hearing-distance query with a positive number
// when it is loaded; an unloaded plugin returns 0.0. Only a working plugin
// switches the module over, so the NWScript talk mode stays in use otherwise.
void LangNwnxInit()
{
    if (NWNX_Chat_GetChatHearingDistance() <= 0.0)
    {
        WriteTimestampedLogEntry("Language system: NWNX Chat not loaded, using the NWScript talk mode.");
        return;
    }
    if (!LangCfgNwnxEnabled())
    {
        WriteTimestampedLogEntry("Language system: NWNX Chat loaded but switched off (lang_nwnx_on), using the NWScript talk mode.");
        return;
    }
    NWNX_Chat_RegisterChatScript(DMFI_LANG_NWNX_SCRIPT);
    SetLocalInt(GetModule(), DMFI_LANG_NWNX_FLAG, TRUE);
    WriteTimestampedLogEntry("Language system: NWNX Chat active.");
}

void LangNwnxLog(object oListener, string sLine)
{
    if (!LangLogWanted(oListener) || !NuiFindWindow(oListener, DMFI_LANG_NUI_WINDOW)) return;
    SetLocalString(oListener, DMFI_LANG_VAR_NUI_LINE, sLine);
    ExecuteScript("lang_nui_append", oListener);
}

// Sends sSaid, spoken by oSpeaker in iLang, to every listener within fRange.
void LangNwnxSpeak(object oSpeaker, int iChannel, int iLang, string sSaid, float fRange)
{
    string sName = LangName(iLang);
    if (iLang == 9 && GetStringLength(sSaid) > DMFI_LANG_CANT_MAX_LENGTH)
        sSaid = GetStringLeft(sSaid, DMFI_LANG_CANT_MAX_LENGTH);
    string sTag = "[" + sName + "] ";
    string sScrambled = LangSpoken(iLang, sSaid, oSpeaker);
    int iSpeakerFluency = LangSpeakerFluency(oSpeaker, iLang);

    location lSpeaker = GetLocation(oSpeaker);
    object oListener = GetFirstObjectInShape(SHAPE_SPHERE, fRange, lSpeaker, FALSE, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(oListener))
    {
        int bHears = GetIsPC(oListener) || GetIsDM(oListener) || GetIsDMPossessed(oListener);
        if (bHears && oListener != oSpeaker && !GetIsDM(oListener) && !GetIsDMPossessed(oListener))
            bHears = LineOfSightObject(oSpeaker, oListener);
        if (bHears)
        {
            int iFluency = LangFluency(oListener, iLang);
            string sLine;
            if (oListener == oSpeaker || iFluency >= DMFI_LANG_NATIVE_LEVEL)
                sLine = sTag + LangGarble(sSaid, iFluency, iLang, oListener, oSpeaker, iSpeakerFluency);
            else if (iFluency > 0)
            {
                sLine = sTag + LangGarble(sSaid, iFluency, iLang, oListener, oSpeaker, iSpeakerFluency);
                LangGainExposure(oListener, iLang, oSpeaker);
            }
            else
            {
                sLine = sScrambled;
                NoticeLanguage(oListener, oSpeaker, iLang, sName);
            }
            NWNX_Chat_SendMessage(iChannel, sLine, oSpeaker, oListener);
            LangNwnxLog(oListener, GetName(oSpeaker) + " says in " + sName + ": " + sLine);
        }
        oListener = GetNextObjectInShape(SHAPE_SPHERE, fRange, lSpeaker, FALSE, OBJECT_TYPE_CREATURE);
    }
}

// The registered chat script body. Returns nothing; skips the original
// message when the language system takes the line over.
void LangNwnxHandleChat()
{
    object oSpeaker = NWNX_Chat_GetSender();
    if (!GetIsPC(oSpeaker) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker)) return;
    if (!GetLocalInt(oSpeaker, DMFI_LANG_VAR_TALK)) return;

    int iChannel = NWNX_Chat_GetChannel();
    float fRange;
    if (iChannel == NWNX_CHAT_CHANNEL_PLAYER_TALK) fRange = DMFI_LANG_RANGE_TALK;
    else if (iChannel == NWNX_CHAT_CHANNEL_PLAYER_WHISPER) fRange = DMFI_LANG_RANGE_WHISPER;
    else return;

    string sMsg = NWNX_Chat_GetMessage();
    if (sMsg == "" || FindSubString(".[*:/", GetStringLeft(sMsg, 1)) != -1) return;

    int iLang = GetSpokenLanguage(oSpeaker);
    if (!iLang || !GetKnowsLanguage(oSpeaker, iLang)) return;
    if (!LangIsSign(iLang) && LangScramble(iLang, sMsg) == "") return;

    NWNX_Chat_SkipMessage();
    // A sign language has no spoken line; LangSpeak sends the descriptions.
    if (LangIsSign(iLang)) LangSpeak(oSpeaker, iLang, sMsg, fRange, FALSE);
    else LangNwnxSpeak(oSpeaker, iChannel, iLang, sMsg, fRange);
}

// Run on the speaker by LangSpeak (ExecuteScript lang_nwnx_say): delivers the
// line stored in the delivery locals as per-listener chat lines.
void LangNwnxSay(object oSpeaker)
{
    int iLang = GetLocalInt(oSpeaker, DMFI_LANG_VAR_DLV_LANG);
    string sSaid = GetLocalString(oSpeaker, DMFI_LANG_VAR_DLV_TEXT);
    float fRange = GetLocalFloat(oSpeaker, DMFI_LANG_VAR_DLV_RANGE);
    DeleteLocalInt(oSpeaker, DMFI_LANG_VAR_DLV_LANG);
    DeleteLocalString(oSpeaker, DMFI_LANG_VAR_DLV_TEXT);
    DeleteLocalFloat(oSpeaker, DMFI_LANG_VAR_DLV_RANGE);
    if (!iLang || sSaid == "") return;

    int iChannel = NWNX_CHAT_CHANNEL_PLAYER_TALK;
    if (fRange <= DMFI_LANG_RANGE_WHISPER) iChannel = NWNX_CHAT_CHANNEL_PLAYER_WHISPER;
    LangNwnxSpeak(oSpeaker, iChannel, iLang, sSaid, fRange);
}
