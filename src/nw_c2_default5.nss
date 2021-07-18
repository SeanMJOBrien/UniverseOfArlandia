//::///////////////////////////////////////////////
//:: Default On Attacked
//:: NW_C2_DEFAULT5
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    If already fighting then ignore, else determine
    combat round
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 16, 2001
//:://////////////////////////////////////////////

#include "nw_i0_generic"

//DMFI CODE ADDITIONS*****************************
void SafeFaction(object oCurrent, object oAttacker)
{
        AssignCommand(oAttacker, ClearAllActions());
        AssignCommand(oCurrent, ClearAllActions());
        // * Note: waiting for Sophia to make SetStandardFactionReptuation to clear all personal reputation
        if (GetStandardFactionReputation(STANDARD_FACTION_COMMONER, oAttacker) <= 10)
        {   SetLocalInt(oAttacker, "NW_G_Playerhasbeenbad", 10); // * Player bad
            SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 80, oAttacker);
        }
        if (GetStandardFactionReputation(STANDARD_FACTION_MERCHANT, oAttacker) <= 10)
        {   SetLocalInt(oAttacker, "NW_G_Playerhasbeenbad", 10); // * Player bad
            SetStandardFactionReputation(STANDARD_FACTION_MERCHANT, 80, oAttacker);
        }
        if (GetStandardFactionReputation(STANDARD_FACTION_DEFENDER, oAttacker) <= 10)
        {   SetLocalInt(oAttacker, "NW_G_Playerhasbeenbad", 10); // * Player bad
            SetStandardFactionReputation(STANDARD_FACTION_DEFENDER, 80, oAttacker);
        }


}
//END DMFI CODE ADDITIONS*************************

void main()
{
object oAttacker = GetLastAttacker();
//DMFI CODE ADDITIONS*****************************
    if ((GetIsPC(GetLastAttacker()) && (GetLocalInt(GetModule(), "dmfi_safe_factions")==1)))
        {
        SafeFaction(OBJECT_SELF, GetLastAttacker());
        SpeakString("DM ALERT:  Default non-hostile faction member attacked.  Player: "+GetName(GetLastAttacker()), TALKVOLUME_SILENT_SHOUT);
        SendMessageToAllDMs("DMFI Safe Faction setting is currently set to ignore.");
        SendMessageToPC(GetLastAttacker(), "Script Fired.");
        return;
        }
//END DMFI CODE ADDITIONS****************************

// UOA henchs
if(GetLocalInt(OBJECT_SELF,"Hench")>0){ExecuteScript("nw_ch_ac5",OBJECT_SELF);}else{
// UOA henchs
// UOA Special
object oPC = GetLastAttacker();
object oArea = GetArea(OBJECT_SELF);
int iAreaWidth = GetAreaSize(AREA_WIDTH,oArea)*10;int iAreaHeight = GetAreaSize(AREA_HEIGHT,oArea)*10;
// Flee
if((GetLastAttackType(oPC)==SPECIAL_ATTACK_KNOCKDOWN)||(GetLastAttackType(oPC)==SPECIAL_ATTACK_IMPROVED_KNOCKDOWN)||(GetLastAttackType(oPC)==SPECIAL_ATTACK_STUNNING_FIST)){SetLocalInt(OBJECT_SELF,"Knock",1);}else{DeleteLocalInt(OBJECT_SELF,"Knock");}
if(GetLocalInt(oPC,"AniReserve")>0){ExecuteScript("creatures_attack",OBJECT_SELF);}
if(((GetLocalInt(OBJECT_SELF,"Flee")==1)||(GetStringLeft(GetTag(OBJECT_SELF),3)=="com")||(GetLocalInt(OBJECT_SELF,"Fleeing")==1))&&(GetLocalInt(OBJECT_SELF,"NotFlee")!=1)&&(GetLocalInt(OBJECT_SELF,"Knock")==0)&&(GetIsPC(oPC))&&(!GetIsDM(oPC))){ChangeToStandardFaction(OBJECT_SELF,STANDARD_FACTION_MERCHANT);SetStandardFactionReputation(STANDARD_FACTION_MERCHANT,50,oPC);ClearAllActions();ActionMoveToLocation(Location(GetArea(OBJECT_SELF),Vector(IntToFloat(Random(iAreaWidth)),IntToFloat(Random(iAreaHeight)),0.0),IntToFloat(Random(360))),TRUE);}else{
// UOA Special

    if(GetFleeToExit()) {
        // Run away!
        ActivateFleeToExit();
    } else if (GetSpawnInCondition(NW_FLAG_SET_WARNINGS)) {
        // We give an attacker one warning before we attack
        // This is not fully implemented yet
        SetSpawnInCondition(NW_FLAG_SET_WARNINGS, FALSE);

        //Put a check in to see if this attacker was the last attacker
        //Possibly change the GetNPCWarning function to make the check
    } else {
        object oAttacker = GetLastAttacker();
        if (!GetIsObjectValid(oAttacker)) {
            // Don't do anything, invalid attacker

        } else if (!GetIsFighting(OBJECT_SELF)) {
            // We're not fighting anyone else, so
            // start fighting the attacker
            if(GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL)) {
                SetSummonHelpIfAttacked();
                DetermineSpecialBehavior(oAttacker);
            } else if (GetArea(oAttacker) == GetArea(OBJECT_SELF)) {
                SetSummonHelpIfAttacked();
                DetermineCombatRound(oAttacker);
            }

            //Shout Attack my target, only works with the On Spawn In setup
            //SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);

            //Shout that I was attacked
            //SpeakString("NW_I_WAS_ATTACKED", TALKVOLUME_SILENT_TALK);
        }
    }


    if(GetSpawnInCondition(NW_FLAG_ATTACK_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(EVENT_ATTACKED));
    }
if(GetIsPC(oPC)){SetStandardFactionReputation(STANDARD_FACTION_MERCHANT,50,oPC);if(GetStandardFactionReputation(STANDARD_FACTION_MERCHANT,OBJECT_SELF)>=90){ClearPersonalReputation(oPC);}}
}}}
