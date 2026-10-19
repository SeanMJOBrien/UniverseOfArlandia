// act_qd - dialog action for the quest-dialog example.
// Parameters: quest, op, and per op:
//   stage     value               set the stage (and journal entry)
//   setflag   name                set qd_<quest>_<name>
//   attempt                       count a wrong answer
//   roll      skill, dc, name     d20 + skill vs DC; sets tried/ok/fail_<name>
//   pay       gold, name          take gold; sets tried_ and ok_<name>
//   complete  xp, gold            finish the quest once, add a caravan lead
//   reset                         forget all quest-dialog progress (testing)
#include "qd_inc"

void main()
{
    object oPC = GetPCSpeaker();
    string sQuest = GetScriptParam("quest");
    string sOp = GetScriptParam("op");
    string sName = GetScriptParam("name");

    if (sOp == "stage") QdSetStage(oPC, sQuest, StringToInt(GetScriptParam("value")));
    else if (sOp == "setflag") QdSetFlag(oPC, sQuest, sName);
    else if (sOp == "attempt") QdSetFlag(oPC, sQuest, "attempts", QdFlag(oPC, sQuest, "attempts") + 1);
    else if (sOp == "roll") QdRoll(oPC, sQuest, GetScriptParam("skill"), StringToInt(GetScriptParam("dc")), sName);
    else if (sOp == "pay")
    {
        int iGold = StringToInt(GetScriptParam("gold"));
        if (GetGold(oPC) < iGold) return;
        TakeGoldFromCreature(iGold, oPC, TRUE);
        QdSetFlag(oPC, sQuest, "tried_" + sName);
        QdSetFlag(oPC, sQuest, "ok_" + sName);
    }
    else if (sOp == "complete") QdComplete(oPC, sQuest, StringToInt(GetScriptParam("xp")), StringToInt(GetScriptParam("gold")));
    else if (sOp == "reset") QdReset(oPC);
}
