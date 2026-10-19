// cond_qd - dialog condition for the quest-dialog example.
// Parameters: quest (miller, envoy, ledger, caravan), op, value, name, not=1
// to invert. Ops:
//   stage_eq / stage_lt / stage_ge   quest stage against value
//   flag / noflag                    qd_<quest>_<name> set / not set
//   gold                             the PC carries at least value gold
//   attempts_ge                      wrong answers so far >= value
//   leads_eq / leads_ge              caravan leads held, against value
//   finale_ready                     caravan accepted, not done, all leads held
// Language checks use cond_lang_know instead.
#include "qd_inc"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    string sQuest = GetScriptParam("quest");
    string sOp = GetScriptParam("op");
    int iValue = StringToInt(GetScriptParam("value"));
    string sName = GetScriptParam("name");

    int bResult = FALSE;
    if (sOp == "stage_eq") bResult = QdStage(oPC, sQuest) == iValue;
    else if (sOp == "stage_lt") bResult = QdStage(oPC, sQuest) < iValue;
    else if (sOp == "stage_ge") bResult = QdStage(oPC, sQuest) >= iValue;
    else if (sOp == "flag") bResult = QdFlag(oPC, sQuest, sName) != 0;
    else if (sOp == "noflag") bResult = QdFlag(oPC, sQuest, sName) == 0;
    else if (sOp == "gold") bResult = GetGold(oPC) >= iValue;
    else if (sOp == "attempts_ge") bResult = QdFlag(oPC, sQuest, "attempts") >= iValue;
    else if (sOp == "leads_eq") bResult = QdLeads(oPC) == iValue;
    else if (sOp == "leads_ge") bResult = QdLeads(oPC) >= iValue;
    else if (sOp == "finale_ready")
        bResult = QdStage(oPC, "caravan") == QD_STAGE_ACCEPTED && QdLeads(oPC) >= QD_LEADS_NEEDED;

    if (GetScriptParam("not") == "1") return !bResult;
    return bResult;
}
