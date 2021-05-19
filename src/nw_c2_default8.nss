//:://////////////////////////////////////////////////
//:: NW_C2_DEFAULT8
/*
  Default OnDisturbed event handler for NPCs.
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
if(GetLocalInt(OBJECT_SELF,"Hench")>0){ExecuteScript("nw_ch_ac8",OBJECT_SELF);}else{
// UOA henchs

    object oTarget = GetLastDisturbed();

// UOA Special
object oPC = oTarget;
object oArea = GetArea(OBJECT_SELF);
int iAreaWidth = GetAreaSize(AREA_WIDTH,oArea)*10;int iAreaHeight = GetAreaSize(AREA_HEIGHT,oArea)*10;
if(((GetLocalInt(OBJECT_SELF,"Flee")==1)||(GetLocalInt(OBJECT_SELF,"Fleeing")==1))&&(GetLocalInt(OBJECT_SELF,"NotFlee")!=1)&&(GetLocalInt(OBJECT_SELF,"Knock")==0)&&(GetIsPC(oPC))&&(!GetIsDM(oPC))){ChangeToStandardFaction(OBJECT_SELF,STANDARD_FACTION_MERCHANT);SetStandardFactionReputation(STANDARD_FACTION_MERCHANT,50,oPC);ClearAllActions();ActionMoveToLocation(Location(GetArea(OBJECT_SELF),Vector(IntToFloat(Random(iAreaWidth)),IntToFloat(Random(iAreaHeight)),0.0),IntToFloat(Random(360))),TRUE);}else{
// UOA Special


    // If we've been disturbed and are not already fighting,
    // attack our disturber.
    if (GetIsObjectValid(oTarget) && !GetIsFighting(OBJECT_SELF)) {
        DetermineCombatRound(oTarget);
    }

    // Send the disturbed flag if appropriate.
    if(GetSpawnInCondition(NW_FLAG_DISTURBED_EVENT)) {
        SignalEvent(OBJECT_SELF, EventUserDefined(EVENT_DISTURBED));
    }
}}}
