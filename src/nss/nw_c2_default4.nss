//:://////////////////////////////////////////////////
//:: NW_C2_DEFAULT4
/*
  Default OnConversation event handler for NPCs.

 */
//:://////////////////////////////////////////////////
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 12/22/2002
//:://////////////////////////////////////////////////

#include "nw_i0_generic"

void main()
{
// UOA henchs
if(GetLocalInt(OBJECT_SELF,"Hench")>0){ExecuteScript("nw_ch_ac4",OBJECT_SELF);}else{
// UOA henchs

// UOA
object oPC = GetLastSpeaker();
// Missions
if((GetLocalString(OBJECT_SELF,"Tag")=="mission")&&(GetName(oPC)==GetLocalString(OBJECT_SELF,"Master"))&&(GetMaster(OBJECT_SELF)==OBJECT_INVALID))
 {
BeginConversation("mission",oPC);
 }
// Commoners
else if(GetTag(OBJECT_SELF)=="commoner")
 {
string s;int iRand = Random(5)+1;
     if(iRand==1){s = "Hi";}
else if(iRand==2){s = "Leave me alone, I am busy";}
else if(iRand==3){s = "It is a pleasure to see people like you here";}
else if(iRand==4){s = "Hurry, the shops sell good stuff today";}
else if(iRand==5){s = "You know there are quite dangerous places on this planet";}

SetCustomToken(10064,s);
 }
// UOA

    // * if petrified, jump out
    if (GetHasEffect(EFFECT_TYPE_PETRIFY, OBJECT_SELF) == TRUE)
    {
        return;
    }

    // * If dead, exit directly.
    if (GetIsDead(OBJECT_SELF) == TRUE)
    {
        return;
    }


    // See if what we just 'heard' matches any of our
    // predefined patterns
    int nMatch = GetListenPatternNumber();
    object oShouter = GetLastSpeaker();


    //DMFI CODE ADDITIONS BEGIN HERE
    if (GetIsPC(oShouter) || GetIsDM(oShouter) || GetIsDMPossessed(oShouter))
        {
        ExecuteScript("dmfi_voice_exe", OBJECT_SELF);
        }

    if (nMatch == -1 && GetIsPC(oShouter) &&(GetLocalInt(GetModule(), "dmfi_AllMute") || GetLocalInt(OBJECT_SELF, "dmfi_Mute")))
    {
        SendMessageToAllDMs(GetName(oShouter) + " is trying to speak to a muted NPC, " + GetName(OBJECT_SELF) + ", in area " + GetName(GetArea(OBJECT_SELF)));
        SendMessageToPC(oShouter, "This NPC is muted. A DM will be here shortly.");
        return;
    }
    //DMFI CODE ADDITIONS END HERE



    if (nMatch == -1)
    {
        // Not a match -- start an ordinary conversation
        if (GetCommandable(OBJECT_SELF))
        {
            ClearActions(CLEAR_NW_C2_DEFAULT4_29);
            BeginConversation();
        }
        else
        // * July 31 2004
        // * If only charmed then allow conversation
        // * so you can have a better chance of convincing
        // * people of lowering prices
        if (GetHasEffect(EFFECT_TYPE_CHARMED) == TRUE)
        {
            ClearActions(CLEAR_NW_C2_DEFAULT4_29);
            BeginConversation();
        }
    }
    // Respond to shouts from friendly non-PCs only
    else if (GetIsObjectValid(oShouter)
               && !GetIsPC(oShouter)
               && GetIsFriend(oShouter))
    {
        object oIntruder = OBJECT_INVALID;
        // Determine the intruder if any
        if(nMatch == 4)
        {
            oIntruder = GetLocalObject(oShouter, "NW_BLOCKER_INTRUDER");
        }
        else if (nMatch == 5)
        {
            oIntruder = GetLastHostileActor(oShouter);
            if(!GetIsObjectValid(oIntruder))
            {
                oIntruder = GetAttemptedAttackTarget();
                if(!GetIsObjectValid(oIntruder))
                {
                    oIntruder = GetAttemptedSpellTarget();
                    if(!GetIsObjectValid(oIntruder))
                    {
                        oIntruder = OBJECT_INVALID;
                    }
                }
            }
        }

        // Actually respond to the shout
        RespondToShout(oShouter, nMatch, oIntruder);
    }

    // Send the user-defined event if appropriate
    if(GetSpawnInCondition(NW_FLAG_ON_DIALOGUE_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(EVENT_DIALOGUE));
    }
}}
