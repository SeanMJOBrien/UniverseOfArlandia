//::///////////////////////////////////////////////
//:: Default On Blocked
//:: NW_C2_DEFAULTE
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This will cause blocked creatures to open
    or smash down doors depending on int and
    str.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 23, 2001
//:://////////////////////////////////////////////

void main()
{
// UOA henchs
if(GetLocalInt(OBJECT_SELF,"Hench")>0){ExecuteScript("nw_ch_ace",OBJECT_SELF);}else{
// UOA henchs

    object oDoor = GetBlockingDoor();

// UOA Special
object oPC = oDoor;
object oArea = GetArea(OBJECT_SELF);
int iAreaWidth = GetAreaSize(AREA_WIDTH,oArea)*10;int iAreaHeight = GetAreaSize(AREA_HEIGHT,oArea)*10;
if(((GetLocalInt(OBJECT_SELF,"Flee")==1)||(GetLocalInt(OBJECT_SELF,"Fleeing")==1))&&(GetLocalInt(OBJECT_SELF,"NotFlee")!=1)&&(GetLocalInt(OBJECT_SELF,"Knock")==0)&&(GetIsPC(oPC))&&(!GetIsDM(oPC))){ChangeToStandardFaction(OBJECT_SELF,STANDARD_FACTION_MERCHANT);SetStandardFactionReputation(STANDARD_FACTION_MERCHANT,50,oPC);ClearAllActions();ActionMoveToLocation(Location(GetArea(OBJECT_SELF),Vector(IntToFloat(Random(iAreaWidth)),IntToFloat(Random(iAreaHeight)),0.0),IntToFloat(Random(360))),TRUE);}else{
// UOA Special

    if (GetObjectType(oDoor) == OBJECT_TYPE_CREATURE)
    {
        // * Increment number of times blocked
        /*SetLocalInt(OBJECT_SELF, "X2_NUMTIMES_BLOCKED", GetLocalInt(OBJECT_SELF, "X2_NUMTIMES_BLOCKED") + 1);
        if (GetLocalInt(OBJECT_SELF, "X2_NUMTIMES_BLOCKED") > 3)
        {
            SpeakString("Blocked by creature");
            SetLocalInt(OBJECT_SELF, "X2_NUMTIMES_BLOCKED",0);
            ClearAllActions();
            object oEnemy = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY);
            if (GetIsObjectValid(oEnemy) == TRUE)
            {
                ActionEquipMostDamagingRanged(oEnemy);
                ActionAttack(oEnemy);
            }
            return;
        }   */
        return;
    }
    if(GetAbilityScore(OBJECT_SELF, ABILITY_INTELLIGENCE) >= 5)
    {
        if(GetIsDoorActionPossible(oDoor, DOOR_ACTION_OPEN) && GetAbilityScore(OBJECT_SELF, ABILITY_INTELLIGENCE) >= 7 )
        {
            DoDoorAction(oDoor, DOOR_ACTION_OPEN);
        }
        else if(GetIsDoorActionPossible(oDoor, DOOR_ACTION_BASH))
        {
            DoDoorAction(oDoor, DOOR_ACTION_BASH);
        }
    }
}}}
