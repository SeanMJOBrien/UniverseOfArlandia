// qd_inc - state and helpers for the quest-dialog example (quest_demo.dlg).
// ---
// All state lives on the PC as local ints, which the .bic file keeps, so a
// quest resumes after logout:
//   qd_<quest>_stage        0 not started, 1 accepted, 9 complete
//   qd_<quest>_<flag>       any named flag (tried_*, ok_*, fail_*, lead_*, ...)
//   qd_<quest>_attempts     wrong answers so far
// The journal category tag is qd_<quest>; the entry id is the stage.
//
// Quests: miller (persuasion), envoy (language), ledger (logic), caravan
// (umbrella: each of the three others adds a lead_<quest> flag to it).

const int QD_STAGE_ACCEPTED = 1;
const int QD_STAGE_DONE = 9;
const int QD_LEADS_NEEDED = 3;

string QdKey(string sQuest, string sName)
{
    return "qd_" + sQuest + "_" + sName;
}

int QdStage(object oPC, string sQuest)
{
    return GetLocalInt(oPC, QdKey(sQuest, "stage"));
}

void QdSetStage(object oPC, string sQuest, int iStage)
{
    SetLocalInt(oPC, QdKey(sQuest, "stage"), iStage);
    AddJournalQuestEntry("qd_" + sQuest, iStage, oPC, FALSE, FALSE, FALSE);
}

int QdFlag(object oPC, string sQuest, string sName)
{
    return GetLocalInt(oPC, QdKey(sQuest, sName));
}

void QdSetFlag(object oPC, string sQuest, string sName, int iValue = 1)
{
    SetLocalInt(oPC, QdKey(sQuest, sName), iValue);
}

// How many of the three leads the PC holds (the caravan quest's lead_* flags).
int QdLeads(object oPC)
{
    return QdFlag(oPC, "caravan", "lead_miller") + QdFlag(oPC, "caravan", "lead_envoy") + QdFlag(oPC, "caravan", "lead_ledger");
}

int QdSkillFromName(string sSkill)
{
    sSkill = GetStringLowerCase(sSkill);
    if (sSkill == "persuade") return SKILL_PERSUADE;
    if (sSkill == "intimidate") return SKILL_INTIMIDATE;
    if (sSkill == "bluff") return SKILL_BLUFF;
    if (sSkill == "lore") return SKILL_LORE;
    if (sSkill == "search") return SKILL_SEARCH;
    return -1;
}

// d20 + skill rank against iDC, once per approach: sets tried_<name> and
// either ok_<name> or fail_<name>, and tells the player the numbers.
int QdRoll(object oPC, string sQuest, string sSkill, int iDC, string sName)
{
    int iSkill = QdSkillFromName(sSkill);
    if (iSkill < 0) return FALSE;

    int iDie = d20();
    int iRank = GetSkillRank(iSkill, oPC);
    int bPass = iDie + iRank >= iDC;
    SendMessageToPC(oPC, GetStringUpperCase(GetStringLeft(sSkill, 1)) + GetStringRight(sSkill, GetStringLength(sSkill) - 1)
        + ": d20 " + IntToString(iDie) + " + " + IntToString(iRank) + " = " + IntToString(iDie + iRank)
        + " vs DC " + IntToString(iDC) + (bPass ? " - success." : " - failure."));

    QdSetFlag(oPC, sQuest, "tried_" + sName);
    QdSetFlag(oPC, sQuest, "ok_" + sName, bPass);
    QdSetFlag(oPC, sQuest, "fail_" + sName, !bPass);
    return bPass;
}

// Finishes a quest once: stage 9, reward, and a lead for the caravan quest.
void QdComplete(object oPC, string sQuest, int iXP, int iGold)
{
    if (QdStage(oPC, sQuest) >= QD_STAGE_DONE) return;
    QdSetStage(oPC, sQuest, QD_STAGE_DONE);
    if (iXP > 0) GiveXPToCreature(oPC, iXP);
    if (iGold > 0) GiveGoldToCreature(oPC, iGold);
    if (sQuest != "caravan")
    {
        QdSetFlag(oPC, "caravan", "lead_" + sQuest);
        SendMessageToPC(oPC, "You have a new lead on the lost caravan (" + IntToString(QdLeads(oPC)) + " of " + IntToString(QD_LEADS_NEEDED) + ").");
    }
}

// Test aid: forgets every quest-dialog variable and journal entry.
void QdReset(object oPC)
{
    string sQuests = "miller,envoy,ledger,caravan";
    string sNames = "stage,attempts,gist,misread,lead_miller,lead_envoy,lead_ledger,"
        + "tried_persuade,ok_persuade,fail_persuade,tried_intimidate,ok_intimidate,fail_intimidate,"
        + "tried_bribe,ok_bribe,tried_gist,ok_gist,fail_gist,tried_decipher,ok_decipher,fail_decipher";
    string sQ = sQuests;
    while (sQ != "")
    {
        int iComma = FindSubString(sQ, ",");
        string sQuest = iComma == -1 ? sQ : GetStringLeft(sQ, iComma);
        sQ = iComma == -1 ? "" : GetStringRight(sQ, GetStringLength(sQ) - iComma - 1);

        string sN = sNames;
        while (sN != "")
        {
            int iSep = FindSubString(sN, ",");
            string sName = iSep == -1 ? sN : GetStringLeft(sN, iSep);
            sN = iSep == -1 ? "" : GetStringRight(sN, GetStringLength(sN) - iSep - 1);
            DeleteLocalInt(oPC, QdKey(sQuest, sName));
        }
        RemoveJournalQuestEntry("qd_" + sQuest, oPC, FALSE, FALSE);
    }
    SendMessageToPC(oPC, "Quest progress reset.");
}
