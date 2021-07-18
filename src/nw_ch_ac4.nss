//::///////////////////////////////////////////////
//:: Associate: On Dialogue
//:: NW_CH_AC4
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Determines the course of action to be taken
    by the generic script after dialogue or a
    shout is initiated.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 24, 2001
//:://////////////////////////////////////////////


#include "x0_inc_henai"
// * This function checks to make sure no
// * dehibilating effects are on the player that should
// * Don't use getcommandable for this since the dying system
// * will sometimes leave a player in a noncommandable state
int AbleToTalk(object oSelf)
{
    if (GetCommandable(oSelf) == FALSE)
    {
        if (GetHasEffect(EFFECT_TYPE_CONFUSED, oSelf) || GetHasEffect(EFFECT_TYPE_DOMINATED, oSelf) ||
            GetHasEffect(EFFECT_TYPE_PETRIFY, oSelf) || GetHasEffect(EFFECT_TYPE_PARALYZE, oSelf)   ||
            GetHasEffect(EFFECT_TYPE_STUNNED, oSelf) || GetHasEffect(EFFECT_TYPE_FRIGHTENED, oSelf)
        )
        {
            return FALSE;
        }
    }
    return TRUE;
}
void main()
{
    object oPC = GetLastSpeaker();
    object oMaster = GetMaster();
    int nMatch = GetListenPatternNumber();
    object oShouter = GetLastSpeaker();
    object oIntruder;
    string sDialog = "hench";

    //DMFI CODE ADDITIONS BEGIN HERE
    if (!GetIsInCombat(OBJECT_SELF))
        ExecuteScript("dmfi_voice_exe", OBJECT_SELF);
    //DMFI CODE ADDITIONS END HERE

    if (nMatch == -1) {
        if(AbleToTalk(OBJECT_SELF) || GetCurrentAction() != ACTION_OPENLOCK)
        {
            ClearActions(CLEAR_NW_CH_AC4_28);

            // * if in XP2, use an alternative dialog file
            if (GetLocalInt(GetModule(), "X2_L_XP2") ==  1)
            {
                sDialog = "hench";
            }
            BeginConversation(sDialog);
        }
    } else {
        // listening pattern matched
        if (GetIsObjectValid(oShouter) && oMaster == oShouter)
        {
            SetCommandable(TRUE);
            bkRespondToHenchmenShout(oShouter, nMatch, oIntruder, TRUE);
        }
    }

    // Signal user-defined event
    if(GetSpawnInCondition(NW_FLAG_ON_DIALOGUE_EVENT)) {
        SignalEvent(OBJECT_SELF, EventUserDefined(EVENT_DIALOGUE));
    }
// UOA Henchs command
if(GetLastAssociateCommand()==ASSOCIATE_COMMAND_ATTACKNEAREST){ActionAttack(GetAttackTarget(oMaster));}
else if(GetLastAssociateCommand()==ASSOCIATE_COMMAND_LEAVEPARTY){if(GetTag(GetArea(oMaster))==""){SetImmortal(OBJECT_SELF,FALSE);SetPlotFlag(OBJECT_SELF,FALSE);SetIsDestroyable(TRUE,FALSE,FALSE);DestroyObject(OBJECT_SELF);}else{DelayCommand(0.5,AddHenchman(oMaster,OBJECT_SELF));}}
//
DeleteLocalInt(OBJECT_SELF,"Tracking");
}
